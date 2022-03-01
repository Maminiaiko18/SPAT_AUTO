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
public class PaiementEngagement extends ClassMAPTable {
    private String id, idEngagement, idOP ;

    public PaiementEngagement() {
        super.setNomTable("payementEngagement");
    }
    

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdEngagement() {
        return idEngagement;
    }

    public void setIdEngagement(String idEngagement) throws Exception{
        if(this.getMode().compareToIgnoreCase("modif")==0&&(idEngagement == null || idEngagement == " " )) throw new Exception("idEngagement invalide");
        this.idEngagement = idEngagement;
    }

    public String getIdOP() {
        return idOP;
    }

    public void setIdOP(String idOP) throws Exception{
        if(this.getMode().compareToIgnoreCase("modif")==0&&(idOP == null || idEngagement == " ")) throw new Exception("idOP invalide");
        this.idOP = idOP;
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
        preparePk("CR","getseqpayementEngagement");
        setId(makePK(c));
    }
    
    
}
