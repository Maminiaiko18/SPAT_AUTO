/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;


public class ClientTP extends ClassMAPTable {
    private String cdclt,tp,valide;
    private Date dttp;

    public ClientTP() {
        super.setNomTable("client_tp");
    }

    public String getCdclt() {
        return cdclt;
    }

    public void setCdclt(String cdclt) {
        this.cdclt = cdclt;
    }

    public String getTp() {
        return tp;
    }

    public void setTp(String tp) {
        this.tp = tp;
    }

    public String getValide() {
        return valide;
    }

    public void setValide(String valide) {
        this.valide = valide;
    }

    public Date getDttp() {
        return dttp;
    }

    public void setDttp(Date dttp) {
        this.dttp = dttp;
    }

    @Override
    public String getTuppleID() {
        return cdclt;
    }

    @Override
    public String getAttributIDName() {
        return "cdclt";
    }
    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("CTP", "get_seq_clientTP");
        setCdclt(makePK(c));
    }
    
}
