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
import facture.NumeroFacture;
import lignecredit.LigneCredit;
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
    private String projet;
    private String direction;

    public String getProjet() {
        return this.projet;
    }

    public void setProjet(String projet) {
        this.projet = projet;
    }

    public String getDirection() {
        return this.direction;
    }

    public void setDirection(String direction) {
        this.direction = direction;
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
            fille.setIdbordereau(this.getId());
            retour = (BordereauFilleLibComplet[])CGenUtil.rechercher(fille, null, null, c, "");
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
        BordereauFilleLibComplet[] listeFille=this.getFille(c);
        if(listeFille!=null && listeFille.length>0){
            FactureFournisseur ff = ((BordereauFille)listeFille[0]).getFF("FACTUREFOURNVALIDE_TOUS",c);
            if(ff!=null){
                LigneCredit critere=new LigneCredit();
                critere.setNomTable("situationLC_vide");
                critere.setProjet(ff.getProjetlib());
                critere.setDirection(ff.getCode_etablissementlib());
                this.setDirection(ff.getCode_etablissementlib());
                this.setNumero(this.calculerNumero(c));
            }
        }else throw new Exception("Bordereau comporte aucune facture");
        return super.createObject(u, c);
    }
    
    @Override
    public Object validerObject(String u, Connection c) throws Exception {
        this.checkFacture(c);
        //visaFacture(u, c);
        BordereauFilleLibComplet[] listeFille=this.getFille(c);
        if(listeFille!=null && listeFille.length>0){
            FactureFournisseur ff = ((BordereauFille)listeFille[0]).getFF("FACTUREFOURNVALIDE_TOUS",c);
            if(ff!=null){
                LigneCredit critere=new LigneCredit();
                critere.setNomTable("situationLC_vide");
                critere.setProjet(ff.getProjetlib());
                critere.setDirection(ff.getCode_etablissementlib());
                this.setDirection(ff.getCode_etablissementlib());
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
        String rqt="SELECT  nvl(max(TO_NUMBER(num))+1,1) AS numerosuivant FROM NUMEROFSB where codeetablissementlib='"+this.getDirection()+"' AND annee="+annee;
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

    public void visaFacture(String u, Connection c) throws Exception {
            BordereauFilleLibComplet[] listeFille=this.getFille(c);
            if(listeFille!=null && listeFille.length>0){
            for(BordereauFilleLibComplet details : listeFille){
                FactureFournisseur ff = ((BordereauFille)details).getFF("factfourn_msum_lib",c);
                ff.validerSansControleResteEngagement(u, true, c);
            }
        }
    }
}