package mg.port.api.servlet;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import historique.AnnulationUtilisateurUtil;
import historique.HistoriqueEJBClient;
import historique.HistoriqueLocal;
import historique.MapRoles;
import historique.MapUtilisateur;
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
import mg.port.api.model.UtilisateurApiRequest;

/**
 * Privileged automation API for user lifecycle operations. Every operation is
 * attributed to the configured active DG service account in SPAT history.
 */
@WebServlet("/api/utilisateurs/*")
public class ApiUtilisateurServlet extends HttpServlet {

    private ObjectMapper mapper;

    @Override
    public void init() throws ServletException {
        mapper = new ObjectMapper();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Context context = authenticate(request, response);
        if (context == null) return;
        String refuser = targetId(request, response);
        if (refuser == null) return;
        try {
            MapUtilisateur user = findUser(context.historique, refuser);
            if (user == null) {
                sendError(response, HttpServletResponse.SC_NOT_FOUND, "Utilisateur introuvable");
                return;
            }
            writeUser(response, user, isDisabled(refuser));
        } catch (Exception e) {
            log("Erreur API lors de la lecture d’un utilisateur", e);
            sendError(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "La lecture de l’utilisateur a échoué");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Context context = authenticate(request, response);
        if (context == null) return;
        String path = pathInfo(request);
        if (path.isEmpty() || "/".equals(path)) {
            create(request, response, context);
            return;
        }
        String[] segments = path.substring(1).split("/");
        if (segments.length != 2 || !isValidId(segments[0])) {
            sendError(response, HttpServletResponse.SC_NOT_FOUND, "Route utilisateur inconnue");
            return;
        }
        if (segments[0].equals(context.refuser) && "desactiver".equals(segments[1])) {
            sendError(response, HttpServletResponse.SC_CONFLICT,
                    "Le compte de service ne peut pas se désactiver lui-même");
            return;
        }
        try {
            if (findUser(context.historique, segments[0]) == null) {
                sendError(response, HttpServletResponse.SC_NOT_FOUND, "Utilisateur introuvable");
                return;
            }
            if ("desactiver".equals(segments[1])) {
                if (isDisabled(segments[0])) {
                    sendError(response, HttpServletResponse.SC_CONFLICT, "Utilisateur déjà désactivé");
                    return;
                }
                context.historique.desactiveUtilisateur(segments[0], context.refuser);
            } else if ("reactiver".equals(segments[1])) {
                if (!isDisabled(segments[0])) {
                    sendError(response, HttpServletResponse.SC_CONFLICT, "Utilisateur déjà actif");
                    return;
                }
                context.historique.activeUtilisateur(segments[0], context.refuser);
            } else {
                sendError(response, HttpServletResponse.SC_NOT_FOUND, "Route utilisateur inconnue");
                return;
            }
            response.setStatus(HttpServletResponse.SC_OK);
            writeLifecycle(response, segments[0], "desactiver".equals(segments[1]) ? "DESACTIVE" : "ACTIF");
        } catch (Exception e) {
            log("Erreur API lors d’un changement d’état utilisateur", e);
            sendError(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Le changement d’état du compte a échoué");
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Context context = authenticate(request, response);
        if (context == null) return;
        String refuser = targetId(request, response);
        if (refuser == null) return;
        if (refuser.equals(context.refuser)) {
            sendError(response, HttpServletResponse.SC_CONFLICT,
                    "Le compte de service ne peut pas être modifié par cette API");
            return;
        }
        UtilisateurApiRequest body = readBody(request, response);
        if (body == null) return;
        String error = validate(body, true);
        if (error != null) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, error);
            return;
        }
        try {
            if (findUser(context.historique, refuser) == null) {
                sendError(response, HttpServletResponse.SC_NOT_FOUND, "Utilisateur introuvable");
                return;
            }
            MapUtilisateur[] sameLogin = context.historique.findUtilisateurs(
                    "%", body.getLoginuser().trim(), "%", "%", "%", "%", "%");
            if (sameLogin != null) {
                for (MapUtilisateur candidate : sameLogin) {
                    if (!refuser.equals(String.valueOf(candidate.getRefuser()))) {
                        sendError(response, HttpServletResponse.SC_CONFLICT, "Login déjà utilisé");
                        return;
                    }
                }
            }
            validateRole(context.historique, body.getIdrole().trim());
            String updatedId = context.historique.updateUtilisateurs(refuser,
                    body.getLoginuser().trim(), body.getPwduser(), body.getNomuser().trim(),
                    valueOrEmpty(body.getAdruser()), valueOrEmpty(body.getTeluser()),
                    body.getIdrole().trim(), context.refuser);
            response.setStatus(HttpServletResponse.SC_OK);
            writeLifecycle(response, updatedId, "MODIFIE");
        } catch (IllegalArgumentException e) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
        } catch (Exception e) {
            log("Erreur API lors de la modification d’un utilisateur", e);
            sendError(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "La modification du compte a échoué");
        }
    }

    private void create(HttpServletRequest request, HttpServletResponse response, Context context)
            throws IOException {
        UtilisateurApiRequest body = readBody(request, response);
        if (body == null) return;
        String error = validate(body, false);
        if (error != null) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, error);
            return;
        }
        try {
            MapUtilisateur[] sameLogin = context.historique.findUtilisateurs(
                    "%", body.getLoginuser().trim(), "%", "%", "%", "%", "%");
            if (sameLogin != null && sameLogin.length > 0) {
                sendError(response, HttpServletResponse.SC_CONFLICT, "Login déjà utilisé");
                return;
            }
            validateRole(context.historique, body.getIdrole().trim());
            String id;
            if (isBlank(body.getCodeEtablissement())) {
                id = context.historique.createUtilisateurs(body.getLoginuser().trim(), body.getPwduser(),
                        body.getNomuser().trim(), valueOrEmpty(body.getAdruser()),
                        valueOrEmpty(body.getTeluser()), body.getIdrole().trim(), context.refuser);
            } else {
                id = context.historique.createUtilisateurs(body.getLoginuser().trim(), body.getPwduser(),
                        body.getNomuser().trim(), valueOrEmpty(body.getAdruser()),
                        valueOrEmpty(body.getTeluser()), body.getIdrole().trim(), context.refuser,
                        body.getCodeEtablissement().trim());
            }
            response.setStatus(HttpServletResponse.SC_CREATED);
            writeLifecycle(response, id, "ACTIF");
        } catch (IllegalArgumentException e) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
        } catch (Exception e) {
            log("Erreur API lors de la création d’un utilisateur", e);
            sendError(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "La création du compte a échoué");
        }
    }

    private Context authenticate(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        String token = System.getenv("SPATERP_USER_API_TOKEN");
        String refuser = System.getenv("SPATERP_USER_API_REFUSER");
        if (isBlank(token) || !isValidId(refuser)) {
            sendError(response, HttpServletResponse.SC_SERVICE_UNAVAILABLE,
                    "API utilisateurs non configurée sur le serveur");
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
        try {
            HistoriqueLocal historique = HistoriqueEJBClient.lookupHistoriqueEJBBeanLocal();
            MapUtilisateur actor = findUser(historique, refuser);
            if (actor == null || !"dg".equals(actor.getIdrole()) || isDisabled(refuser)) {
                sendError(response, HttpServletResponse.SC_FORBIDDEN,
                        "Le compte de service doit être un compte DG actif");
                return null;
            }
            return new Context(historique, refuser);
        } catch (Exception e) {
            log("Impossible de vérifier l’identité de service de l’API utilisateurs", e);
            sendError(response, HttpServletResponse.SC_SERVICE_UNAVAILABLE,
                    "Le service de gestion utilisateur SPAT est indisponible");
            return null;
        }
    }

    private UtilisateurApiRequest readBody(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            return mapper.readValue(request.getInputStream(), UtilisateurApiRequest.class);
        } catch (JsonProcessingException e) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "JSON invalide");
            return null;
        }
    }

    private String validate(UtilisateurApiRequest body, boolean update) {
        if (body == null || isBlank(body.getLoginuser()) || isBlank(body.getPwduser())
                || isBlank(body.getNomuser()) || isBlank(body.getIdrole())) {
            return "loginuser, pwduser, nomuser et idrole sont obligatoires";
        }
        if (body.getLoginuser().trim().length() > 100 || body.getNomuser().trim().length() > 200
                || body.getPwduser().length() > 256) {
            return "Un champ dépasse la longueur autorisée";
        }
        if (update && !isBlank(body.getCodeEtablissement())) {
            return "Le code établissement ne peut pas être modifié par cette route";
        }
        return null;
    }

    private void validateRole(HistoriqueLocal historique, String roleId) throws Exception {
        MapRoles[] roles = historique.findRole(roleId);
        if (roles == null || roles.length == 0) {
            throw new IllegalArgumentException("Rôle inconnu");
        }
    }

    private MapUtilisateur findUser(HistoriqueLocal historique, String refuser) throws Exception {
        MapUtilisateur[] users = historique.findUtilisateurs(refuser, "%", "%", "%", "%", "%", "%");
        return users == null || users.length == 0 ? null : users[0];
    }

    private boolean isDisabled(String refuser) throws Exception {
        Object[] cancellations = new AnnulationUtilisateurUtil().rechercher(2, refuser);
        if (cancellations == null) {
            throw new Exception("Impossible de vérifier le statut du compte utilisateur");
        }
        return cancellations.length > 0;
    }

    private String targetId(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String path = pathInfo(request);
        if (!path.matches("/[0-9]+")) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Référence utilisateur invalide");
            return null;
        }
        return path.substring(1);
    }

    private String pathInfo(HttpServletRequest request) {
        String path = request.getPathInfo();
        return path == null ? "" : path;
    }

    private boolean isValidId(String value) {
        return value != null && value.matches("[0-9]+");
    }

    private String valueOrEmpty(String value) {
        return value == null ? "" : value.trim();
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }

    private void writeUser(HttpServletResponse response, MapUtilisateur user, boolean disabled)
            throws IOException {
        Map<String, Object> result = new LinkedHashMap<String, Object>();
        result.put("refuser", String.valueOf(user.getRefuser()));
        result.put("loginuser", user.getLoginuser());
        result.put("nomuser", user.getNomuser());
        result.put("adruser", user.getAdruser());
        result.put("teluser", user.getTeluser());
        result.put("idrole", user.getIdrole());
        result.put("etat", disabled ? "DESACTIVE" : "ACTIF");
        mapper.writeValue(response.getWriter(), result);
    }

    private void writeLifecycle(HttpServletResponse response, String refuser, String status)
            throws IOException {
        Map<String, String> result = new LinkedHashMap<String, String>();
        result.put("refuser", refuser);
        result.put("etat", status);
        mapper.writeValue(response.getWriter(), result);
    }

    private void sendError(HttpServletResponse response, int status, String message)
            throws IOException {
        response.setStatus(status);
        Map<String, String> error = new LinkedHashMap<String, String>();
        error.put("error", message);
        mapper.writeValue(response.getWriter(), error);
    }

    private static class Context {
        private final HistoriqueLocal historique;
        private final String refuser;

        private Context(HistoriqueLocal historique, String refuser) {
            this.historique = historique;
            this.refuser = refuser;
        }
    }
}
