package facture;


import bean.ClassEtat;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.Constante;
import utilitaire.UtilDB;

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
    String caisselib,caisse,bonprovisoire;
    int estOM;
    String designation;

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getBonprovisoire() {
        return bonprovisoire;
    }

    public void setBonprovisoire(String bonprovisoire) {
        this.bonprovisoire = bonprovisoire;
    }
    
    public int getEstOM() {
        return estOM;
    }

    public void setEstOM(int estOM) {
        this.estOM = estOM;
    }
    

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
    
    public void genererFF(Connection c, String iduser) throws Exception {
        int verif = 0;
        try{
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
                c.setAutoCommit(false);
            }
            
            FactureFournisseur ff = new FactureFournisseur(null, this.getTiers(), this.getDesignation(), Constante.typeFCAuComptant, this.getRemarque(), iduser, null, Constante.idBonProvisoire, 0, this.getDaty(), null, 0);
            ff.setDeviseMere(Constante.deviseAr);
            ff.setExercice(utilitaire.Utilitaire.getAneeEnCours());
            ff.setBonprovisoire(this.getId());
            
            if(this.getEstOM() != 0) {
                ff.setCode_etablissement(Constante.dirAppuiAdm);
                ff.setProjet(Constante.projMissionHebergement);
            }
            
            FactureClientDetails fcd = new FactureClientDetails(null, 1, this.getMontant(), Constante.compteBP, this.getDesignation(), 0, utilitaire.Utilitaire.getAneeEnCours(), utilitaire.Utilitaire.getMoisEnCoursReel(), Constante.deviseAr, 0);
            if(this.getEstOM() == 0) {
                fcd.setCompte(Constante.compteHorsCircuit);
            }
            
            ff.setFille(new FactureClientDetails[] { fcd } );
            ff.createObject(iduser, c);
            ff.validerObject(iduser, c);
            
            if(verif == 1) c.commit();
        } catch (Exception e) {
            if(c != null && verif == 1)c.rollback();
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
}
