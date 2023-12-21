package mg.spat;

public class EngagementLib extends Engagement{
    
    String idfacturefournisseur;
    double montantengager;
    String chantier, idtravaux, idcontrat;
    
    public EngagementLib()
    {
        this.setNomTable("LIAISONENGAGEMENTFF");
    }
    public String getidfacturefournisseur()
    {
        return idfacturefournisseur;
    }
    public void setIdfacturefournisseur(String idfacturefournisseur)
    {
        this.idfacturefournisseur=idfacturefournisseur;
    }

    public double getMontantengager() {
        return montantengager;
    }

    public void setMontantengager(double montantengager) {
        this.montantengager = montantengager;
    }

    public String getChantier() {
        return chantier;
    }

    public void setChantier(String chantier) {
        this.chantier = chantier;
    }

    public String getIdtravaux() {
        return idtravaux;
    }

    public void setIdtravaux(String idtravaux) {
        this.idtravaux = idtravaux;
    }

    public String getIdcontrat() {
        return idcontrat;
    }

    public void setIdcontrat(String idcontrat) {
        this.idcontrat = idcontrat;
    }
    
}
