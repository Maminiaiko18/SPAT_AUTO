/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.stock;

import bean.AdminGen;
import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author Finaritra
 */
public class BonDeLivraisonFille extends ClassMAPTable {

    private String id, produit, numbl, iddetailsfacturefournisseur, idbondecommande, pdt;
    private double quantite, quantiteparpack;
    private double pu,montant,montanttva,montantttc;
    

    public void controlQuantite(BonDeCommandeFilleReste[] bcF) throws Exception {
        String[] atts = {"id"};
        String[] values = {this.getIdbondecommande()};
        ClassMAPTable[] tmp = AdminGen.find(bcF, atts, values);
        
        if(tmp != null && tmp.length > 0) {
            BonDeCommandeFilleReste bcfille = (BonDeCommandeFilleReste) tmp[0];
            
            if(bcfille.getQuantitereste() < this.getQuantite()) {
                throw new Exception("Quantité supérieure au reste à livrer!");
            }
        }
    }

    public double getPu() {
        return pu;
    }

    public void setPu(double pu) {
        this.pu = pu;
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

    public double getMontantttc() {
        return montantttc;
    }

    public void setMontantttc(double montantttc) {
        this.montantttc = montantttc;
    }

    public String getIdbondecommande() {
        return idbondecommande;
    }

    public void setIdbondecommande(String idbondecommande) {
        this.idbondecommande = idbondecommande;
    }

    public String getIddetailsfacturefournisseur() {
        return iddetailsfacturefournisseur;
    }

    public void setIddetailsfacturefournisseur(String iddetailsfacturefournisseur) {
        this.iddetailsfacturefournisseur = iddetailsfacturefournisseur;
    }

    public BonDeLivraisonFille() {
        this.setNomTable("AS_BONDELIVRAISON_FILLE");
    }

    public BonDeLivraisonFille(String idbc, String produit, String numbl, double quantite) {
        this.setNomTable("AS_BONDELIVRAISON_FILLE");
        this.setProduit(produit);
        this.setNumbl(numbl);
        this.setQuantite(quantite);
        this.setIdbondecommande(idbc);
    }

    public BonDeLivraisonFille(String produit, String numbl, double quantiteparpack, double quantite) {
        this.setNomTable("AS_BONDELIVRAISON_FILLE");
        this.setProduit(produit);
        this.setNumbl(numbl);
        this.setQuantiteparpack(quantiteparpack);
        this.setQuantite(quantite);
    }

    public BonDeLivraisonFille(String produit, String numbl, double quantiteparpack, double quantite, String iddetailsfacturefournisseur) {
        this.setNomTable("AS_BONDELIVRAISON_FILLE");
        this.setProduit(produit);
        this.setNumbl(numbl);
        this.setQuantiteparpack(quantiteparpack);
        this.setQuantite(quantite);
        this.setIddetailsfacturefournisseur(iddetailsfacturefournisseur);
    }

    public void construirePK(Connection c) throws Exception {
        this.preparePk("BLF", "GET_SEQBONDELIVRAISONFILLE");
        this.setId(makePK(c));
    }

    public String getProduit() {
        return produit;
    }

    public void setProduit(String produit) {
        this.produit = produit;
    }

    public String getNumbl() {
        return numbl;
    }

    public void setNumbl(String numbl) {
        this.numbl = numbl;
    }

    public double getQuantite() {
        return quantite;
    }

    public void setQuantite(double quantite) {
        this.quantite = quantite;
    }

    public double getQuantiteparpack() {
        return quantiteparpack;
    }

    public void setQuantiteparpack(double quantiteparpack) {
        this.quantiteparpack = quantiteparpack;
    }

    public String getPdt() {
        return pdt;
    }

    public void setPdt(String pdt) {
        this.pdt = pdt;
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

    public double getTotal() {
        return this.getQuantiteparpack() * this.getQuantite();
    }
}
