/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.travaux;

/**
 *
 * @author Sam25v14
 */
public class PourcentageProjetComplet extends PourcentageProjet {

    private String nom, chantierlib;

    public PourcentageProjetComplet() {
        this.setNomTable("POURCENTAGEPROJETLIBCOMPLET");
    }

    public String getChantierlib() {
        return chantierlib;
    }

    public void setChantierlib(String chantierlib) {
        this.chantierlib = chantierlib;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }
}
