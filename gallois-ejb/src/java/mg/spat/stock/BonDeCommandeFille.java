package mg.spat.stock;

import bean.CGenUtil;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import mg.allosakafo.produits.LiaisonDetailsBCProduit;
import mg.allosakafo.produits.Produits;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;

/**
 *
 * @author BICI
 */
public class BonDeCommandeFille extends ClassMAPTable {

    private String id, produit, idbc, remarque,unite;
    private double quantiteparpack, quantite,montantbl,montantblreste ;
    private double pu, montant, quantitelivre, quantitereste, tva;
    private String produitlib;
    private double montantht,montanttva,montantttc,remise;

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
                LiaisonDetailsBCProduit liaison = new LiaisonDetailsBCProduit(this.getId(), this.getProduit());
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
}
