/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

/**
 *
 * @author JESSI
 */
public class AnalyseMouvement extends MouvementLibComplet{
    private double depart,arrivee,difference;
    private String typenavire,escale;

    public String getEscale() {
        return escale;
    }

    public void setEscale(String escale) {
        this.escale = escale;
    }

    public String getTypenavire() {
        return typenavire;
    }

    public void setTypenavire(String typenavire) {
        this.typenavire = typenavire;
    }
    

    public double getDifference() {
        return difference;
    }

    public void setDifference(double difference) {
        this.difference = difference;
    }
    
    public AnalyseMouvement() {
        this.setNomTable("MVTLIBCOMPLETANALYSEUNION1");
    }

    public double getDepart() {
        return depart;
    }

    public void setDepart(double depart) {
        this.depart = depart;
    }

    public double getArrivee() {
        return arrivee;
    }

    public void setArrivee(double arrive) {
        this.arrivee = arrive;
    }
    
}
