/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassMAPTable;

/**
 *
 * @author MEVA
 */
public class BonCommande extends ClassMAPTable{
    private String boncommande,categorie,fournisseur,organe_demandeur;
    private int quantite;
    private double montanttotal, montantfacture, montantnonfacture, montantpaye, montantnonpaye;

    public String getBoncommande() {
        return boncommande;
    }

    public void setBoncommande(String boncommande) {
        this.boncommande = boncommande;
    }

    public String getCategorie() {
        return categorie;
    }

    public void setCategorie(String categorie) {
        this.categorie = categorie;
    }

    public int getQuantite() {
        return quantite;
    }

    public void setQuantite(int quantite) {
        this.quantite = quantite;
    }

    public double getMontanttotal() {
        return montanttotal;
    }

    public void setMontanttotal(double montanttotal) {
        this.montanttotal = montanttotal;
    }

    public double getMontantfacture() {
        return montantfacture;
    }

    public void setMontantfacture(double montantfacture) {
        this.montantfacture = montantfacture;
    }

    public double getMontantnonfacture() {
        return montantnonfacture;
    }

    public void setMontantnonfacture(double montantnonfacture) {
        this.montantnonfacture = montantnonfacture;
    }

    public double getMontantpaye() {
        return montantpaye;
    }

    public void setMontantpaye(double montantpaye) {
        this.montantpaye = montantpaye;
    }

    public double getMontantnonpaye() {
        return montantnonpaye;
    }

    public void setMontantnonpaye(double montantnonpaye) {
        this.montantnonpaye = montantnonpaye;
    }

    public String getFournisseur() {
        return fournisseur;
    }

    public void setFournisseur(String fournisseur) {
        this.fournisseur = fournisseur;
    }

    public String getOrgane_demandeur() {
        return organe_demandeur;
    }

    public void setOrgane_demandeur(String organe_demandeur) {
        this.organe_demandeur = organe_demandeur;
    }
    
    public BonCommande()
    {
        this.setNomTable("v_analyse_bon_commande");
    }
    
    @Override
    public String getTuppleID() {
        return boncommande; //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String getAttributIDName() {
        return "boncommande";   
    }
    
}
