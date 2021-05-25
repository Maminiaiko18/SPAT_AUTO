/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.CGenUtil;
import java.sql.Connection;
import utilitaire.Utilitaire;

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
    
    public void findFactureClient(String[] ids,Connection c) throws Exception {
        String id=Utilitaire.tabToString(ids,"'",",");
        FactureClient[]listeFact=  (FactureClient[]) CGenUtil.rechercher(new FactureClient(), null, null, c, " and  id in(" + id + ")");
        this.setListeFactureClient(listeFact);
    }
}
