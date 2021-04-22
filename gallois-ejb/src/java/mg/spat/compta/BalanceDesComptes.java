/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.compta;

import utilitaire.Utilitaire;

/**
 *
 * @author Me
 */
public class BalanceDesComptes{
    String compte;
    String libelle_compte;
    double mouvementDebit;
    double mouvementCredit;
    double soldeDebiteur;
    double soldeCrediteur;
    String typecompte;
    double anterieurDebit;
    double anterieurCredit;
    String chiffre3;
    String chiffre2;
    String compteToSplit;
    double soldeMouvementDebit;
    double soldeMouvementCredit;

    public double getSoldeMouvementDebit() {
        return soldeMouvementDebit;
    }

    public void setSoldeMouvementDebit(double soldeMouvementDebit) {
        this.soldeMouvementDebit = soldeMouvementDebit;
    }

    public double getSoldeMouvementCredit() {
        return soldeMouvementCredit;
    }

    public void setSoldeMouvementCredit(double soldeMouvementCredit) {
        this.soldeMouvementCredit = soldeMouvementCredit;
    }

    public String getChiffre3() {
        return chiffre3;
    }

    public void setChiffre3(String chiffre3) {
        this.chiffre3 = chiffre3;
    }

    public String getChiffre2() {
        return chiffre2;
    }

    public void setChiffre2(String chiffre2) {
        this.chiffre2 = chiffre2;
    }

    public double getSoldeDebiteur() {
        return soldeDebiteur;
    }

    public void setSoldeDebiteur(double soldeDebiteur) {
        this.soldeDebiteur = soldeDebiteur;
    }

    public double getSoldeCrediteur() {
        return soldeCrediteur;
    }

    public void setSoldeCrediteur(double soldeCrediteur) {
       this.soldeCrediteur = soldeCrediteur;
    }

    public double getMouvementDebit() {
        return mouvementDebit;
    }

    public void setMouvementDebit(double mouvementDebit) {
        this.mouvementDebit = mouvementDebit;
    }

    public double getMouvementCredit() {
        return mouvementCredit;
    }

    public void setMouvementCredit(double mouvementCredit) {
        this.mouvementCredit = mouvementCredit;
    }

    public double getAnterieurDebit() {
        return anterieurDebit;
    }

    public void setAnterieurDebit(double anterieurDebit) {
        this.anterieurDebit = anterieurDebit;
    }

    public double getAnterieurCredit() {
        return anterieurCredit;
    }

    public void setAnterieurCredit(double anterieurCredit) {
        this.anterieurCredit = anterieurCredit;
    }

    
    
    public String getTypecompte() {
        return typecompte;
    }

    public void setTypecompte(String typecompte) {
        this.typecompte = typecompte;
    }

    public BalanceDesComptes() {
    }

    public BalanceDesComptes(String compte, String libelle_compte, double mouvementDebit, double mouvementCredit, double soldeDebiteur, double soldeCrediteur, double anterieurDebit, double anterieurCredit) {
        this.setCompte(compte);
        this.setLibelle_compte(libelle_compte);
        this.setMouvementDebit(mouvementDebit);
        this.setMouvementCredit(mouvementCredit);
        this.setSoldeDebiteur(soldeDebiteur);
        this.setSoldeCrediteur(soldeCrediteur);
        this.setAnterieurDebit(anterieurDebit);
        this.setAnterieurCredit(anterieurCredit);
    }
    
    public BalanceDesComptes(String compte, String libelle_compte, double mouvementDebit, double mouvementCredit, double soldeDebiteur, double soldeCrediteur, double anterieurDebit, double anterieurCredit, double soldeMouvementDebit, double soldeMouvementCredit) {
        this.setCompte(compte);
        this.setLibelle_compte(libelle_compte);
        this.setMouvementDebit(mouvementDebit);
        this.setMouvementCredit(mouvementCredit);
        this.setSoldeDebiteur(soldeDebiteur);
        this.setSoldeCrediteur(soldeCrediteur);
        this.setAnterieurDebit(anterieurDebit);
        this.setAnterieurCredit(anterieurCredit);
        this.setSoldeMouvementDebit(soldeMouvementDebit);
        this.setSoldeMouvementCredit(soldeMouvementCredit);
    }

    public BalanceDesComptes(String compte, String libelle_compte, double mouvementDebit, double mouvementCredit, double anterieurDebit, double anterieurCredit, String chiffre3, String chiffre2) {
        this.compte = compte;
        this.libelle_compte = libelle_compte;
        this.mouvementDebit = mouvementDebit;
        this.mouvementCredit = mouvementCredit;
        this.anterieurDebit = anterieurDebit;
        this.anterieurCredit = anterieurCredit;
        this.chiffre3 = chiffre3;
        this.chiffre2 = chiffre2;
    }
    
    public BalanceDesComptes(String compte, String libelle_compte, String chiffre3, String chiffre2) {
        this.compte = compte;
        this.libelle_compte = libelle_compte;
        this.chiffre3 = chiffre3;
        this.chiffre2 = chiffre2;
    }

    public String getCompte() {
        return Utilitaire.champNull(compte);
    }

    public void setCompte(String compte) {
        this.compte = compte;
    }

    public String getLibelle_compte() {
        return Utilitaire.champNull(libelle_compte);
    }

    public void setLibelle_compte(String libelle_compte) {
        this.libelle_compte = libelle_compte;
    }
    
    public double[] valSolde(double debit, double credit){
        double solde = debit-credit;
        double[] ret = {0,0};
        if(solde>0){
            ret[0] = solde;
            ret[1] = 0;
        }
        else{
            ret[0] = 0;
            ret[1] = solde *(-1);
        }
        return ret;
    }   

    public String getCompteToSplit() {
        return compteToSplit;
    }

    public void setCompteToSplit(String compteToSplit) {
        this.compteToSplit = compteToSplit;
    }
    
    
    
}
