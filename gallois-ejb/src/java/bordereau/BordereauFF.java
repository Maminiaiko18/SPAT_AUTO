/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bordereau;

/**
 *
 * @author Audace
 */
public class BordereauFF extends Bordereau{

    private double montantbudget;
    private double montantav;
    private double montantap;

    public double getMontantbudget(){
        return this.montantbudget;
    }

    public double getMontantav() {
        return montantav;
    }

    public double getMontantap() {
        return montantap;
    }

    public void setMontantap(double montantap) {
        this.montantap = montantap;
    }

    public void setMontantav(double montantav) {
        this.montantav = montantav;
    }

    public void setMontantbudget(double montantbudget) {
        this.montantbudget = montantbudget;
    }
    
    public BordereauFF(){
        this.setNomTable("BORDEREAUFF");
        this.setNomTableFille("liaisonbordereauFF");
        this.setNomFonctionSequence("get_seqnumerobordereauFF");
    }
}