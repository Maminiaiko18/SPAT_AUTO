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
import ded.OrdonnerPayement;
import facture.FactureFournisseur;
import facture.FactureFournisseurDetails;
import java.sql.Connection;
import java.sql.Date;
import lignecredit.LigneCredit;
import utilitaire.Utilitaire;
import utilitaire.Constante;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;

/**
 *
 * @author Nouta
 */
public class Engagement extends ClassEtat {
    private String id,designation,codeEtablissement,projet,compte,idLC,idLClib,avecFacturelib;
    private String codeEtablissementlib,projetlib;
    private double montant,disponible,dispoAvant,dispoApres,montantOP;
    private Date daty;
    private int avecFacture;

    
    public double getResteAFacturer(Connection c) throws Exception{
        FactureFournisseur[]factures=this.getFacturesLiees("factfourn_msum_libV",c);
        double totalFF = AdminGen.calculSommeDouble(factures, "montant");
        return this.getMontant() - totalFF;
    }

    public double getMontantOP() {
        return montantOP;
    }

    public void setMontantOP(double montantOP) throws Exception {
        this.montantOP = montantOP;
    }

    public String getAvecFacturelib() {
        return avecFacturelib;
    }

    public void setAvecFacturelib(String avecFacturelib) {
        this.avecFacturelib = avecFacturelib;
    }
    
    public int getAvecFacture() {
        return avecFacture;
    }

    public void setAvecFacture(int avecFacture) {
        this.avecFacture = avecFacture;
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
    
    public FactureFournisseur genererFactureFournisseurMere() throws Exception {
        FactureFournisseur ff = new FactureFournisseur();
        ff.setDesignation(this.getDesignation());
        ff.setTypeEngagement("ED");
        ff.setCode_etablissement(this.getCodeEtablissement()); 
        ff.setDaty(Utilitaire.dateDuJourSql());
        ff.setProjet(this.getProjet());
        ff.setIdengagement(this.getId());
        ff.setIdcategorie(Constante.categorieFFdefault);
        ff.setType(Constante.getTypeFCAcredit());
        ff.setExercice(Utilitaire.getAneeEnCours());
        ff.setDeviseMere(Constante.deviseAr);
        
        return ff;
    }
    
    public LigneCredit findSituationCredit(Connection c) throws Exception{
        LigneCredit lc = new LigneCredit();
        //lc.setNomTable("ligneCreditDepenseGrp");
        lc.setNomTable("SITUATIONLCDEPENSEGRP");
        String dir=this.getCodeEtablissement();
        String prj=this.getProjet();
        if(dir==null||dir.compareToIgnoreCase("")==0||prj==null||prj.compareToIgnoreCase("")==0)
        {
            if(this.getIdLC()==null || this.getIdLC().compareTo("")==0) throw new Exception("Ligne de crédit invalide");
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
        EngagementFille[] filles = this.getEngagementFilles(null, c);
        if(filles.length==0){
            throw new Exception ("Doit contenir au moins un détail engagement");
        }
        
        
        double montantTotal = AdminGen.calculSommeDouble(filles, "montant");
        if(montantTotal > this.getMontant()) throw new Exception("Montant details ("+Utilitaire.formaterAr(montantTotal)+") superieur au montant de l'engagement ("+Utilitaire.formaterAr(this.getMontant())+")");
        if(this.getMontant() > lc.getResteApresEngmt()) throw new Exception("Montant de l engagement ("+Utilitaire.formaterAr(this.getMontant())+") superieur au budget disponible ("+Utilitaire.formaterAr(lc.getResteApresEngmt())+")");
        //this.setDispoAvant(lc.getRestebudget());
        this.setDispoAvant(lc.getResteApresEngmt());
        this.setDispoApres(this.getDispoAvant() - this.getMontant());
        super.validerObject(u, c);
        if(avecFacture==0){
             this.genererFacture(u, c, filles);
        }
        return this; 
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
    
    public EngagementFille[] getEngagementFilles(String nomtable,Connection c) throws Exception{
        if(nomtable == null || nomtable.compareToIgnoreCase("") == 0) nomtable = "engagement_fille";
        EngagementFille engagement = new EngagementFille();
        engagement.setNomTable(nomtable);
        EngagementFille[] ef = (EngagementFille[]) CGenUtil.rechercher(engagement, null, null, c, " and idmere = '"+this.getId()+"'");
        if(ef.length > 0) return ef;
        return null;
    } 
    
    public FactureFournisseur genererFacture(String u, Connection c, EngagementFille[] filles) throws Exception{
        boolean check = false;
        try{
            if(c == null){
                c = new UtilDB().GetConn();
                check = true;
                c.setAutoCommit(false);
            }
            FactureFournisseur ff = this.genererFactureFournisseurMere();
            if(filles != null){
                FactureFournisseurDetails[] ffd = new FactureFournisseurDetails[filles.length];
                for(int i=0; i<filles.length; i++){
                    ffd[i] = filles[i].genererFactureFournisseurDetail(c);
                }
                ff.setFille(ffd);
            }
            ff.createObject(u, c);
            ff.validerObject(u, c);
            if(check) c.commit();
        return ff;
        } catch(Exception ex){
            if(check && c != null) c.rollback();
            throw ex;
        } finally{
            if(check && c != null) c.close();
        }
    }
    
    public void payerEngagementFille(String idFilles, String u, Connection c) throws Exception {
        boolean check = false;
        try{
            if(c == null){
                c = new UtilDB().GetConn();
                check = true;
                c.setAutoCommit(false);
            }
            Engagement eng = (Engagement)new Engagement().getById(this.getId(), null, c);
            if(eng == null) throw new Exception("Engagement introuvable");
            
            if(eng.getEtat() < ConstanteEtat.getEtatValider()) throw new Exception("Engagement non vise");
            if(eng.getAvecFacture()==1) throw new Exception("Paiement détail impossible pour un engagement avec facture");
            
            String[] ids = Utilitaire.stringToTab(idFilles, ";");
            String idFillesIn = Utilitaire.tabToString(ids, "'", ",");
            
            FactureFournisseur[] ff = eng.getFacturesLiees(null, c);
            if(ff == null || ff.length == 0) throw new Exception("Facture introuvable pour cet engagement");
            
            EngagementFille[] filles=(EngagementFille[])CGenUtil.rechercher(new EngagementFille(), null, null, c, " and id in ("+idFillesIn+")");
            if(filles == null || filles.length==0) throw new Exception("Aucun détail engement trouvé");
            
            for(int i=0; i < filles.length; i++) {
                OrdonnerPayement op=new OrdonnerPayement(ff[0].getId(),filles[i].getMontant(),Utilitaire.dateDuJourSql(),u,"OP auto - "+filles[i].getDesignation(),ConstanteEtat.getEtatCreer(),ff[0].getTiers());
                op.createObject(u, c);
                PaiementEngagement engPaie = new PaiementEngagement(filles[i].getId(), op.getId());
                engPaie.createObject(u, c);
            }
            
            
            if(check) c.commit();
        } catch(Exception ex){
            if(check && c != null) c.rollback();
            throw ex;
        } finally{
            if(check && c != null) c.close();
        }
    }
}
