/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.compta;

import bean.CGenUtil;
import bean.ClassMAPTable;
import java.sql.Date;

/**
 *
 * @author MEVA
 */
public class ComptaJournal extends ClassMAPTable{
    private String id;
    private String mere;
    private Date daty;
    private String compte_debit;
    private String compte_credit;
    private double debit;
    private double credit;
    private String compte_aux;
    private String libellepiece;
    private String journal;
    private int exercice;
    
    
    public ComptaJournal(){
        super.setNomTable("COMTPA_JOURNAL_ETAT");
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

    public String getMere() {
        return mere;
    }

    public void setMere(String mere) {
        this.mere = mere;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public String getCompte_debit() {
        if(debit==0) return "";
        return compte_debit;
    }

    public void setCompte_debit(String compte_debit) {
        this.compte_debit = compte_debit;
    }

    public String getCompte_credit() {
        if(credit==0) return "";
        return compte_credit;
    }

    public void setCompte_credit(String compte_credit) {
        this.compte_credit = compte_credit;
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

    public String getCompte_aux() {
        return compte_aux;
    }

    public void setCompte_aux(String compte_aux) {
        this.compte_aux = compte_aux;
    }

    public String getLibellepiece() {
        return libellepiece;
    }

    public void setLibellepiece(String libellepiece) {
        this.libellepiece = libellepiece;
    }

    public String getJournal() {
        return journal;
    }

    public void setJournal(String journal) {
        this.journal = journal;
    }

    public int getExercice() {
        return exercice;
    }

    public void setExercice(int exercice) {
        this.exercice = exercice;
    }
    
    public static ComptaJournal[] get(){
        try{
            ComptaJournal[] liste = (ComptaJournal[])CGenUtil.rechercher(new ComptaJournal(), null, null,"");
            return liste;
        }catch(Exception ex){
            ex.printStackTrace();
        }
        return null;
    }
}