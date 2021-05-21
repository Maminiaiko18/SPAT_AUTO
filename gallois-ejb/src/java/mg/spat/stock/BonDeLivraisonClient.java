/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.stock;

import bean.CGenUtil;
import bean.TypeObjet;
import java.sql.Connection;
import facture.FactureClient;

/**
 *
 * @author Daniel
 */
public class BonDeLivraisonClient extends BonDeLivraison {
    private String designationFacture;
    
    public FactureClient getFacture(Connection c) throws Exception{
        FactureClient facture=null;
        FactureClient[] factures=(FactureClient[]) CGenUtil.rechercher(new FactureClient(), null, null, c, " and id = '" + this.getIdbc() + "'");
        if(factures.length>0){
            facture=factures[0];
        }
        return facture;
    }
    
    public void testerVisaFacture(Connection c) throws Exception{
        FactureClient facture = this.getFacture(c);
        if(facture!=null && facture.getEtat()<11){
             throw new Exception("Facture non visée");
        }
    }
    
    
    @Override
    public void controlerUpdate(Connection c) throws Exception {
        testerVisaFacture(c);
        super.controlerUpdate(c); 
    }
    
    @Override
    public void controler(Connection c) throws Exception {
        testerVisaFacture(c);
        super.controler(c);
    }
    public BonDeLivraisonClient(){
        super.setNomTable("as_bondelivraison_cl");
    }

    public String getDesignationFacture() {
        return designationFacture;
    }

    public void setDesignationFacture(String designationFacture) {
        this.designationFacture = designationFacture;
    }
    @Override
    public void controlQuantite(Connection c) throws Exception {}
}
