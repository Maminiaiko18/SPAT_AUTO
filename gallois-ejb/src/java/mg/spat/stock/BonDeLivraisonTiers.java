package mg.spat.stock;

public class BonDeLivraisonTiers extends BonDeLivraison{
    private String fournisseur;
    private String fournisseurLib;

    public String getFournisseur() {
        return fournisseur;
    }

    public void setFournisseur(String fournisseur) {
        this.fournisseur = fournisseur;
    }

    public String getFournisseurLib() {
        return fournisseurLib;
    }

    public void setFournisseurLib(String fournisseurLib) {
        this.fournisseurLib = fournisseurLib;
    }

    public BonDeLivraisonTiers() {
        this.setNomTable("AS_BONDELIVRAISON_MTTCPL_Tiers");
    }
}
