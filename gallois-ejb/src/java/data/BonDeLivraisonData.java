/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package data;

import bean.CGenUtil;
import facture.FactureClientDetails;
import facture.FactureFournisseurDetails;
import java.sql.Connection;
import utilitaire.UtilDB;

/**
 *
 * @author je sais pas
 */
public class BonDeLivraisonData {
    private String idfacture;

    public String getIdfacture() {
        return idfacture;
    }

    public void setIdfacture(String idfacture) {
        this.idfacture = idfacture;
    }
    
    public FactureClientDetails[] findFCDetails() throws Exception{
        Connection c=null;
        FactureClientDetails[] fcdetails = null;
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }            
            FactureClientDetails p = new FactureClientDetails();
            p.setNomTable("facture_client_fille_lib_reste");
            fcdetails = (FactureClientDetails[]) CGenUtil.rechercher(p, null, null, " and idmere = '" + idfacture+ "'");
            
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
        
        return fcdetails;
    }
    
    public FactureFournisseurDetails[] findFFDetails() throws Exception{
        Connection c=null;
        FactureFournisseurDetails[] fcdetails = null;
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }            
            FactureFournisseurDetails p = new FactureFournisseurDetails();
            p.setNomTable("factfourn_fille_lib_reste");
            fcdetails = (FactureFournisseurDetails[]) CGenUtil.rechercher(p, null, null, " and idmere = '" + idfacture+ "'");
            
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
        
        return fcdetails;
    }
}
