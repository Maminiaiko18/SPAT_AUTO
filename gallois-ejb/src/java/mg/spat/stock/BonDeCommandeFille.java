package mg.spat.stock;

import bean.CGenUtil;
import bean.ClassMAPTable;
import fin.Coursdevise;
import java.sql.Connection;
import java.sql.Date;
import mg.allosakafo.produits.LiaisonDetailsBCProduit;
import mg.allosakafo.produits.Produits;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author BICI
 */
public class BonDeCommandeFille extends ClassMAPTable {

    private String id, produit, idbc, numbc, remarque,unite;
    private double quantiteparpack, quantite,montantbl,montantblreste ;
    private double pu, montant, quantitelivre, quantitereste, tva;
    private String produitlib;
    private String fournisseur, fournisseurlib;
    private double montantht,montanttva,montantttc,remise,montantHTSansRemise;
    private double montantremise,montantTVA,taux ;
    private String observation;
    private String code,codelib,projet,projetlib,devise;

    public double getTaux() {
        return taux;
    }

    public void setTaux(double taux) {
        this.taux = taux;
    }

    public String getDevise() {
        return devise;
    }

    public void setDevise(String devise) {
        this.devise = devise;
    }
    

    public double getMontantTVA() {
        return montantTVA;
    }

    public String getNumbc() {
        return numbc;
    }

    public void setNumbc(String numbc) {
        this.numbc = numbc;
    }

    public void setMontantTVA(double montantTVA) {
        this.montantTVA = montantTVA;
    }
    
    public String getCodelib() {
        return codelib;
    }

    public void setCodelib(String codelib) {
        this.codelib = codelib;
    }

    public String getProjetlib() {
        return projetlib;
    }

    public void setProjetlib(String projetlib) {
        this.projetlib = projetlib;
    }
    private int numeroLigne;
    private Date daty;

     public String getFournisseurlib() {
        return fournisseurlib;
    }

    public void setFournisseurlib(String fournisseurlib) {
        this.fournisseurlib = fournisseurlib;
    }
    
    public double getMontantHTSansRemise() {
        return montantHTSansRemise;
    }

    public void setMontantHTSansRemise(double montantHTSansRemise) {
        this.montantHTSansRemise = montantHTSansRemise;
    }
    
    public String getProjet() {
        return projet;
    }

    public void setProjet(String projet) {
        this.projet = projet;
    }
    
     public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }
    
    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date date) {
        this.daty = date;
    }

    public int getNumeroLigne() {
        return numeroLigne;
    }

    public void setNumeroLigne(int numeroLigne) {
        this.numeroLigne = numeroLigne;
    }

    public String getObservation() {
        return observation;
    }

     public String getFournisseur() {
        return fournisseur;
    }

    public void setFournisseur(String fournisseur) {
        this.fournisseur = fournisseur;
    }
    
    public void setObservation(String observetion) {
        this.observation = observetion;
    }

    public double getMontantremise() {
        return montantremise;
    }

    public void setMontantremise(double montantremise) {
        this.montantremise = montantremise;
    }
    
    public double getRemise() {
        return remise;
    }

    public void setRemise(double remise) {
        this.remise = remise;
    }

    public String getProduitlib() {
        return produitlib;
    }

    public void setProduitlib(String produitlib) {
        this.produitlib = produitlib;
    }

    
    public double getMontantht() {
        return montantht;
    }

    public void setMontantht(double montantht) {
        this.montantht = montantht;
    }

    public double getMontanttva() {
        return montanttva;
    }

    public void setMontanttva(double montanttva) {
        this.montanttva = montanttva;
    }

    public double getMontantttc() {
        return montantttc;
    }

    public void setMontantttc(double montantttc) {
        this.montantttc = montantttc;
    }

    public double getTva() {
        return tva;
    }

    public void setTva(double tva) {
        this.tva = tva;
    }

    public double getMontantbl() {
        return montantbl;
    }

    public void setMontantbl(double montantbl) {
        this.montantbl = montantbl;
    }

    public double getMontantblreste() {
        return montantblreste;
    }

    public void setMontantblreste(double montantblreste) {
        this.montantblreste = montantblreste;
    }

    public BonDeCommande getMere(Connection c) throws Exception {
        BonDeCommande retour=null;
        try{
            BonDeCommande[] liste=null;
            liste=(BonDeCommande[])CGenUtil.rechercher(new BonDeCommande(), null, null, c, " and id='"+this.getIdbc()+"'");
            if(liste.length>0) retour=liste[0];
        }catch(Exception e){
            throw e;
        }
        return retour;
    }
    
    @Override
    public ClassMAPTable createObject(String u, Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            if(estProduit(this.getProduit(), c)){
                LiaisonDetailsBCProduit liaison = new LiaisonDetailsBCProduit(this.getIdbc(), this.getProduit());
                liaison.createObject(u, c);
            }
            super.createObject(u, c);
            if (verif == 1 && c != null) {
                c.commit();
            }
        } catch (Exception ex) {
            if (c != null) {
                c.rollback();
            }
            throw ex;
        } finally {
            if (verif == 1 && c != null) {
                c.close();
            }
        }
        return this;
    }

    public String getUnite() {
        return unite;
    }

    public void setUnite(String unite) {
        this.unite = unite;
    }

    private boolean estProduit(String id, Connection c) throws Exception {
        Produits prod = new Produits();
        prod.setId(id);
        Produits[] produit = (Produits[]) CGenUtil.rechercher(prod, null, null, c, "");
        if (produit.length != 0) {
            return true;
        }
        return false;
    }
    
    public double getQuantitelivre() {
        return quantitelivre;
    }

    public void setQuantitelivre(double quantitelivre) {
        this.quantitelivre = quantitelivre;
    }

    public double getQuantitereste() {
        return quantitereste;
    }

    public void setQuantitereste(double quantitereste) {
        this.quantitereste = quantitereste;
    }

    public BonDeCommandeFille() {
        this.setNomTable("AS_BONDECOMMANDE_FILLE");
    }

    public BonDeCommandeFille(String produit, String idbc, String remarque, double prixu, double qtepack, double qte) {
        this.setNomTable("AS_BONDECOMMANDE_FILLE");
        this.setProduit(produit);
        this.setIdbc(idbc);
        this.setRemarque(remarque);
        this.setPu(prixu);
        this.setQuantiteparpack(qtepack);
        this.setQuantite(qte);
        this.setMontant(pu * quantite);
    }
    public BonDeCommandeFille(String produit, String idbc, String remarque, double prixu, double qtepack, double qte,String unite,double tva) {
        this.setNomTable("AS_BONDECOMMANDE_FILLE");
        this.setProduit(produit);
        this.setIdbc(idbc);
        this.setRemarque(remarque);
        this.setPu(prixu);
        this.setQuantiteparpack(qtepack);
        this.setQuantite(qte);
        this.setMontant(pu * quantite);
        this.setUnite(unite);
        this.setTva(tva);
    }

    public void construirePK(Connection c) throws Exception {
        this.preparePk("BCF", "GETSEQAS_BONDECOMMANDEFILLE");
        this.setId(makePK(c));
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public String getProduit() {
        return produit;
    }

    public void setProduit(String produit) {
        this.produit = produit;
    }

    public String getIdbc() {
        return idbc;
    }

    public void setIdbc(String idbc) {
        this.idbc = idbc;
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

    public double getQuantiteparpack() {
        return quantiteparpack;
    }

    public void setQuantiteparpack(double quantiteparpack) {
        this.quantiteparpack = quantiteparpack;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }
    
    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    public void controler(Connection c) throws Exception {
        try{
            BonDeCommande mere=this.getMere(c);
            if(mere.getEtat()>=ConstanteEtat.getEtatValider()) throw new Exception("Ajout détails BC impossible pour un BC déjà visé");
        }catch(Exception e){
            throw e;
        }
    }
    public void controlerUpdate(Connection c) throws Exception {
        try{
            BonDeCommande mere=this.getMere(c);
            if(mere.getEtat()>=ConstanteEtat.getEtatValider()) throw new Exception("Modification impossible, BC déjà visé");
        }catch(Exception e){
            throw e;
        }
    }
     public double getValeurTaux(Connection c, String nomTable, Date date) throws Exception {
        String awhere = " and daty = (SELECT max(daty) FROM " + nomTable + " WHERE  daty <= to_date('" + Utilitaire.datetostring(date) + "', 'dd/mm/yyyy') and iddevise = '" + this.getDevise() + "') "
                + " and iddevise = '" + this.getDevise() + "'";
        Coursdevise cours = new Coursdevise();
        cours.setNomTable(nomTable);
        Coursdevise[] cd = (Coursdevise[]) CGenUtil.rechercher(cours, null, null, c, awhere);

        return cd != null && cd.length > 0 ? cd[0].getMontant() : 0;
    }
     
     public double getTauxRecent(Connection c) throws Exception {
        BonDeCommande mere = this.getMere(c);
        if(mere == null) throw new Exception("BC mere introuvable");
        return getValeurTaux(c, "coursdeviseNonMICTSL", mere.getDaty());
    }
}
