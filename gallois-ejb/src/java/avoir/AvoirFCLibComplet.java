/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package avoir;

/**
 *
 * @author Ratsidikaina
 */
public class AvoirFCLibComplet extends AvoirFC {
    private String typeavoir_desce, etatlib, tierslib;
    private double montantpaye, montantreste;
    
    public AvoirFCLibComplet() throws Exception {
        setNomTable("AVOIRFC_MONTANTLIBETAT");
    }

    public String getTypeavoir_desce() {
        return typeavoir_desce;
    }

    public void setTypeavoir_desce(String typeavoir_desce) {
        this.typeavoir_desce = typeavoir_desce;
    }

    public String getEtatlib() {
        return etatlib;
    }

    public void setEtatlib(String etatlib) {
        this.etatlib = etatlib;
    }

    public String getTierslib() {
        return tierslib;
    }

    public void setTierslib(String tierslib) {
        this.tierslib = tierslib;
    }

    public double getMontantpaye() {
        return montantpaye;
    }

    public void setMontantpaye(double montantpaye) {
        this.montantpaye = montantpaye;
    }

    public double getMontantreste() {
        return montantreste;
    }

    public void setMontantreste(double montantreste) {
        this.montantreste = montantreste;
    }
    
    
    
}
