/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facturefournisseur;

import bean.CGenUtil;
import bean.ClassMAPTable;
import java.sql.Connection;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;

/**
 *
 * @author rasol
 */
public class DetailsFactureFournisseur  extends ClassMAPTable{
    String marge;
    private String id,idingredient,idmere,compte, iddqe;
    private double pu,qte;
    private double pudevise;
    private double qteff,qtechantier,puchantier;
    private String libellechantier,idchantier;
    private double montant;
    private double qteReste;
    private double tva;
 
    public DetailsFactureFournisseur(String idingredient, String idmere, double qte, double pu)throws Exception {
      this.setNomTable("facture_detail_fournisseur");
      this.setIdingredient(idingredient);
      this.setIdmere(idmere);
      this.setQte(qte);
      this.setPu(pu);
    }

    public double getQteReste() {
        return qteReste;
    }

    public void setQteReste(double qteReste) {
        this.qteReste = qteReste;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public String getIdchantier() {
        return idchantier;
    }

    public void setIdchantier(String idchantier) {
        this.idchantier = idchantier;
    }

    public double getQteff() {
        return qteff;
    }

    public void setQteff(double qteff) {
        this.qteff = qteff;
    }

    public double getQtechantier() {
        return qtechantier;
    }

    public void setQtechantier(double qtechantier) {
        this.qtechantier = qtechantier;
    }

    public double getPuchantier() {
        return puchantier;
    }

    public void setPuchantier(double puchantier) {
        this.puchantier = puchantier;
    }

    public String getLibellechantier() {
        return libellechantier;
    }

    public void setLibellechantier(String libellechantier) {
        this.libellechantier = libellechantier;
    }

    public String getMarge() {
        return marge;
    }

    public void setMarge(String marge) {
        this.marge = marge;
    }

    public String getIddqe() {
        return iddqe;
    }

    public void setIddqe(String iddqe) {
        this.iddqe = iddqe;
    }

    public String getCompte() {
        return compte;
    }

    public void setCompte(String compte) {
        this.compte = compte;
    }

    public double getPudevise() {
        return pudevise;
    }

    public void setPudevise(double pudevise) {
        this.pudevise = pudevise;
    }

//    public void gererPU(Connection c) throws Exception{
//        int verif=0;
//        try{
//            if(c==null){
//                c=new UtilDB().GetConn();
//                verif=1;
//            }
//            ProduitsPrix[] produit=(ProduitsPrix[]) CGenUtil.rechercher(new ProduitsPrix(), null, null, c, " and id='"+this.getIdingredient()+"'");
//            if(produit.length==0) throw new Exception("Produit introuvable");
//            FactureFournisseur mere= this.getFactureMere(c);
//            this.setPudevise(this.getPu());
//            this.setPu(this.getPu()*mere.getMontantdevise());
//        }
//        catch(Exception ex){
//            ex.printStackTrace();
//            throw ex;
//        }
//        finally{
//            if(c!=null && verif==1)c.close();
//        }
//    }

    public DetailsFactureFournisseur() {
        this.setNomTable("detailsfacturefournisseur");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdingredient() {
        return idingredient;
    }

    public void setIdingredient(String idingredient)throws Exception {
//        if(this.getMode().compareToIgnoreCase("modif")==0 &&(idingredient==null||idingredient.compareToIgnoreCase("")==0) )throw new  Exception("Ingredient invalide");
        this.idingredient = idingredient;
    }

    public String getIdmere() {
        return idmere;
    }

    public void setIdmere(String idmere) {
        this.idmere = idmere;
    }

    public double getQte() {
        return qte;
    }

    public void setQte(double qte)throws Exception {
//        if(this.getMode().compareToIgnoreCase("modif")==0 && qte<=0)throw new  Exception("quantite invalide");
  
        this.qte = qte;
    }

    public double getPu() {
        return pu;
    }

    public void setPu(double pu)throws Exception {
        if(this.getMode().compareToIgnoreCase("modif")==0 && pu<=0)throw new  Exception("Prix unitaire invalide");
        this.pu = pu;
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
         this.preparePk("DF", "getseqdetailsfacturefourniss");
        this.setId(makePK(c));
    }
    
    
    @Override
    public void controler(Connection c) throws Exception {
        int verif=0;
        try{
            if(c==null){
                c=new UtilDB().GetConn();
                verif=1;
            }
           FactureFournisseur mere =this.getFactureMere(c);
           if(mere.getEtat()>= ConstanteEtat.getEtatValider())throw new Exception("Facture fournisseur d&eacute;jà valid&eacute;");
        }
        catch(Exception ex){
            ex.printStackTrace();
            throw ex;
        }
        finally{
            if(c!=null && verif==1)c.close();
        }
    }
    @Override
    public void controlerUpdate(Connection c) throws Exception {
        int verif=0;
        try{
            if(c==null){
                c=new UtilDB().GetConn();
                verif=1;
            }
           FactureFournisseur[] lsf=(FactureFournisseur[]) CGenUtil.rechercher(new FactureFournisseur(), null, null, c, " and id='"+this.getIdmere()+"'");
           if(lsf==null || lsf.length==0)throw new Exception("facture fournisseur introuvable");
           if(lsf[0].getEtat()>= ConstanteEtat.getEtatValider())throw new Exception("facture fournisseur deja valid&eacute;");
        }
        catch(Exception ex){
            ex.printStackTrace();
            throw ex;
        }
        finally{
            if(c!=null && verif==1)c.close();
        }
    }
    
    public FactureFournisseur getFactureMere(Connection c) throws Exception{
        boolean estOuvert=false;
        FactureFournisseur ff=null;
        try{
            if(c==null){
                c=new UtilDB().GetConn();
                estOuvert=true;
            }
            FactureFournisseur[] ce=(FactureFournisseur[])CGenUtil.rechercher(new FactureFournisseur(), null, null, c, " and id='"+this.getIdmere()+"'");
            if(ce.length==0) throw new Exception("Facture fournisseur mère introuvable");
            ff=ce[0];
        }catch(Exception e){
            throw e;
        }finally{
            if(c!=null && estOuvert)c.close();
        }
        return ff;
    }
//    public ComptaEcriture getEcritureMere(Connection c) throws Exception{
//        boolean estOuvert=false;
//        ComptaEcriture ff=null;
//        try{
//            if(c==null){
//                c=new UtilDB().GetConn();
//                estOuvert=true;
//            }
//            FactureFournisseur mere=this.getFactureMere(c);
//            ComptaEcriture[] ce=(ComptaEcriture[])CGenUtil.rechercher(new ComptaEcriture(), null, null, c, " and origine='"+mere.getId()+"'");
//            if(ce.length<0) throw new Exception("Ecriture mère introuvable");
//            ff=ce[0];
//        }catch(Exception e){
//            throw e;
//        }finally{
//            if(c!=null && estOuvert)c.close();
//        }
//        return ff;
//    }
    /*public void inserer(String refuser,Connection c) throws Exception{
        boolean estOuvert=false;
        try{
            if(c==null){
                c=new UtilDB().GetConn();
                c.setAutoCommit(false);
                estOuvert=true;
            }
            this.createObject(refuser,c);
            ComptaEcriture ce=getEcritureMere(c);
            ComptaDeviseEcriture cde=ce.getDeviseEcriture(c);
            ComptaSousEcriture cse=new ComptaSousEcriture(this.getCompte(), 0, this.getQte()*this.getPu()*cde.getMontantdevise(), "", "Détails pour le produit "+this.getIdingredient(), ce.getId());
            cse.createObject(refuser,c);
            if(c!=null && estOuvert)c.commit();
        }catch(Exception e){
            if(c!=null && estOuvert)c.rollback();
            throw e;
        }finally{
            if(c!=null && estOuvert)c.close();
        }
    }*/

    public double getTva() {
        return tva;
    }

    public void setTva(double tva) {
        this.tva = tva;
    }

    
    
}