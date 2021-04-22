/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package historique;

/**
 *
 * @author MEVA
 */
public class MapUtilisateurLib extends bean.ClassMAPTable{
    
    private String loginuser;
    private String pwduser;
    private String idrole;
    private String nomuser;
    private String adruser;
    private String teluser;
    private String refuser;

    public MapUtilisateurLib() {
        setNomTable("UTILISATEURVUEFICHE_ID");
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

    public String getIdrole() {
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

    public String getAdruser() {
        return adruser;
    }

    public void setAdruser(String adruser) {
        this.adruser = adruser;
    }

    public String getTeluser() {
        return teluser;
    }

    public void setTeluser(String teluser) {
        this.teluser = teluser;
    }

    public String getRefuser() {
        return refuser;
    }

    public void setRefuser(String refuser) {
        this.refuser = refuser;
    }

    @Override
    public String getTuppleID() {
       return refuser;
    }

    @Override
    public String getAttributIDName() {
        return "refuser";
    }
    
    
    
}
