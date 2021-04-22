/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package affichage;

/**
 *
 * @author rakotondralambokoto
 */
public class Ac_object {
    private Object valeur;
    private Object affiche; 

    public Object getValeur() {
        return valeur;
    }

    public void setValeur(Object valeur) {
        this.valeur = valeur;
    }

    public Object getAffiche() {
        return affiche;
    }

    public void setAffiche(Object affiche) {
        this.affiche = affiche;
    }

    public Ac_object(Object valeur, Object affiche) {
        this.setValeur(valeur);
        this.setAffiche(affiche);
    }

    public Ac_object() {
    }
    
    
}
