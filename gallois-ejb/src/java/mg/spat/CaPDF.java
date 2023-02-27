/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import utilitaire.Utilitaire;


public class CaPDF {
    String id, libelle,compteMere,compteMerelib,compte; 
    double anciencumul, regul, regulEETP, avoirEETP, comptant, credit, esttotal,taux,avoir,montant,AvoirCumRegul;
    String nbComptant,nbCredit,mois,annee;
    double  total, nCumul;

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

    public double getTaux() {
        return taux;
    }

    public void setTaux(double taux) {
        this.taux = taux;
    }

    public double getAvoir() {
        return avoir;
    }

    public void setAvoir(double avoir) {
        this.avoir = avoir;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public double getAvoirCumRegul() {
        return AvoirCumRegul;
    }

    public void setAvoirCumRegul(double AvoirCumRegul) {
        this.AvoirCumRegul = AvoirCumRegul;
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

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public double getnCumul() {
        return nCumul;
    }

    public void setnCumul(double nCumul) {
        this.nCumul = nCumul;
    }
    
    
    public CaPDF() {
    }
    
    public CaPDF(CA ca) {
        this.setLibelle(ca.getLibelle());
        this.setAnciencumul(ca.getAnciencumul());
        this.setRegul(ca.getRegul());
        this.setRegulEETP(ca.getRegulEETP());
        this.setAvoirCumRegul(ca.getAvoirCumRegul());
        this.setAvoirEETP(ca.getAvoirEETP());
        this.setComptant( ca.getComptant());
        this.setCredit(ca.getCredit());
        this.setTotal( ca.getTotal());
        this.setnCumul(ca.getNCumul());
        this.setTaux( ca.getTaux());
    }
}

    
    