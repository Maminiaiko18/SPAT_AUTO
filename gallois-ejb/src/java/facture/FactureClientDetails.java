/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.CGenUtil;
import bean.ClassFille;
import bean.ClassMAPTable;
import fin.Coursdevise;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.Utilitaire;
/**
 *
 * @author
 */
public class FactureClientDetails extends ClassFille {

    
    private String id,idmere;
    private double quantite,pu,taux;
    private String compte,idproduit,devise,designation, idProduitLib,idactivite,categorieFacturelib;
    private FactureClient mere;
    private double montant;
    private double montanttaux;
    private double montantavoirsanstaux;
    private double montantavoiravectaux;
    private double qtelivree, restealivrer; 
    
    
    @Override
    public String getValColLibelle() {
        return getLibDesignation()+";"+Utilitaire.formaterAr(montanttaux)+";"+Utilitaire.formaterAr(montanttaux)+";"+devise;
    }
    
    public String getLibDesignation(){
        return designation==null || designation.equals("") ? id : designation;
    }
    
    public String getIdProduitLib() {
        return idProduitLib;
    }

    public void setIdProduitLib(String idProduitLib) {
        this.idProduitLib = idProduitLib;
    }

    public double getQtelivree() {
        return qtelivree;
    }

    public void setQtelivree(double qtelivree) {
        this.qtelivree = qtelivree;
    }

    public double getRestealivrer() {
        return restealivrer;
    }

    public void setRestealivrer(double restealivrer) {
        this.restealivrer = restealivrer;
    }

    public double getMontantavoirsanstaux() {
        return montantavoirsanstaux;
    }

    public void setMontantavoirsanstaux(double montantavoirsanstaux) {
        this.montantavoirsanstaux = montantavoirsanstaux;
    }

    public double getMontantavoiravectaux() {
        return montantavoiravectaux;
    }

    public void setMontantavoiravectaux(double montantavoiravectaux) {
        this.montantavoiravectaux = montantavoiravectaux;
    }
   

    public double getMontanttaux() {
        return montanttaux;
    }

    public void setMontanttaux(double montanttaux) {
        this.montanttaux = montanttaux;
    }
    
    
    public FactureClientDetails() throws Exception{
        setNomTable("facture_client_fille");
        this.setNomClasseMere("facture.FactureClient");
        this.setLiaisonMere("idmere");
    }
    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("FCF", "get_seq_facture_client_fille");
        setId(makePK(c));
    }

    @Override
    public String getLiaisonMere() {
        return "idmere";
    }

    @Override
    public ClassMAPTable createObject(String user, Connection c) throws Exception {
        setTaux(getTauxRecent(c));
        return super.createObject(user, c);
    }
    
    public double getTauxRecent(Connection c) throws Exception {
         //this.setLiaisonMere("idmere");
         //this.setNomClasseMere("facture.FactureClient");
         System.out.println("liaison mere "+this.getLiaisonMere());
        Date date = ((FactureClient)this.findMere("",c)).getDaty();
        String awhere = " and daty = (SELECT max(daty) FROM COURSDEVISE WHERE  daty <= '" + Utilitaire.datetostring(date) + "' and iddevise = '" + this.getDevise() + "') "
                + " and iddevise = '" + this.getDevise() + "'";
        Coursdevise[] cd = (Coursdevise[]) CGenUtil.rechercher(new Coursdevise(), null, null, c, awhere);
        
        if(cd != null && cd.length > 0) return cd[0].getMontant();
        
        return 0;
    }
    
    /*public FactureClient getMere(Connection c) throws Exception {
        if(this.getMere() != null){
            return this.getMere();
        }
        FactureClient mere = new FactureClient();
        mere.setId(idmere);
        mere = (FactureClient) mere.getById(idmere, null, c);
        if(mere == null){
            throw new Exception("FactureClient mere non trouvee !");
        }
        return mere;
    }*/

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
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

    public double getQuantite() {
        return quantite;
    }

    public void setQuantite(double quantite) {
        this.quantite = quantite;
    }

    public double getPu() {
        return pu;
    }

    public void setPu(double pu) {
        this.pu = pu;
    }

    public double getTaux() {
        return taux;
    }

    public void setTaux(double taux) {
        this.taux = taux;
    }

    public String getCompte() {
        return compte;
    }

    public void setCompte(String compte) {
        this.compte = compte;
    }

    public String getIdproduit() {
        return idproduit;
    }

    public void setIdproduit(String idproduit) {
        this.idproduit = idproduit;
    }

    public String getDevise() {
        return devise;
    }

    public void setDevise(String devise) {
        this.devise = devise;
    }
    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public FactureClient getMere() {
        return mere;
    }

    /*public void setMere(FactureClient mere) {
        this.mere = mere;
    }*/

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }
    public String getIdactivite() {
        return idactivite;
    }

    public void setIdactivite(String idactivite) {
        this.idactivite = idactivite;
    }
    
    public String getCategorieFacturelib() {
        return categorieFacturelib;
    }

    public void setCategorieFacturelib(String categorieFacturelib) {
        this.categorieFacturelib = categorieFacturelib;
    }
}
