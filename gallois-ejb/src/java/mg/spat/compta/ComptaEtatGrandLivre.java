/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.compta;

import bean.ClassMAPTable;
import java.sql.Date;

/**
 *
 * @author MEVA
 */
public class ComptaEtatGrandLivre extends ClassMAPTable{
    private String id, journal, libelle, compte, lettrage, auxiliaire;
    private java.sql.Date daty;
    private double debit, credit, debiteur, crediteur;

    public ComptaEtatGrandLivre() {
        setNomTable("compta_grand_livre");
    }
    
    @Override
    public String getTuppleID() {
        return "";
    }

    @Override
    public String getAttributIDName() {
        return "";
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    
    public String getJournal() {
        return journal;
    }

    public void setJournal(String journal) {
        this.journal = journal;
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

    public String getCompte() {
        return compte;
    }

    public void setCompte(String compte) {
        this.compte = compte;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
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

    public double getDebiteur() {
        return debiteur;
    }

    public void setDebiteur(double debiteur) {
        this.debiteur = debiteur;
    }

    public double getCrediteur() {
        return crediteur;
    }

    public void setCrediteur(double crediteur) {
        this.crediteur = crediteur;
    }

    public String getLettrage() {
        return lettrage;
    }

    public void setLettrage(String lettrage) {
        this.lettrage = lettrage;
    }

    /**
     * @return the auxiliaire
     */
    public String getAuxiliaire() {
        //if(getAuxiliaire()!=null && getAuxiliaire().compareTo("-")==0)
            return auxiliaire;
        //return getCompte();
             
    }

    /**
     * @param auxiliaire the auxiliaire to set
     */
    public void setAuxiliaire(String auxiliaire) {
        this.auxiliaire = auxiliaire;
    }
}

