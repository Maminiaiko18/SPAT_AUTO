/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package service;

import bean.CGenUtil;
import java.sql.Connection;
import java.sql.Date;
import mg.spat.Report;

/**
 *
 * @author MEVA
 */
public class ReportService {

    public static Report getReportFarany(Date daty,String caisse,Connection c) throws Exception{
        Report retour=null;
        try{
            Report[] report=(Report[])CGenUtil.rechercher(new Report(), null, null, c, " and daty<to_date('"+daty.toString()+"','YYYY-MM-dd') and caisse='"+caisse+"'");
            if(report.length>0) retour=report[0];
            return retour;
        }catch(Exception e){
            throw e;
        }
    }
    
}
