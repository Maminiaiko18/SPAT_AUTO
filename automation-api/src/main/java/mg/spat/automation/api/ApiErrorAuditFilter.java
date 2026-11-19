package mg.spat.automation.api;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Properties;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

/** Records failed HTTP responses using a separate, insert-only audit account. */
@Component
public class ApiErrorAuditFilter extends OncePerRequestFilter {
    private static final Logger log = LoggerFactory.getLogger(ApiErrorAuditFilter.class);
    private static final String INSERT_SQL =
            "INSERT INTO SPAT_CAPITAINERIE.SPATERP_API_ERROR_LOG "
            + "(SERVICE_NAME, HTTP_METHOD, ENDPOINT, HTTP_STATUS, ERROR_CODE, SUMMARY) "
            + "VALUES (?, ?, ?, ?, ?, ?)";

    private final Environment environment;

    public ApiErrorAuditFilter(Environment environment) {
        this.environment = environment;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
            FilterChain filterChain) throws ServletException, IOException {
        boolean failed = false;
        try {
            filterChain.doFilter(request, response);
        } catch (ServletException | IOException | RuntimeException exception) {
            failed = true;
            throw exception;
        } catch (Error error) {
            failed = true;
            throw error;
        } finally {
            int status = failed ? HttpServletResponse.SC_INTERNAL_SERVER_ERROR : response.getStatus();
            if (status >= 400) {
                try {
                    record(request, status);
                } catch (Throwable ignored) {
                    // Audit failures must not replace or alter the original HTTP result.
                }
            }
        }
    }

    private void record(HttpServletRequest request, int status) {
        if (!Boolean.parseBoolean(environment.getProperty("spat.audit.enabled", "false"))) {
            return;
        }
        String url = environment.getProperty("spat.audit.jdbc-url", "");
        String username = environment.getProperty("spat.audit.username", "");
        String password = environment.getProperty("spat.audit.password", "");
        if (url.isBlank() || username.isBlank() || password.isBlank()) {
            log.warn("Journal d’erreurs API activé sans configuration complète du compte d’audit");
            return;
        }

        Properties properties = new Properties();
        properties.setProperty("user", username);
        properties.setProperty("password", password);
        properties.setProperty("oracle.net.CONNECT_TIMEOUT", "3000");
        properties.setProperty("oracle.jdbc.ReadTimeout", "3000");
        try (Connection connection = DriverManager.getConnection(url, properties);
                PreparedStatement statement = connection.prepareStatement(INSERT_SQL)) {
            statement.setQueryTimeout(3);
            statement.setString(1, environment.getProperty("spring.application.name", "facture-automation-api"));
            statement.setString(2, limit(request.getMethod(), 10));
            statement.setString(3, endpoint(request));
            statement.setInt(4, status);
            statement.setString(5, "HTTP_" + status);
            statement.setString(6, "API request returned HTTP " + status);
            statement.executeUpdate();
        } catch (Exception exception) {
            // Logging failure must never replace the original API response.
            log.warn("Échec de l’écriture de l’historique d’erreurs API", exception);
        }
    }

    private String endpoint(HttpServletRequest request) {
        String path = request.getRequestURI();
        String context = request.getContextPath();
        if (context != null && !context.isEmpty() && path.startsWith(context)) {
            path = path.substring(context.length());
        }
        String[] parts = path.split("/");
        if (parts.length >= 4) {
            return limit("/" + parts[1] + "/" + parts[2] + "/" + parts[3] + "/*", 512);
        }
        return limit(path, 512);
    }

    private String limit(String value, int maxLength) {
        if (value == null) return null;
        return value.length() <= maxLength ? value : value.substring(0, maxLength);
    }
}
