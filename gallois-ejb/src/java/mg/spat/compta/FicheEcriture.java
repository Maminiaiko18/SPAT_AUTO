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
public class FicheEcriture {
    private ComptaEcriture[] ecritures;
    private ComptaSousEcriture[] sousEcritures;

    public FicheEcriture() {
    }

    public FicheEcriture(ComptaEcriture[] ecritures, ComptaSousEcriture[] sousEcritures) {
        this.ecritures = ecritures;
        this.sousEcritures = sousEcritures;
    }

    public ComptaEcriture[] getEcritures() {
        return ecritures;
    }

    public void setEcritures(ComptaEcriture[] ecritures) {
        this.ecritures = ecritures;
    }

    public ComptaSousEcriture[] getSousEcritures() {
        return sousEcritures;
    }

    public void setSousEcritures(ComptaSousEcriture[] sousEcritures) {
        this.sousEcritures = sousEcritures;
    }
    
}
