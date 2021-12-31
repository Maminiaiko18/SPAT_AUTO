/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import utilitaire.Utilitaire;


public class CaPDF {
    String id, libelle,compteMere,compteMerelib,compte; 
    String anciencumul, regul, regulEETP, avoirEETP, comptant, credit, esttotal,taux,avoir,montant,AvoirCumRegul;
    String nbComptant,nbCredit,mois,annee;
    String total, nCumul;

    public String getnCumul() {
        return nCumul;
    }

    public void setnCumul(String nCumul) {
        this.nCumul = nCumul;
    }

    public CaPDF() {
    }
    
    public CaPDF(CA ca) {
        this.setLibelle(ca.getLibelle());
        this.setAnciencumul(Utilitaire.formaterAr(ca.getAnciencumul()));
        this.setRegul(Utilitaire.formaterAr(ca.getRegul()));
        this.setRegulEETP(Utilitaire.formaterAr(ca.getRegulEETP()));
        this.setAvoirCumRegul(Utilitaire.formaterAr(ca.getAvoirCumRegul()));
        this.setAvoirEETP( Utilitaire.formaterAr(ca.getAvoirEETP()));
        this.setComptant( Utilitaire.formaterAr(ca.getComptant()));
        this.setCredit(Utilitaire.formaterAr(ca.getCredit()));
        this.setTotal( Utilitaire.formaterAr(ca.getTotal()));
        this.setnCumul(Utilitaire.formaterAr(ca.getNCumul()));
        this.setTaux( Utilitaire.formaterAr(ca.getTaux()));
    }

    
    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }

    
    
    public String getAvoirCumRegul() {
        return AvoirCumRegul;
    }

    public void setAvoirCumRegul(String AvoirCumRegul) {
        this.AvoirCumRegul = AvoirCumRegul;
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

    public String getCompte() {
        return compte;
    }

    public void setCompte(String compte) {
        this.compte = compte;
    }

    public String getAnciencumul() {
        return anciencumul;
    }

    public void setAnciencumul(String anciencumul) {
        this.anciencumul = anciencumul;
    }

    public String getRegul() {
        return regul;
    }

    public void setRegul(String regul) {
        this.regul = regul;
    }

    public String getRegulEETP() {
        return regulEETP;
    }

    public void setRegulEETP(String regulEETP) {
        this.regulEETP = regulEETP;
    }

    public String getAvoirEETP() {
        return avoirEETP;
    }

    public void setAvoirEETP(String avoirEETP) {
        this.avoirEETP = avoirEETP;
    }

    public String getComptant() {
        return comptant;
    }

    public void setComptant(String comptant) {
        this.comptant = comptant;
    }

    public String getCredit() {
        return credit;
    }

    public void setCredit(String credit) {
        this.credit = credit;
    }

    public String getEsttotal() {
        return esttotal;
    }

    public void setEsttotal(String esttotal) {
        this.esttotal = esttotal;
    }

    public String getTaux() {
        return taux;
    }

    public void setTaux(String taux) {
        this.taux = taux;
    }

    public String getAvoir() {
        return avoir;
    }

    public void setAvoir(String avoir) {
        this.avoir = avoir;
    }

    public String getMontant() {
        return montant;
    }

    public void setMontant(String montant) {
        this.montant = montant;
    }

    public String getNbComptant() {
        return nbComptant;
    }

    public void setNbComptant(String nbComptant) {
        this.nbComptant = nbComptant;
    }

    public String getNbCredit() {
        return nbCredit;
    }

    public void setNbCredit(String nbCredit) {
        this.nbCredit = nbCredit;
    }

    public String getMois() {
        return mois;
    }

    public void setMois(String mois) {
        this.mois = mois;
    }

    public String getAnnee() {
        return annee;
    }

    public void setAnnee(String annee) {
        this.annee = annee;
    }
    
    
}
