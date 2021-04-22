/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import detailschantier.DetailChantier;

/**
 *
 * @author ACER
 */
public class DetailChantierLib extends DetailChantier{
    private String libellechantier, caracteristique,unite,nomchantier;

    public DetailChantierLib(){
        this.setNomTable("detailschantierlibelle");
    }
    
    public String getLibellechantier() {
        return libellechantier;
    }

    public void setLibellechantier(String libellechantier) {
        this.libellechantier = libellechantier;
    }

    public String getCaracteristique() {
        return caracteristique;
    }

    public void setCaracteristique(String caracteristique) {
        this.caracteristique = caracteristique;
    }
    
    public String getUnite() {
        return unite;
    }

    public void setUnite(String unite) {
        this.unite = unite;
    }
    
    public String getNomchantier() {
        return nomchantier;
    }

    public void setNomchantier(String nomchantier) {
        this.nomchantier = nomchantier;
    }

}
