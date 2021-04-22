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
public class BordereauFilleLibComplet extends BordereauFille{
    private String remarque,idfacture,idbordereaulib;
    private double montant;
    
    public BordereauFilleLibComplet(){
        setNomTable("liaisonbordereau_libcomplet");
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public String getIdfacture() {
        return idfacture;
    }

    public void setIdfacture(String idfacture) {
        this.idfacture = idfacture;
    }

    public String getIdbordereaulib() {
        return idbordereaulib;
    }

    public void setIdbordereaulib(String idbordereaulib) {
        this.idbordereaulib = idbordereaulib;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }
    
    
}
