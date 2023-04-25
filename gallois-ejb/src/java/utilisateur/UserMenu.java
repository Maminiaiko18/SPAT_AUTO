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
 * @author tahina
 */
public class UserMenu  extends ClassMAPTable {

    private String id;
    private String idrole;
    private String idmenu;
    private String codeservice;
    private String codedir;
    private int interdit;
    private int refuser;
    private String nomUser;
    private String login;
    
    public String getNomUser() {
        return nomUser;
    }

    public String getLogin() {
        return login;
    }

    public void setNomUser(String nomUser) {
        this.nomUser = nomUser;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    
     public UserMenu(String id, String idrole, String idmenu, String codeservice, String codedir, int interdit, int refuser, String nomUser, String login) {
        this.id = id;
        this.idrole = idrole;
        this.idmenu = idmenu;
        this.codeservice = codeservice;
        this.codedir = codedir;
        this.interdit = interdit;
        this.refuser = refuser;
        this.nomUser = nomUser;
        this.login = login;
    }
    
    public void construirePK(Connection c) throws Exception {
        super.setNomTable("usermenu");
        this.preparePk("MEN", "getSeqUserMenu");
        this.setId(makePK(c));
    }
    public UserMenu() {
        super.setNomTable("usermenu");
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

    public String getIdmenu() {
        return idmenu;
    }

    public void setIdmenu(String idmenu) {
        this.idmenu = idmenu;
    }

    public String getCodeservice() {
        return codeservice;
    }

    public void setCodeservice(String codeservice) {
        this.codeservice = codeservice;
    }

    public String getCodedir() {
        return codedir;
    }

    public void setCodedir(String codedir) {
        this.codedir = codedir;
    }

    public int getRefuser() {
        return refuser;
    }

    public void setRefuser(int refuser) {
        this.refuser = refuser;
    }

    

    public int getInterdit() {
        return interdit;
    }

    public void setInterdit(int interdit) {
        this.interdit = interdit;
    }
    
    @Override
    public String getTuppleID() {
        return getId();
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
}
