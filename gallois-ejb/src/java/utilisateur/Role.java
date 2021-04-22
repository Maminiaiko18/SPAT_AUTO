/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilisateur;

import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author user
 */
public class Role extends ClassMAPTable {

    private String idrole;
    private String descrole;
    private int rang; 

    public Role() {
        super.setNomTable("roles");
    }

    public String getIdrole() {
        return idrole;
    }

    public void setIdrole(String idrole) {
        this.idrole = idrole;
    }

    public String getDescrole() {
        return descrole;
    }

    public void setDescrole(String descrole) {
        this.descrole = descrole;
    }

    public int getRang() {
        return rang;
    }

    public void setRang(int rang) {
        this.rang = rang;
    }
    

    @Override
    public void construirePK(Connection c) throws Exception {
        super.setNomTable("roles");
        this.preparePk("ROL", "getSeqRoles");
        this.setIdrole(makePK(c));
    }

    @Override
    public String getTuppleID() {
        return this.getIdrole();
    }

    @Override
    public String getAttributIDName() {
        return "idrole";
    }

}
