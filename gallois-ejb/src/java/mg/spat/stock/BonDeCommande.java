/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.stock;

import bean.CGenUtil;
import bean.ClassEtat;
import bean.ClassFille;
import bean.ClassMAPTable;
import static bean.ClassMere.getNomClasseFille;
import facture.FactureFournisseur;
import facture.FactureFournisseurDetails;
import lignecredit.LigneCredit;

import java.sql.Connection;
import java.sql.Date;
import mg.spat.Engagement;
import mg.spat.EngagementFille;
import utilitaire.Constante;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author BICI
 */
public class BonDeCommande extends ClassEtat {

    private String id, designation, modepaiement, fournisseur, idDa, idDalib;
    private Date daty;
    private int tva, delaipaiement;
    String remarque;
    private String nomfournisseur, numbc;
    private double montant, montanttva, montantTTC, montant_A_payer, montant_paye_reel, restepayergeneral, resteapayerreel, montantfacture;
    private String projet, code_etab, etatlib;
    private String projet_lib, code_etab_lib, fournisseur_lib, modepaiement_lib;
    private String adresse;
    private double remise, montantRemise, montantHTSansRemise;
    private String idengagement, idengagementlib, code_etablib;

    public String getCode_etablib() {
        return code_etablib;
    }

    public void setCode_etablib(String code_etablib) {
        this.code_etablib = code_etablib;
    }

    public double getMontantHTSansRemise() {
        return montantHTSansRemise;
    }

    public void setMontantHTSansRemise(double montantHTSansRemise) {
        this.montantHTSansRemise = montantHTSansRemise;
    }

    public String getIdDa() {
        return this.idDa;
    }

    public void setIdDa(String idDa) {
        this.idDa = idDa;
    }

    public String getIdDalib() {
        return this.idDalib;
    }

    public void setIdDalib(String idDalib) {
        this.idDalib = idDalib;
    }

    public String getIdengagement() {
        return idengagement;
    }

    public void setIdengagement(String idengagement) {
        this.idengagement = idengagement;
    }

    public String getIdengagementlib() {
        return idengagementlib;
    }

    public void setIdengagementlib(String idengagementlib) {
        this.idengagementlib = idengagementlib;
    }

    public double getMontantRemise() {
        return montantRemise;
    }

    public void setMontantRemise(double montantRemise) {
        this.montantRemise = montantRemise;
    }
    private String delailivraison;
    private String typepaiement;
    private String fournisseurlibelle, projetlibelle, code_etablibelle;

    public String getFournisseurlibelle() {
        return fournisseurlibelle;
    }

    public void setFournisseurlibelle(String fournisseurlibelle) {
        this.fournisseurlibelle = fournisseurlibelle;
    }

    public String getProjetlibelle() {
        return projetlibelle;
    }

    public void setProjetlibelle(String projetlibelle) {
        this.projetlibelle = projetlibelle;
    }

    public String getCode_etablibelle() {
        return code_etablibelle;
    }

    public void setCode_etablibelle(String code_etablibelle) {
        this.code_etablibelle = code_etablibelle;
    }

    public String getDelailivraison() {
        return delailivraison;
    }

    public void setDelailivraison(String delailivraison) {
        this.delailivraison = delailivraison;
    }

    public String getTypepaiement() {
        return typepaiement;
    }

    public void setTypepaiement(String typepaiement) {
        this.typepaiement = typepaiement;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public double getRemise() {
        return remise;
    }

    public void setRemise(double remise) {
        this.remise = remise;
    }

    public int getDelaipaiement() {
        return delaipaiement;
    }

    public void setDelaipaiement(int delaipaiement) {
        this.delaipaiement = delaipaiement;
    }

    public String getNomfournisseur() {
        return nomfournisseur;
    }

    public void setNomfournisseur(String nomfournisseur) {
        this.nomfournisseur = nomfournisseur;
    }

    public BonDeCommande() {
        this.setNomTable("as_bondecommande");
    }

    public void construirePK(Connection c) throws Exception {
        this.preparePk("BC", "GETSEQAS_BONDECOMMANDE");
        this.setId(makePK(c));
    }

    public String getNumbc() {
        return numbc;
    }

    public void setNumbc(String numbc) {
        this.numbc = numbc;
    }

    public String getProjet_lib() {
        return projet_lib;
    }

    public void setProjet_lib(String projet_lib) {
        this.projet_lib = projet_lib;
    }

    public String getCode_etab_lib() {
        return code_etab_lib;
    }

    public void setCode_etab_lib(String code_etab_lib) {
        this.code_etab_lib = code_etab_lib;
    }

    public String getFournisseur_lib() {
        return fournisseur_lib;
    }

    public void setFournisseur_lib(String fournisseur_lib) {
        this.fournisseur_lib = fournisseur_lib;
    }

    public String getModepaiement_lib() {
        return modepaiement_lib;
    }

    public void setModepaiement_lib(String modepaiement_lib) {
        this.modepaiement_lib = modepaiement_lib;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getModepaiement() {
        return modepaiement;
    }

    public void setModepaiement(String modepaiement) {
        this.modepaiement = modepaiement;
    }

    public String getFournisseur() {
        return fournisseur;
    }

    public void setFournisseur(String fournisseur) {
        this.fournisseur = fournisseur;
    }

    public int getTva() {
        return tva;
    }

    public void setTva(int tva) {
        this.tva = tva;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public void setMontantTTC(double a) {
        this.montantTTC = a;
    }

    public double getMontantTTC() {
        return montantTTC;
    }
//    public double getMontantTTC() throws Exception {
//        BonDeCommandeFille p = new BonDeCommandeFille();
//        p.setNomTable("as_bondecommande_fille_libelle"); // vue
//        BonDeCommandeFille[] liste = (BonDeCommandeFille[]) CGenUtil.rechercher(p, null, null, " and idbc = '" + this.getId() + "'");
//        double total = 0.0;
//        for (int i = 0; i < liste.length; i++) {
//            total += liste[i].getQuantite() * liste[i].getPu();
//        }
//        double tva = (total * this.getTva()) / 100;
//        total += tva;
//        return total;
//    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public double getMontanttva() {
        return montanttva;
    }

    public void setMontanttva(double montanttva) {
        this.montanttva = montanttva;
    }

    public double getMontant_A_payer() {
        return montant_A_payer;
    }

    public void setMontant_A_payer(double montant_A_payer) {
        this.montant_A_payer = montant_A_payer;
    }

    public double getMontant_paye_reel() {
        return montant_paye_reel;
    }

    public void setMontant_paye_reel(double montant_paye_reel) {
        this.montant_paye_reel = montant_paye_reel;
    }

    public double getRestepayergeneral() {
        return restepayergeneral;
    }

    public void setRestepayergeneral(double reste_a_payer_globale) {
        this.restepayergeneral = reste_a_payer_globale;
    }

    public double getResteapayerreel() {
        return resteapayerreel;
    }

    public void setResteapayerreel(double reste_a_payer_reelle) {
        this.resteapayerreel = reste_a_payer_reelle;
    }

    public String getProjet() {
        return projet;
    }

    public void setProjet(String projet) {
        this.projet = projet;
    }

    public String getCode_etab() {
        return code_etab;
    }

    public void setCode_etab(String code_etab) {
        this.code_etab = code_etab;
    }

    public double getMontantfacture() {
        return montantfacture;
    }

    public void setMontantfacture(double montantfacture) {
        this.montantfacture = montantfacture;
    }

    public String getEtatlib() {
        return etatlib;
    }

    public void setEtatlib(String etatlib) {
        this.etatlib = etatlib;
    }

    public static String getSequence() throws Exception {
        try {
            return String.valueOf(Utilitaire.getMaxSeq("get_seqbccommande"));
        } catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
        }
    }

    public static String getNumBCDefaut() throws Exception {
        try {
            String temporaire = "";
            temporaire += String.valueOf(Utilitaire.getMaxSeq("get_seqbccommande"));
            temporaire += Constante.bc;
            temporaire += Utilitaire.getAnneeEnCours();
            return temporaire;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
        }
    }

    @Override
    public ClassMAPTable createObject(String u, Connection c) throws Exception {
        setIduser(u);
        return super.createObject(u, c); //To change body of generated methods, choose Tools | Templates.
    }

    public boolean canBeCanceled(Connection c) throws Exception {
        boolean check = false, value = true;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                check = true;
            }
            if (this.getEtat() == ConstanteEtat.getEtatAnnuler()) {
                value = false;
            }
            BonDeLivraison bl = new BonDeLivraison();
            bl.setId_bc(this.id);
            Object[] values = CGenUtil.rechercher(bl, null, null, c, "");
            value = values.length == 0;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (check && c != null) {
                c.close();
            }
        }
        return value;
    }

    public String annulerRemplacer(String user) throws Exception {
        Connection c = null;
        BonDeCommande value = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);

            if (!this.canBeCanceled(c)) {
                throw new Exception("Ce bon de commande ne peut être annulé");
            }

            setMode("modif");
            this.setEtat(ConstanteEtat.getEtatAnnuler());
            this.updateToTableWithHisto(user, c);
            this.setEtat(ConstanteEtat.getEtatCreer());

            value = (BonDeCommande) this.dupliquer(user, c);
            value = (BonDeCommande) value.createObject(user, c);

            BonDeCommandeFille bcFille = new BonDeCommandeFille();
            bcFille.setIdbc(this.id);
            ClassMAPTable[] filles = (ClassMAPTable[]) CGenUtil.rechercher(bcFille, null, null, c, "");
            BonDeCommandeFille[] fillesClone = new BonDeCommandeFille[filles.length];

            for (int i = 0; i < filles.length; i++) {
                fillesClone[i] = (BonDeCommandeFille) filles[i].dupliquer(user, c);
                fillesClone[i].setIdbc(value.getId());
                fillesClone[i].createObject(user, c);
            }
        } catch (Exception ex) {
            if (c != null) {
                c.rollback();
            }
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null) {
                c.close();
            }
        }
        return value.getId();
    }

    public BonDeLivraison[] getBLRattaches(Connection c, String nomTable) throws Exception {
        int verif = 0;
        BonDeLivraison[] result = null;
        try {
            if (c == null) {
                verif = 1;
                c = new UtilDB().GetConn();
            }
            BonDeLivraison bl = new BonDeLivraison();
            bl.setNomTable(nomTable);
            bl.setId_bc(this.getId());
            result = (BonDeLivraison[]) CGenUtil.rechercher(bl, null, null, c, "");
        } catch (Exception ex) {
            throw ex;
        } finally {
            if (verif == 1 && c != null) {
                c.close();
            }
        }
        return result;
    }

    @Override
    public void controleAnnulerVisa(Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                verif = 1;
                c = new UtilDB().GetConn();
            }
            BonDeLivraison bl = new BonDeLivraison();
            BonDeLivraison[] blRattache = getBLRattaches(c, bl.getNomTable());
            if (blRattache.length != 0) {
                throw new Exception("Annulation VISA non permise, BL rattaché existant");
            }
        } catch (Exception ex) {
            throw ex;
        } finally {
            if (verif == 1 && c != null) {
                c.close();
            }
        }
    }
     
    public Engagement getEngagement() throws Exception {
        Engagement retour = new Engagement(this.getNumbc(), this.getCode_etab() , this.getProjet(), this.getMontant(), 0.0, 0.0, 0.0, null, null, this.getDaty());
        return retour;
    }
    
    @Override
    public Object validerObject(String u, Connection c) throws Exception {
        LigneCredit lc=this.getBudget(c);
        if(lc==null)throw new Exception("Budget non trouvé");

        if(this.getIdengagement() == null || this.getIdengagement().isEmpty()){
            BonDeCommande bc = (BonDeCommande)new BonDeCommande().getById(this.getId(), "AS_BONDECOMMANDE_LIB_fiche", c);
            this.setMontant(bc.getMontant());
            this.insertEngagement(u,c);
            this.updateToTableWithHisto(u, c);
           }this.setNomTable("as_bondecommande");
        super.validerObject(u, c);
        return this;
    }
    
    public void insertEngagement(String u, Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }

            Engagement engagement = this.getEngagement();
            engagement.construirePK(c);
            engagement.insertToTableWithHisto(u, c);
            
            BonDeCommandeFille bcFille = new BonDeCommandeFille();
            bcFille.setIdbc(this.id);
            BonDeCommandeFille[] filles = (BonDeCommandeFille[]) CGenUtil.rechercher(bcFille, null, null, c, "");
            
            for (int i = 0; i < filles.length; i++) {
                EngagementFille engFille = filles[i].createEngagementFille(engagement.getTuppleID());
                engFille.construirePK(c);
                engFille.insertToTableWithHisto(u, c);
            }

            engagement.validerObject(u, c);

            this.setIdengagement(engagement.getTuppleID());

            if (c != null && verif == 1) {
                c.commit();
            }
        } catch (Exception e) {
            if (c != null && verif == 1) {
                c.rollback();
            }
            e.printStackTrace();
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    
    public LigneCredit getBudget(Connection c)throws Exception{
        int verif=0;
        LigneCredit retour=null;
        try{
            if(c==null){
                c=new UtilDB().GetConn();
                verif=1;
            }
            LigneCredit lc=new LigneCredit();
            lc.setNomTable("SITUATIONLCDEPENSEGRP");
            lc.setIdcodeEtablissement(this.getCode_etab());
            lc.setIdprojet(this.getProjet());
            LigneCredit[] ligneCredits = (LigneCredit[]) CGenUtil.rechercher(lc, null, null, c, " and annee="+Utilitaire.getAnnee(this.getDaty()));
            if(ligneCredits.length>0)retour=ligneCredits[0];   
        }catch(Exception e){
            e.printStackTrace();
            throw e;
        }finally{
            if(c!=null && verif==1)c.close();
        }
        return retour;
    }
}
