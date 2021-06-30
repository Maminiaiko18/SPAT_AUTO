/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lignecredit;

import bean.ClassEtat;
import java.sql.Connection;

/**
 *
 * @author
 */
public class LigneCredit extends ClassEtat {
    
    private String id;
    private String designation,compte;
    private double quantite,montant,facture,paye;
    private int annee;

    
    
    public LigneCredit(){
        this.setNomTable("ligneCreditRecette");
    }
    
    public void construirePK(Connection c) throws Exception {
        this.preparePk("LCRD", "get_seqligneCreditRecette");
        this.setId(makePK(c));
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
    
    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getCompte() {
        return compte;
    }

    public void setCompte(String compte) {
        this.compte = compte;
    }

    public double getQuantite() {
        return quantite;
    }

    public void setQuantite(double quantite) {
        this.quantite = quantite;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public int getAnnee() {
        return annee;
    }

    public void setAnnee(int annee) {
        this.annee = annee;
    }
    
    public double getFacture() {
        return facture;
    }

    public void setFacture(double facture) {
        this.facture = facture;
    }

    public double getPaye() {
        return paye;
    }

    public void setPaye(double paye) {
        this.paye = paye;
    }
}
