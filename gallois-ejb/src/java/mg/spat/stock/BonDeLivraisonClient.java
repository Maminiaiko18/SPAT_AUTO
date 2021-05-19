/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.stock;

import java.sql.Connection;

/**
 *
 * @author Daniel
 */
public class BonDeLivraisonClient extends BonDeLivraison {
    private String designationFacture;
    
    public BonDeLivraisonClient(){
        super.setNomTable("as_bondelivraison_cl");
    }

    public String getDesignationFacture() {
        return designationFacture;
    }

    public void setDesignationFacture(String designationFacture) {
        this.designationFacture = designationFacture;
    }
    @Override
    public void controlQuantite(Connection c) throws Exception {}
}
