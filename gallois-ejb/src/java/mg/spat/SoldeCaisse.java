/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassMAPTable;
import java.sql.Date;

/**
 *
 * @author MEVA
 */
public class SoldeCaisse extends ClassMAPTable{

    private Date dateEffet;
    private String caisse;
    private double solde;

    public SoldeCaisse() {
        this.setNomTable("soldecaisse");
    }
    
    public Date getDateEffet() {
        return dateEffet;
    }

    public void setDateEffet(Date dateEffet) {
        this.dateEffet = dateEffet;
    }

    public String getCaisse() {
        return caisse;
    }

    public void setCaisse(String caisse) {
        this.caisse = caisse;
    }

    public double getSolde() {
        return solde;
    }

    public void setSolde(double solde) {
        this.solde = solde;
    }
    
    @Override
    public String getTuppleID() {
        return dateEffet.toString();
    }

    @Override
    public String getAttributIDName() {
        return "dateEffet";
    }
    
}
