/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package service;

import bean.CGenUtil;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import mg.spat.compta.ComptaBilan;
import mg.spat.compta.ComptaBilanPA;
import mg.spat.compta.ComptaBilanRecapPA;
import utilitaire.UtilDB;

/**
 *
 * @author MEVA
 */
public class ComptaService {
   
    public static ComptaBilanRecapPA getRecapPA(Connection c, Date d1, Date d2) throws Exception{
        ComptaBilanRecapPA retour=null;
        int verif = 0;
        try{
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            ComptaBilan cd=new ComptaBilan();
            ComptaBilan[] actif=(ComptaBilan[])CGenUtil.rechercher(cd, "select \n" +
            "    idrubrique, rubrique, reference,\n" +
            "    sum(ec_montant) as ec_montant \n" +
            "from \n" +
            "    comptabilanactif where 1<2  and \n" +
            "    type='Credit' and \n" +
            "    ec_date>=to_date('"+d1+"','YYYY-MM-DD') and \n" +
            "    ec_date<=to_date('"+d2+"','YYYY-MM-DD')\n" +
            "group by \n" +
            "    idrubrique, rubrique, reference", c);
            cd.setNomTable("comptabilanpassif");
            ComptaBilan[] passif=(ComptaBilan[])CGenUtil.rechercher(cd, "select \n" +
            "    idrubrique, rubrique, reference,\n" +
            "    sum(ec_montant) as ec_montant \n" +
            "from \n" +
            "    comptabilanpassif where 1<2  and \n" +
            "    type='Debit' and \n" +
            "    ec_date>=to_date('"+d1+"','YYYY-MM-DD') and \n" +
            "    ec_date<=to_date('"+d2+"','YYYY-MM-DD')\n" +
            "group by \n" +
            "    idrubrique, rubrique, reference", c);
            
            retour=new ComptaBilanRecapPA(passif,actif);
        }catch(Exception e){
            throw e;
        }finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
        return retour;
    }
    public static ComptaBilanRecapPA getRecapPC(Connection c, Date d1, Date d2) throws Exception{
        /***********************************************************************
         * Joh
         */
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(d1);
        int a1 = calendar.get(Calendar.YEAR);
        calendar.setTime(d2);
        int a2 = calendar.get(Calendar.YEAR);
        if(a1 != a2) throw new Exception("Annees differentes. ("+a1+"-"+a2+")");
        /**********************************************************************/
        ComptaBilanRecapPA retour=null;
        int verif = 0;
        try{
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            ComptaBilan cd=new ComptaBilan();
            cd.setNomTable("comptabilanproduit");
            ComptaBilan[] actif=(ComptaBilan[])CGenUtil.rechercher(cd, "select \n" +
            "    idrubrique, rubrique, reference,\n" +
            "    sum(ec_montant) as ec_montant \n" +
            "from \n" +
            "    comptabilanproduit where 1<2  and \n" +
            "    type='Credit' and \n" +
            "    ec_date>=to_date('"+d1+"','YYYY-MM-DD') and \n" +
            "    ec_date<=to_date('"+d2+"','YYYY-MM-DD')\n" +
            "group by \n" +
            "    idrubrique, rubrique, reference", c);
            cd.setNomTable("comptabilancharge");
            ComptaBilan[] passif=(ComptaBilan[])CGenUtil.rechercher(cd, "select \n" +
            "    idrubrique, rubrique, reference,\n" +
            "    sum(ec_montant) as ec_montant \n" +
            "from \n" +
            "    comptabilancharge where 1<2  and \n" +
            "    type='Debit' and \n" +
            "    ec_date>=to_date('"+d1+"','YYYY-MM-DD') and \n" +
            "    ec_date<=to_date('"+d2+"','YYYY-MM-DD')\n" +
            "group by \n" +
            "    idrubrique, rubrique, reference", c);
            retour=new ComptaBilanRecapPA(passif,actif);
        }catch(Exception e){
            throw e;
        }finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
        return retour;
    }
}
