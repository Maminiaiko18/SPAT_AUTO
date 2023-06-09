package mg.spat;

public class EngagementLib extends Engagement{
    
    String idfacturefournisseur;
    double montantengager;
    
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
    
}
