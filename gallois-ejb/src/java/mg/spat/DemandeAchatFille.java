/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author Nouta
 */
public class DemandeAchatFille extends ClassMAPTable {
    private String id,idmere,produit,designation,unite, produitlib, unitelib;
    private double qte,pu,montant;

    public DemandeAchatFille() {
        super.setNomTable("dem_achat_fille");
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

    public void setIdmere(String idmere) throws Exception {
        this.idmere = idmere;
    }

    public String getProduit() {
        return produit;
    }

    public void setProduit(String produit) {
        this.produit = produit;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) throws Exception {
        if(this.getMode().compareToIgnoreCase("modif")==0&&(designation==null || designation.compareTo("")==0 )) throw new Exception("designation obligatoire");
        this.designation = designation;
    }

    public String getUnite() {
        return unite;
    }

    public void setUnite(String unite) throws Exception {
        if(this.getMode().compareToIgnoreCase("modif")==0&&(unite==null || unite.compareTo("")==0 )) throw new Exception("unite obligatoire");
        this.unite = unite;
    }

    public double getQte() {
        return qte;
    }

    public void setQte(double qte) throws Exception {
        if(this.getMode().compareToIgnoreCase("modif")==0&&qte<=0) throw new Exception("Quantite invalide");
        this.qte = qte;
    }

    public double getPu() {
        return pu;
    }

    public void setPu(double pu) throws Exception {
        if(this.getMode().compareToIgnoreCase("modif")==0&&pu<=0) throw new Exception("Pu invalide");
        this.pu = pu;
    }

    public String getProduitlib() {
        return produitlib;
    }

    public void setProduitlib(String produitlib) {
        this.produitlib = produitlib;
    }

    public String getUnitelib() {
        return unitelib;
    }

    public void setUnitelib(String unitelib) {
        this.unitelib = unitelib;
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
    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("CR","getseq_dem_achat_fille");
        setId(makePK(c));
    }
    
    
}
