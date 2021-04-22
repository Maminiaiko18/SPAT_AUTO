/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.cnaps.formation;

/**
 *
 * @author anthonyandrianaivoravelona
 */
public class FormationEtatDirection extends FormationEtat{
    private String direction;

    public FormationEtatDirection() {
        super.setNomTable("FORMATION_ETAT_DIRECTION");
    }

    public String getDirection() {
        return direction;
    }

    public void setDirection(String direction) {
        this.direction = direction;
    }
    
    
}
