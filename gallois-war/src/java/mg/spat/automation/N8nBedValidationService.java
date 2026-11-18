package mg.spat.automation;

import bean.ClassMAPTable;
import bordereau.BordereauFF;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;
import java.util.Locale;

/** Calls the configured n8n BED control webhook after SPAT has saved a bordereau. */
public final class N8nBedValidationService {
    private static final int CONNECT_TIMEOUT_MS = 5000;
    private static final int READ_TIMEOUT_MS = 10000;
    private static final String DEFAULT_ENDPOINT = "http://127.0.0.1:5678/webhook/spat/bed/controle";
    private static final ObjectMapper MAPPER = new ObjectMapper();

    private N8nBedValidationService() { }

    public static void validateAfterSave(String bedClass, ClassMAPTable created, String bedId, HttpSession session) {
        if (!"bordereau.BordereauFF".equals(bedClass) || !(created instanceof BordereauFF)) {
            return;
        }
        BordereauFF bed = (BordereauFF) created;
        String flashId = bedId;
        if (flashId == null || flashId.trim().isEmpty()) {
            flashId = bed.getTuppleID();
        }
        if (flashId == null || flashId.trim().isEmpty()) {
            flashId = bed.getId();
        }
        if (flashId == null || flashId.trim().isEmpty()) {
            return;
        }

        Map<String, Object> result;
        try {
            result = validate(bed, flashId);
        } catch (Exception validationException) {
            result = new LinkedHashMap<String, Object>();
            result.put("statut", "INDISPONIBLE");
            result.put("errors", singleError("BED enregistré ; préparation de validation impossible ("
                    + validationException.getClass().getSimpleName() + ")."));
        }
        try {
            session.setAttribute("n8nBedValidation:" + flashId, result);
        } catch (Exception sessionException) {
            return;
        }
    }

    private static Map<String, Object> validate(BordereauFF bed, String bedId) {
        Map<String, Object> result = new LinkedHashMap<String, Object>();
        String token = System.getenv("SPATERP_N8N_DASE_WEBHOOK_TOKEN");
        if (token == null || token.trim().isEmpty()) {
            result.put("statut", "INDISPONIBLE");
            result.put("errors", singleError("Jeton du webhook n8n non configuré (SPATERP_N8N_DASE_WEBHOOK_TOKEN)."));
            return result;
        }
        String endpoint = System.getProperty("spat.n8n.bed.webhook");
        if (endpoint == null || endpoint.trim().isEmpty()) {
            endpoint = DEFAULT_ENDPOINT;
        }

        HttpURLConnection connection = null;
        try {
            Map<String, Object> payload = new LinkedHashMap<String, Object>();
            payload.put("daty", formatDaty(bed.getDaty()));
            payload.put("anneebudgetaire", Integer.valueOf(bed.getAnneebudgetaire()));
            payload.put("designation", value(bed.getDesignation()));
            payload.put("typebordereau", value(bed.getTypebordereau()));
            payload.put("id", value(bedId));

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
                                Map<String, Object> n8nResponse = response == null || response.trim().isEmpty()
                        ? null : firstObject(MAPPER.readValue(response, Object.class));
                Object n8nStatut = n8nResponse == null ? null : n8nResponse.get("statut");
                if (n8nStatut != null) {
                    String bandeauStatut = String.valueOf(n8nStatut).trim().toUpperCase(Locale.ROOT);
                    if ("A_VERIFIER".equals(bandeauStatut) || "INDISPONIBLE".equals(bandeauStatut)) {
                        result.put("statut", bandeauStatut);
                        Object message = n8nResponse.get("message");
                        if (message != null && !String.valueOf(message).trim().isEmpty()) {
                            result.put("errors", singleError(String.valueOf(message)));
                        }
                    }
                }
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
            result.put("errors", singleError("Validation n8n BED non reçue : " + exception.getClass().getSimpleName() + "."));
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

    private static String formatDaty(Object value) {
        if (value == null) {
            return "";
        }
        try {
            return new SimpleDateFormat("yyyy-MM-dd").format((Date) value);
        } catch (Exception exception) {
            return "";
        }
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
