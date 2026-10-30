package mg.spat.automation;

import bean.ClassMAPTable;
import facture.FactureFournisseurDetails;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;
import mg.spat.stock.BonDeLivraisonFilleReste;
import utilitaire.UtilDB;

/** Starts invoice validation after SPAT has committed the supplier invoice. */
public final class N8nInvoiceValidationService {
    private N8nInvoiceValidationService() { }

    public static void validateAfterSave(String invoiceClass, String detailClass,
            ClassMAPTable[] details, String invoiceId, HttpSession session) {
        if (!"facture.FactureFournisseur".equals(invoiceClass)
                || !"facture.FactureFournisseurDetails".equals(detailClass)) {
            return;
        }

        List<Map<String, Object>> validations = new ArrayList<Map<String, Object>>();
        Map<String, Map<String, Object>> payloadsParBlEtCommande = new LinkedHashMap<String, Map<String, Object>>();
        try {
            int lignesEnvoyees = 0;
            Connection connection = null;
            try {
                connection = new UtilDB().GetConn();
                for (int i = 0; details != null && i < details.length; i++) {
                    FactureFournisseurDetails detail = (FactureFournisseurDetails) details[i];
                    String idLigneLivraison = detail.getIdBLF();
                    if (idLigneLivraison == null || idLigneLivraison.trim().isEmpty()) {
                        continue;
                    }
                    BonDeLivraisonFilleReste ligneBl = (BonDeLivraisonFilleReste) new BonDeLivraisonFilleReste()
                            .getById(idLigneLivraison, "AS_BONDELIVRAISON_FILLEQTE_RES", connection);
                    String numeroBl = ligneBl == null ? null : ligneBl.getNumbl();
                    String idBonCommande = ligneBl == null ? null : ligneBl.getIdbondecommandemere();
                    if (numeroBl == null || numeroBl.trim().isEmpty()
                            || idBonCommande == null || idBonCommande.trim().isEmpty()) {
                        continue;
                    }

                    String cleGroupe = numeroBl.length() + ":" + numeroBl + idBonCommande;
                    Map<String, Object> payload = payloadsParBlEtCommande.get(cleGroupe);
                    if (payload == null) {
                        payload = new LinkedHashMap<String, Object>();
                        payload.put("idFactureFournisseur", invoiceId);
                        payload.put("idBonLivraison", numeroBl);
                        payload.put("idBonCommande", idBonCommande);
                        payload.put("lignes", new ArrayList<Map<String, Object>>());
                        payloadsParBlEtCommande.put(cleGroupe, payload);
                    }
                    Map<String, Object> ligne = new LinkedHashMap<String, Object>();
                    ligne.put("idLigneLivraison", idLigneLivraison);
                    ligne.put("quantite", Double.valueOf(detail.getQuantite()));
                    ligne.put("prixUnitaire", Double.valueOf(detail.getPu()));
                    ((ArrayList<Map<String, Object>>) payload.get("lignes")).add(ligne);
                    lignesEnvoyees++;
                }
            } finally {
                if (connection != null) {
                    connection.close();
                }
            }

            if (lignesEnvoyees == 0) {
                Map<String, Object> erreur = new LinkedHashMap<String, Object>();
                erreur.put("statut", "INDISPONIBLE");
                erreur.put("ecarts", new String[] { "Aucune ligne de facture n’a pu être associée à son BL et à son bon de commande." });
                validations.add(erreur);
            } else {
                for (Map<String, Object> payload : payloadsParBlEtCommande.values()) {
                    validations.add(N8nInvoiceValidationClient.validate(payload));
                }
            }
        } catch (Exception validationException) {
            Map<String, Object> erreur = new LinkedHashMap<String, Object>();
            erreur.put("statut", "INDISPONIBLE");
            erreur.put("ecarts", new String[] { "Facture enregistrée ; préparation de validation impossible ("
                    + validationException.getClass().getSimpleName() + ")." });
            validations.add(erreur);
        }
        session.setAttribute("n8nInvoiceValidation:" + invoiceId, validations);
    }
}
