/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.stock;

/**
 *
 * @author andya
 */
public class BonDeCommandeFilleLibelle extends BonDeCommandeFille{
    String produitlib;

    public BonDeCommandeFilleLibelle() {
        this.setNomTable("AS_BONDECOMMANDE_FILLE_PRD");
    }

    public String getProduitlib() {
        return produitlib;
    }

    public void setProduitlib(String produitlib) {
        this.produitlib = produitlib;
    }
    
}
