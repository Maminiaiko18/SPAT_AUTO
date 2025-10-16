/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import java.util.ArrayList;

/**
 *
 * @author rahar
 */
public class FactureClientDetailsPDF {
    public ArrayList<FactureClientDetails> details;
    public ArrayList<FactureClientDetailsProf> details1;
    
    public double total, montantdevise, montantTVAdevise, montantTTCdevise;

    public ArrayList<FactureClientDetails> getDetails() {
        return details;
    }
    public ArrayList<FactureClientDetailsProf> getDetailsProf() {
        return details1;
    }
    
    public void setDetails(ArrayList<FactureClientDetails> details) {
        this.details = details;
    }
    public void setDetailsProf(ArrayList<FactureClientDetailsProf> details) {
        this.details1 = details;
    }
    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public double getMontantdevise() {
        return montantdevise;
    }

    public void setMontantdevise(double montantdevise) {
        this.montantdevise = montantdevise;
    }

    public double getMontantTVAdevise() {
        return montantTVAdevise;
    }

    public void setMontantTVAdevise(double montantTVAdevise) {
        this.montantTVAdevise = montantTVAdevise;
    }

    public double getMontantTTCdevise() {
        return montantTTCdevise;
    }

    public void setMontantTTCdevise(double montantTTCdevise) {
        this.montantTTCdevise = montantTTCdevise;
    }
}
