/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author rijan
 */
public class FactureFournisseurDetails extends FactureClientDetails{
    
    private String id , idmere , designation , compte , idproduit , devise , idactivite , rubrique , heureDebut , heureFin;
    private double quantite , pu , taux , tva , reduction , majoration , test;
    private Date datefact;
    private int mois , annee;
    
    public FactureFournisseurDetails() throws Exception{ 
        this.setNomTable("facture_client_fille");
    }

    public FactureFournisseurDetails(String id, String idmere, String designation, String compte, String idproduit, String devise, String idactivite, String rubrique, String heureDebut, String heureFin, double quantite, double pu, double taux, double tva, double reduction, double majoration, double test, Date datefact, int mois, int annee) throws Exception{
        this.setId(id);
        this.setIdmere(idmere);
        this.setDesignation(designation);
        this.setCompte(compte);
        this.setIdproduit(idproduit);
        this.setDevise(devise);
        this.setIdactivite(idactivite);
        this.setRubrique(rubrique);
        this.setHeureDebut(heureDebut);
        this.setHeureFin(heureFin);
        this.setQuantite(quantite);
        this.setPu(pu);
        this.setTaux(taux);
        this.setTva(tva);
        this.setReduction(reduction);
        this.setMajoration(majoration);
        this.setTest(test);
        this.setDatefact(datefact);
        this.setMois(mois);
        this.setAnnee(annee);
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

    public void setDesignation(String designation) {
        this.designation = designation;
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

    public String getIdactivite() {
        return idactivite;
    }

    public void setIdactivite(String idactivite) {
        this.idactivite = idactivite;
    }

    public String getRubrique() {
        return rubrique;
    }

    public void setRubrique(String rubrique) {
        this.rubrique = rubrique;
    }

    public String getHeureDebut() {
        return heureDebut;
    }

    public void setHeureDebut(String heureDebut) {
        this.heureDebut = heureDebut;
    }

    public String getHeureFin() {
        return heureFin;
    }

    public void setHeureFin(String heureFin) {
        this.heureFin = heureFin;
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

    public double getTva() {
        return tva;
    }

    public void setTva(double tva) {
        this.tva = tva;
    }

    public double getReduction() {
        return reduction;
    }

    public void setReduction(double reduction) {
        this.reduction = reduction;
    }

    public double getMajoration() {
        return majoration;
    }

    public void setMajoration(double majoration) {
        this.majoration = majoration;
    }

    public double getTest() {
        return test;
    }

    public void setTest(double test) {
        this.test = test;
    }

    public Date getDatefact() {
        return datefact;
    }

    public void setDatefact(Date datefact) {
        this.datefact = datefact;
    }

    public int getMois() {
        return mois;
    }

    public void setMois(int mois) {
        this.mois = mois;
    }

    public int getAnnee() {
        return annee;
    }

    public void setAnnee(int annee) {
        this.annee = annee;
    }
    
    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("FFD", "get_seq_factFournFille");
        this.setId(makePK(c));
    }
}
