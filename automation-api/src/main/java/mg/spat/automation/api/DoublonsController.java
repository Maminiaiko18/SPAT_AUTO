package mg.spat.automation.api;

import mg.spat.automation.doublons.DoublonsResponse;
import mg.spat.automation.doublons.TiersDoublonsReadRepository;
import mg.spat.automation.doublons.UtilisateurDoublonsReadRepository;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/** Read-only duplicate search used by the n8n post-save control workflows. */
@RestController
@RequestMapping("/api/v1")
public class DoublonsController {
    private final ObjectProvider<TiersDoublonsReadRepository> tiersRepository;
    private final ObjectProvider<UtilisateurDoublonsReadRepository> utilisateurRepository;

    public DoublonsController(ObjectProvider<TiersDoublonsReadRepository> tiersRepository,
            ObjectProvider<UtilisateurDoublonsReadRepository> utilisateurRepository) {
        this.tiersRepository = tiersRepository;
        this.utilisateurRepository = utilisateurRepository;
    }

    @GetMapping("/tiers/doublons")
    public ResponseEntity<?> getTiers(@ModelAttribute TiersDoublonsRequest request) {
        return findTiers(request);
    }

    @PostMapping("/tiers/doublons")
    public ResponseEntity<?> postTiers(@RequestBody TiersDoublonsRequest request) {
        return findTiers(request);
    }

    @GetMapping("/utilisateurs/doublons")
    public ResponseEntity<?> getUtilisateurs(@ModelAttribute UtilisateurDoublonsRequest request) {
        return findUtilisateurs(request);
    }

    @PostMapping("/utilisateurs/doublons")
    public ResponseEntity<?> postUtilisateurs(@RequestBody UtilisateurDoublonsRequest request) {
        return findUtilisateurs(request);
    }

    private ResponseEntity<?> findTiers(TiersDoublonsRequest request) {
        TiersDoublonsReadRepository repository = tiersRepository.getIfAvailable();
        if (repository == null) {
            return unavailable();
        }
        return ResponseEntity.ok(DoublonsResponse.of(
                repository.find(request.nom(), request.nif(), request.stat(), request.idExclu())));
    }

    private ResponseEntity<?> findUtilisateurs(UtilisateurDoublonsRequest request) {
        UtilisateurDoublonsReadRepository repository = utilisateurRepository.getIfAvailable();
        if (repository == null) {
            return unavailable();
        }
        return ResponseEntity.ok(DoublonsResponse.of(
                repository.find(request.loginuser(), request.refuser())));
    }

    private static ResponseEntity<ValidationController.ServiceUnavailableResponse> unavailable() {
        return ResponseEntity.status(HttpStatus.SERVICE_UNAVAILABLE)
                .body(new ValidationController.ServiceUnavailableResponse("Oracle SPAT_RO non configuré"));
    }

    public record TiersDoublonsRequest(String nom, String nif, String stat, String idExclu) { }

    public record UtilisateurDoublonsRequest(String loginuser, String refuser) { }
}
