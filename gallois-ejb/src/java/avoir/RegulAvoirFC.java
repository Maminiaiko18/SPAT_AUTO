/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package avoir;

import bean.ClassMAPTable;
import java.sql.Connection;

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
    
}
