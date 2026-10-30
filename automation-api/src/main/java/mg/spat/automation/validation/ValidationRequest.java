package mg.spat.automation.validation;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import java.math.BigDecimal;
import java.util.List;

public record ValidationRequest(
        @NotBlank String idBonLivraison,
        @NotBlank String idBonCommande,
        @NotEmpty List<@Valid Ligne> lignes) {

    public record Ligne(
            @NotBlank String idLigneLivraison,
            @NotNull @Positive BigDecimal quantite,
            @NotNull @Positive BigDecimal prixUnitaire) { }
}
