/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.compta;

import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author Asus
 */
public class DetailConcessionnaireMtht extends ClassMAPTable{
    
    private String idfacturefille,idfacturemere,refobj,designation,idunite;
    private double quantite,prixunitaire,reduction;

    public DetailConcessionnaireMtht() {
         super.setNomTable("facturefille");
    }

    public String getIdfacturefille() {
        return idfacturefille;
    }

    public void setIdfacturefille(String idfacturefille) {
        this.idfacturefille = idfacturefille;
    }

    public String getIdfacturemere() {
        return idfacturemere;
    }

    public void setIdfacturemere(String idfacturemere) {
        this.idfacturemere = idfacturemere;
    }

    public String getRefobj() {
        return refobj;
    }

    public void setRefobj(String refobj) {
        this.refobj = refobj;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getIdunite() {
        return idunite;
    }

    public void setIdunite(String idunite) {
        this.idunite = idunite;
    }

    public double getQuantite() {
        return quantite;
    }

    public void setQuantite(double quantite) {
        this.quantite = quantite;
    }

    public double getPrixunitaire() {
        return prixunitaire;
    }

    public void setPrixunitaire(double prixunitaire) {
        this.prixunitaire = prixunitaire;
    }

    public double getReduction() {
        return reduction;
    }

    public void setReduction(double reduction) {
        this.reduction = reduction;
    }

    
    
    
    
    @Override
    public String getTuppleID() {
        return this.idfacturefille;
    }

    @Override
    public String getAttributIDName() {
     return "idfacturefille"; 
    }
     public void construirePK(Connection c) throws Exception {
        
    }
    
}
