package mg.spat.automation.validation;

import java.util.List;

public record ValidationResponse(String statut, String idBonLivraison, String idBonCommande,
                                 List<ControleLigne> lignes) {
    public record ControleLigne(String idLigneLivraison, boolean valide, List<String> ecarts) { }
}
