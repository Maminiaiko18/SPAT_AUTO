/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import java.sql.Connection;
import utilitaire.UtilDB;

/**
 *
 * @author rahar
 */
public class FactureFournisseurFilleData {
private FactureFournisseur facture;
    
    public FactureFournisseurFilleData(String idFacture, FactureFournisseurDetails[] liste, Connection c) throws Exception {
        boolean in = false;

        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                in = true;
            }
            String nomTable="factfourn_msum_lib";
            facture =  new FactureFournisseur();
            facture.setEstDDPMICTSL(null);
            facture.setNomTable(nomTable);
            facture = (FactureFournisseur) facture.getById(idFacture, null, c);
            if(facture != null){
                facture.setListeDetails(liste);
                facture.initDetails(c);
            }
            
        }catch(Exception ex){
            throw ex;
        }finally{
            if(in && c!=null) c.close();
        }
    }

    public FactureFournisseur getFacture() {
        return facture;
    }

    public void setFacture(FactureFournisseur facture) {
        this.facture = facture;
    }
        
        
}
