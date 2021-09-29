/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package data;

import facture.EtatProvision;
import facture.FactureClient;
import java.sql.Connection;
import utilitaire.UtilDB;


public class FactureData {
    private String lib;
    private double montantTP;
    private boolean disabled;

    public boolean isDisabled() {
        return disabled;
    }

    public void setDisabled(boolean disabled) {
        this.disabled = disabled;
    }
    
    public String getLib() {
        return lib;
    }

    public void setLib(String lib) {
        this.lib = lib;
    }
    
    public double getMontantTP() {
        return montantTP;
    }

    public void setMontantTP(double montantTP) {
        this.montantTP = montantTP;
    }
    
    public void initData(String idFactureClient)throws Exception{
        FactureClient factClient = new FactureClient();
        factClient.setId(idFactureClient);
        Connection conn = null;
        int verify = 0;
        try{
            if(conn == null){
                conn =  new UtilDB().GetConn();
                verify =1;
            }
            
            EtatProvision etatProvision = new EtatProvision();
            etatProvision.setId(idFactureClient);
            double reste = etatProvision.getResteProvision(conn);
            disabled = reste < 0;
            this.setLib(factClient.affLibelle(reste));
            this.setMontantTP(factClient.affResteProvision(reste));
        }catch(Exception e){
            throw e;
        }finally{
            if(conn!=null && verify==1) conn.close();   
        }
        
    }
    
//    public void initData(String idFactureClient, double resteProv)throws Exception{
//        FactureClient factClient = new FactureClient();
//        factClient.setId(idFactureClient);
//        Connection conn = null;
//        int verify = 0;
//        try{
//            if(conn == null){
//                conn =  new UtilDB().GetConn();
//                verify =1;
//            }
//            this.setLib(factClient.affLibelle(conn));
//            this.setMontantTP(factClient.affResteProvision(resteProv));
//        }catch(Exception e){
//            throw e;
//        }finally{
//            if(conn!=null && verify==1) conn.close();   
//        }
//        
//    }
}
