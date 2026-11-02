package mg.port.api.servlet;

import bean.CGenUtil;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import historique.AnnulationUtilisateurUtil;
import historique.MapUtilisateurServiceDirection;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.Date;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import mg.port.api.model.DaseCreateRequest;
import mg.spat.DemandeAchatFille;
import mg.spat.DemandeAchatMere;
import utilisateur.ConstanteUtilisateur;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import user.UserEJBBean;

@WebServlet("/api/demandes-achat/*")
public class ApiDaseServlet extends HttpServlet {
    private ObjectMapper mapper;

    @Override
    public void init() throws ServletException {
        mapper = new ObjectMapper();
        mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, true);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = targetId(request, response);
        if (id == null)
            return;
        String actorId = authenticate(request, response);
        if (actorId == null)
            return;

        Connection connection = null;
        try {
            connection = new UtilDB().GetConn();
            verifyActor(actorId, connection);
            DemandeAchatMere dase = findDase(id, connection);
            if (dase == null) {
                sendError(response, HttpServletResponse.SC_NOT_FOUND, "DASE introuvable");
                return;
            }
            writeDase(response, dase, findLines(id, connection));
        } catch (ApiException e) {
            sendError(response, e.status, e.getMessage());
        } catch (Exception e) {
            log("Erreur API lors de la lecture d’une DASE", e);
            sendError(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "La lecture de la DASE a échoué");
        } finally {
            close(connection);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        String actorId = authenticate(request, response);
        if (actorId == null)
            return;

        DaseCreateRequest body;
        try {
            body = mapper.readValue(request.getInputStream(), DaseCreateRequest.class);
        } catch (JsonProcessingException e) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "JSON invalide ou champ inconnu");
            return;
        }
        String validationError = validate(body);
        if (validationError != null) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, validationError);
            return;
        }

        Connection connection = null;
        try {
            connection = new UtilDB().GetConn();
            connection.setAutoCommit(false);
            MapUtilisateurServiceDirection actor = verifyActor(actorId, connection);
            verifyInsertPermission(actor, connection);

            DemandeAchatMere dase = new DemandeAchatMere();
            dase.setMode("modif");
            dase.setDaty(Date.valueOf(body.getDaty().trim()));
            dase.setCodeetablissement(body.getCodeetablissement().trim());
            dase.setProjet(body.getProjet().trim());
            dase.setDesignation(body.getDesignation().trim());
            dase.setIdcategorieachat(valueOrNull(body.getIdcategorieachat()));
            dase.setPatrimoine(valueOrNull(body.getPatrimoine()));
            dase.setEtat(ConstanteEtat.getEtatCreer());
            dase.createObject(actorId, connection);

            for (DaseCreateRequest.Ligne proposed : body.getLignes()) {
                DemandeAchatFille line = new DemandeAchatFille();
                line.setMode("modif");
                line.setIdmere(dase.getId());
                line.setProduit(valueOrNull(proposed.getProduit()));
                line.setDesignation(proposed.getDesignation().trim());
                line.setUnite(proposed.getUnite().trim());
                line.setQte(proposed.getQte());
                line.setPu(proposed.getPu());
                line.setMontant(proposed.getQte() * proposed.getPu());
                line.setRemarque(valueOrNull(proposed.getRemarque()));
                line.createObject(actorId, connection);
            }

            connection.commit();
            response.setStatus(HttpServletResponse.SC_CREATED);
            writeDase(response, findDase(dase.getId(), connection), findLines(dase.getId(), connection));
        } catch (ApiException e) {
            rollback(connection);
            sendError(response, e.status, e.getMessage());
        } catch (IllegalArgumentException e) {
            rollback(connection);
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Date ou valeur invalide");
        } catch (Exception e) {
            rollback(connection);
            log("Erreur API lors de la création d’une DASE", e);
            sendError(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "La création de la DASE a échoué; la transaction a été annulée");
        } finally {
            close(connection);
        }
    }

    private String authenticate(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        String token = System.getenv("SPATERP_DASE_API_TOKEN");
        String refuser = System.getenv("SPATERP_DASE_API_REFUSER");
        if (isBlank(token) || !isValidUserId(refuser)) {
            sendError(response, HttpServletResponse.SC_SERVICE_UNAVAILABLE,
                    "API DASE non configurée sur le serveur");
            return null;
        }
        String authorization = request.getHeader("Authorization");
        String supplied = authorization != null && authorization.startsWith("Bearer ")
                ? authorization.substring("Bearer ".length())
                : "";
        if (!MessageDigest.isEqual(token.getBytes(StandardCharsets.UTF_8),
                supplied.getBytes(StandardCharsets.UTF_8))) {
            sendError(response, HttpServletResponse.SC_UNAUTHORIZED, "Authentification requise");
            return null;
        }
        return refuser;
    }

    private MapUtilisateurServiceDirection verifyActor(String actorId, Connection connection)
            throws Exception {
        MapUtilisateurServiceDirection actor = new DemandeAchatMere().getUser(actorId, connection);
        if (actor == null || !"dg".equals(actor.getIdrole())) {
            throw new ApiException(HttpServletResponse.SC_FORBIDDEN,
                    "Le compte de service doit être un compte DG");
        }
        Object[] cancellations = new AnnulationUtilisateurUtil().rechercher(2, actorId);
        if (cancellations == null) {
            throw new Exception("Impossible de vérifier le statut du compte de service");
        }
        if (cancellations.length > 0) {
            throw new ApiException(HttpServletResponse.SC_FORBIDDEN,
                    "Le compte de service doit être actif");
        }
        return actor;
    }

    private void verifyInsertPermission(MapUtilisateurServiceDirection actor, Connection connection)
            throws Exception {
        UserEJBBean roles = new UserEJBBean();
        if (roles.testRestriction(actor, ConstanteUtilisateur.acteInsert,
                "dem_achat_mere", connection) == 1
                || roles.testRestriction(actor, ConstanteUtilisateur.acteInsert,
                        "dem_achat_fille", connection) == 1) {
            throw new ApiException(HttpServletResponse.SC_FORBIDDEN,
                    "Le compte de service n’a pas ACT0001 sur les tables DASE");
        }
    }

    private String validate(DaseCreateRequest body) {
        if (body == null || isBlank(body.getDaty()) || isBlank(body.getCodeetablissement())
                || isBlank(body.getProjet()) || isBlank(body.getDesignation())) {
            return "daty, codeetablissement, projet et designation sont obligatoires";
        }
        if (!body.getDaty().trim().matches("[0-9]{4}-[0-9]{2}-[0-9]{2}")) {
            return "daty doit être au format AAAA-MM-JJ";
        }
        try {
            Date.valueOf(body.getDaty().trim());
        } catch (IllegalArgumentException e) {
            return "daty n’est pas une date valide";
        }
        if (!body.getCodeetablissement().trim().matches("[A-Za-z0-9_-]+")
                || !body.getProjet().trim().matches("[A-Za-z0-9_-]+")) {
            return "codeetablissement et projet doivent être des identifiants SPAT valides";
        }
        if (body.getLignes() == null || body.getLignes().isEmpty() || body.getLignes().size() > 100) {
            return "La DASE doit contenir entre 1 et 100 lignes";
        }
        for (DaseCreateRequest.Ligne line : body.getLignes()) {
            if (line == null || isBlank(line.getDesignation()) || isBlank(line.getUnite())
                    || line.getQte() == null || line.getPu() == null
                    || line.getQte() <= 0 || line.getPu() < 0
                    || Double.isInfinite(line.getQte()) || Double.isNaN(line.getQte())
                    || Double.isInfinite(line.getPu()) || Double.isNaN(line.getPu())) {
                return "Chaque ligne exige designation, unite, qte positive et pu positif ou nul";
            }
            if (Double.isInfinite(line.getQte() * line.getPu())
                    || Double.isNaN(line.getQte() * line.getPu())) {
                return "Le montant d’une ligne dépasse la valeur numérique autorisée";
            }
        }
        return null;
    }

    private String targetId(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        String path = request.getPathInfo();
        if (path == null || !path.matches("/[A-Za-z0-9_-]{1,40}")) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Identifiant DASE invalide");
            return null;
        }
        return path.substring(1);
    }

    private DemandeAchatMere findDase(String id, Connection connection) throws Exception {
        DemandeAchatMere filter = new DemandeAchatMere("dem_achat_merelib");
        DemandeAchatMere[] rows = (DemandeAchatMere[]) CGenUtil.rechercher(filter, null, null,
                connection, " AND ID = '" + id + "'");
        return rows == null || rows.length == 0 ? null : rows[0];
    }

    private DemandeAchatFille[] findLines(String id, Connection connection) throws Exception {
        DemandeAchatFille filter = new DemandeAchatFille();
        filter.setNomTable("dem_achat_fillelib");
        return (DemandeAchatFille[]) CGenUtil.rechercher(filter, null, null, connection,
                " AND IDMERE = '" + id + "' ORDER BY ID");
    }

    private void writeDase(HttpServletResponse response, DemandeAchatMere dase,
            DemandeAchatFille[] lines) throws IOException {
        if (dase == null) {
            sendError(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "La DASE créée n’a pas pu être relue");
            return;
        }
        Map<String, Object> result = new LinkedHashMap<String, Object>();
        result.put("id", dase.getId());
        result.put("num", dase.getNum());
        result.put("daty", dase.getDaty() == null ? null : dase.getDaty().toString());
        result.put("codeetablissement", dase.getCodeetablissement());
        result.put("projet", dase.getProjet());
        result.put("designation", dase.getDesignation());
        result.put("idcategorieachat", dase.getIdcategorieachat());
        result.put("patrimoine", dase.getPatrimoine());
        result.put("etat", dase.getEtat());
        List<Map<String, Object>> lineResults = new ArrayList<Map<String, Object>>();
        if (lines != null) {
            for (DemandeAchatFille line : lines) {
                Map<String, Object> item = new LinkedHashMap<String, Object>();
                item.put("id", line.getId());
                item.put("idmere", line.getIdmere());
                item.put("produit", line.getProduit());
                item.put("designation", line.getDesignation());
                item.put("unite", line.getUnite());
                item.put("qte", line.getQte());
                item.put("pu", line.getPu());
                item.put("montant", line.getMontant());
                item.put("remarque", line.getRemarque());
                lineResults.add(item);
            }
        }
        result.put("lignes", lineResults);
        mapper.writeValue(response.getWriter(), result);
    }

    private void sendError(HttpServletResponse response, int status, String message) throws IOException {
        response.setStatus(status);
        Map<String, String> error = new LinkedHashMap<String, String>();
        error.put("error", message);
        mapper.writeValue(response.getWriter(), error);
    }

    private String valueOrNull(String value) {
        return isBlank(value) ? null : value.trim();
    }

    private boolean isValidUserId(String value) {
        return value != null && value.matches("[0-9]{1,10}");
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }

    private void rollback(Connection connection) {
        if (connection != null) {
            try {
                connection.rollback();
            } catch (Exception ignored) {
            }
        }
    }

    private void close(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (Exception ignored) {
            }
        }
    }

    private static class ApiException extends Exception {
        private final int status;

        ApiException(int status, String message) {
            super(message);
            this.status = status;
        }
    }
}