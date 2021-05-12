/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.ClassMAPTable;

/**
 *
 * @author Daniel
 */
public class Recurrent extends ClassMAPTable {
    private String id, typeFrequence;
    private double nombre;

    public Recurrent(){
        setNomTable("recurrent");
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTypeFrequence() {
        return typeFrequence;
    }

    public void setTypeFrequence(String typeFrequence) {
        this.typeFrequence = typeFrequence;
    }

    public double getNombre() {
        return nombre;
    }

    public void setNombre(double nombre) {
        this.nombre = nombre;
    }
    
    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
}
