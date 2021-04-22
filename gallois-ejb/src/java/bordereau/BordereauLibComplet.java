/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bordereau;

/**
 *
 * @author nyamp
 */
public class BordereauLibComplet extends Bordereau{
    private String tierslib;
    
    public BordereauLibComplet(){
        setNomTable("bordereau_libcomplet");
    }

    public String getTierslib() {
        return tierslib;
    }

    public void setTierslib(String tierslib) {
        this.tierslib = tierslib;
    }
    
    
}
