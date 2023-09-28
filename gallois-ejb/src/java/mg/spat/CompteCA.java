/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.TypeObjet;

/**
 *
 * @author Nouta
 */
public class CompteCA extends TypeObjet{
    String libelle; 
    String idGrandRubrique;

    public String getIdGrandRubrique() {
        return idGrandRubrique;
    }

    public void setIdGrandRubrique(String idGrandRubrique) {
        this.idGrandRubrique = idGrandRubrique;
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

    @Override
    public String getValColLibelle() {
        return this.getVal()+";"+this.getLibelle();
    }
    
    
    
}
