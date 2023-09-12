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
import java.sql.Date;
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
    private double taux,montantHTDevise;
    private double maj,red;
    private double reduction,majoration;
    private double remise;
    private double montant, montantdf, montantDFTaux,tva;
    private double qte ,pu,duree;
    
    private String idavoirfille,codeavoir, type , idfc , codefc , client, mois;
    private double mtthtva, montanttva ,montantttc;
    private Date datyavoirfc;
    private int annee;

    public String getMois() {
        return mois;
    }

    public void setMois(String mois) {
        this.mois = mois;
    }

    public int getAnnee() {
        return annee;
    }

    public void setAnnee(int annee) {
        this.annee = annee;
    }
    
    
    public String getIdavoirfille() {
        return idavoirfille;
    }

    public void setIdavoirfille(String idavoirfille) {
        this.idavoirfille = idavoirfille;
    }
    
    public String getClient() {
        return client;
    }

    public void setClient(String client) {
        this.client = client;
    }

    
    public String getCodeavoir() {
        return codeavoir;
    }

    public void setCodeavoir(String codeavoir) {
        this.codeavoir = codeavoir;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getIdfc() {
        return idfc;
    }

    public void setIdfc(String idfc) {
        this.idfc = idfc;
    }

    public String getCodefc() {
        return codefc;
    }

    public void setCodefc(String codefc) {
        this.codefc = codefc;
    }

    public double getMtthtva() {
        return mtthtva;
    }

    public void setMtthtva(double mtthtva) {
        this.mtthtva = mtthtva;
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

    public Date getDatyavoirfc() {
        return datyavoirfc;
    }

    public void setDatyavoirfc(Date datyavoirfc) {
        this.datyavoirfc = datyavoirfc;
    }
    
    public double getReduction() {
        return reduction;
    }

    public void setReduction(double reduction) {
        this.reduction = reduction;
    }

    public double getMaj() {
        return maj;
    }

    public void setMaj(double maj) {
        this.maj = maj;
    }

    

    public double getRed() {
        return red;
    }

    public void setRed(double red) {
        this.red = red;
    }
    

    public double getTaux() {
        return taux;
    }

    public void setTaux(double taux) {
        this.taux = taux;
    }

    public double getMontantHTDevise() {
        return montantHTDevise;
    }

    public void setMontantHTDevise(double montantHTDevise) {
        this.montantHTDevise = montantHTDevise;
    }
    
    public double getDuree() {
        return duree;
    }

    public void setDuree(double duree) {
        this.duree = duree;
    }
    
    public double getQte() {
        return qte;
    }

    public void setQte(double qte) {
        this.qte = qte;
    }

    public double getPu() {
        return pu;
    }

    public void setPu(double pu) {
        this.pu = pu;
    }
    

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
    
//            if (this.getMontant() > fcd.getMontant()) {
//                throw new Exception("Montant (" + this.getMontant() + ") supérieur à celui du détail! (" + fcd.getMontant() + ") ");
//            }
            
            if(fcd.getTva() < this.getTva()) throw new Exception("Tva invalide pour l`avoir");
            
            if (this.getPu()!=fcd.getPu())
                throw new Exception("PU invalide");
            if(this.getQte()>fcd.getQuantite()) throw new Exception("Quantité invalide");
            if(this.getDuree()>fcd.getDuree()) throw new Exception("Duree invalide");
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

    public double getMajoration() {
        return majoration;
    }

    public void setMajoration(double majoration) {
        this.majoration = majoration;
    }

}
