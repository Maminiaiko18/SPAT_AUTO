/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package data;

import bean.CGenUtil;
import facturefournisseur.DetailsFactureFournisseur;
import facturefournisseur.Detailsffbonlivraison;
import java.sql.Connection;
import utilitaire.UtilDB;

/**
 *
 * @author Sam25v14
 */
public class AvoirFFFilleData extends AvoirFCFilleData {
    private Detailsffbonlivraison[] ffdetails;

    public Detailsffbonlivraison[] getFfdetails() {
        return ffdetails;
    }

    public void setFfdetails(Detailsffbonlivraison[] ffdetails) {
        this.ffdetails = ffdetails;
    }
    
    public void findFFDetails() throws Exception{
        Connection c=null;
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }            
            Detailsffbonlivraison p = new Detailsffbonlivraison();
//            p.setNomTable("facture_client_filleTTC");
            p.setNomTable("Detailsffbonlivraison");
            ffdetails = (Detailsffbonlivraison[]) CGenUtil.rechercher(p, null, null, " and idmere = '" + this.getIdfacture() + "'");
            
            System.out.println("details " + ffdetails.length);
            
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
