/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.ClassMAPTable;
import java.sql.Date;

/**
 *
 * @author bici
 */
public class PaiementFactureLibJc extends ClassMAPTable {
    String id,idmvt,idfact,idmode,idtraite,remarque,caisse,modepaiement,tiers;
    double montant;
    Date dateeffet;

    public PaiementFactureLibJc() {
        this.setNomTable("paiementfacturelibjc");
    }

    public PaiementFactureLibJc(String id, String idmvt, String idfact, String idmode, String idtraite, String remarque, String caisse, String modepaiement, String tiers, double montant, Date dateeffet) {
        this.id = id;
        this.idmvt = idmvt;
        this.idfact = idfact;
        this.idmode = idmode;
        this.idtraite = idtraite;
        this.remarque = remarque;
        this.caisse = caisse;
        this.modepaiement = modepaiement;
        this.tiers = tiers;
        this.montant = montant;
        this.dateeffet = dateeffet;
    }


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdmvt() {
        return idmvt;
    }

    public void setIdmvt(String idmvt) {
        this.idmvt = idmvt;
    }

    public String getIdfact() {
        return idfact;
    }

    public void setIdfact(String idfact) {
        this.idfact = idfact;
    }

    public String getIdmode() {
        return idmode;
    }

    public void setIdmode(String idmode) {
        this.idmode = idmode;
    }

    public String getIdtraite() {
        return idtraite;
    }

    public void setIdtraite(String idtraite) {
        this.idtraite = idtraite;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public String getCaisse() {
        return caisse;
    }

    public void setCaisse(String caisse) {
        this.caisse = caisse;
    }

    public String getModepaiement() {
        return modepaiement;
    }

    public void setModepaiement(String modepaiement) {
        this.modepaiement = modepaiement;
    }

    public String getTiers() {
        return tiers;
    }

    public void setTiers(String tiers) {
        this.tiers = tiers;
    }

    public Date getDateeffet() {
        return dateeffet;
    }

    public void setDateeffet(Date dateeffet) {
        this.dateeffet = dateeffet;
    }
    
    

    @Override
    public String getTuppleID() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String getAttributIDName() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
    
}
