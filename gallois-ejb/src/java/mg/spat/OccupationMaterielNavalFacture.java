/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

/**
 *
 * @author Sam25v14
 */
public class OccupationMaterielNavalFacture extends OccupationMaterielNavalLibComplet {
    private String compte, idfacture;
    private int etatfacture;
    private double pu, montanttotal;

    public OccupationMaterielNavalFacture() {
        this.setNomTable("OCCUPATION_FACTURECLIENT");
    }

    public String getCompte() {
        return compte;
    }

    public void setCompte(String compte) {
        this.compte = compte;
    }

    public String getIdfacture() {
        return idfacture;
    }

    public void setIdfacture(String idfacture) {
        this.idfacture = idfacture;
    }

    public int getEtatfacture() {
        return etatfacture;
    }

    public void setEtatfacture(int etatfacture) {
        this.etatfacture = etatfacture;
    }

    public double getPu() {
        return pu;
    }

    public void setPu(double pu) {
        this.pu = pu;
    }

    public double getMontanttotal() {
        return montanttotal;
    }

    public void setMontanttotal(double montanttotal) {
        this.montanttotal = montanttotal;
    }
}
