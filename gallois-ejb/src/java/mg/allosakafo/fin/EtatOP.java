/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.allosakafo.fin;

/**
 *
 * @author tahina
 */
public class EtatOP extends OrdreDePaiementLettre {
    
    public EtatOP()
    {
        this.setNomTable("etatordonnerpayement");
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
    double montantPaye;
    double reste;
}
