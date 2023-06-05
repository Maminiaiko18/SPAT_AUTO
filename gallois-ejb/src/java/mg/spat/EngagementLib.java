package mg.spat;

public class EngagementLib extends Engagement{
    
    String idfacturefournisseur;
    
    
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
}
