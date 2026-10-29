package mg.port.api.servlet;

import bordereau.BordereauFF;
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
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.LinkedHashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import mg.port.api.model.BedModificationRequest;
import modules.GestionRole;
import user.UserEJBBean;
import utilitaire.Constante;
import utilisateur.ConstanteUtilisateur;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;

/** Read and safely edit selected fields of an unengaged, unapproved BED. */
@WebServlet("/api/bordereaux-bed/*")
public class ApiBedServlet extends HttpServlet {

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
        if (id == null) return;
        String actorId = authenticate(request, response);
        if (actorId == null) return;
        Connection connection = null;
        try {
            connection = new UtilDB().GetConn();
            verifyActor(actorId, connection);
            BordereauFF bed = findBed(id, connection);
            if (bed == null) {
                sendError(response, HttpServletResponse.SC_NOT_FOUND, "BED introuvable");
                return;
            }
            writeBed(response, bed);
        } catch (ApiException e) {
            sendError(response, e.status, e.getMessage());
        } catch (Exception e) {
            log("Erreur API lors de la lecture du BED", e);
            sendError(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "La lecture du BED a échoué");
        } finally {
            close(connection);
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = targetId(request, response);
        if (id == null) return;
        String actorId = authenticate(request, response);
        if (actorId == null) return;
        BedModificationRequest body;
        try {
            body = mapper.readValue(request.getInputStream(), BedModificationRequest.class);
        } catch (JsonProcessingException e) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "JSON invalide ou champ non autorisé");
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
            lockDraftBed(id, connection);
            GestionRole roles = new GestionRole();
            if (roles.testRestriction(actor, ConstanteUtilisateur.acteUpdate, "FSBBED",
                    actor.getDirection(), connection) == 1) {
                throw new ApiException(HttpServletResponse.SC_FORBIDDEN,
                        "Le compte de service n’a pas le droit ACT0002 sur FSBBED");
            }
            BordereauFF bed = findBed(id, connection);
            if (bed == null) {
                throw new ApiException(HttpServletResponse.SC_NOT_FOUND, "BED introuvable");
            }
            ensureEditable(bed);
            validateTypeTransition(bed, body.getTypebordereau(), connection);
            bed.setMode("modif");
            bed.setNomTable("BORDEREAUFF");
            bed.setDaty(Date.valueOf(body.getDaty()));
            bed.setAnneebudgetaire(body.getAnneebudgetaire().intValue());
            bed.setDesignation(body.getDesignation().trim());
            bed.setTypebordereau(body.getTypebordereau().trim().toUpperCase());
            bed.controlerUpdate(connection);
            bed.updateToTableWithHisto(actorId, connection, "Modification BED par API");
            connection.commit();
            response.setStatus(HttpServletResponse.SC_OK);
            writeBed(response, bed);
        } catch (ApiException e) {
            rollback(connection);
            sendError(response, e.status, e.getMessage());
        } catch (Exception e) {
            rollback(connection);
            log("Erreur API lors de la modification du BED", e);
            sendError(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "La modification du BED a échoué");
        } finally {
            close(connection);
        }
    }

    private String authenticate(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        String token = System.getenv("SPATERP_BED_API_TOKEN");
        String refuser = System.getenv("SPATERP_BED_API_REFUSER");
        if (isBlank(token) || !isValidId(refuser)) {
            sendError(response, HttpServletResponse.SC_SERVICE_UNAVAILABLE,
                    "API BED non configurée sur le serveur");
            return null;
        }
        String authorization = request.getHeader("Authorization");
        String supplied = authorization != null && authorization.startsWith("Bearer ")
                ? authorization.substring("Bearer ".length()) : "";
        if (!MessageDigest.isEqual(token.getBytes(StandardCharsets.UTF_8),
                supplied.getBytes(StandardCharsets.UTF_8))) {
            sendError(response, HttpServletResponse.SC_UNAUTHORIZED, "Authentification requise");
            return null;
        }
        return refuser;
    }

    private MapUtilisateurServiceDirection verifyActor(String actorId, Connection connection)
            throws Exception {
        BordereauFF filter = new BordereauFF();
        MapUtilisateurServiceDirection actor = filter.getUser(actorId, connection);
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

    private void lockDraftBed(String id, Connection connection) throws Exception {
        try (PreparedStatement statement = connection.prepareStatement(
                "SELECT ETAT, IDENGAGEMENT FROM BORDEREAUFF WHERE ID = ? FOR UPDATE")) {
            statement.setString(1, id);
            try (ResultSet result = statement.executeQuery()) {
                if (!result.next()) {
                    throw new ApiException(HttpServletResponse.SC_NOT_FOUND, "BED introuvable");
                }
                int state = result.getInt("ETAT");
                String engagement = result.getString("IDENGAGEMENT");
                if (state != ConstanteEtat.getEtatCreer() || !isBlank(engagement)) {
                    throw new ApiException(HttpServletResponse.SC_CONFLICT,
                            "Seul un BED créé et non engagé peut être modifié");
                }
            }
        }
    }

    private void ensureEditable(BordereauFF bed) throws ApiException {
        if (bed.getEtat() != ConstanteEtat.getEtatCreer() || !isBlank(bed.getIdengagement())) {
            throw new ApiException(HttpServletResponse.SC_CONFLICT,
                    "Seul un BED créé et non engagé peut être modifié");
        }
    }

    private BordereauFF findBed(String id, Connection connection) throws Exception {
        BordereauFF filter = new BordereauFF();
        filter.setNomTable("BORDEREAUFF");
        BordereauFF[] rows = (BordereauFF[]) CGenUtil.rechercher(filter, null, null, connection,
                " AND ID = '" + id + "'");
        return rows == null || rows.length == 0 ? null : rows[0];
    }

    private String validate(BedModificationRequest body) {
        if (body == null || isBlank(body.getDaty()) || body.getAnneebudgetaire() == null
                || isBlank(body.getDesignation()) || isBlank(body.getTypebordereau())) {
            return "daty, anneebudgetaire, designation et typebordereau sont obligatoires";
        }
        if (!body.getDaty().matches("[0-9]{4}-[0-9]{2}-[0-9]{2}")) {
            return "daty doit être au format AAAA-MM-JJ";
        }
        try {
            Date.valueOf(body.getDaty());
        } catch (IllegalArgumentException e) {
            return "daty n’est pas une date valide";
        }
        if (body.getAnneebudgetaire().intValue() < 1) {
            return "anneebudgetaire doit être une année positive";
        }
        if (body.getDesignation().trim().length() > 40) {
            return "designation ne doit pas dépasser 40 caractères";
        }
        if (!Constante.typeBED.equalsIgnoreCase(body.getTypebordereau().trim())
                && !Constante.typeEtatDepense.equalsIgnoreCase(body.getTypebordereau().trim())) {
            return "typebordereau doit être TYPB1 (BED) ou TYPB2 (État de dépense)";
        }
        return null;
    }

    private void validateTypeTransition(BordereauFF bed, String requestedType, Connection connection)
            throws Exception {
        if (!Constante.typeBED.equalsIgnoreCase(requestedType.trim())
                || Constante.typeBED.equalsIgnoreCase(bed.getTypebordereau())) {
            return;
        }

        bed.setTypebordereau(Constante.typeBED);
        bed.controlerFF(connection);
        int linkedInvoices = 0;
        try (PreparedStatement statement = connection.prepareStatement(
                "SELECT F.IDBL, F.ETAT, F.IDPROVISION "
                + "FROM FACTURE_FOURNISSEUR_MERE F "
                + "JOIN LIAISONBORDEREAUFF L ON L.IDOP = F.ID "
                + "WHERE L.IDBORDEREAU = ?")) {
            statement.setString(1, bed.getId());
            try (ResultSet result = statement.executeQuery()) {
                while (result.next()) {
                    linkedInvoices++;
                    if (!isBlank(result.getString("IDBL"))) {
                        throw new ApiException(HttpServletResponse.SC_CONFLICT,
                                "Impossible de convertir en BED: une facture est liée à un bon de livraison");
                    }
                    if (result.getInt("ETAT") == ConstanteEtat.getEtatValider()) {
                        throw new ApiException(HttpServletResponse.SC_CONFLICT,
                                "Impossible de convertir en BED: une facture est déjà visée");
                    }
                    if (!isBlank(result.getString("IDPROVISION"))) {
                        throw new ApiException(HttpServletResponse.SC_CONFLICT,
                                "Cette facture avec provision doit rester de type État de dépense (TYPB2)");
                    }
                }
            }
        }
        if (linkedInvoices == 0) {
            throw new ApiException(HttpServletResponse.SC_CONFLICT,
                    "Un BED doit contenir au moins une facture fournisseur liée");
        }
    }

    private String targetId(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        String path = request.getPathInfo();
        if (path == null || !path.matches("/[A-Za-z0-9_-]{1,40}")) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Identifiant BED invalide");
            return null;
        }
        return path.substring(1);
    }

    private void writeBed(HttpServletResponse response, BordereauFF bed) throws IOException {
        Map<String, Object> value = new LinkedHashMap<String, Object>();
        value.put("id", bed.getId());
        value.put("daty", bed.getDaty() == null ? null : bed.getDaty().toString());
        value.put("anneebudgetaire", bed.getAnneebudgetaire());
        value.put("designation", bed.getDesignation());
        value.put("typebordereau", bed.getTypebordereau());
        value.put("etat", bed.getEtat());
        value.put("idengagement", bed.getIdengagement());
        mapper.writeValue(response.getWriter(), value);
    }

    private void sendError(HttpServletResponse response, int status, String message) throws IOException {
        response.setStatus(status);
        Map<String, String> error = new LinkedHashMap<String, String>();
        error.put("error", message);
        mapper.writeValue(response.getWriter(), error);
    }

    private boolean isValidId(String value) {
        return value != null && value.matches("[0-9]{1,10}");
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }

    private void rollback(Connection connection) {
        if (connection != null) {
            try { connection.rollback(); } catch (Exception ignored) { }
        }
    }

    private void close(Connection connection) {
        if (connection != null) {
            try { connection.close(); } catch (Exception ignored) { }
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
