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
public class RecapitulationRH extends ClassMAPTable {

    private String type;
    double nombre;

    public double getNombre() {
        return nombre;
    }

    public void setNombre(double nombre) {
        this.nombre = nombre;
    }
    
    public RecapitulationRH(String type) {
        this.setType(type);
        this.setNomTable("statistiqueRH");
    }

    public RecapitulationRH() {
        this.setNomTable("statistiqueRH");
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

}
