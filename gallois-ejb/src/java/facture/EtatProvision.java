/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author Andriamiary
 */
public class EtatProvision extends ClassMAPTable {
    private String id;
    private double montantfacture, montantprovision, ecart;
    
    public EtatProvision(){ 
        this.setNomTable("etatprovision");
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
    
}
