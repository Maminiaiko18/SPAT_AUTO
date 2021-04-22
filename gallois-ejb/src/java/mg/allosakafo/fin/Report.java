/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.allosakafo.fin;

import bean.ClassEtat;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author Joe
 */
public class Report extends ClassEtat {

    public String id;
    public Date daty;
    public double montant;
    public String devise;
    public String caisse;
    private Date date_report;

    public Date getDate_report() {
        return date_report;
    }

    public void setDate_report(Date date_report) {
        this.date_report = date_report;
    }

    public Report() {
        this.setNomTable("report");
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public void construirePK(Connection c) throws Exception {
        this.preparePk("RP", "getSeqReport");
        this.setId(makePK(c));
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant)throws Exception {
        System.out.println("montant : "+montant);
        if(this.getMode().equals("modif") && montant<=0){
            System.out.println("ato am exception");
            throw new Exception("montant invalide");
        }
        this.montant = montant;
    }

    public String getDevise() {
        return devise;
    }

    public void setDevise(String devise) {
        this.devise = devise;
    }

    public String getCaisse() {
        return caisse;
    }

    public void setCaisse(String caisse) {
        this.caisse = caisse;
    }

}
