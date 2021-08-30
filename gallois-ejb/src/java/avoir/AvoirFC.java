/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package avoir;


import bean.CGenUtil;
import bean.ClassEtat;
import bean.ClassMere;
import bean.TypeObjet;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.Utilitaire;


/**
 *
 * @author
 */
public class AvoirFC extends ClassMere {
    
    private String id;
    private Date daty;
    private String idfacture, designationFacture,tiers,tierslib;
    private double montant, montantpaye,montantreste;    
    private String designation;
    private String code;
    private String categorie;


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

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public double getMontantpaye() {
        return montantpaye;
    }

    public void setMontantpaye(double montantpaye) {
        this.montantpaye = montantpaye;
    }

    public double getMontantreste() {
        return montantreste;
    }

    public void setMontantreste(double montantreste) {
        this.montantreste = montantreste;
    }


    public String getDesignationFacture() {
        return designationFacture;
    }

    public void setDesignationFacture(String designationFacture) {
        this.designationFacture = designationFacture;
    }

        public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getCategorie() {
        return categorie;
    }

    public void setCategorie(String categorie) {
        this.categorie = categorie;
    }
    
    public AvoirFC() throws Exception {
        setNomTable("AvoirFC");
        this.setLiaisonFille("idmere");
        this.setNomClasseFille("avoir.AvoirFCFille");
    }
    public AvoirFC(String id, Date daty, String idfacture, String designationFacture, String tiers, String tierslib, double montant, double montantpaye, double montantreste) {
        setNomTable("AvoirFC");        
        this.id = id;
        this.daty = daty;
        this.idfacture = idfacture;
        this.designationFacture = designationFacture;
        this.tiers = tiers;
        this.tierslib = tierslib;
        this.montant = montant;
        this.montantpaye = montantpaye;
        this.montantreste = montantreste;
    }    
    
    public AvoirFC(String id, Date daty, String idfacture, String designationFacture, String tiers, String tierslib, double montant, double montantpaye, double montantreste, String designation, String code, String categorie) {
        setNomTable("AvoirFC"); 
        this.id = id;
        this.daty = daty;
        this.idfacture = idfacture;
        this.designationFacture = designationFacture;
        this.tiers = tiers;
        this.tierslib = tierslib;
        this.montant = montant;
        this.montantpaye = montantpaye;
        this.montantreste = montantreste;
        this.designation = designation;
        this.code = code;
        this.categorie = categorie;
    }
    
    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("AVRFC", "get_seqAvoirFC");
        setId(makePK(c));
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
    
    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }
    
    public String getIdfacture() {
        return idfacture;
    }

    public void setIdfacture(String idfacture) {
        this.idfacture = idfacture;
    }
    
    public String genererSequence(Connection c, String nomtable, int longueur) throws Exception {
        String requete = "SELECT  * FROM %s";
        requete = String.format(requete, nomtable);

//        System.out.println("requete " + requete);
        TypeObjet obj = new TypeObjet();
        obj.setNomTable(nomtable);
        TypeObjet[] seq = (TypeObjet[]) CGenUtil.rechercher(obj, requete, c);

        String sequence = "";
        if (seq != null && seq.length > 0) {
            sequence = seq[0].getVal();
        }

        return Utilitaire.completerInt(longueur, sequence);
    }    
}
