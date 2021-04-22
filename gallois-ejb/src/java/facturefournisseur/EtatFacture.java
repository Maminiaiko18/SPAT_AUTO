/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facturefournisseur;
/**
 *
 * @author tahina
 */
public class EtatFacture extends FactureFournisseurLettre {
    
    private String nomfournisseur;
    double montantPaye;
    double reste;
    double retenue;
    private double montantTTDevise;

    public double getRetenue() {
        return retenue;
    }

    public void setRetenue(double retenue) {
        this.retenue = retenue;
    }

    public double getMontantTTDevise() {
        return montantTTDevise;
    }

    public void setMontantTTDevise(double montantTTDevise) {
        this.montantTTDevise = montantTTDevise;
    }

    public EtatFacture()
    {
        this.setNomTable("EtatFacture");
    }
    public double getMontantPaye() {
        return montantPaye;
    }

    public void setMontantPaye(double montantPaye) {
        this.montantPaye = montantPaye;
    }

    public double getReste() {
        return reste;
    }

    public void setReste(double reste) {
        this.reste = reste;
    }

    public String getNomfournisseur() {
        return nomfournisseur;
    }

    public void setNomfournisseur(String nomfournisseur) {
        this.nomfournisseur = nomfournisseur;
    }
    

    
    
    
}
