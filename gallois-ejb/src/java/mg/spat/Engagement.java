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
import facture.NumeroFacture;

import java.sql.Connection;
import java.sql.Date;
//import javax.validation.executable.ValidateOnExecution;
import lignecredit.LigneCredit;
import utilitaire.Utilitaire;
import utilitaire.Constante;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import bean.ValidationException;
import facture.LiaisonEngagement;

/**
 *
 * @author Nouta
 */
public class Engagement extends ClassEtat {
    private String id,designation,codeEtablissement,projet,compte,idLC,idLClib,avecFacturelib,observation;
    private String codeEtablissementlib,projetlib,tiers ,tierslib,num, idengagement;
    private double montant,disponible,dispoAvant,dispoApres,montantOP,montantreste,montantliberer;
    private Date daty;
    private int avecFacture,annee;
    private String type;
    private Date dateImpression;
    private String chantier, objet, duree;

    public String getChantier() {
        return chantier;
    }

    public void setChantier(String chantier) {
        this.chantier = chantier;
    }


    public Date getDateImpression() {
        return dateImpression;
    }

    public void setDateImpression(Date dateImpression) {
        this.dateImpression = dateImpression;
    }

    public Engagement(String designation,String codeEtablissement,String projet,double montant,double disponible,double dispoAvant,double dispoApres,String compte,String idLC,Date daty)throws Exception{
        this.setNomTable("ENGAGEMENT");
        this.setDesignation(designation);
        this.setCodeEtablissement(codeEtablissement);
        this.setProjet(projet);
        this.setMontant(montant);
        this.setDisponible(disponible);
        this.setDispoAvant(dispoAvant);
        this.setDispoApres(dispoApres);
        this.setCompte(compte);
        this.setIdLC(idLC);
        this.setDaty(daty);
    }
    
    public double getResteAFacturer(Connection c) throws Exception{
        FactureFournisseur[]factures=this.getFacturesLiees("factfourn_msum_libV",c);
        double totalFF = AdminGen.calculSommeDouble(factures, "montant");
        return this.getMontant() - totalFF;
    }

    public Engagement modifierEntete(String refUser, Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }

            this.updateToTableWithHisto(refUser, c);

            if (verif == 1) {
                c.commit();
            }
        } catch (Exception e) {
            if (c != null && verif == 1) {
                c.rollback();
            }
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
        return this;
    }

    public String getObservation() {
        return observation;
    }

    public void setObservation(String observation) {
        this.observation = observation;
    }
    
    public int getAnnee() {
        return annee;
    }

    public void setAnnee(int annee) {
        this.annee = annee;
    }
    
    public String getNum() {
        return num;
    }

    public void setNum(String num) {
        this.num = num;
    }
    
    public String getTiers() {
        return tiers;
    }

    public void setTiers(String tiers) {
        this.tiers = tiers;
    }

    public String getTierslib() {
        return tierslib;
    }

    public void setTierslib(String tierslib) {
        this.tierslib = tierslib;
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

    public double getMontantliberer() {
        return montantliberer;
    }

    public void setMontantliberer(double montantliberer) {
        this.montantliberer = montantliberer;
    }

    public String getIdLC() {
        return idLC;
    }

    public void setIdLC(String idLC) throws Exception {
        //if(this.getMode().compareToIgnoreCase("modif")==0&& (idLC==null || idLC.compareToIgnoreCase("")==0)) throw new Exception("Budget obligatoire.");
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

    public void setDesignation(String designation) throws Exception {
        if(this.getMode().compareToIgnoreCase("modif")==0&& (designation==null || designation.compareToIgnoreCase("")==0)) throw new Exception("Désignation obligatoire.");
        this.designation = designation;
    }

    public String getCodeEtablissement() {
        return codeEtablissement;
    }

    public void setCodeEtablissement(String codeEtablissement) throws Exception {
        if(this.getMode().compareToIgnoreCase("modif")==0&& (codeEtablissement==null || codeEtablissement.compareToIgnoreCase("")==0)) throw new Exception("Code établissement obligatoire.");
        this.codeEtablissement = codeEtablissement;
    }

    public String getProjet() {
        return projet;
    }

    public void setProjet(String projet) throws Exception {
        if(this.getMode().compareToIgnoreCase("modif")==0&& (projet==null || projet.compareToIgnoreCase("")==0)) throw new Exception("Code projet obligatoire.");
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
        if(this.getMode().compareToIgnoreCase("modif")==0&&montant<=0) throw new Exception("montant engagement invalide");
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

    public String getIdengagement() {
        return idengagement;
    }

    public void setIdengagement(String idengagement) {
        this.idengagement = idengagement;
    }

    public double getMontantreste() {
        return montantreste;
    }

    public void setMontantreste(double montantreste) {
        this.montantreste = montantreste;
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getObjet() {
        return objet;
    }

    public void setObjet(String objet) {
        this.objet = objet;
    }

    public String getDuree() {
        return duree;
    }

    public void setDuree(String duree) {
        this.duree = duree;
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
    
    @Override
    public ClassMAPTable createObject(String u, Connection c) throws Exception {        
        // this.setNum(String.valueOf(Utilitaire.getMaxSeq("getseqNumeroEngagement",c)));
        return super.createObject(u, c); 
    }

    public LigneCredit findLigneCredit(Connection c) throws Exception{
        LigneCredit lc = new LigneCredit();
        lc.setNomTable("ligneCreditDepenseLib");
        LigneCredit[] ligneCredits = (LigneCredit[]) CGenUtil.rechercher(lc, null, null, c, " and id='"+this.getIdLC()+"'");
        if(ligneCredits.length > 0) return ligneCredits[0];
        return null;
    }
    
    public FactureFournisseur genererFactureFournisseurMere(LigneCredit lc) throws Exception {
        FactureFournisseur ff = new FactureFournisseur();
        ff.setDesignation(this.getDesignation());
        ff.setTypeEngagement("ED");
        if(this.getIdLC()!=null && this.getIdLC().compareTo("")!=0){
            ff.setCode_etablissement(lc.getIdcodeEtablissement()); 
            ff.setProjet(lc.getIdprojet());
        }else{
            ff.setCode_etablissement(this.getCodeEtablissement()); 
            ff.setProjet(this.getProjet());
        }
        ff.setDaty(Utilitaire.dateDuJourSql());
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
        lc.setNomTable("SITUATIONLCDEPENSEGRP_TEMP");
        String dir=this.getCodeEtablissement();
        String prj=this.getProjet();
        if(dir==null||dir.compareToIgnoreCase("")==0||prj==null||prj.compareToIgnoreCase("")==0)
        {
            if(this.getIdLC()==null || this.getIdLC().compareTo("")==0) throw new Exception("Budget invalide");
            LigneCredit ligne = findLigneCredit(c);
            dir=ligne.getCodeEtablissement();
            prj=ligne.getProjet();
        }
        LigneCredit[] ligneCredits = (LigneCredit[]) CGenUtil.rechercher(lc, null, null, c, " and idcodeEtablissement='"+dir +"' and idprojet='"+prj+"' and annee="+this.getAnnee());
        if(ligneCredits.length > 0) return ligneCredits[0];
        return null;
        }

    public String calculerNumero(Connection c) throws Exception{
        String seq="";
        // System.out.println("eeeeeeeeeee"+this.getCodeEtablissementlib());
        Engagement engagement  = new Engagement();
        engagement.setNomTable("engagementlib");
        engagement = (Engagement)engagement.getById(this.getId(), null, c);
        String rqt="SELECT  nvl(max(TO_NUMBER(num))+1,1) AS numerosuivant FROM NUMEROFSB where codeetablissement='"+engagement.getCodeEtablissement()+"' AND annee="+annee;
        NumeroFacture[] result = (NumeroFacture[])CGenUtil.rechercher(new NumeroFacture(), rqt, c);
        if(result.length>0) seq=Utilitaire.completerInt(4, result[0].getNumerosuivant());
        return seq;
    }
    
    @Override
    public Object validerObject(String u, Connection c) throws Exception {
        if(this.getType() == null) this.setType(Constante.typeEngagementEng);
        this.setNum(this.calculerNumero(c));
        LigneCredit lc = this.findSituationCredit(c);
        if(lc == null) throw new Exception("Budjet non trouv&eacute;");
        EngagementFille[] filles = this.getEngagementFilles(null, c);
        if(filles.length==0){
            throw new Exception ("Doit contenir au moins un détail engagement");
        }
        
        double montantTotal = AdminGen.calculSommeDouble(filles, "montant");
        if((float)montantTotal > (float)this.getMontant()) throw new Exception("Montant details ("+Utilitaire.formaterAr(montantTotal)+") superieur au montant de l'engagement ("+Utilitaire.formaterAr(this.getMontant())+")");
        if((float)this.getMontant() > (float)lc.getResteApresEngmt()) throw new ValidationException("Montant de l engagement ("+Utilitaire.formaterAr(this.getMontant())+") superieur au reste apres engagement disponible ("+Utilitaire.formaterAr(lc.getResteApresEngmt())+")",this.getType(),"validerBC");
        this.setDispoAvant(lc.getResteApresEngmt());
        this.setDispoApres(lc.getResteApresEngmt() - this.getMontant());
        super.validerObject(u, c);
        if(avecFacture==1){
             this.genererFacture(u, c, filles,lc);
        }
        return this; 
    }

    public Object validerObjectSansControleMontant(String u, Connection c) throws Exception {
        boolean check = false;
        try{
            if(c == null){
                c = new UtilDB().GetConn();
                check = true;
                c.setAutoCommit(false);
            }
            this.setNum(this.calculerNumero(c));
            LigneCredit lc = this.findSituationCredit(c);
            if(lc == null) throw new Exception("Ligne credit non trouv&eacute;");
            EngagementFille[] filles = this.getEngagementFilles(null, c);
            if(filles.length==0){
                throw new Exception ("Doit contenir au moins un détail engagement");
            }

            double montantTotal = AdminGen.calculSommeDouble(filles, "montant");
            double diff = Math.abs(montantTotal-this.getMontant());
            if(diff > 0.01) throw new Exception("Montant details ("+Utilitaire.formaterAr(montantTotal)+") superieur au montant de l'engagement ("+Utilitaire.formaterAr(this.getMontant())+")");
            //if((float)this.getMontant() > (float)lc.getRestebudget()) throw new ValidationException("Montant de l engagement ("+Utilitaire.formaterAr(this.getMontant())+") superieur au budget disponible ("+Utilitaire.formaterAr(lc.getRestebudget())+")");
            this.setDispoAvant(lc.getResteApresEngmt());
            this.setDispoApres(lc.getResteApresEngmt() - this.getMontant());
            super.validerObject(u, c);
            if(avecFacture==1){
                 this.genererFacture(u, c, filles,lc);
            }
            return this; 
        }
        catch(Exception e){
            if(check && c != null) c.rollback();
            throw e;
        }
        finally{
            if(check && c != null) c.close();
        }
    }
    
    public FactureFournisseur[] getFacturesLiees(String nomtable, Connection c) throws Exception{
        try{
            FactureFournisseur fact = new FactureFournisseur();
            fact.setNomTable(nomtable);
            fact.setIdengagement(this.getId());
            fact.setEtat(ConstanteEtat.getEtatValider());
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
    
    public FactureFournisseur genererFacture(String u, Connection c, EngagementFille[] filles,LigneCredit lc) throws Exception{
        boolean check = false;
        try{
            if(c == null){
                c = new UtilDB().GetConn();
                check = true;
                c.setAutoCommit(false);
            }
            FactureFournisseur ff = this.genererFactureFournisseurMere(lc);
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

    public Engagement(String designation, String codeEtablissement, String projet, double montant, int annee, Date daty, String tiers, int avecFacture)throws Exception{
        this.setNomTable("engagement");
        this.setDesignation(designation);
        this.setCodeEtablissement(codeEtablissement);
        this.setProjet(projet);
        this.setAnnee(annee);
        this.setDaty(daty);
        this.setTiers(tiers);
        this.setAvecFacture(avecFacture);
        this.setMontant(montant);
    }
    
    public void controleAnnulerVisa(Connection c) throws Exception
    {
        boolean ouvert = false;
        try{
            if(c == null){
                c = new UtilDB().GetConn();
                ouvert = true;
            }
            Engagement[] engagement = (Engagement[]) CGenUtil.rechercher(new Engagement(), null, null, c, "and codeetablissement='"+this.getCodeEtablissement()+"' and num > " + this.getNum() + " and etat = " + ConstanteEtat.getEtatValider());
            if(engagement.length > 0)
                throw new Exception("Un autre engagement a été créé après celui-ci.");
                
            LiaisonEngagement[] liaisons = (LiaisonEngagement[]) CGenUtil.rechercher(new LiaisonEngagement(), null, null, c, " and id1 = '" + this.getId() + "' and etat = " + ConstanteEtat.getEtatValider());
            if(liaisons.length > 0)
                throw new Exception("Engagement d\\351j\\340 li\\351 \\340 un bon de commande ou \\340 une facture fournisseur ou BED.");
            
            if(this.getEtat() < ConstanteEtat.getEtatValider()) 
                throw new Exception("Impossible \\340 lib\\351rer, d\\351j\\340 annul\\351");
            
            super.controleAnnulerVisa(c);
        } catch(Exception ex){
            throw ex;
        } finally{
            if(ouvert && c != null) c.close();
        }
    }
    
    @Override
    public void controleAnnuler(Connection c) throws Exception
    {
        try{
            LiaisonEngagement[] liaisons = (LiaisonEngagement[]) CGenUtil.rechercher(new LiaisonEngagement(), null, null, c, " and id1 = '" + this.getId() + "' and etat = " + ConstanteEtat.getEtatValider());
            if(liaisons.length > 0)
                throw new Exception("Engagement d\\351j\\340 li\\351 \\340 un bon de commande ou \\340 une facture fournisseur.");
            
            super.controleAnnuler(c);
        }
        catch(Exception e){
            throw e;
        }
    }
    
    @Override
    public void controler(Connection c) throws Exception {
        if(this.getEtat() == ConstanteEtat.getEtatAnnuler()) 
            throw new Exception("Impossible \\340 viser, d\\351j\\340 annul\\351");
    }
}
