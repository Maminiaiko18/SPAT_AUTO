/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author Nouta
 */
public class DernierStationnement extends ClassMAPTable{
    private String id,idactivite,escale;
    public DernierStationnement() {
        super.setNomTable("dernier_stationnement");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdactivite() {
        return idactivite;
    }

    public void setIdactivite(String idactivite) {
        this.idactivite = idactivite;
    }

    public String getEscale() {
        return escale;
    }

    public void setEscale(String escale) {
        this.escale = escale;
    }
    
    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
     public void construirePK(Connection c) throws Exception {
        this.preparePk("DST", "GET_SEQ_DERNIER_STATIONNEMENT");
        this.setId(makePK(c));
    }
    
}
