/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

/**
 *
 * @author
 */
public class AdminFactureClient {
    
    private FactureClient[] listeFactureClient;
    
    public AdminFactureClient(){
    }
    

    public FactureClient[] getListeFactureClient() {
        return listeFactureClient;
    }

    public void setListeFactureClient(FactureClient[] listeFactureClient) {
        this.listeFactureClient = listeFactureClient;
    }
    
}
