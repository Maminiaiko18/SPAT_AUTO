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
public class ProformaFilleData {
    private ProformaMere proforma;
    
    public ProformaFilleData(String idFacture, ProformaFille[] liste, Connection c) throws Exception {
        boolean in = false;

        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                in = true;
            }
            String nomTable="proforma_mere_msum_lib";
            proforma =  new ProformaMere();
            proforma.setEstDDPMICTSL(null);
            proforma.setNomTable(nomTable);
            proforma = (ProformaMere) proforma.getById(idFacture, null, c);
            if(proforma != null){
                //proforma.setListeDetails(liste);
                proforma.initDetails(c);
            }
            
        }catch(Exception ex){
            throw ex;
        }finally{
            if(in && c!=null) c.close();
        }
    }

    public ProformaMere getProforma() {
        return proforma;
    }

    public void setProforma(ProformaMere proforma) {
        this.proforma = proforma;
    }

    
}
