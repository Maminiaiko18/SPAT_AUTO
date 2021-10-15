/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package data;

import bean.CGenUtil;
import facture.FactureFournisseurDetails;
import java.sql.Connection;
import java.sql.SQLException;
import mg.spat.stock.BonDeLivraisonFille;
import utilitaire.UtilDB;

/**
 *
 * @author nyamp
 */
public class FactureFournisseurData {
    BonDeLivraisonFille[] fille;
    String idBL;

    public FactureFournisseurData(String idBL) {
        this.idBL = idBL;
        fille=null;
    }
    public void initData() throws SQLException, Exception{
         Connection c=null;
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            BonDeLivraisonFille o= new BonDeLivraisonFille();
            o.setNomTable("AS_BONDELIVRAISON_FILLE");
            fille = (BonDeLivraisonFille[]) CGenUtil.rechercher(o, null, null,c, " and IDBONDECOMMANDE='"+idBL+"' ");
            
            if(c!=null && verif==1) c.commit();
        } catch (Exception e) {
            if (c != null && verif == 1) {
                c.rollback();
            }
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    public BonDeLivraisonFille[] getFille() {
        return fille;
    }

    public void setFille(BonDeLivraisonFille[] fille) {
        this.fille = fille;
    }

    public String getIdBL() {
        return idBL;
    }

    public void setIdBL(String idBL) {
        this.idBL = idBL;
    }
    
    
}
