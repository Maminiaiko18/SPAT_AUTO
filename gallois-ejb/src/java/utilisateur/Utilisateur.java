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
public class Utilisateur extends ClassMAPTable{

    private String refuser;
    private String loginuser ;
    private String pwduser;
    private String idrole;
    private String nomuser;
    private String teluser;

    public Utilisateur() {
        super.setNomTable("utilisateur");
    }

    public Utilisateur(String loginuser, String pwduser, String idrole, String nomuser, String teluser) {
        this.setLoginuser(loginuser);
        this.setPwduser(pwduser);
        this.setIdrole(idrole);
        this.setNomuser(nomuser);
        this.setTeluser(teluser);
    }

    public String getRefuser() {
        return refuser;
    }

    public void setRefuser(String refuser) {
        this.refuser = refuser;
    }

    public String getLoginuser() {
        return loginuser;
    }

    public void setLoginuser(String loginuser) {
        this.loginuser = loginuser;
    }

    public String getPwduser() {
        return pwduser;
    }

    public void setPwduser(String pwduser) {
        this.pwduser = pwduser;
    }

    public String getIdRole() {
        return idrole;
    }

    public void setIdrole(String idrole) {
        this.idrole = idrole;
    }

    public String getNomuser() {
        return nomuser;
    }

    public void setNomuser(String nomuser) {
        this.nomuser = nomuser;
    }

    public String getTeluser() {
        return teluser;
    }

    public void setTeluser(String teluser) {
        this.teluser = teluser;
    }
    
    @Override
    public String getTuppleID() {
        return this.refuser;
    }

    @Override
    public String getAttributIDName() {
        return "refuser"  ; 
    }
    public void construirePK(Connection c) throws Exception {
        super.setNomTable("user_bo");
        this.preparePk("USER", "getSeqUtilisateur");
        this.setRefuser(makePK(c));
    }
    
}
