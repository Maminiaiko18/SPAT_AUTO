/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.CGenUtil;
import java.sql.Connection;
import utilitaire.UtilDB;

/**
 *
 * @author Ratsidikaina
 */
public class FactureClientFilleData {
    private FactureClient facture;
    
    public FactureClientFilleData(String idFacture, FactureClientDetails[] liste, Connection c) throws Exception {
        boolean in = false;

        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                in = true;
            }
            String nomTable="factureClientValide";
            facture =  new FactureClient();
            facture.setEstDDPMICTSL(null);
            facture.setNomTable(nomTable);
            facture = (FactureClient) facture.getById(idFacture, null, c);
            facture.setListeDetails(liste);
            facture.initDetails(c);
        }catch(Exception ex){
            throw ex;
        }finally{
            if(in && c!=null) c.close();
        }
    }

    public FactureClient getFacture() {
        return facture;
    }

    public void setFacture(FactureClient facture) {
        this.facture = facture;
    }
    
}
