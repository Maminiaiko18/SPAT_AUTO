/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package avoir;

import bean.CGenUtil;
import bean.ClassMAPTable;
import facture.FactureClient;
import java.sql.Connection;
import utilitaire.UtilDB;

/**
 *
 * @author Rija Ramilison
 */
public class RegulAvoirFC extends ClassMAPTable {
    
    private String id , idAvoir , idFacture;
    
    public RegulAvoirFC(){
        this.setNomTable("regulAvoirFC");
    }

    public RegulAvoirFC(String id, String idAvoir, String idFacture) {
        this.setNomTable("regulAvoirFC");
        this.setId(id);
        this.setIdAvoir(idAvoir);
        this.setIdFacture(idFacture);
    }
    

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdAvoir() {
        return idAvoir;
    }

    public void setIdAvoir(String idAvoir) {
        this.idAvoir = idAvoir;
    }

    public String getIdFacture() {
        return idFacture;
    }

    public void setIdFacture(String idFacture) {
        this.idFacture = idFacture;
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("RGA", "get_seq_regulAvoirFC");
        setId(makePK(c));
    }
    
    public FactureClient getFacture(Connection c) throws Exception{
        boolean verif = false;
        try{
            if(c == null){
                c = new UtilDB().GetConn();
                verif = true;
                c.setAutoCommit(false);
            }
            
            FactureClient fc = new FactureClient();
            fc.setNomTable("facture_client_union");
            FactureClient[] result = (FactureClient[])CGenUtil.rechercher(fc, null, null, c, String.format(" and id = '%s' ", this.getIdFacture()));
            if(result.length > 0)
                return result[0];
            return null;
        } finally{
            if(c != null && verif){
                c.close();
            }
        }
    }
    
    public AvoirFC getAvoir(Connection c) throws Exception{
        boolean verif = false;
        try{
            if(c == null){
                c = new UtilDB().GetConn();
                verif = true;
                c.setAutoCommit(false);
            }
            
            AvoirFC afc = new AvoirFC();
            afc.setNomTable("avoirFC_montant");
            AvoirFC[] result = (AvoirFC[])CGenUtil.rechercher(afc, null, null, c, String.format(" and id = '%s' ", this.getIdAvoir()));
            if(result.length > 0)
                return result[0];
            return null;
        } finally{
            if(c != null && verif){
                c.close();
            }
        }
    }
}
