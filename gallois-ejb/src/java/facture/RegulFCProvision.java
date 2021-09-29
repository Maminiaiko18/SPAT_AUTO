/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.ClassEtat;

/**
 *
 * @author rijan
 */
public class RegulFCProvision extends ClassEtat{
    
    private String id, idProvision,idFacture,idProvisionCode,idFactureCode;
    private int etat;
    private String etatlib;

    public RegulFCProvision(String id, String idProvision, String idFacture, String idProvisionCode, String idFactureCode, int etat ,String etatlib) {
        this.setNomTable("regulFCProvision");
        this.setId(id);
        this.setIdProvision(idProvision);
        this.setIdFacture(idFacture);
        this.setIdProvisionCode(idProvisionCode);
        this.setIdFactureCode(idFactureCode);
        this.setEtat(etat);
        this.setEtatlib(etatlib);
    }
    
    public RegulFCProvision(){ 
        this.setNomTable("regulFCProvision");
    }
    
    public String getEtatlib() {
        return etatlib;
    }

    public void setEtatlib(String etatlib) {
        this.etatlib = etatlib;
    }


    public int getEtat() {
        return etat;
    }

    public void setEtat(int etat) {
        this.etat = etat;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdProvision() {
        return idProvision;
    }

    public void setIdProvision(String idProvision) {
        this.idProvision = idProvision;
    }

    public String getIdFacture() {
        return idFacture;
    }

    public void setIdFacture(String idFacture) {
        this.idFacture = idFacture;
    }

    public String getIdProvisionCode() {
        return idProvisionCode;
    }

    public void setIdProvisionCode(String idProvisionCode) {
        this.idProvisionCode = idProvisionCode;
    }

    public String getIdFactureCode() {
        return idFactureCode;
    }

    public void setIdFactureCode(String idFactureCode) {
        this.idFactureCode = idFactureCode;
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
}
