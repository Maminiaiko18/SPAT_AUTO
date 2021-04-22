/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package factureclient;

import bean.CGenUtil;
import bean.ClassEtat;
import facturefournisseur.EtatFactureMontantDaty;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author rasol
 */
public class PaiementFactureRemise extends ClassEtat{
    private String id, tiers, designation, typee, devise, compte, remarque, coursdevise;
    private Date daty;
    private double tva, montant, montanttva, avoir, montanttotaleremise, montanttotal, montantpayer, resteapayer, resteavoir;

    public PaiementFactureRemise() {
        this.setNomTable("paiement_factureclient_remise");
    }
    
    public PaiementFactureRemise[] getByIds(String[] ids, Connection c) throws Exception {
        int verif = 0;
        PaiementFactureRemise[] factures = new PaiementFactureRemise[0];
                
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            
            PaiementFactureRemise f = new PaiementFactureRemise();
            String in = Utilitaire.tabToString(ids, "'", ",");
            
            factures = (PaiementFactureRemise[]) CGenUtil.rechercher(f, null, null, c, " and id in (" + in + ")");
            
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
        
        return factures;
    }
    
    public static PaiementFactureRemise getFactureClient(String id, Connection c) throws Exception {
        return (PaiementFactureRemise) new PaiementFactureRemise().getById(id, "PAIEMENT_FACTURECLIENT_REMISE", c);
    }
    
    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
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

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getTypee() {
        return typee;
    }

    public void setTypee(String typee) {
        this.typee = typee;
    }

    public String getDevise() {
        return devise;
    }

    public void setDevise(String devise) {
        this.devise = devise;
    }

    public String getCompte() {
        return compte;
    }

    public void setCompte(String compte) {
        this.compte = compte;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public String getCoursdevise() {
        return coursdevise;
    }

    public void setCoursdevise(String coursdevise) {
        this.coursdevise = coursdevise;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public double getTva() {
        return tva;
    }

    public void setTva(double tva) {
        this.tva = tva;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public double getMontanttva() {
        return montanttva;
    }

    public void setMontanttva(double montanttva) {
        this.montanttva = montanttva;
    }

    public double getAvoir() {
        return avoir;
    }

    public void setAvoir(double avoir) {
        this.avoir = avoir;
    }

    public double getMontanttotaleremise() {
        return montanttotaleremise;
    }

    public void setMontanttotaleremise(double montanttotaleremise) {
        this.montanttotaleremise = montanttotaleremise;
    }

    public double getMontanttotal() {
        return montanttotal;
    }

    public void setMontanttotal(double montanttotal) {
        this.montanttotal = montanttotal;
    }

    public double getMontantpayer() {
        return montantpayer;
    }

    public void setMontantpayer(double montantpayer) {
        this.montantpayer = montantpayer;
    }

    public double getResteapayer() {
        if(resteapayer < 0) return 0;
        return resteapayer;
    }

    public void setResteapayer(double resteapayer) {
        this.resteapayer = resteapayer;
    }

    public double getResteavoir() {
        return resteavoir;
    }

    public void setResteavoir(double resteavoir) {
        this.resteavoir = resteavoir;
        
    }
}
