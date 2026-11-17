package mg.spat.automation.doublons;

import java.util.List;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

/** Read-only lookup of duplicate users in UTILISATEUR through the SPAT_RO account. */
@Repository
@ConditionalOnProperty(name = "spat.readonly.enabled", havingValue = "true")
public class UtilisateurDoublonsReadRepository {
    private static final String SQL = "SELECT TO_CHAR(REFUSER) AS ID, NOMUSER AS NOM "
            + "FROM SPAT_CAPITAINERIE.UTILISATEUR WHERE ";

    private final JdbcTemplate jdbc;

    public UtilisateurDoublonsReadRepository(JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    public List<DoublonsResponse.Doublon> find(String loginuser, String refuser) {
        if (loginuser == null || loginuser.trim().isEmpty()) {
            return List.of();
        }
        String sql = SQL + (refuser != null && !refuser.trim().isEmpty()
                ? "TO_CHAR(REFUSER) <> ? AND UPPER(TRIM(LOGINUSER)) = UPPER(?)"
                : "UPPER(TRIM(LOGINUSER)) = UPPER(?)") + " ORDER BY REFUSER";
        Object[] args = refuser != null && !refuser.trim().isEmpty()
                ? new Object[] { refuser.trim(), loginuser.trim() }
                : new Object[] { loginuser.trim() };
        return jdbc.query(sql, (rs, rowNum) ->
                new DoublonsResponse.Doublon(rs.getString("ID"), rs.getString("NOM")), args);
    }
}
