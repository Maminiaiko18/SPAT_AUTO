package mg.spat.automation.validation;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import mg.spat.automation.validation.ValidationResponse.ControleLigne;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@ConditionalOnProperty(name = "spat.readonly.enabled", havingValue = "true")
public class InvoiceValidationService {
    private final BonLivraisonReadRepository repository;

    public InvoiceValidationService(BonLivraisonReadRepository repository) {
        this.repository = repository;
    }

    @Transactional(readOnly = true)
    public ValidationResponse validate(ValidationRequest request) {
        List<ControleLigne> results = new ArrayList<>();
        Set<String> seen = new HashSet<>();

        for (ValidationRequest.Ligne proposed : request.lignes()) {
            List<String> issues = new ArrayList<>();
            if (!seen.add(proposed.idLigneLivraison())) {
                issues.add("La ligne est présente plusieurs fois dans la demande.");
            } else {
                var stored = repository.findLine(request.idBonLivraison(), request.idBonCommande(),
                        proposed.idLigneLivraison());
                if (stored.isEmpty()) {
                    issues.add("Ligne introuvable pour ce bon de livraison et ce bon de commande.");
                } else {
                    BonLivraisonReadRepository.DeliveryLine line = stored.get();
                    if (proposed.quantite().compareTo(line.quantiteRestante()) > 0) {
                        issues.add("La quantité proposée dépasse le reste à facturer ("
                                + line.quantiteRestante().toPlainString() + ").");
                    }
                    if (proposed.prixUnitaire().compareTo(line.prixUnitaire()) != 0) {
                        issues.add("Le prix unitaire proposé diffère du prix du bon de livraison ("
                                + line.prixUnitaire().toPlainString() + ").");
                    }
                }
            }
            results.add(new ControleLigne(proposed.idLigneLivraison(), issues.isEmpty(), List.copyOf(issues)));
        }

        boolean valid = results.stream().allMatch(ControleLigne::valide);
        return new ValidationResponse(valid ? "VALIDE" : "A_CORRIGER",
                request.idBonLivraison(), request.idBonCommande(), List.copyOf(results));
    }
}
