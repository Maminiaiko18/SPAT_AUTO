/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassMAPTable;
import java.sql.Date;

/**
 *
 * @author john
 */
public class FactureAnalyse extends ClassMAPTable{
    private String nmfact,source, client,designation,devfact,numCompte, categorie_facture, sous_categorie_facture,categorie_client,valCat;
    private Date daty;
    private double mttc,mtht,taxe,mtdevise,mtavoir,paye,reste;
    private double montantreste;
    private String id, tiers,remarque;

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
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

    public String getNmfact() {
        return nmfact;
    }

    public void setNmfact(String nmfact) {
        this.nmfact = nmfact;
    }

    public String getSous_categorie_facture() {
        return sous_categorie_facture;
    }

    public void setSous_categorie_facture(String sous_categorie_facture) {
        this.sous_categorie_facture = sous_categorie_facture;
    }
    
    public FactureAnalyse() {
        super.setNomTable("factureanalyse");
    }
    @Override
    public String getTuppleID() {
        return nmfact;
    }

    public String getNmFact() {
        return nmfact;
    }

    public void setNmFact(String id) {
        this.nmfact = id;
    }
    
    public String getValCat() {
        return valCat;
    }

    public void setValCat(String id) {
        this.valCat = id;
    }


    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getClient() {
        return client;
    }

    public void setClient(String client) {
        this.client = client;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getDevfact() {
        return devfact;
    }

    public void setDevfact(String devfact) {
        this.devfact = devfact;
    }

    public String getNumCompte() {
        return numCompte;
    }

    public void setNumCompte(String numCompte) {
        this.numCompte = numCompte;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public double getMttc() {
        return mttc;
    }

    public void setMttc(double mttc) {
        this.mttc = mttc;
    }

    public double getMtht() {
        return mtht;
    }

    public void setMtht(double mtht) {
        this.mtht = mtht;
    }

    public double getTaxe() {
        return taxe;
    }

    public void setTaxe(double taxe) {
        this.taxe = taxe;
    }

    public double getMtdevise() {
        return mtdevise;
    }

    public void setMtdevise(double mtdevise) {
        this.mtdevise = mtdevise;
    }

    public double getMtavoir() {
        return mtavoir;
    }

    public void setMtavoir(double mtavoir) {
        this.mtavoir = mtavoir;
    }

   

    public double getPaye() {
        return paye;
    }

    public void setPaye(double paye) {
        this.paye = paye;
    }

    public double getReste() {
        return reste;
    }

    public void setReste(double reste) {
        this.reste = reste;
    }

    public String getCategorie_facture() {
        return categorie_facture;
    }

    public void setCategorie_facture(String categorie_facture) {
        this.categorie_facture = categorie_facture;
    }

    public String getCategorie_client() {
        return categorie_client;
    }

    public void setCategorie_client(String categorie_client) {
        this.categorie_client = categorie_client;
    }

    public double getMontantreste() {
        return montantreste;
    }

    public void setMontantreste(double montantreste) {
        this.montantreste = montantreste;
    }
    
    @Override
    public String getAttributIDName() {
        return "nmfact";
    }
}
