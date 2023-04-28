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
    private String nomuser;

	public String getNomuser() {
		return this.nomuser;
	}

	public void setNomuser(String nomuser) {
		this.nomuser = nomuser;
	}


	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getIdrole() {
		return this.idrole;
	}

	public void setIdrole(String idrole) {
		this.idrole = idrole;
	}

	public String getIdmenu() {
		return this.idmenu;
	}

	public void setIdmenu(String idmenu) {
		this.idmenu = idmenu;
	}

	public String getCodeservice() {
		return this.codeservice;
	}

	public void setCodeservice(String codeservice) {
		this.codeservice = codeservice;
	}

	public String getCodedir() {
		return this.codedir;
	}

	public void setCodedir(String codedir) {
		this.codedir = codedir;
	}

	public int getInterdit() {
		return this.interdit;
	}

	public void setInterdit(int interdit) {
		this.interdit = interdit;
	}

	public String getRefuser() {
		return this.refuser;
	}

	public void setRefuser(String refuser) {
		this.refuser = refuser;
	}

	public String getLogin() {
		return this.login;
	}

	public void setLogin(String login) {
		this.login = login;
	}


    
  
    public UserMenu(String idrole, String idmenu, String codeservice, String codedir, int interdit, String refuser) {
        this.idrole = idrole;
        this.idmenu = idmenu;
        this.codeservice = codeservice;
        this.codedir = codedir;
        this.interdit = interdit;
        this.refuser = refuser;
    }

    public UserMenu(String id,String idrole, String idmenu, String codeservice, String codedir, int interdit, String refuser, String login, String nomuser) {
        this.id = id;
        this.idrole = idrole;
        this.idmenu = idmenu;
        this.codeservice = codeservice;
        this.codedir = codedir;
        this.interdit = interdit;
        this.refuser = refuser;
        this.login = login;
        this.nomuser = nomuser;
    }
    
    public void construirePK(Connection c) throws Exception {
            super.setNomTable("usermenu");
        this.preparePk("MEN", "getSeqUserMenu");
        this.setId(makePK(c));
    }
    public UserMenu() {
        super.setNomTable("usermenu");
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
