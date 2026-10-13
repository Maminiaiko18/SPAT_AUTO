package mg.port.api.servlet;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.LinkedHashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import mg.port.api.dao.TiersDAO;
import mg.port.api.model.TiersCreateRequest;
import mg.spat.Tiers;

@WebServlet("/api/tiers")
public class ApiTiersServlet extends HttpServlet {

    private ObjectMapper mapper;
    private TiersDAO dao;

    @Override
    public void init() throws ServletException {
        mapper = new ObjectMapper();
        dao = new TiersDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        String token = System.getenv("SPATERP_API_TOKEN");
        String userId = System.getenv("SPATERP_API_USER");
        if (isBlank(token) || isBlank(userId)) {
            sendError(response, HttpServletResponse.SC_SERVICE_UNAVAILABLE,
                    "API non configuree sur le serveur");
            return;
        }

        String authorization = request.getHeader("Authorization");
        String suppliedToken = authorization != null && authorization.startsWith("Bearer ")
                ? authorization.substring("Bearer ".length())
                : "";
        if (!MessageDigest.isEqual(token.getBytes(StandardCharsets.UTF_8),
                suppliedToken.getBytes(StandardCharsets.UTF_8))) {
            sendError(response, HttpServletResponse.SC_UNAUTHORIZED, "Authentification requise");
            return;
        }

        TiersCreateRequest body;
        try {
            body = mapper.readValue(request.getInputStream(), TiersCreateRequest.class);
        } catch (JsonProcessingException e) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "JSON invalide");
            return;
        }

        if (body == null || isBlank(body.getNom()) || isBlank(body.getType())) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Les champs nom et type sont obligatoires");
            return;
        }
        try {
            Tiers validator = new Tiers();
            validator.setNif(body.getNif());
            validator.setStat(body.getStat());
            validator.setCin(body.getCin());
        } catch (Exception e) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
            return;
        }

        try {
            Tiers tiers = dao.create(body, userId.trim());
            response.setStatus(HttpServletResponse.SC_CREATED);
            Map<String, Object> result = new LinkedHashMap<>();
            result.put("id", tiers.getId());
            result.put("nom", tiers.getNom());
            result.put("type", tiers.getType());
            result.put("etat", tiers.getEtat());
            mapper.writeValue(response.getWriter(), result);
        } catch (IllegalArgumentException e) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
        } catch (Exception e) {
            getServletContext().log("Erreur API lors de la creation d'un tiers", e);
            sendError(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "La creation du tiers a echoue");
        }
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }

    private void sendError(HttpServletResponse response, int status, String message)
            throws IOException {
        response.setStatus(status);
        Map<String, String> error = new LinkedHashMap<>();
        error.put("error", message);
        mapper.writeValue(response.getWriter(), error);
    }
}