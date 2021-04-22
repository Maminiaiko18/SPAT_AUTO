/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

/**
 *
 * @author pro
 */

public class PatrimoineAnalyse extends Patrimoine{
    private double nombre;
    private double superficie_occupee,superficie_disponible;

    public double getSuperficie_occupee() {
        return superficie_occupee;
    }

    public void setSuperficie_occupee(double superficie_occupee) {
        this.superficie_occupee = superficie_occupee;
    }

    public double getSuperficie_disponible() {
        return superficie_disponible;
    }

    public void setSuperficie_disponible(double superficie_disponible) {
        this.superficie_disponible = superficie_disponible;
    }
    
    public PatrimoineAnalyse() {
        this.setNomTable("patrimoinelib_analyse");
    }
    
    public double getNombre() {
        return nombre;
    }

    public void setNombre(double nombre) {
        this.nombre = nombre;
    }
    
}
