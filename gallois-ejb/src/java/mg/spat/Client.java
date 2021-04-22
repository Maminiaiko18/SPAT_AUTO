/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassMAPTable;

/**
 *
 * @author MEVA
 */
public class Client extends ClassMAPTable{

    private String cdclt,cdcat,nomclt,adrclt,nmsttclt,telclt,faxclt,nmcin,nif,rc;

    public Client() {
        super.setNomTable("clientmat");
    }

    public String getValColLibelle() {
        return nomclt;
    }
    
    public String getCdclt() {
        return cdclt;
    }

    public void setCdclt(String cdclt) {
        this.cdclt = cdclt;
    }

    public String getCdcat() {
        return cdcat;
    }

    public void setCdcat(String cdcat) {
        this.cdcat = cdcat;
    }

    public String getNomclt() {
        return nomclt;
    }

    public void setNomclt(String nomclt) {
        this.nomclt = nomclt;
    }

    public String getAdrclt() {
        return adrclt;
    }

    public void setAdrclt(String adrclt) {
        this.adrclt = adrclt;
    }

    public String getNmsttclt() {
        return nmsttclt;
    }

    public void setNmsttclt(String nmsttclt) {
        this.nmsttclt = nmsttclt;
    }

    public String getTelclt() {
        return telclt;
    }

    public void setTelclt(String telclt) {
        this.telclt = telclt;
    }

    public String getFaxclt() {
        return faxclt;
    }

    public void setFaxclt(String faxclt) {
        this.faxclt = faxclt;
    }

    

    public String getNmcin() {
        return nmcin;
    }

    public void setNmcin(String nmcin) {
        this.nmcin = nmcin;
    }

    public String getNif() {
        return nif;
    }

    public void setNif(String nif) {
        this.nif = nif;
    }

    public String getRc() {
        return rc;
    }

    public void setRc(String rc) {
        this.rc = rc;
    }
    
    
    
    @Override
    public String getTuppleID() {
        return this.cdclt;
    }

    @Override
    public String getAttributIDName() {
        return "cdclt";
    }
    
}
