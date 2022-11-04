/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;


public class ClientQuit extends ClassMAPTable {
    private String id,cdclt,quit,valide;
    private Date dtquit;
    private String nomclt;

    public ClientQuit() {
        super.setNomTable("client_quit");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    
    public String getCdclt() {
        return cdclt;
    }

    public void setCdclt(String cdclt) {
        this.cdclt = cdclt;
    }

    public String getQuit() {
        return quit;
    }

    public void setQuit(String quit) {
        this.quit = quit;
    }

    public String getValide() {
        return valide;
    }

    public void setValide(String valide) {
        this.valide = valide;
    }

    public Date getDtquit() {
        return dtquit;
    }

    public void setDtquit(Date dtquit) {
        this.dtquit = dtquit;
    }

    public String getNomclt() {
        return nomclt;
    }

    public void setNomclt(String nomclt) {
        this.nomclt = nomclt;
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
        preparePk("CQ", "get_seq_client_quit");
        setCdclt(makePK(c));
    }
    
}
