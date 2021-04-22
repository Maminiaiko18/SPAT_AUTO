/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.cnaps.messagecommunication;

import bean.ClassMAPTable;
import java.sql.Connection;
import utilitaire.Utilitaire;

/**
 *
 * @author NERD
 */
public class Conversation extends ClassMAPTable{
    private String id;
    private String iduser1;
    private String iduser2;
    
    public Conversation() {
        super.setNomTable("conversation");
    }

    public Conversation(String id, String iduser1, String iduser2) {
        super.setNomTable("conversation");
        this.id = id;
        this.iduser1 = iduser1;
        this.iduser2 = iduser2;
    }
    
    public String getTuppleID() {
        return id;
    }
    
    public String getAttributIDName() {
        return "id";
    }
    
    public void construirePK(Connection c) throws Exception {
       
        this.preparePk("CNV", "getSeqconversation");
        this.setId(makePK(c));
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIduser1() {
        return Utilitaire.champNull(iduser1);
    }

    public void setIduser1(String iduser1) {
        if(getMode().compareTo("modif")==0 && iduser1!=null && iduser1.contains("/")){
            String[] g = Utilitaire.split(iduser1, "/");
            String t = g[0];
            this.iduser1= g[0];
            return;
        }
        this.iduser1 = iduser1;
    }

    public String getIduser2() {
        return Utilitaire.champNull(iduser2);
    }

    public void setIduser2(String iduser2) {
        if(getMode().compareTo("modif")==0 && iduser2!=null && iduser2.contains("/")){
            String[] g = Utilitaire.split(iduser2, "/");
            String t = g[0];
            this.iduser2= g[0];
            return;
        }
        this.iduser2 = iduser2;
    }  
}