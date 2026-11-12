package mg.spat.automation;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;
import mg.spat.DemandeAchatFille;
import mg.spat.DemandeAchatMere;
import utilitaire.UtilDB;

/** Starts DASE validation after SPAT has committed the purchase request. */
public final class N8nDaseValidationService {
    private N8nDaseValidationService() { }

    public static void validateAfterSave(String daseClass, String detailClass,
            ClassMAPTable[] details, String daseId, HttpSession session) {
        if (!"mg.spat.DemandeAchatMere".equals(daseClass)
                || !"mg.spat.DemandeAchatFille".equals(detailClass)) {
            return;
        }

        Map<String, Object> result;
        try {
            result = buildAndValidate(details, daseId);
        } catch (Exception validationException) {
            result = new LinkedHashMap<String, Object>();
            result.put("statut", "INDISPONIBLE");
            result.put("errors", singleError("DASE enregistrée ; préparation de validation impossible ("
                    + validationException.getClass().getSimpleName() + ")."));
        }
        try {
            session.setAttribute("n8nDaseValidation:" + daseId, result);
        } catch (Exception sessionException) {
            return;
        }
    }

    private static Map<String, Object> buildAndValidate(ClassMAPTable[] details, String daseId)
            throws Exception {
        Connection connection = null;
        try {
            connection = new UtilDB().GetConn();
            DemandeAchatMere dase = (DemandeAchatMere) new DemandeAchatMere()
                    .getById(daseId, "dem_achat_mere", connection);
            if (dase == null) {
                return unavailable("DASE introuvable pour le contrôle n8n.");
            }
            Map<String, Object> payload = new LinkedHashMap<String, Object>();
            payload.put("mode", "controle");
            payload.put("daty", formatDaty(dase.getDaty()));
            payload.put("codeetablissement", value(dase.getCodeetablissement()));
            payload.put("projet", value(dase.getProjet()));
            payload.put("designation", value(dase.getDesignation()));
            payload.put("lignes", buildLignes(details));
            return N8nDaseValidationClient.validate(payload);
        } finally {
            if (connection != null) {
                connection.close();
            }
        }
    }

    private static List<Map<String, Object>> buildLignes(ClassMAPTable[] details) {
        List<Map<String, Object>> lignes = new ArrayList<Map<String, Object>>();
        for (int i = 0; details != null && i < details.length; i++) {
            if (!(details[i] instanceof DemandeAchatFille)) {
                continue;
            }
            DemandeAchatFille detail = (DemandeAchatFille) details[i];
            String designation = detail.getDesignation();
            String unite = detail.getUnite();
            double qte = detail.getQte();
            double pu = detail.getPu();
            if (designation == null || designation.trim().isEmpty()
                    || unite == null || unite.trim().isEmpty()
                    || qte <= 0 || pu < 0
                    || Double.isInfinite(qte) || Double.isNaN(qte)
                    || Double.isInfinite(pu) || Double.isNaN(pu)) {
                continue;
            }
            Map<String, Object> ligne = new LinkedHashMap<String, Object>();
            ligne.put("designation", designation.trim());
            ligne.put("unite", unite.trim());
            ligne.put("qte", Double.valueOf(qte));
            ligne.put("pu", Double.valueOf(pu));
            lignes.add(ligne);
        }
        return lignes;
    }

    private static String formatDaty(Object value) throws Exception {
        if (value == null) {
            throw new IllegalArgumentException("Date absente");
        }
        if (value instanceof Date) {
            return new SimpleDateFormat("yyyy-MM-dd").format((Date) value);
        }
        String text = value.toString().trim();
        SimpleDateFormat input;
        if (text.matches("[0-9]{2}/[0-9]{2}/[0-9]{4}")) {
            input = new SimpleDateFormat("dd/MM/yyyy");
        } else if (text.matches("[0-9]{4}-[0-9]{2}-[0-9]{2}")) {
            input = new SimpleDateFormat("yyyy-MM-dd");
        } else {
            throw new IllegalArgumentException("Format de date invalide");
        }
        input.setLenient(false);
        return new SimpleDateFormat("yyyy-MM-dd").format(input.parse(text));
    }

    private static Map<String, Object> unavailable(String message) {
        Map<String, Object> result = new LinkedHashMap<String, Object>();
        result.put("statut", "INDISPONIBLE");
        result.put("errors", singleError(message));
        return result;
    }

    private static List<String> singleError(String message) {
        List<String> errors = new ArrayList<String>();
        errors.add(message);
        return errors;
    }

    private static String value(String value) {
        return value == null ? "" : value;
    }
}
