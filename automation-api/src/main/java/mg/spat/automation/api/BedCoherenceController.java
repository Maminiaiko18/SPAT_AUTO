package mg.spat.automation.api;

import mg.spat.automation.coherence.BedCoherenceReadRepository;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/** Read-only BED coherence check used by the n8n BED control workflow. */
@RestController
@RequestMapping("/api/v1")
public class BedCoherenceController {
    private final ObjectProvider<BedCoherenceReadRepository> repository;

    public BedCoherenceController(ObjectProvider<BedCoherenceReadRepository> repository) {
        this.repository = repository;
    }

    @GetMapping("/bed/coherence")
    public ResponseEntity<?> coherence(@RequestParam(name = "id", required = false) String id) {
        BedCoherenceReadRepository repo = repository.getIfAvailable();
        if (repo == null) {
            return ResponseEntity.status(HttpStatus.SERVICE_UNAVAILABLE)
                    .body(new ValidationController.ServiceUnavailableResponse("Oracle SPAT_RO non configure"));
        }
        if (id == null || id.trim().isEmpty()) {
            return ResponseEntity.badRequest().build();
        }
        return ResponseEntity.ok(repo.check(id.trim()));
    }
}