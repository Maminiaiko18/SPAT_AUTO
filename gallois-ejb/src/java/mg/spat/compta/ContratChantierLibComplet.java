/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.compta;

/**
 *
 * @author rasol
 */
public class ContratChantierLibComplet extends ContratChantier{
    private double montant_paye, reste_a_payer, resteapaye;
    private String nom_chantier,nom_prestataire, montantfact, resteAfacturer;
    private String chantierlib,prestatairelib,code_etablib;
    private String code_etablissement,code_etablissementlib;

    public String getCode_etablissement() {
        return code_etablissement;
    }

    public void setCode_etablissement(String code_etablissement) {
        this.code_etablissement = code_etablissement;
    }

    public String getCode_etablissementlib() {
        return code_etablissementlib;
    }

    public void setCode_etablissementlib(String code_etablissementlib) {
        this.code_etablissementlib = code_etablissementlib;
    }
    public String getCode_etablib() {
        return code_etablib;
    }

    public void setCode_etablib(String code_etablib) {
        this.code_etablib = code_etablib;
    }

    public String getChantierlib() {
        return chantierlib;
    }

    public void setChantierlib(String chantierlib) {
        this.chantierlib = chantierlib;
    }

    public String getPrestatairelib() {
        return prestatairelib;
    }

    public void setPrestatairelib(String prestatairelib) {
        this.prestatairelib = prestatairelib;
    }
    
    
    public String getMontantfact() {
        return montantfact;
    }

    public void setMontantfact(String montantfact) {
        this.montantfact = montantfact;
    }

    public String getResteAfacturer() {
        return resteAfacturer;
    }

    public void setResteAfacturer(String resteAfacturer) {
        this.resteAfacturer = resteAfacturer;
    }

    public ContratChantierLibComplet() {
        this.setNomTable("contrat_chantier_CplSum");
    }

    public String getNom_chantier() {
        return nom_chantier;
    }

    public void setNom_chantier(String nom_chantier) {
        this.nom_chantier = nom_chantier;
    }

    public String getNom_prestataire() {
        return nom_prestataire;
    }

    public void setNom_prestataire(String nom_prestataire) {
        this.nom_prestataire = nom_prestataire;
    }

    public double getMontant_paye() {
        return montant_paye;
    }

    public void setMontant_paye(double montant_paye) {
        this.montant_paye = montant_paye;
    }

    public double getReste_a_payer() {
        return reste_a_payer;
    }

    public void setReste_a_payer(double reste_a_payer) {
        this.reste_a_payer = reste_a_payer;
    }

    public double getResteapaye() {
        return resteapaye;
    }

    public void setResteapaye(double resteapaye) {
        this.resteapaye = resteapaye;
    }
    
}
