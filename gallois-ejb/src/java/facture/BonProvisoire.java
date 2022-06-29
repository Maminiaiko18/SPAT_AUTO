package facture;


import bean.ClassEtat;
import java.sql.Connection;
import java.sql.Date;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author MADALITSO
 */
public class BonProvisoire extends ClassEtat{

    String id;
    String tiers;
    Date daty;
    double montant;
    String remarque;
    String tierslib;
    String caisselib,caisse;

    public String getCaisse() {
        return caisse;
    }

    public void setCaisse(String caisse) {
        this.caisse = caisse;
    }
    

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTiers() {
        return tiers;
    }

    public void setTiers(String tiers) {
        this.tiers = tiers;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) throws Exception {
        if(this.getMode().compareToIgnoreCase("modif")==0&&montant<=0) throw new Exception("montant invalide");
        this.montant = montant;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remaque) {
        this.remarque = remarque;
    }

    public String getTierslib() {
        return tierslib;
    }

    public void setTierslib(String tierslib) {
        this.tierslib = tierslib;
    }

    public String getCaisselib() {
        return caisselib;
    }

    public void setCaisselib(String caisselib) {
        this.caisselib = caisselib;
    }
    
    public BonProvisoire() {
        this.setNomTable("bon_provisoire_final");
    }
     
    @Override
    public String getTuppleID() {
        return this.id; //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String getAttributIDName() {
        return "id"; //To change body of generated methods, choose Tools | Templates.
    }
    
    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("BPV", "getseqbon_provisoire_final");
        this.setId(makePK(c));
    }   
    
}
