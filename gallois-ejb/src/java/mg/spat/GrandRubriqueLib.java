/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.TypeObjet;

/**
 *
 * @author Itokiana
 */
public class GrandRubriqueLib extends TypeObjet {
    private int rang;

    public int getRang() {
        return rang;
    }

    public void setRang(int rang) {
        this.rang = rang;
    }

    public GrandRubriqueLib() {
        super.setNomTable("GRANDRUBRIQUE");
    }
    
    
}
