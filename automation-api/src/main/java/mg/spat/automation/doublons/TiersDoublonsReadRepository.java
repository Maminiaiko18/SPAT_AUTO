package mg.spat.automation.doublons;

import java.util.ArrayList;
import java.util.List;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

/** Read-only lookup of duplicate tiers in TIERS through the SPAT_RO account. */
@Repository
@ConditionalOnProperty(name = "spat.readonly.enabled", havingValue = "true")
public class TiersDoublonsReadRepository {
    private static final String SELECT = "SELECT ID, NOM FROM SPAT_CAPITAINERIE.TIERS WHERE ";

    private final JdbcTemplate jdbc;

    public TiersDoublonsReadRepository(JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    public List<DoublonsResponse.Doublon> find(String nom, String nif, String stat, String idExclu) {
        List<String> criteria = new ArrayList<>();
        List<Object> criterionArgs = new ArrayList<>();
        if (present(nif)) {
            criteria.add("NVL(TRIM(NIF), '') = ?");
            criterionArgs.add(nif.trim());
        }
        if (present(stat)) {
            criteria.add("NVL(TRIM(STAT), '') = ?");
            criterionArgs.add(stat.trim());
        }
        if (present(nom)) {
            criteria.add("UPPER(NVL(TRIM(NOM), '')) = UPPER(?)");
            criterionArgs.add(nom.trim());
        }
        if (criteria.isEmpty()) {
            return List.of();
        }

        List<Object> args = new ArrayList<>();
        StringBuilder sql = new StringBuilder(SELECT);
        if (present(idExclu)) {
            sql.append("ID <> ?");
            args.add(idExclu.trim());
        } else {
            sql.append("1 = 1");
        }
        sql.append(" AND (").append(String.join(" OR ", criteria)).append(") ORDER BY ID");
        args.addAll(criterionArgs);
        return jdbc.query(sql.toString(), (rs, rowNum) ->
                new DoublonsResponse.Doublon(rs.getString("ID"), rs.getString("NOM")), args.toArray());
    }

    private static boolean present(String value) {
        return value != null && !value.trim().isEmpty();
    }
}
