/**
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
    private String refuser;
    private String login;
    private String nomUser;
    
  
    public UserMenu(String idrole, String idmenu, String codeservice, String codedir, int interdit, String refuser) {
        this.idrole = idrole;
        this.idmenu = idmenu;
        this.codeservice = codeservice;
        this.codedir = codedir;
        this.interdit = interdit;
        this.refuser = refuser;
    }

    public UserMenu(String idrole, String idmenu, String codeservice, String codedir, int interdit, String refuser, String login, String nomUser) {
        this.idrole = idrole;
        this.idmenu = idmenu;
        this.codeservice = codeservice;
        this.codedir = codedir;
        this.interdit = interdit;
        this.refuser = refuser;
        this.login = login;
        this.nomUser = nomUser;
    }
    
    public void construirePK(Connection c) throws Exception {
            super.setNomTable("usermenu");
        this.preparePk("MEN", "getSeqUserMenu");
        this.setId(makePK(c));
    }
    public UserMenu() {
        super.setNomTable("usermenu");
    }
    public String getLogin() {
          return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getNomUser() {
        return nomUser;
    }

    public void setNomUser(String nomUser) {
        this.nomUser = nomUser;
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

    public String getRefuser() {
        return refuser;
    }

    public void setRefuser(String refuser) {
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
