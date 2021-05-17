/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.CGenUtil;
import bean.ClassMAPTable;
import fin.Coursdevise;
import java.sql.Connection;
import utilitaire.Utilitaire;
/**
 *
 * @author
 */
public class FactureClientDetails extends ClassMAPTable {

    
    private String id,idmere;
    private double quantite,pu,taux;
    private String compte,idproduit,devise,designation;
    private FactureClient mere;
    private double montant;
    private double montanttaux;
    private double montantavoirsanstaux;
    private double montantavoiravectaux;
    private double qtelivree, restealivrer;

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
    
    
    public FactureClientDetails(){
        setNomTable("facture_client_fille");
    }
    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("FCF", "get_seq_facture_client_fille");
        setId(makePK(c));
    }

    @Override
    public ClassMAPTable createObject(String user, Connection c) throws Exception {
        setTaux(getTauxRecent(c));
        return super.createObject(user, c);
    }
    
    public double getTauxRecent(Connection c) throws Exception {
        String awhere = " and daty = (SELECT max(daty) FROM COURSDEVISE WHERE  daty <= '" + Utilitaire.datetostring(this.getMere().getDaty()) + "' and iddevise = '" + this.getDevise() + "') "
                + " and iddevise = '" + this.getDevise() + "'";
        Coursdevise[] cd = (Coursdevise[]) CGenUtil.rechercher(new Coursdevise(), null, null, c, awhere);
        
        if(cd != null && cd.length > 0) return cd[0].getMontant();
        
        return 0;
    }

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

    public void setMere(FactureClient mere) {
        this.mere = mere;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }
    
}
