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
    private double montantbudget,montantav,montantap;
    
    public BordereauLibComplet(){
        setNomTable("bordereau_libcomplet");
    }

    public double getMontantbudget() {
        return montantbudget;
    }

    public void setMontantbudget(double montantbudget) {
        this.montantbudget = montantbudget;
    }

    public double getMontantav() {
        return montantav;
    }

    public void setMontantav(double montantav) {
        this.montantav = montantav;
    }

    public double getMontantap() {
        return montantap;
    }

    public void setMontantap(double montantap) {
        this.montantap = montantap;
    }

    public String getTierslib() {
        return tierslib;
    }

    public void setTierslib(String tierslib) {
        this.tierslib = tierslib;
    }
    
    
}
