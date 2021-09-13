/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author Andriamiary
 */
public class EtatProvision extends ClassMAPTable {
    private String id;
    private double montantfacture, montantprovision, ecart,montantpaye;
    private String tiers,tierslib;
    private Date daty;

    public EtatProvision(){ 
        this.setNomTable("etatprovision");
    }
    
    public EtatProvision(String id, double montantfacture, double montantprovision, double ecart, double montantpaye) {
        this.id = id;
        this.montantfacture = montantfacture;
        this.montantprovision = montantprovision;
        this.ecart = ecart;
        this.montantpaye = montantpaye;
    } 

    public EtatProvision(String id, double montantfacture, double montantprovision, double ecart, double montantpaye, String tierslib, Date daty) {
        this.id = id;
        this.montantfacture = montantfacture;
        this.montantprovision = montantprovision;
        this.ecart = ecart;
        this.montantpaye = montantpaye;
        this.tierslib = tierslib;
        this.daty = daty;
    }
    
    public EtatProvision(String id, double montantfacture, double montantprovision, double ecart, double montantpaye, String tiers, String tierslib, Date daty) {
        this.id = id;
        this.montantfacture = montantfacture;
        this.montantprovision = montantprovision;
        this.ecart = ecart;
        this.montantpaye = montantpaye;
        this.tiers = tiers;
        this.tierslib = tierslib;
        this.daty = daty;
    }
    
    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }   
    public double getMontantpaye() {
        return montantpaye;
    }

    public void setMontantpaye(double montantpaye) {
        this.montantpaye = montantpaye;
    }
          
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public double getMontantfacture() {
        return montantfacture;
    }

    public void setMontantfacture(double montantfacture) {
        this.montantfacture = montantfacture;
    }

    public double getMontantprovision() {
        return montantprovision;
    }

    public void setMontantprovision(double montantprovision) {
        this.montantprovision = montantprovision;
    }

    public double getEcart() {
        return ecart;
    }

    public void setEcart(double ecart) {
        this.ecart = ecart;
    }

    @Override
    public String getTuppleID() {return id;}

    @Override
    public String getAttributIDName() {return "id";}

    public String getTierslib() {
        return tierslib;
    }

    public void setTierslib(String tierslib) {
        this.tierslib = tierslib;
    }
    
    public String getTiers() {
        return tiers;
    }

    public void setTiers(String tiers) {
        this.tiers = tiers;
    }
    
}
