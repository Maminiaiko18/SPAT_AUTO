package mg.port.api.model;

/** Only the fields editable on a draft BED form are accepted by the API. */
public class BedModificationRequest {

    private String daty;
    private Integer anneebudgetaire;
    private String designation;
    private String typebordereau;

    public String getDaty() { return daty; }
    public void setDaty(String daty) { this.daty = daty; }
    public Integer getAnneebudgetaire() { return anneebudgetaire; }
    public void setAnneebudgetaire(Integer anneebudgetaire) { this.anneebudgetaire = anneebudgetaire; }
    public String getDesignation() { return designation; }
    public void setDesignation(String designation) { this.designation = designation; }
    public String getTypebordereau() { return typebordereau; }
    public void setTypebordereau(String typebordereau) { this.typebordereau = typebordereau; }
}
