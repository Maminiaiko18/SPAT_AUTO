/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.compta;

/**
 *
 * @author MEVA
 */
public class ConsultationComptePDF {
    private String date, folio, contrepartie, libelle, lettrage, cours_devise, montant_devise, cours_deviseD, cours_deviseC, etat;
    private String idMvt, compte;
    private double  montant_debit, montant_credit;

    public ConsultationComptePDF(String date, String folio, String contrepartie, String libelle, double montant_debit, double montant_credit, String lettrage, String cours_devise, String montant_devise, String cours_deviseD, String cours_deviseC, String etat, String idMvt, String compte) {
        this.date = date;
        this.folio = folio;
        this.contrepartie = contrepartie;
        this.libelle = libelle;
        this.montant_debit = montant_debit;
        this.montant_credit = montant_credit;
        this.lettrage = lettrage;
        this.cours_devise = cours_devise;
        this.montant_devise = montant_devise;
        this.cours_deviseD = cours_deviseD;
        this.cours_deviseC = cours_deviseC;
        this.etat = etat;
        this.idMvt = idMvt;
        this.compte = compte;
    }
        

    public ConsultationComptePDF(String date, String folio, String contrepartie, String libelle, double montant_debit, double montant_credit, String lettrage, String cours_devise, String montant_devise, String cours_deviseD, String cours_deviseC, String etat) {
        this.date = date;
        this.folio = folio;
        this.contrepartie = contrepartie;
        this.libelle = libelle;
        this.montant_debit = montant_debit;
        this.montant_credit = montant_credit;
        this.lettrage = lettrage;
        this.cours_devise = cours_devise;
        this.montant_devise = montant_devise;
        this.cours_deviseD = cours_deviseD;
        this.cours_deviseC = cours_deviseC;
        this.etat = etat;
    }

    public String getEtat() {
        return etat;
    }

    public void setEtat(String etat) {
        this.etat = etat;
    }

    public String getCours_deviseD() {
        return cours_deviseD;
    }

    public void setCours_deviseD(String cours_deviseD) {
        this.cours_deviseD = cours_deviseD;
    }

    public String getCours_deviseC() {
        return cours_deviseC;
    }

    public void setCours_deviseC(String cours_deviseC) {
        this.cours_deviseC = cours_deviseC;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getFolio() {
        return folio;
    }

    public void setFolio(String folio) {
        this.folio = folio;
    }

    public String getContrepartie() {
        return contrepartie;
    }

    public void setContrepartie(String contrepartie) {
        this.contrepartie = contrepartie;
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

    public double getMontant_debit() {
        return montant_debit;
    }

    public void setMontant_debit(double montant_debit) {
        this.montant_debit = montant_debit;
    }

    public double getMontant_credit() {
        return montant_credit;
    }
    
    public void setMontant_credit(double montant_credit) {
        this.montant_credit = montant_credit;
    }
    
    public String getLettrage() {
        return lettrage;
    }

    public void setLettrage(String lettrage) {
        this.lettrage = lettrage;
    }

    public ConsultationComptePDF(String date, String folio, String contrepartie, String libelle, double montant_debit, double montant_credit, String lettrage) {
        this.date = date;
        this.folio = folio;
        this.contrepartie = contrepartie;
        this.libelle = libelle;
        this.montant_debit = montant_debit;
        this.montant_credit = montant_credit;
        this.lettrage = lettrage;
    }

    public ConsultationComptePDF(String date, String folio, String contrepartie, String libelle, double montant_debit, double montant_credit, String lettrage, String cours_devise, String montant_devise) {
        this.date = date;
        this.folio = folio;
        this.contrepartie = contrepartie;
        this.libelle = libelle;
        this.montant_debit = montant_debit;
        this.montant_credit = montant_credit;
        this.lettrage = lettrage;
        this.cours_devise = cours_devise;
        this.montant_devise = montant_devise;
    }

    
    public ConsultationComptePDF() {
    }

    public ConsultationComptePDF(String date, String folio, String contrepartie, String libelle, double montant_debit, double montant_credit, String lettrage, String cours_devise, String montant_devise, String cours_deviseD, String cours_deviseC) {
        this.date = date;
        this.folio = folio;
        this.contrepartie = contrepartie;
        this.libelle = libelle;
        this.montant_debit = montant_debit;
        this.montant_credit = montant_credit;
        this.lettrage = lettrage;
        this.cours_devise = cours_devise;
        this.montant_devise = montant_devise;
        this.cours_deviseD = cours_deviseD;
        this.cours_deviseC = cours_deviseC;
    }

    public String getCours_devise() {
        return cours_devise;
    }

    public void setCours_devise(String cours_devise) {
        this.cours_devise = cours_devise;
    }

    public String getMontant_devise() {
        return montant_devise;
    }

    public void setMontant_devise(String montant_devise) {
        this.montant_devise = montant_devise;
    }

    public String getIdMvt() {
        return idMvt;
    }

    public void setIdMvt(String idMvt) {
        this.idMvt = idMvt;
    }

    public String getCompte() {
        return compte;
    }

    public void setCompte(String compte) {
        this.compte = compte;
    }
 
}
