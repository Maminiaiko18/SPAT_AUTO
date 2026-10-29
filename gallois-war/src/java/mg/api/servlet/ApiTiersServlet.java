package mg.port.api.servlet;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.UUID;
import java.security.MessageDigest;
import java.util.LinkedHashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import mg.port.api.dao.TiersDAO;
import mg.port.api.model.TiersCreateRequest;
import mg.spat.Tiers;

@WebServlet("/api/tiers")
public class ApiTiersServlet extends HttpServlet {

    private static final long MAX_DOCUMENT_BYTES = 10L * 1024L * 1024L;
    private static final long MAX_REQUEST_BYTES = 21L * 1024L * 1024L;

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

        File nifDocument = null;
        File statDocument = null;
        FileItem nifItem = null;
        FileItem statItem = null;
        boolean created = false;
        TiersCreateRequest body;
        try {
            if (!ServletFileUpload.isMultipartContent(request)) {
                sendError(response, HttpServletResponse.SC_BAD_REQUEST,
                        "La creation exige multipart/form-data avec payload, nifDocument et statDocument");
                return;
            }
            request.setCharacterEncoding("UTF-8");
            DiskFileItemFactory factory = new DiskFileItemFactory();
            factory.setSizeThreshold(512 * 1024);
            ServletFileUpload upload = new ServletFileUpload(factory);
            upload.setSizeMax(MAX_REQUEST_BYTES);
            upload.setFileSizeMax(MAX_DOCUMENT_BYTES);

            String payload = null;
            for (Object itemObject : upload.parseRequest(request)) {
                FileItem item = (FileItem) itemObject;
                if (item.isFormField() && "payload".equals(item.getFieldName())) {
                    if (payload != null) {
                        throw new IllegalArgumentException("Le champ payload doit être fourni une seule fois");
                    }
                    payload = item.getString("UTF-8");
                } else if (!item.isFormField() && "nifDocument".equals(item.getFieldName())) {
                    if (nifItem != null) {
                        throw new IllegalArgumentException("Un seul fichier nifDocument est autorisé");
                    }
                    nifItem = item;
                } else if (!item.isFormField() && "statDocument".equals(item.getFieldName())) {
                    if (statItem != null) {
                        throw new IllegalArgumentException("Un seul fichier statDocument est autorisé");
                    }
                    statItem = item;
                } else {
                    throw new IllegalArgumentException("Champ multipart non reconnu");
                }
            }
            if (isBlank(payload)) {
                throw new IllegalArgumentException("Le champ payload JSON est obligatoire");
            }
            body = mapper.readValue(payload, TiersCreateRequest.class);
            if (body.getVerificationJustificatifs() == null || !body.getVerificationJustificatifs()) {
                throw new IllegalArgumentException(
                        "L'appelant doit attester avoir vérifié les justificatifs NIF et STAT officiels");
            }
        } catch (JsonProcessingException e) {
            cleanupMultipartItems(nifItem, statItem);
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "JSON invalide");
            return;
        } catch (FileUploadException e) {
            cleanupMultipartItems(nifItem, statItem);
            sendError(response, HttpServletResponse.SC_REQUEST_ENTITY_TOO_LARGE,
                    "La requête dépasse la taille autorisée (10 Mo par justificatif)");
            return;
        } catch (IllegalArgumentException e) {
            cleanupMultipartItems(nifItem, statItem);
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
            return;
        } catch (Exception e) {
            cleanupMultipartItems(nifItem, statItem);
            getServletContext().log("Impossible de recevoir les justificatifs NIF/STAT", e);
            sendError(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "La reception des justificatifs a echoue");
            return;
        }

        if (body == null || isBlank(body.getNom()) || isBlank(body.getType())
                || isBlank(body.getNif()) || isBlank(body.getStat())) {
            cleanupMultipartItems(nifItem, statItem);
            sendError(response, HttpServletResponse.SC_BAD_REQUEST,
                    "Les champs nom, type, NIF et STAT sont obligatoires");
            return;
        }
        String nif = body.getNif().trim();
        String stat = body.getStat().trim();
        if (!nif.matches("[0-9]{10}")) {
            cleanupMultipartItems(nifItem, statItem);
            sendError(response, HttpServletResponse.SC_BAD_REQUEST,
                    "Le NIF doit contenir exactement 10 chiffres; conservez les zéros initiaux");
            return;
        }
        if (!stat.matches("[0-9]{17}")) {
            cleanupMultipartItems(nifItem, statItem);
            sendError(response, HttpServletResponse.SC_BAD_REQUEST,
                    "Le STAT doit contenir exactement 17 chiffres");
            return;
        }
        body.setNif(nif);
        body.setStat(stat);
        try {
            Tiers validator = new Tiers();
            // Tiers applique les contrôles NIF/STAT uniquement en mode modification.
            // Sans ce mode, les setters acceptent silencieusement les valeurs invalides.
            validator.setMode("modif");
            validator.setNif(body.getNif());
            validator.setStat(body.getStat());
            validator.setCin(body.getCin());
        } catch (Exception e) {
            cleanupMultipartItems(nifItem, statItem);
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
            return;
        }

        if (nifItem == null || statItem == null) {
            cleanupMultipartItems(nifItem, statItem);
            sendError(response, HttpServletResponse.SC_BAD_REQUEST,
                    "Les justificatifs nifDocument et statDocument sont obligatoires");
            return;
        }

        try {
            nifDocument = persistEvidence(nifItem, "nif");
            statDocument = persistEvidence(statItem, "stat");
        } catch (IllegalArgumentException e) {
            deleteQuietly(nifDocument);
            deleteQuietly(statDocument);
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
            return;
        } catch (Exception e) {
            deleteQuietly(nifDocument);
            deleteQuietly(statDocument);
            getServletContext().log("Impossible de stocker les justificatifs NIF/STAT", e);
            sendError(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Le stockage des justificatifs a echoue");
            return;
        } finally {
            cleanupMultipartItems(nifItem, statItem);
        }

        try {
            Tiers tiers = dao.create(body, userId.trim(), nifDocument.getName(), statDocument.getName());
            created = true;
            response.setStatus(HttpServletResponse.SC_CREATED);
            Map<String, Object> result = new LinkedHashMap<>();
            result.put("id", tiers.getId());
            result.put("nom", tiers.getNom());
            result.put("type", tiers.getType());
            result.put("etat", tiers.getEtat());
            result.put("justificatifsNifStatAttaches", Boolean.TRUE);
            mapper.writeValue(response.getWriter(), result);
        } catch (TiersDAO.DuplicateTierIdentifierException e) {
            sendError(response, HttpServletResponse.SC_CONFLICT, e.getMessage());
        } catch (IllegalArgumentException e) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
        } catch (Exception e) {
            getServletContext().log("Erreur API lors de la creation d'un tiers", e);
            sendError(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "La creation du tiers a echoue");
        } finally {
            if (!created) {
                deleteQuietly(nifDocument);
                deleteQuietly(statDocument);
            }
        }
    }

    private File persistEvidence(FileItem item, String kind) throws Exception {
        if (item.getSize() <= 0 || item.getSize() > MAX_DOCUMENT_BYTES) {
            throw new IllegalArgumentException("Chaque justificatif doit peser entre 1 octet et 10 Mo");
        }
        String extension = detectSafeExtension(item);
        String base = System.getProperty("jboss.server.base.dir");
        if (isBlank(base)) {
            throw new IllegalStateException("Répertoire de données WildFly indisponible");
        }
        File root = new File(new File(base, "deployments"), "dossier.war");
        File directory = new File(root, "travaux");
        if (!directory.exists() && !directory.mkdirs()) {
            throw new IOException("Impossible de créer le répertoire de justificatifs SPAT");
        }
        File canonicalRoot = root.getCanonicalFile();
        File target = new File(directory, "tiers-api-" + kind + "-" + UUID.randomUUID().toString() + extension)
                .getCanonicalFile();
        if (!target.toPath().startsWith(canonicalRoot.toPath())) {
            throw new SecurityException("Chemin de justificatif invalide");
        }
        item.write(target);
        return target;
    }

    private String detectSafeExtension(FileItem item) throws IOException {
        byte[] signature = new byte[8];
        int count;
        try (InputStream input = item.getInputStream()) {
            count = input.read(signature);
        }
        if (count >= 5 && signature[0] == '%' && signature[1] == 'P' && signature[2] == 'D'
                && signature[3] == 'F' && signature[4] == '-') {
            return ".pdf";
        }
        if (count >= 3 && (signature[0] & 0xff) == 0xff && (signature[1] & 0xff) == 0xd8
                && (signature[2] & 0xff) == 0xff) {
            return ".jpg";
        }
        if (count == 8 && (signature[0] & 0xff) == 0x89 && signature[1] == 'P'
                && signature[2] == 'N' && signature[3] == 'G' && (signature[4] & 0xff) == 0x0d
                && (signature[5] & 0xff) == 0x0a && (signature[6] & 0xff) == 0x1a
                && (signature[7] & 0xff) == 0x0a) {
            return ".png";
        }
        throw new IllegalArgumentException("Les justificatifs doivent être des PDF, JPEG ou PNG valides");
    }

    private void deleteQuietly(File file) {
        if (file != null && file.exists() && !file.delete()) {
            getServletContext().log("Impossible de supprimer un justificatif temporaire : " + file.getName());
        }
    }

    private void cleanupMultipartItems(FileItem nifItem, FileItem statItem) {
        if (nifItem != null) {
            nifItem.delete();
        }
        if (statItem != null) {
            statItem.delete();
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
