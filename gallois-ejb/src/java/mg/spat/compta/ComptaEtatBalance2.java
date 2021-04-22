/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.compta;

import bean.ClassMAPTable;
import java.sql.Date;
import utilitaire.Utilitaire;

/**
 *
 * @author MEVA
 */
public class ComptaEtatBalance2 extends ClassMAPTable{
    double debit, credit;
    String compte;
    String libelle_compte;
    String typecompte;
    double[] soldeAnterieur;
    int mois;
    int annee;
    String chiffre3;
    String chiffre2;
    Date daty;

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
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
    
    public ComptaEtatBalance2(double debit, double credit, String compte, String libelle_compte, String typecompte) {
        this.debit = debit;
        this.credit = credit;
        this.compte = compte;
        this.libelle_compte = libelle_compte;
        this.typecompte = typecompte;
    }
    
    public ComptaEtatBalance2(double debit, double credit, String compte, String libelle_compte, String typecompte, String chiffre3, String chiffre2) {
        this.setDebit(debit);
        this.setCredit(credit);
        this.setCompte(compte);
        this.setLibelle_compte(libelle_compte);
        this.setTypecompte(typecompte);
        this.setChiffre3(chiffre3);
        this.setChiffre2(chiffre2);
    }

    public double[] getSoldeAnterieur() {
        return soldeAnterieur;
    }

    public void setSoldeAnterieur(double[] soldeAnterieur) {
        this.soldeAnterieur = soldeAnterieur;
    }
    

    public String getTypecompte() {
        return typecompte;
    }

    public void setTypecompte(String typecompte) {
        this.typecompte = typecompte;
    }
    
    public ComptaEtatBalance2(){
        super.setNomTable("compta_balance_etat");
    }
    
    public double getDebit() {
        return debit;
    }

    public void setDebit(double debit) {
        this.debit = debit;
    }

    public double getCredit() {
        return credit;
    }

    public void setCredit(double credit) {
        this.credit = credit;
    }

    public String getCompte() {
        return compte;
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
    
    

    @Override
    public String getTuppleID() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String getAttributIDName() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
}
