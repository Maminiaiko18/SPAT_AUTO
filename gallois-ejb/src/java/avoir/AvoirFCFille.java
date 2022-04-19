/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package avoir;

import bean.CGenUtil;
import bean.ClassFille;
import bean.ClassMAPTable;
import facture.FactureClient;
import java.sql.Connection;
import utilitaire.ConstanteEtat;
import facture.FactureClientDetails;
import factureclient.FactureClientDetail;
import java.text.DecimalFormat;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author
 */
public class AvoirFCFille extends ClassFille {

    private String id;
    private String idmere, compte, iddetailfacture, devise, designation;
    private double remise;
    private double montant, montantdf, montantDFTaux,tva;

    public FactureClient getFacture(Connection c) throws Exception {
        FactureClient fc = new FactureClient();
        fc.setNomTable("AVOIRFC_FACTURE");
        FactureClient[] tFact = (FactureClient[]) CGenUtil.rechercher(fc, null, null, c, " and idavoir = '" + this.getIdmere() + "'");

        if (tFact != null && tFact.length > 0) {
            return tFact[0];
        }

        return null;
    }

    public AvoirFCFille(String id, double montant, double montantdf, double montantDFTaux, String idmere, String compte, String iddetailfacture, String devise, String designation, double remise) {
        this.id = id;
        this.montant = montant;
        this.montantdf = montantdf;
        this.montantDFTaux = montantDFTaux;
        this.idmere = idmere;
        this.compte = compte;
        this.iddetailfacture = iddetailfacture;
        this.devise = devise;
        this.designation = designation;
        this.remise = remise;
    }

    public double getTva() {
        return tva;
    }

    public void setTva(double tva) {
        this.tva = tva;
    }
    
    public double getRemise() {
        return remise;
    }

    public void setRemise(double remise) {
        this.remise = remise;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getDevise() {
        return devise;
    }

    public void setDevise(String devise) {
        this.devise = devise;
    }

    public double getMontantDFTaux() {
        return montantDFTaux;
    }

    public void setMontantDFTaux(double montantDFTaux) {
        this.montantDFTaux = montantDFTaux;
    }

    @Override
    public void controlerUpdate(Connection c) throws Exception {
        controlQte(c);
        super.controlerUpdate(c);
    }

    @Override
    public void controler(Connection c) throws Exception {
        FactureClient fc = getFacture(c);

        if (fc != null) {
            if (fc.getEtat() < ConstanteEtat.getEtatValider()) {
                throw new Exception("Facture non visée");
            }
        }
        
        controlQte(c);

        super.controler(c);
    }
    
    public void controlQte(Connection c) throws Exception {
        if (this.getIddetailfacture() != null) {
            FactureClientDetails fcd = getFactureClientDetail(c);
            if(fcd == null) throw new Exception("Aucune facture details lies au details de l'avoir!" + this.getId());
    
            if (this.getRemise() > 0) {
                if(fcd.getTaux()==0) throw new Exception("Taux=0");
                setMontant(Utilitaire.stringToDouble((new DecimalFormat("###.###")).format(((fcd.getMontant()/fcd.getTaux()) * this.getRemise()) / 100)));
                setTva(fcd.getTva());
            }
    
            if (this.getMontant() > fcd.getMontant()) {
                throw new Exception("Montant (" + this.getMontant() + ") supérieur à celui du détail! (" + fcd.getMontant() + ") ");
            }
            
            if(fcd.getTva() != this.getTva()) throw new Exception("Tva invalide pour l`avoir");
        }
    }

    public AvoirFCFille() throws Exception {
        setNomTable("avoirFCfille");
        this.setNomClasseMere("avoir.AvoirFC");
        this.setLiaisonMere("idmere");
    }

    @Override
    public String getLiaisonMere() {
        return "idmere";
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("AVRFCF", "get_seqavoirFCfille");
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

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) throws Exception {
//        if (this.getMode().equalsIgnoreCase("modif")) {
//            if(montant < 0) throw new Exception("Montant negatif");
//        }
        this.montant = montant;
    }

    public String getIdmere() {
        return idmere;
    }

    public void setIdmere(String idmere) {
        this.idmere = idmere;
    }

    public String getCompte() {
        return compte;
    }

    public void setCompte(String compte) {
        this.compte = compte;
    }

    public String getIddetailfacture() {
        return iddetailfacture;
    }

    public void setIddetailfacture(String iddetailfacture) {
        this.iddetailfacture = iddetailfacture;
    }

    public double getMontantdf() {
        return montantdf;
    }

    public void setMontantdf(double montantdf) {
        this.montantdf = montantdf;
    }

    public FactureClientDetails getFactureClientDetail(Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            FactureClientDetails fc = new FactureClientDetails();
            fc.setNomTable("FCFILLECOMPLET");
            String awhere = String.format(" and id = '%s' ", this.getIddetailfacture());
            FactureClientDetails[] result = (FactureClientDetails[]) CGenUtil.rechercher(fc, null, null, c, awhere);
            this.setNomClasseMere("avoir.AvoirFC");
            if (result != null && result.length > 0) {
                return result[0];
            }
            
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
        
        return null;
    }

}
