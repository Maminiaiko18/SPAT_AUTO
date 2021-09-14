/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.CGenUtil;
import facture.FactureClient;
import java.sql.Connection;
import utilitaire.UtilDB;

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
    
    public FactureClient[] getResteProvision(Connection c) throws Exception {
        int verif = 0;
	try {
		if (c == null) {
			c = (new UtilDB()).GetConn();
			verif = 1;
		}
		FactureClient factureClient = new FactureClient();
		factureClient.setNomTable("provisionEcart");
		String awhere = String.format(" and ecart > 0 and tiers = '%s' ", this.getCdclt());
		FactureClient[] result = (FactureClient[])CGenUtil.rechercher(factureClient, null, null, c, awhere);
		return result;
	} finally {
		if (c != null && verif == 1) {
			c.close();
		}
	}
    }
}
