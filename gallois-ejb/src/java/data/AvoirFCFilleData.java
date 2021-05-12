/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package data;
import avoir.AvoirFCFille;
import facture.FactureClientDetails;
import java.sql.Connection;
import bean.CGenUtil;
import utilitaire.UtilDB;

/**
 *
 * @author je sais pas
 */
public class AvoirFCFilleData {
    private FactureClientDetails[] fcdetails;
    private String idfacture;

    public FactureClientDetails[] getFcdetails() {
        return fcdetails;
    }

    public void setFcdetails(FactureClientDetails[] fcdetails) {
        this.fcdetails = fcdetails;
    }

    public String getIdfacture() {
        return idfacture;
    }

    public void setIdfacture(String idfacture) {
        this.idfacture = idfacture;
    }
    
    public void setFCDetails() throws Exception{
        Connection c=null;
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }            
            FactureClientDetails p = new FactureClientDetails();
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
    }
}
