/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassMAPTable;

/**
 *
 * @author john
 */
public class ClientFactureCategorieClient extends ClassMAPTable {

    private String id, idClient, idtype_fact_cat_client;
    private int statut;

    public ClientFactureCategorieClient() {
        super.setNomTable("Client_fact_cat_client");
    }   

    public String getTuppleID() {
        return id;
    }

    public String getAttributIDName() {
        return "id";
    }

    public ClientFactureCategorieClient(String id, String idClient, String idtype_fact_cat_client, int statut) {
        this.id = id;
        this.idClient = idClient;
        this.idtype_fact_cat_client = idtype_fact_cat_client;
        this.statut = statut;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdClient() {
        return idClient;
    }

    public void setIdClient(String idClient) {
        this.idClient = idClient;
    }

    public String getIdtype_fact_cat_client() {
        return idtype_fact_cat_client;
    }

    public void setIdtype_fact_cat_client(String idtype_fact_cat_client) {
        this.idtype_fact_cat_client = idtype_fact_cat_client;
    }

    public int getStatut() {
        return statut;
    }

    public void setStatut(int statut) {
        this.statut = statut;
    }
    
}
