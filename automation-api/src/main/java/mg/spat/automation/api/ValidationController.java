package mg.spat.automation.api;

import jakarta.validation.Valid;
import java.sql.SQLException;
import mg.spat.automation.validation.InvoiceValidationService;
import mg.spat.automation.validation.ValidationRequest;
import mg.spat.automation.validation.ValidationResponse;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1")
public class ValidationController {
    private static final Logger log = LoggerFactory.getLogger(ValidationController.class);
    private final ObjectProvider<InvoiceValidationService> validationService;
    private final ObjectProvider<JdbcTemplate> jdbcTemplate;

    public ValidationController(ObjectProvider<InvoiceValidationService> validationService,
            ObjectProvider<JdbcTemplate> jdbcTemplate) {
        this.validationService = validationService;
        this.jdbcTemplate = jdbcTemplate;
    }

    @GetMapping("/health")
    public HealthResponse health() {
        return new HealthResponse("UP", "facture-automation-api");
    }

    @GetMapping("/ready")
    public ResponseEntity<ReadinessResponse> ready() {
        JdbcTemplate jdbc = jdbcTemplate.getIfAvailable();
        if (jdbc == null) {
            return ResponseEntity.status(HttpStatus.SERVICE_UNAVAILABLE)
                    .body(new ReadinessResponse("DOWN", "facture-automation-api", "Oracle SPAT_RO non configuré", "ORACLE_NOT_CONFIGURED"));
        }
        try {
            jdbc.queryForObject("SELECT 1 FROM dual", Integer.class);
            return ResponseEntity.ok(new ReadinessResponse("UP", "facture-automation-api", "Oracle SPAT_RO joignable", "OK"));
        } catch (DataAccessException e) {
            String code = oracleErrorCode(e);
            log.error("Le contrôle de disponibilité Oracle SPAT_RO a échoué ({})", code, e);
            return ResponseEntity.status(HttpStatus.SERVICE_UNAVAILABLE)
                    .body(new ReadinessResponse("DOWN", "facture-automation-api", "Lecture Oracle SPAT_RO indisponible", code));
        }
    }

    private static String oracleErrorCode(Throwable error) {
        for (Throwable cause = error; cause != null; cause = cause.getCause()) {
            if (cause instanceof SQLException sql && sql.getErrorCode() != 0) {
                return String.format("ORA-%05d", Math.abs(sql.getErrorCode()));
            }
        }
        return "ORACLE_READ_FAILED";
    }

    @PostMapping("/factures-fournisseurs/validation")
    public ResponseEntity<?> validate(@Valid @RequestBody ValidationRequest request) {
        InvoiceValidationService service = validationService.getIfAvailable();
        if (service == null) {
            return ResponseEntity.status(HttpStatus.SERVICE_UNAVAILABLE)
                    .body(new ServiceUnavailableResponse("Oracle SPAT_RO non configuré"));
        }
        return ResponseEntity.ok(service.validate(request));
    }

    public record HealthResponse(String status, String service) { }
    public record ReadinessResponse(String status, String service, String database, String oracleCode) { }
    public record ServiceUnavailableResponse(String erreur) { }
}
