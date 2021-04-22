/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package service;

import bean.CGenUtil;
import bean.TypeObjet;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import mg.spat.Cloture;
import mg.spat.Report;
import mg.spat.SoldeCaisse;
import static service.ReportService.getReportFarany;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author HP
 */
public class JournalService {
    
    public static double getSoldeJournal(Date daty1,Date daty2, String caisse, Connection c) throws Exception {
        double solde=0;
        try {
            SoldeCaisse[] so= (SoldeCaisse[])CGenUtil.rechercher(new SoldeCaisse(), "select current_date,caisse,sum(solde) as solde from soldecaisse where 1<2 and dateEffet>=to_date('"+daty1.toString()+"','YYYY-MM-DD') and dateEffet<to_date('"+daty2.toString()+"','YYYY-MM-DD') and caisse='"+caisse+"' group by caisse", c);
            if(so.length>0)
                solde=so[0].getSolde();
            System.out.println("solde="+solde);
        } catch (Exception e) {
            throw e;
        }
        return solde;
    }
    
    public double getSoldeAnterieur(Connection c,Date dateactuel,String caisse) throws Exception{
        boolean news = false;
        try{
            if(c == null){
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                news=true;
            }
            TypeObjet t=new TypeObjet();
            t.setNomTable("caisse");
            TypeObjet[] lto=(TypeObjet[]) CGenUtil.rechercher(t, null, null, c, " and id='"+caisse+"'");
            if(lto.length==0) throw new Exception("Caisse introuvable");           
           
            Report report=ReportService.getReportFarany(dateactuel,lto[0].getId(),c);
            double reportMontant=0;
            if(report!=null){
                reportMontant=report.getMontant();
                dateactuel=report.getDaty();
            }
            return reportMontant+JournalService.getSoldeJournal(dateactuel, dateactuel, lto[0].getId(), c);
        }catch(Exception e){
            throw e;
        }
        finally{
            if(c!=null && news) c.close();
        }
    }
    public double getSoldeActuel(Connection c,Date dateactuel,String caisse) throws Exception{
        boolean news = false;
        try{
            if(c == null){
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                news=true;
            }
            TypeObjet t=new TypeObjet();
            t.setNomTable("caisse");
            TypeObjet[] lto=(TypeObjet[]) CGenUtil.rechercher(t, null, null, c, " and val='"+caisse+"'");
            if(lto.length==0) throw new Exception("Pas de caisse à ce nom");
                        
            String query = "select (sum(debit)-sum(credit)) as solde,dateEffet,caisse from Journalcaisse where dateeffet<='"+Utilitaire.datetostring(dateactuel)+"' and caisse='"+lto[0].getId()+"' group by dateeffet,caisse";
            System.out.println("query :: "+query);          
            
            SoldeCaisse[] liste=(SoldeCaisse[]) CGenUtil.rechercher(new SoldeCaisse(), query, c);
            if(liste.length>0)
                return liste[0].getSolde();
        }catch(Exception e){
            throw e;
        }
        finally{
            if(c!=null && news) c.close();
        }
        return 0;
    }
    public double getSoldeAnterieur2(Connection c,Date dateactuel) throws Exception{
        PreparedStatement stmt = null;
        ResultSet r = null;
        boolean news = false;
        try{
            if(c == null){
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                news=true;
            }
            String query = "select (sum(debit)-sum(credit)) as solde from Journalcaisse where dateeffet< '"+Utilitaire.datetostring(dateactuel)+"'"/*+" group by dateeffet "*/;
            System.out.println("query :: "+query);
            stmt = c.prepareStatement(query);
            //stmt.setDate(1, dateactuel);
            
            r = stmt.executeQuery();
            if(r.next()){
                return r.getDouble("solde");
            }
        }catch(Exception e){
            e.printStackTrace();
            if(c!=null) c.rollback();
            throw e;
        }
        finally{
            if(r!=null) r.close();
            if(stmt!=null) stmt.close();
            if(c!=null && news) c.close();
        }
        return 0;
    }
    
    public double getSoldeActuel2(Connection c,Date dateactuel) throws Exception{
        PreparedStatement stmt = null;
        ResultSet r = null;
        boolean news = false;
        try{
            if(c == null){
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                news=true;
            }
            String query = "select (sum(debit)-sum(credit)) as solde from Journalcaisse where dateeffet<='"+Utilitaire.datetostring(dateactuel)+"'";/*+" group by dateeffet "*/;
            System.out.println("query :: "+query);
            stmt = c.prepareStatement(query);
            //stmt.setDate(1, dateactuel);
            
            r = stmt.executeQuery();
            if(r.next()){
                return r.getDouble("solde");
            }
        }catch(Exception e){
            e.printStackTrace();
            if(c!=null) c.rollback();
            throw e;
        }
        finally{
            if(r!=null) r.close();
            if(stmt!=null) stmt.close();
            if(c!=null && news) c.close();
        }
        return 0;
    }
}
