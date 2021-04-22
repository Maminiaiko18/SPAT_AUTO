/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.compta;

/**
 *
 * @author MEVA
 */
public class ComptaSousEcritureAvecDevise extends ComptaSousEcriture{
    double coursdevise;
    double montantdevise;
    String contrep;

    public String getContrep() {
        return contrep;
    }

    public void setContrep(String contrep) {
        this.contrep = contrep;
    }

    public ComptaSousEcritureAvecDevise() {
        super.setNomTable("COMPTA_SOUSECRITURE_AVECDEVISE");
    }

    public double getCoursdevise() {
        return coursdevise;
    }

    public void setCoursdevise(double coursdevise) {
        this.coursdevise = coursdevise;
    }

    public double getMontantdevise() {
        return montantdevise;
    }

    public void setMontantdevise(double montantdevise) {
        this.montantdevise = montantdevise;
    }
    
}
