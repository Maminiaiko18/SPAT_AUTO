/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.stock;

/**
 *
 * @author rasol
 */
public class BonDeCommandeFilleReste extends BonDeCommandeFille{
    private double qteFacturee, qteReste;

    public BonDeCommandeFilleReste() {
        this.setNomTable("BonDeCommandeFilleReste");
    }

    public double getQteFacturee() {
        return qteFacturee;
    }

    public void setQteFacturee(double qteFacturee) {
        this.qteFacturee = qteFacturee;
    }

    public double getQteReste() {
        return qteReste;
    }

    public void setQteReste(double qteReste) {
        this.qteReste = qteReste;
    }
}
