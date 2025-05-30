/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.CGenUtil;
import bean.ClassMAPTable;
import fin.Coursdevise;
import java.sql.Connection;
import utilitaire.Utilitaire;

/**
 *
 * @author Asus
 */
public class CA extends ClassMAPTable {
    String id, libelle,compteMere,compteMerelib,compte; 
    double anciencumul, regul, regulEETP, regulEETPINT, regulEETPEXT,avoirEETP, avoirEETPINT, avoirEETPEXT,comptant, credit, esttotal,taux,avoir, avoirinterne, avoirexterne, montant, reportAvoir;
    int nbComptant,nbCredit,mois,annee,moisFact,anneeFact, checkReport, nbFactureTotal;

    public double getAvoirexterne() {
        return avoirexterne;
    }

    public void setAvoirexterne(double avoirexterne) {
        this.avoirexterne = avoirexterne;
    }

    public double getAvoirinterne() {
        return avoirinterne;
    }

    public void setAvoirinterne(double avoirinterne) {
        this.avoirinterne = avoirinterne;
    }

    public int getMoisFact() {
        return moisFact;
    }

    public void setMoisFact(int moisFact) {
        this.moisFact = moisFact;
    }

    public int getAnneeFact() {
        return anneeFact;
    }

    public void setAnneeFact(int anneeFact) {
        this.anneeFact = anneeFact;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public double getAvoir() {
        return avoir;
    }

    public void setAvoir(double avoir) {
        this.avoir = avoir;
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

    public String getCompte() {
        return compte;
    }

    public void setCompte(String compte) {
        this.compte = compte;
    }

    public String getCompteMere() {
        return compteMere;
    }

    public void setCompteMere(String compteMere) {
        this.compteMere = compteMere;
    }

    public String getCompteMerelib() {
        return compteMerelib;
    }

    public void setCompteMerelib(String compteMerelib) {
        this.compteMerelib = compteMerelib;
    }
    
    public double getAvoirCumRegul()
    {
        return this.getAnciencumul() - this.getRegul() - this.getRegulEETP();
    }
    public double getTotal()
    {
        return this.getComptant() + this.getCredit() - this.getAvoirEETP();
    }
    public double getNCumul()
    {
        return this.getAvoirCumRegul() + this.getTotal();
    }

    public double getTaux() {
        return taux;
    }

    public void setTaux(double taux) {
        this.taux = taux;
    }

    public int getNbComptant() {
        return nbComptant;
    }

    public void setNbComptant(int nbComptant) {
        this.nbComptant = nbComptant;
    }

    public int getNbCredit() {
        return nbCredit;
    }

    public void setNbCredit(int nbCredit) {
        this.nbCredit = nbCredit;
    }
    

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

    public double getAnciencumul() {
        return anciencumul;
    }

    public void setAnciencumul(double anciencumul) {
        this.anciencumul = anciencumul;
    }

    public double getRegul() {
        return regul;
    }

    public void setRegul(double regul) {
        this.regul = regul;
    }

    public double getRegulEETP() {
        return regulEETP;
    }

    public void setRegulEETP(double regulEETP) {
        this.regulEETP = regulEETP;
    }

    public double getAvoirEETP() {
        return avoirEETP;
    }

    public void setAvoirEETP(double avoirEETP) {
        this.avoirEETP = avoirEETP;
    }

    public double getComptant() {
        return comptant;
    }

    public void setComptant(double comptant) {
        this.comptant = comptant;
    }

    public double getCredit() {
        return credit;
    }

    public void setCredit(double credit) {
        this.credit = credit;
    }

    public double getEsttotal() {
        return esttotal;
    }

    public void setEsttotal(double esttotal) {
        this.esttotal = esttotal;
    }

    public double getReportAvoir() {
        return reportAvoir;
    }

    public void setReportAvoir(double reportAvoir) {
        this.reportAvoir = reportAvoir;
    }

    public int getCheckReport() {
        return checkReport;
    }

    public void setCheckReport(int checkReport) {
        this.checkReport = checkReport;
    }

    public int getNbFactureTotal() {
        return nbFactureTotal;
    }

    public void setNbFactureTotal(int nbFactureTotal) {
        this.nbFactureTotal = nbFactureTotal;
    }

    public double getRegulEETPINT() {
        return regulEETPINT;
    }

    public void setRegulEETPINT(double regulEETPINT) {
        this.regulEETPINT = regulEETPINT;
    }

    public double getRegulEETPEXT() {
        return regulEETPEXT;
    }

    public void setRegulEETPEXT(double regulEETPEXT) {
        this.regulEETPEXT = regulEETPEXT;
    }

    public double getAvoirEETPINT() {
        return avoirEETPINT;
    }

    public void setAvoirEETPINT(double avoirEETPINT) {
        this.avoirEETPINT = avoirEETPINT;
    }

    public double getAvoirEETPEXT() {
        return avoirEETPEXT;
    }

    public void setAvoirEETPEXT(double avoirEETPEXT) {
        this.avoirEETPEXT = avoirEETPEXT;
    }
    
    public CA() {
        this.setNomTable("CA_vide");
    }

    public CA(String id, String libelle, double anciencumul, double regul, double regulEETP, double regulEETPINT, double regulEETPEXT, double avoirEETP,double avoirEETPINT ,double avoirEETPEXT , double comptant, double credit, double esttotal) {
       
        this.setNomTable("CA_vide");
        this.setId(id);
        this.setLibelle(libelle);
        this.setAnciencumul(anciencumul);
        this.setRegul(regul);
        this.setRegulEETPINT(regulEETPINT);
        this.setRegulEETPEXT(regulEETPEXT);
        this.setRegulEETP(regulEETP);
        this.setAvoirEETP(avoirEETP);
        this.setAvoirEETPINT(avoirEETPINT);
        this.setAvoirEETPEXT(avoirEETPEXT);
        this.setComptant(comptant);
        this.setCredit(credit);
        this.setEsttotal(esttotal);
        
    }
    
    public void construirePK(Connection c) throws Exception {
        this.preparePk("MCA", "get_seqMereCA");
        this.setId(makePK(c));
    }
    
    @Override
    public String getTuppleID() {
        return "id";
    }

    @Override
    public String getAttributIDName() {
        return "";
    }
    
    public void convertirDevise(Coursdevise devise){
        if(devise!=null){
            this.setComptant(this.getComptant()/devise.getMontant());
            this.setCredit(this.getCredit()/devise.getMontant());
            this.setAvoir(this.getAvoir()/devise.getMontant());
            this.setMontant(this.getMontant()/devise.getMontant());
        }
    }
    
    
    
}
