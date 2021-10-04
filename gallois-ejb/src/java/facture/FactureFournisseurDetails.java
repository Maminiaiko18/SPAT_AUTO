/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.CGenUtil;
import bean.ClassFille;
import bean.ClassMAPTable;
import fin.Coursdevise;
import java.sql.Connection;
import java.sql.Date;
import mg.spat.Prevision;
import utilitaire.Constante;
import utilitaire.Utilitaire;

/**
 *
 * @author rijan
 */
public class FactureFournisseurDetails extends ClassFille{
    
    private String id , idmere , designation , compte , idproduit , devise , idactivite , rubrique , heureDebut , heureFin,  produitlib;
    private double quantite , pu , taux , tva , reduction , majoration, montant;
    private Date datefact;
    private int mois , annee;
    boolean tauxDonne=false;
    
    
    
    public FactureFournisseurDetails() throws Exception{ 
        this.setNomTable("facture_fournisseur_fille");
        this.setNomClasseMere("facture.FactureFournisseur");
        this.setLiaisonMere("idmere");
    }

    public FactureFournisseurDetails(String id, String idmere, String designation, String compte, String idproduit, String devise, String idactivite, String rubrique, String heureDebut, String heureFin, double quantite, double pu, double taux, double tva, double reduction, double majoration, double test, Date datefact, int mois, int annee) throws Exception{
        this.setNomTable("facture_fournisseur_fille");
        this.setId(id);
        this.setIdmere(idmere);
        this.setDesignation(designation);
        this.setCompte(compte);
        this.setIdproduit(idproduit);
        this.setDevise(devise);
        this.setIdactivite(idactivite);
        this.setRubrique(rubrique);
        this.setHeureDebut(heureDebut);
        this.setHeureFin(heureFin);
        this.setQuantite(quantite);
        this.setPu(pu);
        this.setTaux(taux);
        this.setTva(tva);
        this.setReduction(reduction);
        this.setMajoration(majoration);
        this.setDatefact(datefact);
        this.setMois(mois);
        this.setAnnee(annee);
    }

    
    public String getProduitlib() {
        return produitlib;
    }

    public void setProduitlib(String produitlib) {
        this.produitlib = produitlib;
    }
    

    public boolean isTauxDonne() {
        return tauxDonne;
    }

    
    
    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }
    
    
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdmere() {
        return idmere;
    }

    public void setIdmere(String idmere) {
        this.idmere = idmere;
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

    public String getIdproduit() {
        return idproduit;
    }

    public void setIdproduit(String idproduit) {
        this.idproduit = idproduit;
    }

    public String getDevise() {
        return devise;
    }

    public void setDevise(String devise) {
        this.devise = devise;
    }

    public String getIdactivite() {
        return idactivite;
    }

    public void setIdactivite(String idactivite) {
        this.idactivite = idactivite;
    }

    public String getRubrique() {
        return rubrique;
    }

    public void setRubrique(String rubrique) {
        this.rubrique = rubrique;
    }

    public String getHeureDebut() {
        return heureDebut;
    }

    public void setHeureDebut(String heureDebut) {
        this.heureDebut = heureDebut;
    }

    public String getHeureFin() {
        return heureFin;
    }

    public void setHeureFin(String heureFin) {
        this.heureFin = heureFin;
    }

    public double getQuantite() {
        return quantite;
    }

    public void setQuantite(double quantite) {
        this.quantite = quantite;
    }

    public double getPu() {
        return pu;
    }

    public void setPu(double pu) {
        this.pu = pu;
    }

    public double getTaux() {
        return taux;
    }

    public void setTaux(double taux) {
        this.taux = taux;
    }

    public double getTva() {
        return tva;
    }

    public void setTva(double tva) {
        this.tva = tva;
    }

    public double getReduction() {
        return reduction;
    }

    public void setReduction(double reduction) {
        this.reduction = reduction;
    }

    public double getMajoration() {
        return majoration;
    }

    public void setMajoration(double majoration) {
        this.majoration = majoration;
    }

    

    public Date getDatefact() {
        return datefact;
    }

    public void setDatefact(Date datefact) {
        this.datefact = datefact;
    }

    public int getMois() {
        return mois;
    }

    public void setMois(int mois) {
        this.mois = mois;
    }

    public int getAnnee() {
        return annee;
    }

    public void setAnnee(int annee) {
        this.annee = annee;
    }

    public boolean getTauxDonne() {
        return tauxDonne;
    }

    public void setTauxDonne(boolean tauxDonne) {
        this.tauxDonne = tauxDonne;
    }
    
    
    
    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("FFD", "get_seq_factFournFille");
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
  /*  
    
    private FactureFournisseur findMere(Connection c) throws Exception {
        if(this.getMere() == null) {
            FactureFournisseur fc = new FactureFournisseur();
            fc.setId(this.getIdmere());
            //fc.setEstDDPMICTSL(null);
            FactureFournisseur[] tmp = (FactureFournisseur[]) CGenUtil.rechercher(fc, null, null, c, "");
            
            if(tmp != null && tmp.length > 0) { 
                this.setMere(tmp[0]);
                return tmp[0];
            }
        }
        
        return this.getMere();
    }*/
    public double getTauxRecentNormal(Connection c) throws Exception {
        FactureFournisseur mere = (FactureFournisseur) this.getMere();
        if(mere == null) mere = (FactureFournisseur) super.findMere(null, c);
        Date date = mere.getDaty();
        
        return getValeurTaux(c, "coursdeviseNonMICTSL", date);
    }
    
    public double getValeurTaux(Connection c, String nomTable, Date date) throws Exception {
        String awhere = " and daty = (SELECT max(daty) FROM " + nomTable + " WHERE  daty <= '" + Utilitaire.datetostring(date) + "' and iddevise = '" + this.getDevise() + "') "
                + " and iddevise = '" + this.getDevise() + "'";
        Coursdevise cours = new Coursdevise();
        cours.setNomTable(nomTable);
        Coursdevise[] cd = (Coursdevise[]) CGenUtil.rechercher(cours, null, null, c, awhere);

        return cd != null && cd.length > 0 ? cd[0].getMontant() : 0;
    }
    
    public double getTauxRecent(Connection c) throws Exception {
        super.findMere(null,c);
        if(this.getMere() == null) throw new Exception("Facture mere introuvable");
        
        
        
        return getTauxRecentNormal(c);
    }
    
    @Override
    public ClassMAPTable createObject(String user, Connection c) throws Exception {
        System.out.println(this.getClass().toString());
        if(getTauxDonne()==false)setTaux(getTauxRecent(c));
        return super.createObject(user, c);
    }
}
