package mg.spat.automation.coherence;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

/** Read-only check: does the tiers of a BED match the tiers of its linked invoices? */
@Repository
@ConditionalOnProperty(name = "spat.readonly.enabled", havingValue = "true")
public class BedCoherenceReadRepository {
    private static final String SQL =
            "SELECT B.TIERS AS TIERS_BED, TB.NOM AS NOM_BED, F.ID AS FACTURE, "
            + "F.TIERS AS TIERS_FACTURE, TF.NOM AS NOM_FACTURE "
            + "FROM SPAT_CAPITAINERIE.BORDEREAUFF B "
            + "JOIN SPAT_CAPITAINERIE.LIAISONBORDEREAUFF L ON L.IDBORDEREAU = B.ID "
            + "JOIN SPAT_CAPITAINERIE.FACTURE_FOURNISSEUR_MERE F ON F.ID = L.IDOP "
            + "LEFT JOIN SPAT_CAPITAINERIE.TIERS TB ON TB.ID = B.TIERS "
            + "LEFT JOIN SPAT_CAPITAINERIE.TIERS TF ON TF.ID = F.TIERS "
            + "WHERE B.ID = ? ORDER BY F.ID";

    private final JdbcTemplate jdbc;

    public BedCoherenceReadRepository(JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    public BedCoherenceResponse check(String bedId) {
        List<Row> rows = jdbc.query(SQL, (rs, n) -> new Row(
                rs.getString("TIERS_BED"), rs.getString("NOM_BED"), rs.getString("FACTURE"),
                rs.getString("TIERS_FACTURE"), rs.getString("NOM_FACTURE")), bedId);
        if (rows.isEmpty()) {
            return new BedCoherenceResponse("A_VERIFIER", "Aucune facture liee a ce BED en base.");
        }
        Row first = rows.get(0);
        List<String> ecarts = new ArrayList<>();
        for (Row r : rows) {
            if (!Objects.equals(trim(r.tiersBed()), trim(r.tiersFacture()))) {
                ecarts.add("facture " + r.facture() + " : tiers " + label(r.tiersFacture(), r.nomFacture()));
            }
        }
        if (ecarts.isEmpty()) {
            return new BedCoherenceResponse("VALIDE",
                    "Tiers du BED identique a celui de " + rows.size() + " facture(s).");
        }
        String message = "Le tiers du BED (" + label(first.tiersBed(), first.nomBed())
                + ") differe de celui de : " + String.join(" ; ", ecarts.subList(0, Math.min(3, ecarts.size())));
        return new BedCoherenceResponse("A_VERIFIER", message);
    }

    private static String trim(String value) {
        return value == null ? null : value.trim();
    }

    private static String label(String id, String nom) {
        if (nom == null || nom.trim().isEmpty()) {
            return String.valueOf(id);
        }
        return nom.trim() + " [" + id + "]";
    }

    private record Row(String tiersBed, String nomBed, String facture, String tiersFacture, String nomFacture) { }
}
