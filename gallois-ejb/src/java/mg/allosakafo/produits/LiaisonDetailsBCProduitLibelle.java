/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package mg.allosakafo.produits;

import java.sql.Date;

/**
 *
 * @author nyamp
 */
public class LiaisonDetailsBCProduitLibelle extends LiaisonDetailsBCProduit{
    String iddetailslib, idfournisseur,fournisseur,produit;
    Date daty;
    
    public LiaisonDetailsBCProduitLibelle(){
        this.setNomTable("LIAISONDETAILSBCPRODUITLIBELLE");
    }

    public String getProduit() {
        return produit;
    }

    public void setProduit(String produit) {
        this.produit = produit;
    }
    
    public String getIddetailslib() {
        return iddetailslib;
    }

    public void setIddetailslib(String iddetailslib) {
        this.iddetailslib = iddetailslib;
    }

    public String getIdfournisseur() {
        return idfournisseur;
    }

    public void setIdfournisseur(String idfournisseur) {
        this.idfournisseur = idfournisseur;
    }

    public String getFournisseur() {
        return fournisseur;
    }

    public void setFournisseur(String fournisseur) {
        this.fournisseur = fournisseur;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }
    
}
