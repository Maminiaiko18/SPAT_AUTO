/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.compta;

import bean.TypeObjet;
import java.util.List;

/**
 *
 * @author MEVA
 */
public class EtatDeveloppementSolde {
    private String mois;
    private int annee;
    private String solde_compte_debut_mois_date;
    private String numero_compte;
    private String intitule_compte;
    private double solde_compte_debut;
    private double debit_compte;
    private double credit_compte;
    private double solde_compte;
    private String date_jour;
    private List<TypeObjet> lto;

    public EtatDeveloppementSolde() {
    }

    public EtatDeveloppementSolde(String mois, int annee, String solde_compte_debut_mois_date, String numero_compte, String intitule_compte, double solde_compte_debut, double debit_compte, double credit_compte, double solde_compte, String date_jour, List<TypeObjet> lto) {
        this.mois = mois;
        this.annee = annee;
        this.solde_compte_debut_mois_date = solde_compte_debut_mois_date;
        this.numero_compte = numero_compte;
        this.intitule_compte = intitule_compte;
        this.solde_compte_debut = solde_compte_debut;
        this.debit_compte = debit_compte;
        this.credit_compte = credit_compte;
        this.solde_compte = solde_compte;
        this.date_jour = date_jour;
        this.lto = lto;
    }

    public String getMois() {
        return mois;
    }

    public void setMois(String mois) {
        this.mois = mois;
    }

    public int getAnnee() {
        return annee;
    }

    public void setAnnee(int annee) {
        this.annee = annee;
    }

    public String getSolde_compte_debut_mois_date() {
        return solde_compte_debut_mois_date;
    }

    public void setSolde_compte_debut_mois_date(String solde_compte_debut_mois_date) {
        this.solde_compte_debut_mois_date = solde_compte_debut_mois_date;
    }

    public String getNumero_compte() {
        return numero_compte;
    }

    public void setNumero_compte(String numero_compte) {
        this.numero_compte = numero_compte;
    }

    public String getIntitule_compte() {
        return intitule_compte;
    }

    public void setIntitule_compte(String intitule_compte) {
        this.intitule_compte = intitule_compte;
    }

    public double getSolde_compte_debut() {
        return solde_compte_debut;
    }

    public void setSolde_compte_debut(double solde_compte_debut) {
        this.solde_compte_debut = solde_compte_debut;
    }

    public double getDebit_compte() {
        return debit_compte;
    }

    public void setDebit_compte(double debit_compte) {
        this.debit_compte = debit_compte;
    }

    public double getCredit_compte() {
        return credit_compte;
    }

    public void setCredit_compte(double credit_compte) {
        this.credit_compte = credit_compte;
    }

    public double getSolde_compte() {
        return solde_compte;
    }

    public void setSolde_compte(double solde_compte) {
        this.solde_compte = solde_compte;
    }

    public String getDate_jour() {
        return date_jour;
    }

    public void setDate_jour(String date_jour) {
        this.date_jour = date_jour;
    }

    public List<TypeObjet> getLto() {
        return lto;
    }

    public void setLto(List<TypeObjet> lto) {
        this.lto = lto;
    }
    
}
