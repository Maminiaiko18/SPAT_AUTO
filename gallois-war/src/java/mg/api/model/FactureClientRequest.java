package mg.port.api.model;

import java.util.List;

public class FactureClientRequest {

    private FactureClientDTO facture;
    private List<FactureClientLigneDTO> details;

    public FactureClientDTO getFacture() {
        return facture;
    }

    public void setFacture(FactureClientDTO facture) {
        this.facture = facture;
    }

    public List<FactureClientLigneDTO> getDetails() {
        return details;
    }

    public void setDetails(List<FactureClientLigneDTO> details) {
        this.details = details;
    }
}