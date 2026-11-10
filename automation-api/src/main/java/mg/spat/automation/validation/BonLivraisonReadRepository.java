package mg.spat.automation.validation;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.Optional;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

/** Read-only access to the delivery remainder view used by the existing SPAT invoice flow. */
@Repository
@ConditionalOnProperty(name = "spat.readonly.enabled", havingValue = "true")
public class BonLivraisonReadRepository {
    private static final String SQL = "SELECT v.QUANTITERESTE, v.PU "
            + "FROM SPAT_CAPITAINERIE.AS_BONDELIVRAISON_FILLEQTE_RES v "
            + "WHERE v.NUMBL = ? AND v.IDBONDECOMMANDEMERE = ? AND v.ID = ?";

    private static final String SQL_EXCLUDING_INVOICE = "SELECT "
            + "v.QUANTITE - (NVL(v.FACTURE, 0) - NVL((SELECT SUM(ff.QUANTITE) "
            + "FROM SPAT_CAPITAINERIE.FACTURE_FOURNISSEUR_FILLE ff "
            + "WHERE ff.IDBLF = v.ID AND ff.IDMERE = ?), 0)) AS QUANTITERESTE, v.PU "
            + "FROM SPAT_CAPITAINERIE.AS_BONDELIVRAISON_FILLEQTE_RES v "
            + "WHERE v.NUMBL = ? AND v.IDBONDECOMMANDEMERE = ? AND v.ID = ?";

    private final JdbcTemplate jdbc;

    public BonLivraisonReadRepository(JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    public Optional<DeliveryLine> findLine(String idBonLivraison, String idBonCommande, String idLigne,
            String idFactureFournisseur) {
        boolean excludeInvoice = idFactureFournisseur != null && !idFactureFournisseur.isBlank();
        String sql = excludeInvoice ? SQL_EXCLUDING_INVOICE : SQL;
        Object[] args = excludeInvoice
                ? new Object[] { idFactureFournisseur, idBonLivraison, idBonCommande, idLigne }
                : new Object[] { idBonLivraison, idBonCommande, idLigne };
        return jdbc.query(sql, rs -> {
            if (!rs.next()) return Optional.empty();
            Map<String, Object> columns = readColumns(rs);
            return Optional.of(new DeliveryLine(
                    decimal(columns, "QUANTITERESTE", "QUANTITE_RESTE"),
                    decimal(columns, "PU", "PRIXUNITAIRE", "PRIX_UNITAIRE")));
        }, args);
    }

    private static Map<String, Object> readColumns(ResultSet rs) throws SQLException {
        ResultSetMetaData metadata = rs.getMetaData();
        Map<String, Object> values = new HashMap<>();
        for (int i = 1; i <= metadata.getColumnCount(); i++) {
            values.put(metadata.getColumnLabel(i).toUpperCase(Locale.ROOT).replace(" ", ""), rs.getObject(i));
        }
        return values;
    }

    private static BigDecimal decimal(Map<String, Object> values, String... names) {
        for (String name : names) {
            Object value = values.get(name.replace(" ", ""));
            if (value instanceof BigDecimal decimal) return decimal;
            if (value instanceof Number number) return BigDecimal.valueOf(number.doubleValue());
        }
        throw new IllegalStateException("Colonne attendue absente de AS_BONDELIVRAISON_FILLEQTE_RES: "
                + String.join(" / ", names));
    }

    public record DeliveryLine(BigDecimal quantiteRestante, BigDecimal prixUnitaire) { }
}
