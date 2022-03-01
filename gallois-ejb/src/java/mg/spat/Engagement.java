/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.AdminGen;
import bean.CGenUtil;
import bean.ClassEtat;
import bean.ClassMAPTable;
import facture.FactureFournisseur;
import java.sql.Connection;
import java.sql.Date;
import lignecredit.LigneCredit;

/**
 *
 * @author Nouta
 */
public class Engagement extends ClassEtat {
    private String id,designation,codeEtablissement,projet,compte,idLC,idLClib;
    private String codeEtablissementlib,projetlib;
    private double montant,disponible,dispoAvant,dispoApres;
    private Date daty;
    
    public double getResteAFacturer(Connection c) throws Exception{
        FactureFournisseur[]factures=this.getFacturesLiees("factfourn_msum_lib",c);
        double montant = AdminGen.calculSommeDouble(factures, "montant");
        return montant;
    }
    
    public Engagement() {
        super.setNomTable("engagement");
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public String getIdLC() {
        return idLC;
    }

    public void setIdLC(String idLC) {
        this.idLC = idLC;
    }

    public String getIdLClib() {
        return idLClib;
    }

    public void setIdLClib(String idLClib) {
        this.idLClib = idLClib;
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

    public String getCodeEtablissement() {
        return codeEtablissement;
    }

    public void setCodeEtablissement(String codeEtablissement) {
        this.codeEtablissement = codeEtablissement;
    }

    public String getProjet() {
        return projet;
    }

    public void setProjet(String projet) {
        this.projet = projet;
    }

    public String getCompte() {
        return compte;
    }

    public void setCompte(String compte) {
        this.compte = compte;
    }

    

    public String getCodeEtablissementlib() {
        return codeEtablissementlib;
    }

    public void setCodeEtablissementlib(String codeEtablissementlib) {
        this.codeEtablissementlib = codeEtablissementlib;
    }

    public String getProjetlib() {
        return projetlib;
    }

    public void setProjetlib(String projetlib) {
        this.projetlib = projetlib;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant)throws Exception {
        if(this.getMode().compareToIgnoreCase("modif")==0&&montant<=0) throw new Exception("montant invalide");
        this.montant = montant;
    }

    public double getDisponible() {
        return disponible;
    }

    public void setDisponible(double disponible) {
        this.disponible = disponible;
    }

    public double getDispoAvant() {
        return dispoAvant;
    }

    public void setDispoAvant(double dispoAvant) {
        this.dispoAvant = dispoAvant;
    }

    public double getDispoApres() {
        return dispoApres;
    }

    public void setDispoApres(double dispoApres) {
        this.dispoApres = dispoApres;
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("CR","getseqengagement");
        setId(makePK(c));
    }

    @Override
    public String getValColLibelle() {
        return this.getDesignation();
    }

    public LigneCredit findLigneCredit(Connection c) throws Exception{
        LigneCredit lc = new LigneCredit();
        lc.setNomTable("ligneCreditDepenseLib");
        LigneCredit[] ligneCredits = (LigneCredit[]) CGenUtil.rechercher(lc, null, null, c, " and id='"+this.getIdLC()+"'");
        if(ligneCredits.length > 0) return ligneCredits[0];
        return null;
    }
    
    public LigneCredit findSituationCredit(Connection c) throws Exception{
        LigneCredit lc = new LigneCredit();
        lc.setNomTable("ligneCreditDepenseGrp");
        String dir=this.getCodeEtablissement();
        String prj=this.getProjet();
        if(dir==null||dir.compareToIgnoreCase("")==0||prj==null||prj.compareToIgnoreCase("")==0)
        {
            LigneCredit ligne = findLigneCredit(c);
            dir=ligne.getCodeEtablissement();
            prj=ligne.getProjet();
        }
        LigneCredit[] ligneCredits = (LigneCredit[]) CGenUtil.rechercher(lc, null, null, c, " and idcodeEtablissement='"+dir +"' and idprojet='"+prj+"'");
        if(ligneCredits.length > 0) return ligneCredits[0];
        return null;
    }

    @Override
    public Object validerObject(String u, Connection c) throws Exception {
        LigneCredit lc = this.findSituationCredit(c);
        if(lc == null) throw new Exception("Ligne credit non trouv&eacute;");
        this.setDispoAvant(lc.getRestebudget());
        this.setDispoApres(this.getDispoAvant() - this.getMontant());
        
        return super.validerObject(u, c); 
    }
    
    public FactureFournisseur[] getFacturesLiees(String nomtable, Connection c) throws Exception{
        try{
            FactureFournisseur fact = new FactureFournisseur();
            fact.setNomTable(nomtable);
            fact.setIdengagement(this.getId());
            FactureFournisseur[] res = (FactureFournisseur[]) CGenUtil.rechercher(fact, null, null, c, "");
            return res;
        }catch(Exception e){
            throw e;
        }
    }
    
     
    
    
}
