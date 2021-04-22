/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facturefournisseur;

/**
 *
 * @author Daniel
 */
public class FactureFournisseurLibelle extends FactureFournisseur {
    private String fournisseur, idchantier;
    
    public FactureFournisseurLibelle(){
        setNomTable("facturefournisseurlibelle");
    }

    public String getFournisseur() {
        return fournisseur;
    }

    public void setFournisseur(String fournisseur) {
        this.fournisseur = fournisseur;
    }

    public String getIdchantier() {
        return idchantier;
    }

    public void setIdchantier(String idchantier) {
        this.idchantier = idchantier;
    }
    
    public String getColValLibelle(){
        return this.getDesignation();
    }
    
}
