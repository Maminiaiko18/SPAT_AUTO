/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ded;

import utilitaire.ChiffreLettre;

/**
 *
 * @author Lenovo
 */
public class OrdonnerPayementPDF extends OrdonnerPayement {
    String adresse, montant_lettre,devise,beneficiaire,numfact, destinationlib;

    public String getDestinationlib() {
        return destinationlib;
    }

    public void setDestinationlib(String destinationlib) {
        this.destinationlib = destinationlib;
    }

    public String getNumfact() {
        return numfact;
    }

    public void setNumfact(String numfact) {
        this.numfact = numfact;
    }

    public String getBeneficiaire() {
        return beneficiaire;
    }

    public void setBeneficiaire(String beneficiaire) {
        this.beneficiaire = beneficiaire;
    }

    public OrdonnerPayementPDF() {
        this.setNomTable("OrdonnerPayement");
    }
    

    public OrdonnerPayementPDF(String adresse, String montant_lettre, String devise) {
        this.setNomTable("OrdonnerPayement");
        this.setAdresse(adresse);
        this.setMontant_lettre(montant_lettre);
        this.setDevise(devise);
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public String getMontant_lettre() {
        String montantString = String.valueOf((int)this.getMontant());
        long montantLong = Long.valueOf(montantString);
        this.setMontant_lettre((ChiffreLettre.convertIntToString(montantLong)+" "+this.getDevise()).toUpperCase());
        return montant_lettre;
    }

    public void setMontant_lettre(String montant_lettre) {
        this.montant_lettre = montant_lettre;
    }

    public String getDevise() {
        return devise;
    }

    public void setDevise(String devise) {
        this.devise = devise;
    }
}
