/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.CGenUtil;
import bean.ClassEtat;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.Constante;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author Itokiana
 */
public class Contrat extends ClassEtat{
    private String id,idTiers,objet,devise,unite,typedroitport,typeDuree,numeros,idchantier,numero;
    private String idTierslib,contratlib,nom,valunite,projet,codeetablissement,idLC,projetlib,codeetablissementlib,lclib,chantierlib,idavenant,codeprojetlib;
    private double droit_entree,redevance_fixe,redevance_variable,droit_port,redevance_domaniale,redevance_locative,pipeline,montant,montantpaye;
    private Date date_signature,debut_contrat,fin_contrat,fin_avenant;
    private int controleMontant, annee;
    private double duree;
    
    public Contrat() {
        super.setNomTable("CONTRAT");
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }
    
    
    public String getValColLibelle(){
        return this.getObjet();
    }
    public String getIdTierslib() {
        return idTierslib;
    }

    public void setIdTierslib(String idTierslib) {
        this.idTierslib = idTierslib;
    }

    public String getContratlib() {
        return contratlib;
    }

    public void setContratlib(String contratlib) {
        this.contratlib = contratlib;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdTiers() {
        return idTiers;
    }

    public void setIdTiers(String idTiers) {
        this.idTiers = idTiers;
    }

    public String getObjet() {
        return objet;
    }

    public void setObjet(String objet) {
        this.objet = objet;
    }

    public String getDevise() {
        return devise;
    }

    public void setDevise(String devise) {
        this.devise = devise;
    }

    public String getUnite() {
        return unite;
    }

    public void setUnite(String unite) {
        this.unite = unite;
    }

    public String getTypedroitport() {
        return typedroitport;
    }

    public void setTypedroitport(String typedroitport) {
        this.typedroitport = typedroitport;
    }

    public String getTypeDuree() {
        return typeDuree;
    }

    public void setTypeDuree(String typeDuree) {
        this.typeDuree = typeDuree;
    }

    public String getNumeros() {
        return numeros;
    }

    public void setNumeros(String numeros) {
        this.numeros = numeros;
    }

    public String getIdchantier() {
        return idchantier;
    }

    public void setIdchantier(String idchantier) {
        this.idchantier = idchantier;
    }

    public double getDuree() {
        return duree;
    }

    public void setDuree(double duree) {
        this.duree = duree;
        if(getMode().equals("modif")){
            if(fin_contrat != null && debut_contrat != null)
            if(this.getUnite().compareToIgnoreCase(Constante.uniteJour) == 0)
                this.duree = Utilitaire.diffJourDaty(this.getFin_contrat(), this.getDebut_contrat());
            else if(this.getUnite().compareToIgnoreCase(Constante.uniteMois) == 0)
                this.duree = Utilitaire.diffMoisDaty(fin_contrat, debut_contrat);
            else
                this.duree = Utilitaire.getAnnee(fin_contrat) - Utilitaire.getAnnee(debut_contrat);
        }
    }

    public double getDroit_entree() {
        return droit_entree;
    }

    public void setDroit_entree(double droit_entree) {
        this.droit_entree = droit_entree;
    }

    public double getRedevance_fixe() {
        return redevance_fixe;
    }

    public void setRedevance_fixe(double redevance_fixe) {
        this.redevance_fixe = redevance_fixe;
    }

    public double getRedevance_variable() {
        return redevance_variable;
    }

    public void setRedevance_variable(double redevance_variable) {
        this.redevance_variable = redevance_variable;
    }

    public double getDroit_port() {
        return droit_port;
    }

    public void setDroit_port(double droit_port) {
        this.droit_port = droit_port;
    }

    public double getRedevance_domaniale() {
        return redevance_domaniale;
    }

    public void setRedevance_domaniale(double redevance_domaniale) {
        this.redevance_domaniale = redevance_domaniale;
    }

    public double getRedevance_locative() {
        return redevance_locative;
    }

    public void setRedevance_locative(double redevance_locative) {
        this.redevance_locative = redevance_locative;
    }

    public double getPipeline() {
        return pipeline;
    }

    public void setPipeline(double pipeline) {
        this.pipeline = pipeline;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public Date getDate_signature() {
        return date_signature;
    }

    public void setDate_signature(Date date_signature) {
        this.date_signature = date_signature;
    }

    public Date getDebut_contrat() {
        return debut_contrat;
    }

    public void setDebut_contrat(Date debut_contrat) {
        this.debut_contrat = debut_contrat;
    }

    public Date getFin_contrat() {
        return fin_contrat;
    }

    public void setFin_contrat(Date fin_contrat) {
        this.fin_contrat = fin_contrat;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getValunite() {
        return valunite;
    }

    public void setValunite(String valunite) {
        this.valunite = valunite;
    }

    public String getProjet() {
        return projet;
    }

    public void setProjet(String projet) throws Exception {
        this.projet = projet;
        if(this.getMode().compareToIgnoreCase("modif")==0&& (projet==null || projet.compareToIgnoreCase("")==0)) throw new Exception("Projet obligatoire.");
    }

    public String getCodeetablissement() {
        return codeetablissement;
    }

    public void setCodeetablissement(String codeetablissement) throws Exception {
        this.codeetablissement = codeetablissement;
        if(this.getMode().compareToIgnoreCase("modif")==0&& (codeetablissement==null || codeetablissement.compareToIgnoreCase("")==0)) throw new Exception("Code etablissement obligatoire.");
    }

    public String getIdLC() {
        return idLC;
    }

    public void setIdLC(String idLC) throws Exception{
        this.idLC = idLC;
        if(this.getMode().compareToIgnoreCase("modif")==0&& (idLC==null || idLC.compareToIgnoreCase("")==0)) throw new Exception("Budget obligatoire.");
    }

    public String getProjetlib() {
        return projetlib;
    }

    public void setProjetlib(String projetlib) {
        this.projetlib = projetlib;
    }

    public String getCodeetablissementlib() {
        return codeetablissementlib;
    }

    public void setCodeetablissementlib(String codeetablissementlib) {
        this.codeetablissementlib = codeetablissementlib;
    }

    public String getLclib() {
        return lclib;
    }

    public void setLclib(String lclib) {
        this.lclib = lclib;
    }

    public String getChantierlib() {
        return chantierlib;
    }

    public void setChantierlib(String chantierlib) {
        this.chantierlib = chantierlib;
    }

    public int getControleMontant() {
        return controleMontant;
    }

    public void setControleMontant(int controleMontant) {
        this.controleMontant = controleMontant;
    }

    public String getIdavenant() {
        return idavenant;
    }

    public void setIdavenant(String idavenant) {
        this.idavenant = idavenant;
    }

    public double getMontantpaye() {
        return montantpaye;
    }

    public void setMontantpaye(double montantpaye) {
        this.montantpaye = montantpaye;
    }

    public Date getFin_avenant() {
        return fin_avenant;
    }

    public void setFin_avenant(Date fin_avenant) {
        this.fin_avenant = fin_avenant;
    }

    public String getCodeprojetlib() {
        return codeprojetlib;
    }

    public void setCodeprojetlib(String codeprojetlib) {
        this.codeprojetlib = codeprojetlib;
    }

    public int getAnnee() {
        return annee;
    }

    public void setAnnee(int annee) {
        this.annee = annee;
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    public void construirePK(Connection c) throws Exception {
        this.preparePk("CTRT", "GETSEQ_CONTRAT");
        this.setId(makePK(c));
    }
    
    @Override
    public ClassMAPTable createObject(String u, Connection c) throws Exception {        
        try{
            Contrat contrat = (Contrat)super.createObject(u, c); 
            Avenant avenant = new Avenant(this.getIdTiers(), "avenant initial", this.getUnite(), this.getId(), this.getDuree(), this.getMontant(), this.getDate_signature(), this.getDebut_contrat(), this.getFin_contrat(), 0);
            avenant.createObject(u, c);
            
            return contrat;
        }
        catch(Exception e){
            throw e;
        }
    }
    
    @Override
    public Object validerObject(String u, Connection c) throws Exception {
        boolean ouvert = false;
        
        try{
            if(c == null){
                c = new UtilDB().GetConn();
                ouvert = true;
                c.setAutoCommit(false);
            }
            
            Avenant[] avenants = (Avenant[])CGenUtil.rechercher(new Avenant(), null, null, c, " and idcontrat='"+this.getId()+"' and rang = 0");
            if(avenants.length > 0){
                avenants[0].validerObject(u, c);
                
                Engagement engagement = new Engagement();
                engagement.setDesignation(this.getObjet());
                engagement.setCodeEtablissement(this.getCodeetablissement());
                engagement.setProjet(this.getProjet());
                engagement.setIdLC(this.getIdLC());
                engagement.setDaty(Utilitaire.dateDuJourSql());
                engagement.setTiers(avenants[0].getIdTiers());
                engagement.setAnnee(Utilitaire.getAneeEnCours());
                engagement.setIdavenant(avenants[0].getId());
                engagement.setMontant(avenants[0].getMontant());
                engagement.createObject(u, c);
                EngagementFille engfille = new EngagementFille(engagement.getId(), this.getObjet(), avenants[0].getMontant());
                engfille.createObject(u, c);
                
                engagement.setType(Constante.typeEngagementContrat);
                if(this.getControleMontant() == 0)engagement.validerObject(u, c);
                else engagement.validerObjectSansControleMontant(u, c);
            }
                
            super.validerObject(u, c);
            c.commit();
            
            return this;
        }
        catch(Exception e){
            if(ouvert && c != null) c.rollback();
            throw e;
        }
        finally{
            if(ouvert && c != null) c.close();
        }
    }
}
