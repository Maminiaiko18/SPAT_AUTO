/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facturefournisseur;


/**
 *
 * @author ASUS
 */
public class Detailsffbonlivraison extends DetailsFactureFournisseur{
    private double livre,reste,restelivre, quantitelivre, quantitereste, quantite;
    private String idblfille,idblmere, produit;
    private double montanttva,montantttc;

    public double getMontantCalcul() {
        return this.getQte() * this.getPu();
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
    
    public String getProduit() {
        return produit;
    }

    public void setProduit(String produit) {
        this.produit = produit;
    }

    public double getQuantitelivre() {
        return quantitelivre;
    }

    public void setQuantitelivre(double quantitelivre) {
        this.quantitelivre = quantitelivre;
    }

    public double getQuantitereste() {
        return quantitereste;
    }

    public void setQuantitereste(double quantitereste) {
        this.quantitereste = quantitereste;
    }

    public double getQuantite() {
        return quantite;
    }

    public void setQuantite(double quantite) {
        this.quantite = quantite;
    }

    public double getRestelivre() {
        return restelivre;
    }

    public void setRestelivre(double restelivre) {
        this.restelivre = restelivre;
    }

    public String getIdblfille() {
        return idblfille;
    }

    public void setIdblfille(String idblfille) {
        this.idblfille = idblfille;
    }

    public String getIdblmere() {
        return idblmere;
    }

    public void setIdblmere(String idblmere) {
        this.idblmere = idblmere;
    }

    public Detailsffbonlivraison() {
        this.setNomTable("detailsffbonlivraison");
    }

    public double getLivre() {
        return livre;
    }

    public void setLivre(double livre) {
        this.livre = livre;
    }

    public double getReste() {
        return reste;
    }

    public void setReste(double reste) {
        this.reste = reste;
    }  
}
