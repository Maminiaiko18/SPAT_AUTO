package mg.port.api.model;

/** Request payload for the privileged SPAT user-management API. */
public class UtilisateurApiRequest {

    private String loginuser;
    private String pwduser;
    private String nomuser;
    private String adruser;
    private String teluser;
    private String idrole;
    private String codeEtablissement;

    public String getLoginuser() { return loginuser; }
    public void setLoginuser(String loginuser) { this.loginuser = loginuser; }
    public String getPwduser() { return pwduser; }
    public void setPwduser(String pwduser) { this.pwduser = pwduser; }
    public String getNomuser() { return nomuser; }
    public void setNomuser(String nomuser) { this.nomuser = nomuser; }
    public String getAdruser() { return adruser; }
    public void setAdruser(String adruser) { this.adruser = adruser; }
    public String getTeluser() { return teluser; }
    public void setTeluser(String teluser) { this.teluser = teluser; }
    public String getIdrole() { return idrole; }
    public void setIdrole(String idrole) { this.idrole = idrole; }
    public String getCodeEtablissement() { return codeEtablissement; }
    public void setCodeEtablissement(String codeEtablissement) { this.codeEtablissement = codeEtablissement; }
}
