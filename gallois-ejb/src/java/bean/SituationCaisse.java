/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;

/**
 *
 * @author rasol
 */
public class SituationCaisse  extends ClassMAPTable{
    private String id, nomCaisse;
    private double soldeinitial, entree, sortie, soldefinal;

    public SituationCaisse() {
        this.setNomTable("situationcaisse");
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNomCaisse() {
        return nomCaisse;
    }

    public void setNomCaisse(String nomCaisse) {
        this.nomCaisse = nomCaisse;
    }

    public double getSoldeinitial() {
        return soldeinitial;
    }

    public void setSoldeinitial(double soldeinitial) {
        this.soldeinitial = soldeinitial;
    }

    public double getEntree() {
        return entree;
    }

    public void setEntree(double entree) {
        this.entree = entree;
    }

    public double getSortie() {
        return sortie;
    }

    public void setSortie(double sortie) {
        this.sortie = sortie;
    }

    public double getSoldefinal() {
        return soldefinal;
    }

    public void setSoldefinal(double soldefinal) {
        this.soldefinal = soldefinal;
    }
}
