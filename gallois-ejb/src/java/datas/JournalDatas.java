/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package datas;

import bean.CGenUtil;
import java.sql.Connection;
import java.sql.Date;
import java.util.HashMap;
import service.JournalService;
import utilitaire.UtilDB;

/**
 *
 * @author HP
 */
public class JournalDatas {
    public HashMap<String,double[]> autres;
    public JournalDatas(Date date,String caisse)throws Exception{
        Connection c = null;
        try{
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
                
            autres = new HashMap<String,double[]>();
            double[] valeur = {0,0};
            //Valeur encore inconnu
            autres.put("REPORTS", valeur );
            autres.put("CUMULS (1+2)", valeur );
            
            //Solde
            double[] sldA = {0,0};
            sldA[0]=new JournalService().getSoldeAnterieur(c, date,caisse);
            
            //Utilitaire.datetostring(dateactuel)
            autres.put("SOLDE ANTERIEUR", sldA);
            
            double[] sldAct = {0,0};
            sldAct[1]=new JournalService().getSoldeActuel(c, date,caisse);
            autres.put("SOLDE ACTUEL", sldAct );
            
        }catch(Exception e){
            e.printStackTrace();
            if(c!=null) c.rollback();
            throw e;
        }finally{
            if(c!=null) c.close();
        }
    }

    public HashMap<String,double[]> getAutres() {
        return autres;
    }

    public void setAutres(HashMap<String,double[]> autres) {
        this.autres = autres;
    }
    
    
}
