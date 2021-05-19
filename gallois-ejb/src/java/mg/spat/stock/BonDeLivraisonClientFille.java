/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.stock;

import bean.CGenUtil;
import facture.FactureClientDetails;
import java.sql.Connection;

/**
 *
 * @author Daniel
 */
public class BonDeLivraisonClientFille extends BonDeLivraisonFille {
    private String produitLib;
    
    private String pdt;
    
    public BonDeLivraisonClientFille(){
        super.setNomTable("as_bondelivraison_cl_fille");
    }
    
    @Override
    public void controler(Connection c) throws Exception {
        FactureClientDetails fcd = new FactureClientDetails();
        fcd.setNomTable("facture_client_fille_lib_reste");
        FactureClientDetails[] tFcd = (FactureClientDetails[]) CGenUtil.rechercher(fcd, null, null, c, " and id = '" + this.getIddetailsfacturefournisseur() + "'");
        
        if(tFcd != null && tFcd.length > 0) {
            if(tFcd[0].getRestealivrer() < this.getQuantite()) throw new Exception("Quantité supérieure au reste à livrer");
        }
        
        super.controler(c);
    }

    public String getProduitLib() {
        return produitLib;
    }

    public void setProduitLib(String produitLib) {
        this.produitLib = produitLib;
    }
    public String getPdt() {
        return pdt;
    }

    public void setPdt(String pdt) {
        this.pdt = pdt;
    }
    
}
