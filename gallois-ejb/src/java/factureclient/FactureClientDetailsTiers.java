/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package factureclient;

/**
 *
 * @author ACER
 */
public class FactureClientDetailsTiers extends FactureClientDetail{
    private String tiers;
    
    public FactureClientDetailsTiers(){
        this.setNomTable("Facture_Client_Detail_Tiers");
    }

    public String getTiers() {
        return tiers;
    }

    public void setTiers(String tiers) {
        this.tiers = tiers;
    }
}
