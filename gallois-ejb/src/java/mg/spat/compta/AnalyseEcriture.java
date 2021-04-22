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
 * @author Asus
 */

public class AnalyseEcriture extends ClassMAPTable{
    
    
    private int ec_no, cg_type, ec_devise;
    private String cg_num,cg_intitule,ec_refpiece,ec_tresopiece,ec_lettrage;
    private Date ec_date;
    private double debit, credit;

    public AnalyseEcriture() {
          this.setNomTable("analyseecriture");
    }

    public AnalyseEcriture(int ec_no, double debit, double credit, int cg_type, int ec_devise, String cg_num, String cg_intitule, String ec_refpiece, String ecc_tresopiece, String ec_lettrage, Date ec_date) {
        this.setNomTable("analyseecriture");
        this.setEc_no(ec_no);
        this.setDebit(debit);
        this.setCredit(credit);
        this.setCg_type(cg_type);
        this.setEc_devise(ec_devise);
        this.setCg_num(cg_num);
        this.setCg_intitule(cg_intitule);
        this.setEc_refpiece(ec_refpiece);
        this.setEc_tresopiece(ec_tresopiece);
        this.setEc_lettrage(ec_lettrage);
        this.setEc_date(ec_date);
    }

    public int getEc_no() {
        return ec_no;
    }

    public void setEc_no(int ec_no) {
        this.ec_no = ec_no;
    }

    public int getCg_type() {
        return cg_type;
    }

    public void setCg_type(int cg_type) {
        this.cg_type = cg_type;
    }

    public int getEc_devise() {
        return ec_devise;
    }

    public void setEc_devise(int ec_devise) {
        this.ec_devise = ec_devise;
    }

    public String getCg_num() {
        return cg_num;
    }

    public void setCg_num(String cg_num) {
        this.cg_num = cg_num;
    }

    public String getCg_intitule() {
        return cg_intitule;
    }

    public void setCg_intitule(String cg_intitule) {
        this.cg_intitule = cg_intitule;
    }

    public String getEc_refpiece() {
        return ec_refpiece;
    }

    public void setEc_refpiece(String ec_refpiece) {
        this.ec_refpiece = ec_refpiece;
    }

    public String getEc_tresopiece() {
        return ec_tresopiece;
    }

    public void setEc_tresopiece(String ec_tresopiece) {
        this.ec_tresopiece = ec_tresopiece;
    }

    public String getEc_lettrage() {
        return ec_lettrage;
    }

    public void setEc_lettrage(String ec_lettrage) {
        this.ec_lettrage = ec_lettrage;
    }

    public Date getEc_date() {
        return ec_date;
    }

    public void setEc_date(Date ec_date) {
        this.ec_date = ec_date;
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
    
    @Override
    public String getTuppleID() {
     
     return ec_no+"";
    }

    @Override
    public String getAttributIDName() {
     return ec_no+"";
    }
    
}
