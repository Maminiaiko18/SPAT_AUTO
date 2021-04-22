/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package recapitulation;

import bean.ClassMAPTable;

/**
 *
 * @author rasol
 */
public class RecapitulationPatrimoine extends ClassMAPTable{
    private String type;
    private int nombre;
    private double montant;

    public RecapitulationPatrimoine() {
        this.setNomTable("statistiquePatrimoine");
    }

    @Override
    public String getTuppleID() {
        return "";
    }

    @Override
    public String getAttributIDName() {
        return "";
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public int getNombre() {
        return nombre;
    }

    public void setNombre(int nombre) {
        this.nombre = nombre;
    }
}
