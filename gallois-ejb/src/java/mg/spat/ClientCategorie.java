/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

/**
 *
 * @author Asus
 */
public class ClientCategorie extends Client{
    private String categorie;

    public ClientCategorie() {
            super.setNomTable("V_CLIENT_CATEGORIE");
    }

  

    public String getCategorie() {
        return categorie;
    }

    public void setCategorie(String categorie) {
        this.categorie = categorie;
    }
    
    
}
