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
public class BalanceDesComptesAffichage{
    String compte;
    String libelle_compte;
    String mouvementDebit;
    String mouvementCredit;
    String soldeDebiteur;
    String soldeCrediteur;
    String typecompte;
    String anterieurDebit;
    String anterieurCredit;
    String compteToSplit;
    String soldeMouvementDebiteur;
    String soldeMouvementCrediteur;
   


    public String getSoldeMouvementDebiteur() {
        return soldeMouvementDebiteur;
    }

    public void setSoldeMouvementDebiteur(String soldeMouvementDebiteur) {
        if(soldeMouvementDebiteur.compareTo("0")==0){this.soldeMouvementDebiteur = "";return;}
        this.soldeMouvementDebiteur = soldeMouvementDebiteur;
    }

    public String getSoldeMouvementCrediteur() {
        return soldeMouvementCrediteur;
    }

    public void setSoldeMouvementCrediteur(String soldeMouvementCrediteur) {
        if(soldeMouvementCrediteur.compareTo("0")==0){ this.soldeMouvementCrediteur = "";return;}
        this.soldeMouvementCrediteur = soldeMouvementCrediteur;
    }

    public String getCompte() {
        return compte;
    }

    public void setCompte(String compte) {
        this.compte = compte;
    }

    public String getLibelle_compte() {
        return libelle_compte;
    }

    public void setLibelle_compte(String libelle_compte) {
        this.libelle_compte = libelle_compte;
    }

    public String getMouvementDebit() {
        return mouvementDebit;
    }

    public void setMouvementDebit(String mouvementDebit) {
        if(mouvementDebit.compareTo("0")==0){this.mouvementDebit = "";return;}
        this.mouvementDebit = mouvementDebit;
    }

    public String getMouvementCredit() {
        return mouvementCredit;
    }

    public void setMouvementCredit(String mouvementCredit) {
        if(mouvementCredit.compareTo("0")==0){this.mouvementCredit = ""; return;}        
        this.mouvementCredit = mouvementCredit;
    }

    public String getSoldeDebiteur() {
        return soldeDebiteur;
    }

    public void setSoldeDebiteur(String soldeDebiteur) {
        if(soldeDebiteur.compareTo("0")==0){this.soldeDebiteur = "";  return;}        
        this.soldeDebiteur = soldeDebiteur;
    }

    public String getSoldeCrediteur() {
        return soldeCrediteur;
    }

    public void setSoldeCrediteur(String soldeCrediteur) {
        if(soldeCrediteur.compareTo("0")==0){ this.soldeCrediteur =""; return; }       
        this.soldeCrediteur = soldeCrediteur;
    }

    public String getTypecompte() {
        return typecompte;
    }

    public void setTypecompte(String typecompte) {
        this.typecompte = typecompte;
    }

    public String getAnterieurDebit() {
        return anterieurDebit;
    }

    public void setAnterieurDebit(String anterieurDebit) {
         if(anterieurDebit.compareTo("0")==0){this.anterieurDebit = ""; return;}
        
        this.anterieurDebit = anterieurDebit;
    }

    public String getAnterieurCredit() {
        return anterieurCredit;
    }

    public void setAnterieurCredit(String anterieurCredit) {
         if(anterieurCredit.compareTo("0")==0){this.anterieurCredit = ""; return;}
        this.anterieurCredit = anterieurCredit;
    }

    public BalanceDesComptesAffichage(String compte, String libelle_compte, String mouvementDebit, String mouvementCredit, String soldeDebiteur, String soldeCrediteur, String typecompte, String anterieurDebit, String anterieurCredit, String soldeMouvementDB, String soldeMouvementCR) {
        setCompte(compte);
        setLibelle_compte(libelle_compte);
        setMouvementDebit(mouvementDebit);
        setMouvementCredit(mouvementCredit);
        setSoldeDebiteur(soldeDebiteur);
        setSoldeCrediteur(soldeCrediteur);
        setTypecompte(typecompte);
        setAnterieurDebit(anterieurDebit);
        setAnterieurCredit(anterieurCredit);
        setSoldeMouvementDebiteur(soldeMouvementDB);
        setSoldeMouvementCrediteur(soldeMouvementCR);
    }

    public static BalanceDesComptesAffichage[] afficher(BalanceDesComptes[] liste){
        BalanceDesComptesAffichage[] retour = new BalanceDesComptesAffichage[liste.length];
        for(int i=0;i<liste.length; i++){
            retour[i] = new BalanceDesComptesAffichage(liste[i].getCompte(), liste[i].getLibelle_compte(), Utilitaire.formaterAr(liste[i].getMouvementDebit()), Utilitaire.formaterAr(liste[i].getMouvementCredit()), Utilitaire.formaterAr(liste[i].getSoldeDebiteur()), Utilitaire.formaterAr(liste[i].getSoldeCrediteur()), "", Utilitaire.formaterAr(liste[i].getAnterieurDebit()), Utilitaire.formaterAr(liste[i].getAnterieurCredit()), Utilitaire.formaterAr(liste[i].getSoldeMouvementDebit()), Utilitaire.formaterAr(liste[i].getSoldeMouvementCredit()));
            if(liste[i].getCompte().startsWith("ST")||liste[i].getCompte().startsWith("TT")){
                //System.out.println("======= miaritra le = " + "<b>"+retour[i].getCompte()+"</b>");
               retour[i] = new BalanceDesComptesAffichage("<b>"+retour[i].getCompte()+"</b>", "<b>"+retour[i].getLibelle_compte()+"</b>", "<b>"+retour[i].getMouvementDebit()+"</b>", "<b>"+retour[i].getMouvementCredit()+"</b>", "<b>"+retour[i].getSoldeDebiteur()+"</b>", "<b>"+retour[i].getSoldeCrediteur()+"</b>", "", "<b>"+retour[i].getAnterieurDebit()+"</b>", "<b>"+retour[i].getAnterieurCredit()+"</b>","<b>"+retour[i].getSoldeMouvementDebiteur()+"</b>","<b>"+retour[i].getSoldeMouvementCrediteur()+"</b>");
            }
        }
        return retour;
    }

    public String getCompteToSplit() {
        return compteToSplit;
    }

    public void setCompteToSplit(String compteToSplit) {
        this.compteToSplit = compteToSplit;
    }
    
    
    
    
}
