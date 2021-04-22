/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.allosakafo.produits;

import java.sql.Connection;
import bean.ClassMAPTable;

/**
 *
 * @author rasol
 */
public class LiaisonDetailsBCProduit extends ClassMAPTable{
    private String id, idDetailsBC, idProduit;

    public LiaisonDetailsBCProduit(String idDetail, String idPr){
        this.setNomTable("LiaisonDetailsBCProduit");
        this.setIdDetailsBC(idDetail);
        this.setIdProduit(idPr);
    }
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdDetailsBC() {
        return idDetailsBC;
    }

    public void setIdDetailsBC(String idDetailsBC) {
        this.idDetailsBC = idDetailsBC;
    }

    public String getIdProduit() {
        return idProduit;
    }

    public void setIdProduit(String idProduit) {
        this.idProduit = idProduit;
    }

    public LiaisonDetailsBCProduit() {
        this.setNomTable("LiaisonDetailsBCProduit");
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
    public void construirePK(Connection c) throws Exception{
        this.preparePk("LDB", "getseqas_LiaisonDetailsBCProd");
        this.setId(makePK(c));
    }
}
