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
public class ActeProfil extends ClassMAPTable{
    private String id,nomtable,idrole,action;

    public ActeProfil() {
        super.setNomTable("acteProfil");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNomtable() {
        return nomtable;
    }

    public void setNomtable(String nomtable) {
        this.nomtable = nomtable;
    }

    public String getIdrole() {
        return idrole;
    }

    public void setIdrole(String idrole) {
        this.idrole = idrole;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
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
        preparePk("ACTP","get_seq_acteProfil");
        setId(makePK(c));
    }

    
}
