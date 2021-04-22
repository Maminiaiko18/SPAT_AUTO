/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package poste;

import bean.TypeObjet;
import java.sql.Connection;

/**
 *
 * @author rasol
 */
public class Poste extends TypeObjet{
    private double rang;
    
    public Poste(){
        this.setNomTable("Poste");
    }

    public double getRang() {
        return rang;
    }

    public void setRang(double rang) {
        this.rang = rang;
    }
    
    public void construirePK(Connection c) throws Exception{
        this.preparePk("POST", "getseqposte");
        this.setId(makePK(c));
    }
}
