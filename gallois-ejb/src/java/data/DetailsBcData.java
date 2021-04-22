/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package data;
import java.sql.Connection;
import mg.spat.stock.BonDeCommandeFille;
import mg.spat.stock.BonDeCommande;
import bean.CGenUtil;
import utilitaire.UtilDB;
/**
 *
 * @author nyamp
 */
public class DetailsBcData {
    private String id;
    private BonDeCommandeFille[]bcFille;
    private BonDeCommande bc;

    public void setId(String id) {
        this.id = id;
    }
    private void initialize() {
        this.bc = new BonDeCommande();
        this.bcFille = new BonDeCommandeFille[0];
    }
    
    public DetailsBcData(String id) throws Exception{
        this.setId(id);
        this.initialize();
    }
    public void setBC(String vue_mere,String vue_fille) throws Exception{
        Connection c=null;
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }            
            BonDeCommandeFille p = new BonDeCommandeFille();
            p.setNomTable(vue_fille);
            bcFille = (BonDeCommandeFille[]) CGenUtil.rechercher(p, null, null, " and idbc = '" + id+ "'");
            bc = new BonDeCommande();
            bc.setNomTable(vue_mere);
            BonDeCommande[] liste2 = (BonDeCommande[]) CGenUtil.rechercher(bc, null, null, " and id = '" + id+ "'");
            if(liste2!=null && liste2.length>0){
               bc=liste2[0] ;
            }
            if(c!=null && verif==1) c.commit();
        } catch (Exception e) {
            if (c != null && verif == 1) {
                c.rollback();
            }
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    public BonDeCommandeFille[] getBcFille() {
        return bcFille;
    }

    public void setBcFille(BonDeCommandeFille[] bcFille) {
        this.bcFille = bcFille;
    }
    
    public BonDeCommande getBc() {
        return bc;
    }

    public void setBc(BonDeCommande bc) {
        this.bc = bc;
    }
    
    
}
