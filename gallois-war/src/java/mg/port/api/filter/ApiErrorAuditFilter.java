package mg.port.api.filter;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Properties;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/** Best-effort audit of failed API responses; never reads request/response bodies. */
@WebFilter(urlPatterns = "/api/*")
public class ApiErrorAuditFilter implements Filter {
    private static final String INSERT_SQL =
            "INSERT INTO SPAT_CAPITAINERIE.SPATERP_API_ERROR_LOG "
            + "(SERVICE_NAME, HTTP_METHOD, ENDPOINT, HTTP_STATUS, ERROR_CODE, SUMMARY) "
            + "VALUES (?, ?, ?, ?, ?, ?)";

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        boolean failed = false;
        try {
            chain.doFilter(request, response);
        } catch (IOException e) {
            failed = true;
            throw e;
        } catch (ServletException e) {
            failed = true;
            throw e;
        } catch (RuntimeException e) {
            failed = true;
            throw e;
        } catch (Error e) {
            failed = true;
            throw e;
        } finally {
            int status = failed ? HttpServletResponse.SC_INTERNAL_SERVER_ERROR : httpResponse.getStatus();
            if (status >= 400) {
                try {
                    record(httpRequest, status);
                } catch (Throwable ignored) {
                    // Audit failures must not replace or alter the original HTTP result.
                }
            }
        }
    }

    private void record(HttpServletRequest request, int status) {
        if (!"true".equalsIgnoreCase(System.getenv("SPAT_API_AUDIT_ENABLED"))) {
            return;
        }
        String url = System.getenv("SPAT_API_AUDIT_JDBC_URL");
        String username = System.getenv("SPAT_API_AUDIT_DB_USER");
        String password = System.getenv("SPAT_API_AUDIT_DB_PASSWORD");
        if (blank(url) || blank(username) || blank(password)) return;

        Properties properties = new Properties();
        properties.setProperty("user", username);
        properties.setProperty("password", password);
        properties.setProperty("oracle.net.CONNECT_TIMEOUT", "3000");
        properties.setProperty("oracle.jdbc.ReadTimeout", "3000");
        try (Connection connection = DriverManager.getConnection(url, properties);
                PreparedStatement statement = connection.prepareStatement(INSERT_SQL)) {
            statement.setQueryTimeout(3);
            statement.setString(1, "spat-war");
            statement.setString(2, limit(request.getMethod(), 10));
            statement.setString(3, endpoint(request));
            statement.setInt(4, status);
            statement.setString(5, "HTTP_" + status);
            statement.setString(6, "API request returned HTTP " + status);
            statement.executeUpdate();
        } catch (Exception e) {
            try {
                request.getServletContext().log("Échec de l’écriture de l’historique d’erreurs API", e);
            } catch (Throwable ignored) {
                // Keep the original response even if the fallback logger is unavailable.
            }
        }
    }

    private String endpoint(HttpServletRequest request) {
        String path = request.getRequestURI();
        String context = request.getContextPath();
        if (context != null && !context.isEmpty() && path.startsWith(context)) {
            path = path.substring(context.length());
        }
        String[] parts = path.split("/");
        if (parts.length >= 3) {
            return limit("/" + parts[1] + "/" + parts[2] + (parts.length > 3 ? "/*" : ""), 512);
        }
        return limit(path, 512);
    }

    private String limit(String value, int maxLength) {
        if (value == null) return null;
        return value.length() <= maxLength ? value : value.substring(0, maxLength);
    }

    private boolean blank(String value) {
        return value == null || value.trim().isEmpty();
    }

    @Override
    public void destroy() {
    }

}
