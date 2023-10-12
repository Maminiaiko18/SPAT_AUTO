/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bordereau;

import java.sql.Connection;

import bean.AdminGen;
import bean.CGenUtil;
import bean.ClassMAPTable;
import bean.ResultatEtSomme;
import facture.FactureFournisseur;
import facture.LiaisonEngagement;
import facture.NumeroFacture;
import lignecredit.LigneCredit;
import mg.spat.Engagement;
import mg.spat.EngagementFille;
import utilitaire.Constante;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author Audace
 */
public class BordereauFF extends Bordereau{

    private double montantbudget;
    private double montantav;
    private double montantap;
    private String idengagement, tierslib,typebordereau,typebordereaulib;
    
    public String getTypebordereau() {
        return typebordereau;
    }

    public void setTypebordereau(String typebordereau) {
        this.typebordereau = typebordereau;
    }
  
    public double getMontantbudget(){
        return this.montantbudget;
    }

    public double getMontantav() {
        return montantav;
    }

    public double getMontantap() {
        return montantap;
    }

    public void setMontantap(double montantap) {
        this.montantap = montantap;
    }

    public void setMontantav(double montantav) {
        this.montantav = montantav;
    }

    public void setMontantbudget(double montantbudget) {
        this.montantbudget = montantbudget;
    }

    public String getIdengagement() {
        return idengagement;
    }

    public void setIdengagement(String idengagement) {
        this.idengagement = idengagement;
    }

    public String getTierslib() {
        return tierslib;
    }

    public void setTierslib(String tierslib) {
        this.tierslib = tierslib;
    }

    public String getTypebordereaulib() {
        return typebordereaulib;
    }

    public void setTypebordereaulib(String typebordereaulib) {
        this.typebordereaulib = typebordereaulib;
    }
    
    public BordereauFF(){
        this.setNomTable("BORDEREAUFF");
        this.setNomTableFille("liaisonbordereauFF");
        this.setNomFonctionSequence("get_seqnumerobordereauFF");
    }

    public BordereauFilleLibComplet[] getFille(Connection c)throws Exception{
        BordereauFilleLibComplet retour[] = null;
        int verif=0;
        try{
            if(c==null){
                c=new UtilDB().GetConn();
                verif=1;
            }
            BordereauFilleLibComplet fille = new BordereauFilleLibComplet();
            fille.setNomTable("liaisonbordereauFF_libcomplet");
            //fille.setIdbordereau(this.getId());
            retour = (BordereauFilleLibComplet[])CGenUtil.rechercher(fille, null, null, c,"and idbordereau='"+this.getId()+"'");
        }catch(Exception e){
            e.printStackTrace();
            throw e;
        }finally{
            if(c!=null && verif==1)c.close();
        }
        return retour;
    }

    public FactureFournisseur[] getFactures(Connection c)throws Exception{
        FactureFournisseur retour[] = null;
        int verif=0;
        try{
            if(c==null){
                c=new UtilDB().GetConn();
                verif=1;
            }
            FactureFournisseur fille = new FactureFournisseur();
            fille.setNomTable("FACTURE_FOURNISSEUR_MERE");
            retour = (FactureFournisseur[])CGenUtil.rechercher(fille, null, null, c," and id in (" + Utilitaire.tabToString(this.getIdfactures().split(";"), "'", ",") + ")");
        }catch(Exception e){
            e.printStackTrace();
            throw e;
        }finally{
            if(c!=null && verif==1)c.close();
        }
        return retour;
    }


    public void controlerFF(Connection c)throws Exception{
        int verif=0;
        try{
            if(c==null){
                c=new UtilDB().GetConn();
                verif=1;
            }
            FactureFournisseur facture = new FactureFournisseur();
            String requete = "SELECT projet,code_etablissement from FACTURE_FOURNISSEUR_MERE WHERE id IN (select idop from liaisonbordereauFF where idbordereau='"+this.getId()+"') group by projet,code_etablissement";
            FactureFournisseur[] retour= (FactureFournisseur[])CGenUtil.rechercher(facture, requete, c);
            if(retour.length>1)throw new Exception("Les codes projet et direction doivent etre identiques pour les factures.");
            String[] facturesTab = Utilitaire.stringToTab(this.getIdfactures(), ";");
            String factures = Utilitaire.tabToString(facturesTab, "'", ",");
            requete = "SELECT * from FACTURE_FOURNISSEUR_MERE where id in (" + factures + ")";
            FactureFournisseur[] ff = (FactureFournisseur[])CGenUtil.rechercher(facture, requete, c);
            String[] projet = AdminGen.getDistinct(ff, "projet");
            String[] code_etablissement = AdminGen.getDistinct(ff, "code_etablissement");
            if(projet.length > 1){
                throw new Exception("Les factures fournisseur doivent avoir le m\352me projet.");
            }
            if(code_etablissement.length > 1){
                throw new Exception("Les factures fournisseur doivent avoir le m\352me code \351tablissement.");
            }
        }catch(Exception e){
            e.printStackTrace();
            throw e;
        }finally{
            if(c!=null && verif==1)c.close();
        }
    }
    @Override
    public void controler(Connection c) throws Exception {
        this.controlerFF(c);
    }

    @Override
    public ClassMAPTable createObject(String u, Connection c) throws Exception {
        FactureFournisseur[] listeFille=this.getFactures(c);
        if(listeFille!=null && listeFille.length>0){
            if(this.getTypebordereau().compareToIgnoreCase(Constante.typeEtatDepense)!=0){
                for(FactureFournisseur details : listeFille){
                    if(details.getIdBL()!=null) throw new Exception("Facture de bon de commande ne peut pas etre editer BED.");
                    if(details.getEtat()==ConstanteEtat.getEtatValider()) throw new Exception("Facture " + details.getId() + " deja visee.");
                }
            }
            if(listeFille[0]!=null){
                this.setDirection(listeFille[0].getCode_etablissement());
                this.setProjet(listeFille[0].getProjet());
                this.setNumero(this.calculerNumero(c));
            }
        }
        else throw new Exception("Bordereau comporte aucune facture");
        return super.createObject(u, c);
    }
    
    @Override
    public Object validerObject(String u, Connection c) throws Exception {
        BordereauFilleLibComplet[] listeFille=this.getFille(c);
        if(listeFille!=null && listeFille.length>0){
        FactureFournisseur ff = null;
        for(BordereauFilleLibComplet details : listeFille){
            ff = ((BordereauFille)details).getFF("FACTFOURN_MSUM_LIB",c);
            if(ff.getEtat()==ConstanteEtat.getEtatValider()) throw new Exception("Facture " + ff.getId() + " d\\351j\\340 vis\\351e.");
        }

        visaFacture(u, c, true);
            if(ff!=null){
                LigneCredit critere=new LigneCredit();
                critere.setNomTable("situationLC_vide");
                critere.setProjet(ff.getProjetlib());
                critere.setDirection(ff.getCode_etablissementlib());
                //this.setDirection(ff.getCode_etablissementlib());
                this.setNumfsb(this.calculerNumeroFsb(c));
                String[] colSomme = {};
                ResultatEtSomme lc = LigneCredit.findSituationCreditDepense(critere, null, null, String.valueOf(Utilitaire.getAnnee(this.getDaty())),c, colSomme);
                if(lc.getResultat().length>0){
                    double montantBudget=AdminGen.calculSommeDouble(listeFille, "montant");
                    LigneCredit ligneCredit=(LigneCredit)lc.getResultat()[0];
                    this.setMontantbudget(ligneCredit.getMontant());
                    this.setMontantav(ligneCredit.getResteApresEngmt()+montantBudget);
                    this.setMontantap(ligneCredit.getResteApresEngmt());
                }
                
            }
        }
        return super.validerObject(u, c);
    }

    public String calculerNumero(Connection c) throws Exception{
        String dateEffetStr = Utilitaire.datetostring(this.getDaty()) ;
        String annee = Utilitaire.getAnnee(dateEffetStr);
        String seq="";
        String rqt="SELECT  nvl(max(TO_NUMBER(numero))+1,1) AS numerosuivant FROM BORDEREAUFF_LIB_MONTANT where direction='"+this.getDirection()+"' AND extract(YEAR FROM  daty)="+annee;
        NumeroFacture[] result = (NumeroFacture[])CGenUtil.rechercher(new NumeroFacture(), rqt, c);
        if(result.length>0) seq=Utilitaire.completerInt(4, result[0].getNumerosuivant());
        return seq;
    }

    public String calculerNumeroFsb(Connection c) throws Exception{
        String dateEffetStr = Utilitaire.datetostring(this.getDaty()) ;
        String annee = Utilitaire.getAnnee(dateEffetStr);
        String seq="";
        String rqt="SELECT  nvl(max(TO_NUMBER(num))+1,1) AS numerosuivant FROM NUMEROFSB where codeetablissement='"+this.getDirection()+"' AND annee="+annee;
        NumeroFacture[] result = (NumeroFacture[])CGenUtil.rechercher(new NumeroFacture(), rqt, c);
        if(result.length>0) seq=Utilitaire.completerInt(4, result[0].getNumerosuivant());
        return seq;
    }

    public void checkFacture(Connection c) throws Exception {
            BordereauFilleLibComplet[] listeFille=this.getFille(c);
            if(listeFille!=null && listeFille.length>0){
            for(BordereauFilleLibComplet details : listeFille){
                FactureFournisseur ff = ((BordereauFille)details).getFF("FACTURE_FOURNISSEUR_MERE",c);
                if(ff.getEtat()==ConstanteEtat.getEtatCreer()) throw new Exception("Facture non visé");
            }
        }
    }

    public void visaFacture(String u, Connection c, boolean controleBudget) throws Exception {
        BordereauFilleLibComplet[] listeFille=this.getFille(c);
        if(listeFille!=null && listeFille.length>0){
            for(BordereauFilleLibComplet details : listeFille){
                FactureFournisseur ff = ((BordereauFille)details).getFF("factfourn_msum_lib",c);
                ff.setTypeEngagement(Constante.typeEngagementBED);
                ff.validerSansControleResteEngagement(u, controleBudget, c);
            }
        }
    }
    
    public Object validerObjectSansControleBudget(String u, Connection c) throws Exception {
        int verif=0; 
        try{
            if(c==null){
                c=new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif=1;
            }
            visaFacture(u, c, false);
            BordereauFilleLibComplet[] listeFille=this.getFille(c);
            if(listeFille!=null && listeFille.length>0){
                FactureFournisseur ff = ((BordereauFille)listeFille[0]).getFF("FACTFOURN_MSUM_LIB",c);
                if(ff!=null){
                    LigneCredit critere=new LigneCredit();
                    critere.setNomTable("situationLC_vide");
                    critere.setProjet(ff.getProjetlib());
                    critere.setDirection(ff.getCode_etablissementlib());
                    //this.setDirection(ff.getCode_etablissementlib());
                    this.setNumfsb(this.calculerNumeroFsb(c));
                    String[] colSomme = {};
                    ResultatEtSomme lc = LigneCredit.findSituationCreditDepense(critere, null, null, String.valueOf(Utilitaire.getAnnee(ff.getDaty())),c, colSomme);
                    if(lc.getResultat().length>0){
                        double montantBudget=AdminGen.calculSommeDouble(listeFille, "montant");
                        LigneCredit ligneCredit=(LigneCredit)lc.getResultat()[0];
                        this.setMontantbudget(ligneCredit.getMontant());
                        this.setMontantav(ligneCredit.getResteApresEngmt()+montantBudget);
                        this.setMontantap(ligneCredit.getResteApresEngmt());
                    }

                }
            }
            this.setNomTable("bordereauFF");
            super.validerObject(u, c);
            c.commit();
        }catch(Exception e){
            c.rollback();
            e.printStackTrace();
            throw e;
        }finally{
            if(c!=null && verif==1)c.close();
        }
        return this;
    }

    public void checkFactureVisee(Connection c) throws Exception {
            BordereauFilleLibComplet[] listeFille=this.getFille(c);
            if(listeFille!=null && listeFille.length>0){
            for(BordereauFilleLibComplet details : listeFille){
                FactureFournisseur ff = ((BordereauFille)details).getFF("FACTURE_FOURNISSEUR_MERE",c);
                if(ff.getEtat()==ConstanteEtat.getEtatValider()) throw new Exception("Facture deja visée");
            }
        }
    }
    
    public String engager(String u, Connection c, boolean controleBudget) throws Exception {
        boolean ouvert = false;
        
        try{
            if(c == null){
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                ouvert = true;
            }
            
            if(this.getIdengagement()!=null) throw new Exception("BED déja engagé.");
            String idengagement = this.createEngagement(u, c, controleBudget);
            this.setIdengagement(idengagement);
            this.setNomTable("BORDEREAUFF");
            this.updateToTableWithHisto(u, c,"Engager Bordereau");
            
            if(ouvert) 
                c.commit();
        }
        catch(Exception e){
            if(ouvert) 
                c.rollback();
            e.printStackTrace();
            throw e;
        }
        finally{
            if(c != null && ouvert)c.close();
        }
        
        return this.getId();
    }
    
    public String createEngagement(String u, Connection c, boolean controleBudget) throws Exception {
        String idengagement = "";
        
        try{
            LigneCredit lc = new LigneCredit();
            lc.setNomTable("LIGNECREDITDEPENSE");
            lc.setCodeEtablissement(this.getDirection());
            lc.setProjet(this.getProjet());
            LigneCredit[] ligneCredits = (LigneCredit[]) CGenUtil.rechercher(lc, null, null, c, " and annee=" + Utilitaire.getAnnee(this.getDaty()));
            if (ligneCredits.length > 0) {
                lc = ligneCredits[0];
            }

            BordereauFilleFF temp = new BordereauFilleFF();
            temp.setNomTable("LIAISONBORDEREAUFF");
            BordereauFilleFF[] liaisonBordFF = (BordereauFilleFF[]) CGenUtil.rechercher(temp, null, null, c, " and IDBORDEREAU='"+this.getId()+"'");
            String[] facturesTab = AdminGen.getDistinct(liaisonBordFF, "idop");
            String factures = Utilitaire.tabToString(facturesTab, "'", ",");
            String requete = "SELECT * from factfourn_msum_lib where id in (" + factures + ")";
            FactureFournisseur fact = new FactureFournisseur();
            fact.setNomTable("factfourn_msum_lib");
            FactureFournisseur[] ff = (FactureFournisseur[])CGenUtil.rechercher(fact, requete, c);
            double montant = AdminGen.calculSommeDouble(ff, "montant");
            Engagement engagement = new Engagement(this.getDesignation(), this.getDirection(), this.getProjet(), montant, Utilitaire.getAnnee(this.getDaty()), this.getDaty(), this.getTiers(), 0);
            if (lc != null) {
                engagement.setIdLC(lc.getTuppleID());
            }
            engagement.construirePK(c);
            engagement.createObject(u, c);
            
            EngagementFille engFille = new EngagementFille(engagement.getId(),this.getNumero(),montant);
            engFille.construirePK(c);
            engFille.insertToTableWithHisto(u, c);
            engagement.setType(Constante.typeEngagementBED);
            if(controleBudget)
                engagement.validerObject(u, c);
            else 
                engagement.validerObjectSansControleMontant(u, c);

            LiaisonEngagement liaison = new LiaisonEngagement(engagement.getId(), this.getId(), montant, ConstanteEtat.getEtatCreer());
            liaison.createObject(u, c);
            liaison.validerObject(u, c);
            
            idengagement = engagement.getId();
        }
        catch(Exception e){
            e.printStackTrace();
            throw e;
        }
        
        return idengagement;
    }
}