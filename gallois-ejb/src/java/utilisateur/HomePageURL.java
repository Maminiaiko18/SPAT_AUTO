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
 * @author Joe
 */
public class HomePageURL extends ClassMAPTable{
    
    private String id;
    private String codeservice;
    private String urlpage;
    private String idrole;
    private String codedir;

    public HomePageURL() {
        this.setNomTable("USERHOMEPAGE");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCodeservice() {
        return codeservice;
    }

    public void setCodeservice(String codeservice) {
        this.codeservice = codeservice;
    }

    public String getUrlpage() {
        return urlpage;
    }

    public void setUrlpage(String urlpage) {
        this.urlpage = urlpage;
    }

    public String getIdrole() {
        return idrole;
    }

    public void setIdrole(String idrole) {
        this.idrole = idrole;
    }

    public String getCodedir() {
        return codedir;
    }

    public void setCodedir(String codedir) {
        this.codedir = codedir;
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
        this.preparePk("UHP", "getSeqHomePageURL");
        this.setId(makePK(c));
    }
    
}
