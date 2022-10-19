/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.CGenUtil;
import bean.ClassEtat;
import java.sql.Connection;
import java.sql.Date;
import service.JournalService;
import service.ReportService;
import utilitaire.Utilitaire;

/**
 *
 * @author JESSI
 */
public class Report extends ClassEtat{
    
    private String id;
    private Date daty;
    private double montant;
    private String caisse;
    private String devise;

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public String getCaisse() {
        return caisse;
    }

    public void setCaisse(String caisse) {
        this.caisse = caisse;
    }

    public String getDevise() {
        return devise;
    }

    public void setDevise(String devise) {
        this.devise = devise;
    }

    public void controler(Connection c) throws Exception{
//        Report report = this.getReportFarany(this.getDaty(),this.getCaisse(),c);
//        this.montant=report.getMontant()+JournalService.getSoldeJournal(report.getDaty() , Utilitaire.getDateAvant(this.getDaty(), 1), this.getCaisse(), c);
        if(checkDoublon(c)){
            throw new Exception("Report deja effectue pour cette caisse");
        }    
    }
    
    public Report() {
        super.setNomTable("report");
    }
    public void construirePK(Connection c) throws Exception {
        this.preparePk("REP", "GETSEQreport");
        this.setId(makePK(c));
    }
    
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

  
    
    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
    public Report(Date daty, double montant) {
        super.setNomTable("report");
        this.setDaty(daty);
        this.setMontant(montant);
    }
    
    public static Report getReportFarany(Date daty,String caisse,Connection c) throws Exception{
        Report retour=null;
        try{
            Report[] report=(Report[])CGenUtil.rechercher(new Report(), null, null, c, " and daty<to_date('"+daty.toString()+"','YYYY-MM-dd') and caisse='"+caisse+"'");
            if(report.length>0) 
                retour=report[0];
            else
                retour = new Report(Utilitaire.dateDuJourSql(),0);
            return retour;
        }catch(Exception e){
            throw e;
        }
    }
    
    public boolean checkDoublon(Connection c) throws Exception{
        Report base = new Report();
        base.setNomTable("reportlibv");
        String sqlWhere = String.format(" and daty = to_date('%s', 'YYYY-MM-DD') and idcaisse = '%s' ", getDaty(), getCaisse());
        Report[] result = (Report[])CGenUtil.rechercher(base, null, null, c, sqlWhere);
        return result.length > 0;
    }
}
