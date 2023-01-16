/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.CGenUtil;
import bean.ClassMAPTable;
import facture.FactureFournisseurDetails;
import java.sql.Connection;
import utilitaire.Constante;
import utilitaire.Utilitaire;

/**
 *
 * @author Nouta
 */
public class EngagementFille extends ClassMAPTable{
    private String id,idmere,designation,estPaye;
    private double montant;

    public String getEstPaye() {
        return estPaye;
    }

    public void setEstPaye(String estPaye) {
        this.estPaye = estPaye;
    }
    
    public EngagementFille() {
        super.setNomTable("engagement_fille");
    }

    public EngagementFille(String idMere,String designation,double montant)throws Exception{
        this.setNomTable("engagement_fille");
        this.setIdmere(idMere);
        this.setDesignation(designation);
        this.setMontant(montant);
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdmere() {
        return idmere;
    }

    public void setIdmere(String idmere) {
        this.idmere = idmere;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) throws Exception {
        if(this.getMode().compareToIgnoreCase("modif")==0&&(designation==null || designation == "")) throw new Exception("Désignation obligatoire");
        this.designation = designation;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) throws Exception {
       if(this.getMode().compareToIgnoreCase("modif")==0&&montant<=0) throw new Exception("montant invalide");
        this.montant = montant;
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("CR","GETSEQENGAGEMENT_FILLE");
        setId(makePK(c));
    }
    
    public FactureFournisseurDetails genererFactureFournisseurDetail(Connection c) throws Exception {
        
        Engagement eng = this.findEngagement("engagementlib",c);
        
        FactureFournisseurDetails ffd = new FactureFournisseurDetails();
        ffd.setDesignation(this.getDesignation());
        ffd.setQuantite(1);
        ffd.setPu(this.getMontant());
        ffd.setMois(Utilitaire.getMoisEnCoursReel());
        ffd.setAnnee(Utilitaire.getAneeEnCours());
        ffd.setDevise(Constante.deviseAr);
        ffd.setCompte(eng.getCodeEtablissementlib()+eng.getProjetlib());
        
        return ffd;
    }
    
    public Engagement findEngagement(String nomtable,Connection c)throws Exception{
        if(nomtable==null || nomtable.equals("")){
            nomtable = "engagement";
        }
        Engagement engagement = new Engagement();
        engagement.setNomTable(nomtable);
        Engagement[] reponse = (Engagement[])CGenUtil.rechercher(engagement, null, null, c, " and id='"+this.getIdmere()+"'");
        if(reponse.length>0){
            return reponse[0];
        }
        return null;
    }
}
