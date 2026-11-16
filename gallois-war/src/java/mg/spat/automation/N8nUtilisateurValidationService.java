package mg.spat.automation;

import bean.ClassMAPTable;
import com.fasterxml.jackson.databind.ObjectMapper;
import historique.MapUtilisateur;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;

/** Calls the configured n8n Utilisateur control webhook after SPAT has saved an Utilisateur. */
public final class N8nUtilisateurValidationService {
    private static final int CONNECT_TIMEOUT_MS = 5000;
    private static final int READ_TIMEOUT_MS = 10000;
    private static final String DEFAULT_ENDPOINT = "http://127.0.0.1:5678/webhook/spat/utilisateurs/controle";
    private static final ObjectMapper MAPPER = new ObjectMapper();

    private N8nUtilisateurValidationService() { }

    public static void validateAfterSave(String utilisateurClass, ClassMAPTable created, String refuser, HttpSession session) {
        if (!"historique.MapUtilisateur".equals(utilisateurClass) || !(created instanceof MapUtilisateur)) {
            return;
        }
        MapUtilisateur utilisateur = (MapUtilisateur) created;
        String utilisateurId = refuser;
        if (utilisateurId == null || utilisateurId.trim().isEmpty()) {
            utilisateurId = utilisateur.getTuppleID();
        }
        if (utilisateurId == null || utilisateurId.trim().isEmpty()) {
            return;
        }

        Map<String, Object> result;
        try {
            result = validate(utilisateur);
        } catch (Exception validationException) {
            result = new LinkedHashMap<String, Object>();
            result.put("statut", "INDISPONIBLE");
            result.put("errors", singleError("Utilisateur enregistré ; préparation de validation impossible ("
                    + validationException.getClass().getSimpleName() + ")."));
        }
        try {
            session.setAttribute("n8nUtilisateurValidation:" + utilisateurId, result);
        } catch (Exception sessionException) {
            return;
        }
    }

    private static Map<String, Object> validate(MapUtilisateur utilisateur) {
        Map<String, Object> result = new LinkedHashMap<String, Object>();
        String token = System.getenv("SPATERP_N8N_DASE_WEBHOOK_TOKEN");
        if (token == null || token.trim().isEmpty()) {
            result.put("statut", "INDISPONIBLE");
            result.put("errors", singleError("Jeton du webhook n8n non configuré (SPATERP_N8N_DASE_WEBHOOK_TOKEN)."));
            return result;
        }
        String endpoint = System.getProperty("spat.n8n.utilisateurs.webhook");
        if (endpoint == null || endpoint.trim().isEmpty()) {
            endpoint = DEFAULT_ENDPOINT;
        }

        HttpURLConnection connection = null;
        try {
            Map<String, Object> payload = new LinkedHashMap<String, Object>();
            payload.put("loginuser", value(utilisateur.getLoginuser()));
            payload.put("nomuser", value(utilisateur.getNomuser()));
            payload.put("idrole", value(utilisateur.getIdrole()));
            payload.put("teluser", value(utilisateur.getTeluser()));
            payload.put("adruser", value(utilisateur.getAdruser()));
            payload.put("codeEtablissement", value(utilisateur.getCodeEtablissement()));

            connection = (HttpURLConnection) new URL(endpoint).openConnection();
            connection.setRequestMethod("POST");
            connection.setConnectTimeout(CONNECT_TIMEOUT_MS);
            connection.setReadTimeout(READ_TIMEOUT_MS);
            connection.setDoOutput(true);
            connection.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            connection.setRequestProperty("Authorization", "Bearer " + token);
            byte[] body = MAPPER.writeValueAsBytes(payload);
            connection.setFixedLengthStreamingMode(body.length);
            try (OutputStream output = connection.getOutputStream()) {
                output.write(body);
            }
            int status = connection.getResponseCode();
            InputStream input = status >= 200 && status < 300
                    ? connection.getInputStream() : connection.getErrorStream();
            String response = input == null ? "" : readUtf8(input);
            result.put("httpStatus", Integer.valueOf(status));
            if (status == 200 && isValide(response)) {
                result.put("statut", "VALIDE");
            } else if (status == 400) {
                Object parsed = response.trim().isEmpty() ? null : MAPPER.readValue(response, Object.class);
                List<String> errors = extractErrors(parsed);
                if (!errors.isEmpty()) {
                    result.put("statut", "A_CORRIGER");
                    result.put("errors", errors);
                } else {
                    result.put("statut", "INDISPONIBLE");
                    result.put("errors", singleError("n8n a répondu HTTP 400 sans liste d'erreurs."));
                }
            } else {
                result.put("statut", "INDISPONIBLE");
                result.put("errors", singleError("n8n a répondu HTTP " + status + "."));
            }
        } catch (Exception exception) {
            result.put("statut", "INDISPONIBLE");
            result.put("errors", singleError("Validation n8n Utilisateur non reçue : " + exception.getClass().getSimpleName() + "."));
        } finally {
            if (connection != null) {
                connection.disconnect();
            }
        }
        return result;
    }

    private static boolean isValide(String response) {
        if (response == null || response.trim().isEmpty()) {
            return false;
        }
        try {
            Map<String, Object> map = firstObject(MAPPER.readValue(response, Object.class));
            if (map == null) {
                return false;
            }
            Object value = map.get("valide");
            return Boolean.TRUE.equals(value) || "true".equalsIgnoreCase(String.valueOf(value));
        } catch (Exception exception) {
            return false;
        }
    }

    @SuppressWarnings("unchecked")
    private static List<String> extractErrors(Object parsed) {
        List<String> errors = new ArrayList<String>();
        Map<String, Object> map = firstObject(parsed);
        if (map == null) {
            return errors;
        }
        Object raw = map.get("errors");
        if (raw == null) {
            raw = map.get("erreurs");
        }
        if (raw == null) {
            return errors;
        }
        if (raw instanceof List) {
            for (Object item : (List<?>) raw) {
                if (item == null) {
                    continue;
                }
                if (item instanceof Map) {
                    errors.add(formatObjectError((Map<?, ?>) item));
                } else {
                    errors.add(String.valueOf(item));
                }
            }
        } else if (raw instanceof Map) {
            errors.add(formatObjectError((Map<?, ?>) raw));
        } else {
            String text = String.valueOf(raw);
            if (!text.trim().isEmpty()) {
                errors.add(text);
            }
        }
        return errors;
    }

    private static String formatObjectError(Map<?, ?> itemMap) {
        Object field = itemMap.get("field");
        Object message = itemMap.get("message");
        if (message == null) {
            message = itemMap.get("msg");
        }
        if (message == null) {
            message = itemMap.get("error");
        }
        if (field != null && message != null) {
            return String.valueOf(field) + " : " + String.valueOf(message);
        }
        if (message != null) {
            return String.valueOf(message);
        }
        if (field != null) {
            return String.valueOf(field);
        }
        return String.valueOf(itemMap);
    }

    @SuppressWarnings("unchecked")
    private static Map<String, Object> firstObject(Object parsed) {
        if (parsed instanceof Map) {
            return (Map<String, Object>) parsed;
        }
        if (parsed instanceof List && !((List<?>) parsed).isEmpty()
                && ((List<?>) parsed).get(0) instanceof Map) {
            return (Map<String, Object>) ((List<?>) parsed).get(0);
        }
        return null;
    }

    private static List<String> singleError(String message) {
        List<String> errors = new ArrayList<String>();
        errors.add(message);
        return errors;
    }

    private static String readUtf8(InputStream input) throws Exception {
        try (InputStream stream = input; ByteArrayOutputStream output = new ByteArrayOutputStream()) {
            byte[] buffer = new byte[2048];
            int count;
            while ((count = stream.read(buffer)) != -1) {
                output.write(buffer, 0, count);
            }
            return new String(output.toByteArray(), StandardCharsets.UTF_8);
        }
    }

    private static String value(String value) {
        return value == null ? "" : value;
    }
}
