/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilisateur;

import bean.CGenUtil;
import bean.ClassMAPTable;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

import java.sql.Connection;

/**
 *
 * @author Jetta
 */
public class Restriction extends ClassMAPTable {

    private String id;
    private String idrole;
    private String idaction;
    private String tablename;
    private String autorisation;
    private String description;
    private String iddirection;
    private int autorise;
    private String refuser;
    private String tablenamelib;
    private String autoriselib;
    private String actionlib;
    private String loginuser;


    public String getLoginuser() {
        return loginuser;
    }

    public void setLoginuser(String loginuser) {
        this.loginuser = loginuser;
    }

    public String getActionlib() {
        return actionlib;
    }

    public void setActionlib(String actionlib) {
        this.actionlib = actionlib;
    }

    public String getRolelib() {
        return rolelib;
    }

    public void setRolelib(String rolelib) {
        this.rolelib = rolelib;
    }

    private String rolelib;



    public String getAutoriselib() {
        return autoriselib;
    }

    public void setAutoriselib(String autoriselib) {
        this.autoriselib = autoriselib;
    }


    public Restriction(String idaction, String tablename, String description, int autorise,String refuser,String idrole) {
        this.idaction = idaction;
        this.tablename = tablename;
        this.description = description;
        this.autorise = autorise;
        this.refuser = refuser;
        this.idrole = idrole;
    }


    public void ajouterRestrictionUser(String utilisateur, String actions) throws Exception {
        Connection c = null;
        try {
            c = (new UtilDB()).GetConn();

            String[] user = utilisateur.split(";");
            String[] action = actions.split(";");

            if (user != null && user.length > 0) {
                for (String u : user) {
                        if(action!=null && action.length >0){
                            for (String a : action) {
                            Restriction restriction = new  Restriction(a, this.getTablename(),  this.getDescription(), this.getAutorise(),u,null);
                            restriction.setNomTable("restriction");
                            restriction.construirePK(c);
                            restriction.insertToTable(c);
                        }
                    }       
                    else throw new Exception("Veuillez choisir au moins une action.");
                }
            }            
            else throw new Exception("Veuillez choisir au moins un utilisateur.");
            c.commit();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }


    public void ajouterRestrictionRole(String roles, String actions) throws Exception {
        Connection c = null;
        try {
            c = (new UtilDB()).GetConn();

            String[] role = roles.split(";");
            String[] action = actions.split(";");

            if (role != null && role.length > 0) {
                for (String r : role) {
                        if(action!=null && action.length >0){
                            for (String a : action) {
                            Restriction restriction = new  Restriction(a, this.getTablename(),  this.getDescription(), this.getAutorise(),null,r);
                            restriction.setNomTable("restriction");
                            restriction.construirePK(c);
                            restriction.insertToTable(c);
                        }
                    }       
                    else throw new Exception("Veuillez choisir au moins une action.");
                }
            }            
            else throw new Exception("Veuillez choisir au moins un utilisateur.");
            c.commit();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }


    public String getRefuser() {
        return refuser;
    }

    public void setRefuser(String refuser) {
        this.refuser = refuser;
    }

    public int getAutorise() {
        return autorise;
    }

    public void setAutorise(int autorise) {
        this.autorise = autorise;
    }

    public Restriction(String idrole, String idaction, String tablename, String autorisation, String description, String iddirection) {
            this.setIdrole(idrole);
        this.setIdaction(idaction);
        this.setTablename(tablename);
        this.setAutorisation("false");
        this.setDescription(description);
        this.setIddirection(iddirection);
        super.setNomTable("restriction");
    }

    public String getIddirection() {
        return iddirection;
    }

    public void setIddirection(String iddirection) {
        this.iddirection = iddirection;
    }

    public Restriction(String idrole, String idpermission, String nt) {
        super.setNomTable("restriction");
        this.setIdrole(idrole);
        this.setIdaction(idpermission);
        this.setTablename(nt);
        this.setAutorisation("false");
        this.setDescription("");
    }

    public Restriction(String idrole, String action, String nt, String direction) {
        super.setNomTable("restriction");
        this.setIdrole(idrole);
        this.setIdaction(action);
        this.setTablename(nt);
        this.setAutorisation("non");
           this.setIddirection(direction);
    }

    public Restriction() {
        super.setNomTable("restriction");
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
        super.setNomTable("restriction");
        this.preparePk("RES", "getSeqRestriction");
        this.setId(makePK(c));
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdrole() {
        return idrole;
    }

    public void setIdrole(String idrole) {
        this.idrole = idrole;
    }

    public String getIdaction() {
        return idaction;
    }

    public void setIdaction(String idaction) {
        this.idaction = idaction;
    }

    public String getTablename() {
        return tablename;
    }

    public void setTablename(String idelement) {
        this.tablename = idelement;
    }

    public String getAutorisation() {
        return autorisation;
    }

    public void setAutorisation(String autorisation) {
        this.autorisation = autorisation;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getTablenamelib() {
        return tablenamelib;
    }

    public void setTablenamelib(String tablenamelib) {
        this.tablenamelib = tablenamelib;
    }
}
