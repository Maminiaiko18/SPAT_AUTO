package mg.spat.automation;

import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/** Calls the configured n8n production webhook after a supplier invoice is saved. */
public final class N8nInvoiceValidationClient {
    private static final int TIMEOUT_MS = 5000;
    private static final ObjectMapper MAPPER = new ObjectMapper();

    private N8nInvoiceValidationClient() { }

    @SuppressWarnings("unchecked")
    public static Map<String, Object> validate(Map<String, Object> payload) {
        Map<String, Object> result = new LinkedHashMap<String, Object>();
        String endpoint = System.getProperty("spat.n8n.validation.webhook");
        if (endpoint == null || endpoint.trim().isEmpty()) {
            endpoint = System.getenv("SPAT_N8N_VALIDATION_WEBHOOK_URL");
        }
        if (endpoint == null || endpoint.trim().isEmpty()) {
            result.put("statut", "INDISPONIBLE");
            result.put("ecarts", new String[] { "Webhook n8n non configuré (SPAT_N8N_VALIDATION_WEBHOOK_URL)." });
            return result;
        }

        HttpURLConnection connection = null;
        try {
            connection = (HttpURLConnection) new URL(endpoint).openConnection();
            connection.setRequestMethod("POST");
            connection.setConnectTimeout(TIMEOUT_MS);
            connection.setReadTimeout(TIMEOUT_MS);
            connection.setDoOutput(true);
            connection.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            byte[] body = MAPPER.writeValueAsBytes(payload);
            connection.setFixedLengthStreamingMode(body.length);
            try (OutputStream output = connection.getOutputStream()) {
                output.write(body);
            }
            int status = connection.getResponseCode();
            InputStream input = status >= 200 && status < 400
                    ? connection.getInputStream() : connection.getErrorStream();
            String response = input == null ? "" : readUtf8(input);
            result.put("httpStatus", Integer.valueOf(status));
            if (status < 200 || status >= 300) {
                result.put("statut", "INDISPONIBLE");
                result.put("ecarts", new String[] { "n8n a répondu HTTP " + status + "." });
            } else if (response.trim().isEmpty()) {
                result.put("statut", "A_VERIFIER");
                result.put("ecarts", new String[] { "n8n a répondu sans résultat de validation." });
            } else {
                Object parsed = MAPPER.readValue(response, Object.class);
                if (parsed instanceof Map) {
                    result.putAll((Map<String, Object>) parsed);
                } else if (parsed instanceof List && !((List<?>) parsed).isEmpty()
                        && ((List<?>) parsed).get(0) instanceof Map) {
                    result.putAll((Map<String, Object>) ((List<?>) parsed).get(0));
                } else {
                    result.put("statut", "A_VERIFIER");
                    result.put("reponse", parsed);
                    result.put("ecarts", new String[] { "Réponse n8n inattendue." });
                }
            }
        } catch (Exception exception) {
            result.put("statut", "INDISPONIBLE");
            result.put("ecarts", new String[] { "Validation n8n non reçue : " + exception.getClass().getSimpleName() + "." });
        } finally {
            if (connection != null) {
                connection.disconnect();
            }
        }
        return result;
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
}
