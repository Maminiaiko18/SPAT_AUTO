/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author Administrator
 */
public class PaiementFCAvoir extends ClassMAPTable{
    String id;
    String idPaiement;
    String idAvoir;
    
    
    public PaiementFCAvoir(){
        this.setNomTable("paiementFCAvoir");
    }

    public PaiementFCAvoir(String idPaiement,String idAvoir){
       this.setIdPaiement(idPaiement);
       this.setIdAvoir(idAvoir);
       this.setNomTable("paiementFCAvoir");
    }

    public String getIdPaiement() {
        return idPaiement;
    }

    public void setIdPaiement(String idPaiement) {
        this.idPaiement = idPaiement;
    }

    public String getIdAvoir() {
        return idAvoir;
    }

    public void setIdAvoir(String idAvoir) {
        this.idAvoir = idAvoir;
    }

    
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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
        preparePk("PFCA", "GETSEQPaiementFCAvoir");
        setId(makePK(c));
    }

}
