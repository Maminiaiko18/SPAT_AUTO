/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilisateur;

/**
 *
 * @author Ignafah
 */
public class UtilisateurInterimValide extends UtilisateurInterim{
    private int rang;

    public UtilisateurInterimValide() {
        super.setNomTable("UTILISATEUR_INTERIM_VALIDE");
    }

    public int getRang() {
        return rang;
    }

    public void setRang(int rang) {
        this.rang = rang;
    }
    
}
