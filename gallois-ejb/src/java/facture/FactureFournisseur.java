/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.AdminGen;
import bean.CGenUtil;
import bean.ClassMAPTable;
import bean.TypeObjet;
import bean.ValidationException;
import bordereau.BordereauFilleFF;
import ded.OrdonnerPayement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import lignecredit.LigneCredit;
import mg.allosakafo.produits.LiaisonIntraTable;
import mg.spat.Engagement;
import mg.spat.EngagementFille;
import mg.spat.JournalCaisse;
import mg.spat.stock.BonDeCommande;
import mg.spat.stock.BonDeLivraison;
import mg.spat.stock.BonDeLivraisonFilleReste;
import user.UserEJB;
import utilitaire.Constante;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author rijan
 */
public class FactureFournisseur extends FactureClient {

    private String numeroop, projet, code_etablissement, projetlib, code_etablissementlib, nature, naturelib, idbc, numOP;
    private int exercice;
    private String idengagement, idengagementlib;
    private String id2;
    private String codeEtablissement;
    private Date dateRegul;
    private double montantHTSansRemise;
    private String bonprovisoire, num;
    private String idom;
    private String numfsb;


    public String getNumfsb() {
        return numfsb;
    }

    public void setNumfsb(String numfsb) {
        this.numfsb = numfsb;
    }

    public String getIdom() {
        return idom;
    }

    public void setIdom(String idom) {
        this.idom = idom;
    }
    private String idbordereau, numBordereau;
    private String idrefpmt,valcaisserefpmt,numpiecerefpmt,numchequerefpmt,libellerefpmt;
    private Date dateeffetrefpmt;
    private double debitrefpmt;
    private Date dateFacture;
    private String numBc, numBed;
    private String modepaiement;
    private String typeEngagement;
    private boolean apresValidationException;
    private Date datedevise;
    private String modepaiementlib;
    private String chantier, idtravaux;

    public Date getDatedevise() {
        return datedevise;
    }

    public void setDatedevise(Date datedevise) {
        this.datedevise = datedevise;
    }

    public String getModepaiement() {
		return this.modepaiement;
	}

	public void setModepaiement(String modepaiement) {
		this.modepaiement = modepaiement;
	}


    public Date getDateFacture() {
        return dateFacture;
    }

    public void setDateFacture(Date dateFacture) {
        this.dateFacture = dateFacture;
    }

    public String getNumBc() {
        return numBc;
    }

    public void setNumBc(String numBc) {
        this.numBc = numBc;
    }

    public String getNumBed() {
        return numBed;
    }

    public void setNumBed(String numBed) {
        this.numBed = numBed;
    }
    
    
    public String getIdrefpmt() {
        return idrefpmt;
    }

    public void setIdrefpmt(String idrefpmt) {
        this.idrefpmt = idrefpmt;
    }

    public String getValcaisserefpmt() {
        return valcaisserefpmt;
    }

    public void setValcaisserefpmt(String valcaisserefpmt) {
        this.valcaisserefpmt = valcaisserefpmt;
    }

    public String getNumpiecerefpmt() {
        return numpiecerefpmt;
    }

    public void setNumpiecerefpmt(String numpiecerefpmt) {
        this.numpiecerefpmt = numpiecerefpmt;
    }

    public String getNumchequerefpmt() {
        return numchequerefpmt;
    }

    public void setNumchequerefpmt(String numchequerefpmt) {
        this.numchequerefpmt = numchequerefpmt;
    }

    public String getLibellerefpmt() {
        return libellerefpmt;
    }

    public void setLibellerefpmt(String libellerefpmt) {
        this.libellerefpmt = libellerefpmt;
    }

    public Date getDateeffetrefpmt() {
        return dateeffetrefpmt;
    }

    public void setDateeffetrefpmt(Date dateeffetrefpmt) {
        this.dateeffetrefpmt = dateeffetrefpmt;
    }

    public double getDebitrefpmt() {
        return debitrefpmt;
    }

    public void setDebitrefpmt(double debitrefpmt) {
        this.debitrefpmt = debitrefpmt;
    }
    
    public String getIdbordereau() {
        return idbordereau;
    }

    public void setIdbordereau(String idbordereau) {
        this.idbordereau = idbordereau;
    }

    public String getNumBordereau() {
        return numBordereau;
    }

    public void setNumBordereau(String numBordereau) {
        this.numBordereau = numBordereau;
    }
    
    public String getNum() {
        return num;
    }

    public void setNum(String num) {
        this.num = num;
    }

    public String getBonprovisoire() {
        return bonprovisoire;
    }

    public void setBonprovisoire(String bonprovisoire) {
        this.bonprovisoire = bonprovisoire;
    }

    public double getMontantHTSansRemise() {
        return montantHTSansRemise;
    }

    public void setMontantHTSansRemise(double montantHTSansRemise) {
        this.montantHTSansRemise = montantHTSansRemise;
    }

    public Date getDateRegul() {
        return dateRegul;
    }

    public void setDateRegul(Date dateRegul) {
        this.dateRegul = dateRegul;
    }

    public String getIdengagement() {
        return idengagement;
    }

    public void setIdengagement(String idengagement) {
        this.idengagement = idengagement;
    }

    public String getCodeEtablissement() {
        return codeEtablissement;
    }

    public void setCodeEtablissement(String codeEtablissement) {
        this.codeEtablissement = codeEtablissement;
    }

    public String getIdengagementlib() {
        return idengagementlib;
    }

    public void setIdengagementlib(String idengagementlib) {
        this.idengagementlib = idengagementlib;
    }

    public String getId2() {
        return id2;
    }

    public void setId2(String id2) {
        this.id2 = id2;
    }

    public int getExercice() {
        return exercice;
    }

    public void setExercice(int exercice) {
        this.exercice = exercice;
    }

    public String getNumOP() {
        return numOP;
    }

    public void setNumOP(String numOP) {
        this.numOP = numOP;
    }

    public String getNaturelib() {
        return naturelib;
    }

    public void setNaturelib(String naturelib) {
        this.naturelib = naturelib;
    }

    public String getNumeroop() {
        return numeroop;
    }

    public void setNumeroop(String numeroop) {
        this.numeroop = numeroop;
    }

    public String getProjet() {
        return projet;
    }

    public String getNature() {
        return nature;
    }

    public void setNature(String nature) {
        this.nature = nature;
    }

    public void setProjet(String projet) {
        this.projet = projet;
    }

    public String getCode_etablissement() {
        return code_etablissement;
    }

    public void setCode_etablissement(String code_etablissement) {
        this.code_etablissement = code_etablissement;
    }

    public String getProjetlib() {
        return projetlib;
    }

    public void setProjetlib(String projetlib) {
        this.projetlib = projetlib;
    }

    public String getCode_etablissementlib() {
        return code_etablissementlib;
    }

    public void setCode_etablissementlib(String code_etablissementlib) {
        this.code_etablissementlib = code_etablissementlib;
    }

    public String getIdbc() {
        return idbc;
    }

    public void setIdbc(String idbc) {
        this.idbc = idbc;
    }
    public String getTypeEngagement() {
        return typeEngagement;
    }

    public void setTypeEngagement(String typeEngagement) {
        this.typeEngagement = typeEngagement;
    }

    public boolean getApresValidationException() {
        return apresValidationException;
    }

    public void setApresValidationException(boolean apresValidationException) {
        this.apresValidationException = apresValidationException;
    }

    public String getModepaiementlib() {
        return modepaiementlib;
    }

    public void setModepaiementlib(String modepaiementlib) {
        this.modepaiementlib = modepaiementlib;
    }

    public String getChantier() {
        return chantier;
    }

    public void setChantier(String chantier) {
        this.chantier = chantier;
    }

    public String getIdtravaux() {
        return idtravaux;
    }

    public void setIdtravaux(String idtravaux) {
        this.idtravaux = idtravaux;
    }
    
    public FactureFournisseur() throws Exception {
        this.setNomTable("facture_Fournisseur_Mere");
        this.setLiaisonFille("idmere");
        this.setNomClasseFille("facture.FactureFournisseurDetails");
    }

    @Override
    public String getValColLibelle() {
        return getDesignation() + ";" + getId();
    }

    public FactureFournisseur(String id, String tiers, String designation, String type, String remarque, String iduser, String idprevision, String idcategorie, double tva, Date daty, Date dateEcheance, int etat) throws Exception {
        this.setNomTable("facture_Fournisseur_Mere");
        this.setId(id);
        this.setTiers(tiers);
        this.setDesignation(designation);
        this.setType(type);
        this.setRemarque(remarque);
        this.setIduser(iduser);
        this.setIdprevision(idprevision);
        this.setIdcategorie(idcategorie);
        this.setTva(tva);
        this.setDaty(daty);
        this.setDate_echeance(dateEcheance);
        this.setEtat(etat);
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("FAF", "get_seq_factFournMere");
        this.setId(makePK(c));
    }

    public OrdonnerPayement findOP(String nomtable, Connection c) throws SQLException, Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                verif = 1;
            }
            OrdonnerPayement oo = new OrdonnerPayement();
            if (nomtable == null) {
                nomtable = "ordonnerpayement";
            }
            oo.setNomTable(nomtable);
            //OrdonnerPayement[] results = (OrdonnerPayement[]) CGenUtil.rechercher(oo, null, null, c, " and ded_id like '%" + this.getId() + "%' and etat >= " + ConstanteEtat.getEtatValider());
            OrdonnerPayement[] results = (OrdonnerPayement[]) CGenUtil.rechercher(oo, null, null, c, " and etat=11 and ded_id like '%" + this.getId() + "%'");

            if (results != null && results.length > 0) {
                return results[0];
            }
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
        return null;
    }

    public static FactureFournisseur[] getFactures(String ids, Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            FactureFournisseur cc = new FactureFournisseur();
            cc.setNomTable("factureclientgroupvide");
            String requete = "select tiers,tierslib,cast(sum(montantreste) as NUMBER(30,3)) as montant  "
                    + " from FACTFOURN_MSUM_LIB "
                    + " where id in('" + ids.replace(";", "','") + "') "
                    + " and etat >= " + ConstanteEtat.getEtatValider()
                    + " group by tiers,tierslib";
            FactureFournisseur[] result = (FactureFournisseur[]) CGenUtil.rechercher(cc, requete, c);
            if (result != null && result.length > 0) {
                return result;
            }
            return null;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    public void recurrent(UserEJB u, Connection c, String typefrequence, int nb) throws Exception {
        boolean ouvert = false;

        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                ouvert = true;
            }

            FactureClient fc = (FactureClient) this.getById(this.getId(), this.getNomTable(), c);

            TypeObjet typeFreq = new TypeObjet();
            typeFreq.setNomTable("TYPEFREQUENCE");
            TypeObjet[] tmp = (TypeObjet[]) CGenUtil.rechercher(typeFreq, null, null, c, " and id = '" + typefrequence + "'");

            if (tmp != null && tmp.length > 0) {
                int nbJ = Utilitaire.stringToInt(tmp[0].getVal());
                Date dateRef = fc.getDaty(), dateEch = fc.getDate_echeance();
                fc.setEtat(ConstanteEtat.getEtatCreer());

                for (int i = 0; i < nb; i++) {
                    String idF = (String) u.dupliquerObject(fc, "facture.FactureClientDetails", "idmere", c);

                    dateRef = Utilitaire.ajoutJourDate(dateRef, nbJ);
                    dateEch = Utilitaire.ajoutJourDate(dateEch, nbJ);

                    fc.setId(idF);
                    fc.setDaty(dateRef);
                    fc.setDate_echeance(dateEch);

//                    System.out.println("fc " + fc.getId());
                    u.updateObject(fc, c);
                }
            }

            if (ouvert) {
                c.commit();
            }
        } catch (Exception ex) {
            if (c != null && ouvert) {
                c.rollback();
            }
            throw ex;
        } finally {
            if (c != null && ouvert) {
                c.close();
            }
        }
    }

    @Override
    public ClassMAPTable createObject(String iduser, Connection cnctn) throws Exception {
        this.setEstAncienne(1);
        this.setNomClasseFille("facture.FactureFournisseurDetails");
        this.setIduser(iduser);
        this.setId(null);
        this.setDatedevise(Utilitaire.dateDuJourSql());
        /*if (this.getIdcategorie() != null && !this.getIdcategorie().equals(Constante.idBonProvisoire)) {
            this.setCode(calculerCodeSimple(cnctn));
        }*/
        if(this.getIdBL() != null && !this.getIdBL().isEmpty() && this.getIdBL().compareToIgnoreCase("")!=0){
            BonDeLivraison bl = (BonDeLivraison) new BonDeLivraison().getById(this.getIdBL(), "AS_BONDELIVRAISON_BC", cnctn);
            if(bl.getIdengagement() != null)
                this.setIdengagement(bl.getIdengagement());

            //si FF a partir BC dia date BC no datedevise
            BonDeCommande bc = (BonDeCommande) new BonDeCommande().getById(bl.getId_bc(), "AS_BONDECOMMANDE", cnctn);
            if(bc!=null) this.setDatedevise(bc.getDaty());
        }
        if (this.getIdcategorie().compareToIgnoreCase(Constante.idBonProvisoire) == 0) {
            this.setNum(this.calculerNumeroBP(cnctn));
        }
        
        return super.createObject(iduser, cnctn);
    }

    public FactureFournisseurDetails genererFFDetails() throws Exception {
        FactureFournisseurDetails fcd = new FactureFournisseurDetails();
        fcd.setNomTable("FACTURE_FOURNISSEUR_FILLE");
        fcd.setIdmere(this.getId());
        fcd.setDesignation("bon provisoire no " + this.getCode());
        fcd.setQuantite(1);
        fcd.setPu(this.getMontant());
        fcd.setDevise(Constante.deviseAr);
        fcd.setTaux(1);
        fcd.setTva(0);
        return fcd;
    }

    public FactureFournisseur genererBP(String iduser, Connection c) throws Exception {
        boolean ouvert = false;

        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                ouvert = true;
            }
            System.out.println("Niditra tao amin'ny genererBP dans FF");
            this.setType(Constante.getTypeFCAcredit());
            this.setIdcategorie(Constante.getCategorieFFBP());
            this.setDeviseMere(Constante.deviseAr);
            super.createObject(iduser, c);

            FactureClientDetails ffd = genererFFDetails();
            ffd.createObject(iduser, c);

            if (ouvert) {
                c.commit();
            }
        } catch (Exception ex) {
            if (c != null && ouvert) {
                c.rollback();
            }
            throw ex;
        } finally {
            if (c != null && ouvert) {
                c.close();
            }
        }

        return this;
    }

    String idBL;

    public String getIdBL() {
        return idBL;
    }

    public void setIdBL(String idBL) {
        this.idBL = idBL;
    }

    public void controlerUpdate(Connection c) throws Exception {

    }

    public BonDeLivraisonFilleReste[] getBP(Connection c) throws Exception {
        return getBP(null, c);
    }

    public BonDeLivraisonFilleReste[] getBP(String BC, Connection c) throws Exception {
        boolean ouvert = false;
        BonDeLivraisonFilleReste[] livraisons = new BonDeLivraisonFilleReste[0];
        if ((this.getIdBL() == null || this.getIdBL().trim().equals("")) && (BC == null || BC.trim().equals(""))) {
            return livraisons;
        }

        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                ouvert = true;
            }

            BonDeLivraisonFilleReste bl = new BonDeLivraisonFilleReste();
            bl.setNomTable("AS_BONDELIVRAISON_FILLEQTE_RES");
            bl.setNumbl(this.getIdBL());
            bl.setIdbondecommandemere(BC);
            livraisons = (BonDeLivraisonFilleReste[]) CGenUtil.rechercher(bl, null, null, c, "");

        } catch (Exception ex) {
            throw ex;
        } finally {
            if (c != null && ouvert) {
                c.close();
            }
        }

        return livraisons;
    }

    public FactureFournisseur setIdProvision(FactureFournisseur fact2, int type, UserEJB u, Connection c) throws Exception {
        if (type == 1) {
            fact2.setIdProvision(this.getId());
        } else {
            if (this.getIdProvision() != null && !this.getIdProvision().isEmpty()) {
                throw new Exception("Impossible a generer, facture deja liee a un bon provisoire ");
            }
            this.setIdProvision(fact2.getId());
            this.updateToTableWithHisto(u.getUser().getTuppleID(), c);
        }
        return fact2;
    }

    public void controlerDefinitive(Connection c) throws Exception {
        if (this.getEtat() < ConstanteEtat.getEtatValider()) {
            throw new Exception("Bon provisoire non visee");
        }
        if (!this.getIdcategorie().equals(Constante.getCategorieFFBP())) {
            throw new Exception("Cette facture n est pas une facture de provision!");
        }
    }

    public void controlerProvision(Connection c) throws Exception {
        if (this.getEtat() < ConstanteEtat.getEtatValider()) {
            throw new Exception("Facture non visée !");
        }
    }

    public FactureFournisseur genererDefinitive(UserEJB u, int type, Connection c) throws Exception {
        int verif = 0;
        FactureFournisseur fact2 = null;

        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }

            FactureFournisseur fc = this;
            if (fc.getDaty() == null) {
                fc = (FactureFournisseur) this.getById(this.getId(), this.getNomTable(), c);
            }

            String categorie = fc.getIdcategorie();

            if(this.getIdcategorie().compareToIgnoreCase(Constante.idBonProvisoire)==0){
                FactureFournisseur ep = new FactureFournisseur();
                ep.setIdProvision(this.getId());
                FactureFournisseur[] def = (FactureFournisseur[]) CGenUtil.rechercher(ep, null, null, c, "");
                if(def.length > 0 ) throw new Exception("Ce bon provisoire comporte déjà une facture définitive");
            }

            if (type == 1) {
                if (!this.checkPaiement(c)) {
                    throw new Exception("Bon provisoire non payer. Impossible de générer facture définitive");
                }
                fc.controlerDefinitive(c);
                categorie = Constante.categorieFFdefault;
            } else {
                fc.controlerProvision(c);
                categorie = Constante.getCategorieFFBP();
            }

            fact2 = (FactureFournisseur) fc.dupliquer(u.getUser().getTuppleID(), c);
            fact2 = (FactureFournisseur) fc.setIdProvision(fact2, type, u, c);
            fact2.setIdcategorie(categorie);
            fact2.setDaty(Utilitaire.dateDuJourSql());
            fact2.calculerCode(c);
            u.updateObjectMultiple(fact2, "idmere", fact2.getFille(), c);
            if (verif == 1) {
                c.commit();
            }
        } catch (Exception e) {
            if (c != null && verif == 1) {
                c.rollback();
            }
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }

        return fact2;
    }

    public double getMontantResteProvision(Connection c) throws Exception {
        double result = 0.;
        int verify = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verify = 1;
            }
            EtatProvision ep = new EtatProvision();
            ep.setNomTable("etatbpvrai");
            ep.setId(this.getIdProvision());
            EtatProvision[] etatProv = (EtatProvision[]) CGenUtil.rechercher(ep, null, null, c, "");
            if (etatProv.length > 0) {
                result = etatProv[0].getMontantreste();
            }
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && verify == 1) {
                c.close();
            }
        }
        return result;
    }

    public double genererMontantPaiement(Connection c) throws Exception {
        boolean verif = false;
        double montant = 0;

        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = true;
            }

            montant = getMontantResteProvision(c);

            if (montant >= this.getMontantttc()) {
                montant = this.getMontantttc();
            }

        } catch (Exception ex) {
            throw ex;
        } finally {
            if (c != null && verif) {
                c.close();
            }
        }

        return montant;
    }

    public PaiementFacture[] findPaiementProvision(String idProvision, Connection c) throws Exception {
        boolean ouvert = false;
        PaiementFacture[] retour = null;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                ouvert = true;
            }
            PaiementFacture pf = new PaiementFacture();
            pf.setNomTable("paiementfacturef");
            retour = (PaiementFacture[]) CGenUtil.rechercher(pf, null, null, c, " and idFact='" + idProvision + "'");
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && ouvert) {
                c.close();
            }
        }
        return retour;
    }

    private void regulDefinitive(String u, double montant, Connection con) throws Exception {
        boolean verif = false;
        try {
            if (con == null) {
                con = new UtilDB().GetConn();
                con.setAutoCommit(false);
                verif = true;
            }
            if (this.getDateRegul() == null || this.getDateRegul().equals("")) {
                throw new Exception("Date de regul vide");
            }

            Date dateDuJour = this.getDateRegul();
            FactureFournisseur bp = (FactureFournisseur)(new FactureFournisseur()).getById(this.getIdProvision(), "factfourn_msum_lib_fiche", con);
            if(bp.getModepaiement()==null) throw new Exception("Mode de paiement Bon provisoire invalide");
            String caisseBP = "";
            if(bp.getModepaiement().compareToIgnoreCase(Constante.modePaiementEspece)==0) caisseBP = Constante.caisseCentraleBP;
            else caisseBP = Constante.banqueBP;
            JournalCaisse transfert = new JournalCaisse(null,caisseBP, null, bp.getDesignation() , null, dateDuJour, dateDuJour, bp.getMontantttc(), 0, this.getId());
            transfert.setTiers(this.getTiers());
            transfert.setIddevise(this.getDeviseMere());
            transfert.setIdmode(bp.getModepaiement());
            transfert.setEtat(ConstanteEtat.getEtatValider());
            transfert.createObject(u, con);

            OrdonnerPayement[] op = ((OrdonnerPayement[]) CGenUtil.rechercher(new OrdonnerPayement(), null, null, con, " and DED_ID = '" + this.getIdProvision() + "'"));
            if( op.length > 0 && op[0] != null){
                op[0].setDed_Id(op[0].getDed_Id()+";"+this.getId());
                op[0].updateToTable(con);

                LiaisonIntraTable liaison = new LiaisonIntraTable(this.getId(), op[0].getId(), montant);
                liaison.setCheckfacture(false);
                liaison.createObject(u, con);
            }


            if (verif) {
                con.commit();
            }
        } catch (Exception ex) {
            if (con != null && verif) {
                con.rollback();
            }
            throw ex;
        } finally {
            if (con != null && verif) {
                con.close();
            }
        }
    }

    public void genererPaiementDefinitive(String u, String idProvision, Connection c) throws Exception {
        boolean ouvert = false;
        PaiementFacture[] retour = null;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                ouvert = true;
            }

            FactureFournisseur fc = new FactureFournisseur();
            fc = (FactureFournisseur) fc.getById(this.getId(), "FACTFOURN_MSUM_LIB", c);

            double montant = fc.genererMontantPaiement(c);

            regulDefinitive(u, montant, c);

            PaiementFacture[] listeProvision = this.findPaiementProvision(idProvision, c);
            if (listeProvision != null && listeProvision.length > 0) {
                for (int i = 0; i < listeProvision.length; i++) {
                    listeProvision[i].setIdFact(this.getId());
                    listeProvision[i].setMontant(montant);
                    listeProvision[i].setId(null);
                    listeProvision[i].createObject(u, c);
                }
            }
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && ouvert) {
                c.close();
            }
        }
    }

    public String calculerNumeroBP(Connection c) throws Exception{
        String dateEffetStr = Utilitaire.datetostring(this.getDaty()) ;
        String annee = Utilitaire.getAnnee(dateEffetStr);
        String seq="";
        String rqt="SELECT nvl(max(maxidparmoisane)+1,1) AS numerosuivant FROM SEQ_BONPROVISOIRE where annee="+annee;
        NumeroFacture[] result = (NumeroFacture[])CGenUtil.rechercher(new NumeroFacture(), rqt, c);
        if(result.length>0) seq=Utilitaire.completerInt(0, result[0].getNumerosuivant());
        return seq+"/"+Utilitaire.genererAnnee(dateEffetStr);
    }

    @Override
    public Object validerObject(String u, Connection c) throws Exception {
        boolean ouvert = false;
        try{
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                ouvert = true;
            }
            BordereauFilleFF[] bedfilles = (BordereauFilleFF[]) CGenUtil.rechercher(new BordereauFilleFF(), null, null, c, " and idop = '" + this.getId() + "'");
            if(bedfilles.length > 0){
                if(this.getIdengagement()==null )throw new Exception("Veuillez attacher cet facture à l'engagement dans le BED.");
            }

            FactureFournisseur ff = (FactureFournisseur) new FactureFournisseur().getById(this.getId(), "factfourn_msum_lib", c);
            if(ff.getIdBL() != null && ff.getDeviseMere().compareToIgnoreCase(Constante.deviseAr) == 0){
                ff.controleMontant(c);
            }
            if(!this.getApresValidationException()){
                if (this.getIdcategorie().compareToIgnoreCase(Constante.idBonProvisoire) != 0 && this.getIdProvision()==null) {
                    if(ff.getNumeroop()==null) throw new Exception("Numero facture obligatoire.");
                    String sql = "select * from factfourn_msum_lib where lower(numeroop) = '" + ff.getNumeroop().toLowerCase() + "' and montant = " + ff.getMontant() + " and etat >= " + ConstanteEtat.getEtatCreer()+" and id!='"+this.getId()+"'";
                    FactureFournisseur[] doublons = (FactureFournisseur[]) CGenUtil.rechercher(new FactureFournisseur(), sql, c);
                    if(doublons.length > 0){
                        this.setApresValidationException(true);
                        throw new ValidationException("Une facture("+doublons[0].getId()+") avec le numero: " + ff.getNumeroop() + " et avec montant HT: " + Utilitaire.formaterAr(ff.getMontant()) + " existe d\\351j\\340, voulez vous viser?",String.valueOf(this.getApresValidationException()),"validerFF");
                    }
                }
            }

            this.setEstAncienne(1);
            LigneCredit lc = this.getBudget(c);
            if (lc == null) {
                throw new Exception("Budget non trouvé");
            }

            if (this.getIdcategorie() != null && this.getIdcategorie().equals(utilitaire.Constante.categorieFFdefault) && this.getIdProvision() != null) {
                this.genererPaiementDefinitive(u, this.getIdProvision(), c);
            }

            if (this.getIdcategorie().compareToIgnoreCase(Constante.idBonProvisoire) == 0 && this.getNum() == null) {
                this.setNum(this.calculerNumeroBP(c));
            }
            
            if (this.getIdcategorie().compareToIgnoreCase(Constante.idBonProvisoire) == 0 && (this.getModepaiement() == null || this.getModepaiement().compareToIgnoreCase(Constante.paiementNull) == 0)) {
                throw new Exception("Vous devez choisir un mode de paiement");
            }

            if (this.getIdengagement() != null) {
                double resteAEngager = ff.getMontant();
                BonDeCommande bc = findBCResteAFacturer(c);
                Engagement[] lies = this.getEngagementLiee(null, c);
                LiaisonEngagement liaison = new LiaisonEngagement();
                if(bc != null){
                    if(bc.getMontantreste() < ff.getMontant()){
                        resteAEngager -= bc.getMontantreste();
                        FactureFournisseur f = new FactureFournisseur();
                        f.setIdengagement(bc.getIdengagement());
                        Engagement engbc = f.findEngagement("liaisonEngagementBCFF", "idengagement", c);
                        if(engbc.getMontantreste() >= resteAEngager){
                            liaison = new LiaisonEngagement(engbc.getIdengagement(), ff.getId(), resteAEngager, ConstanteEtat.getEtatCreer());
                            liaison.createObject(u, c);
                            liaison.validerObject(u, c);
                            resteAEngager = 0;
                        }
                        else{ 
                            if(engbc.getMontantreste() > 0){
                                liaison = new LiaisonEngagement(engbc.getIdengagement(), ff.getId(), engbc.getMontantreste(), ConstanteEtat.getEtatCreer());
                                liaison.createObject(u, c);
                                liaison.validerObject(u, c);
                                resteAEngager -= engbc.getMontantreste();
                            }
                            resteAEngager = traiterEngagementLiee(resteAEngager, lies, u, c);
                        }
                    }
                    else{
                        resteAEngager = 0;
                    }
                }
                else{
                    String requete = "select * from liaisonengagement where id1 = '" + this.getIdengagement() + "' and id2 = '" + this.getId() + "' and etat = " + ConstanteEtat.getEtatValider();
                    LiaisonEngagement[] liaisonengff = (LiaisonEngagement[]) CGenUtil.rechercher(new LiaisonEngagement(), requete, c);
                    String id = null;
                    if(liaisonengff.length == 0){
                        Engagement engff = this.findEngagement("engagementlib", "id", c);
                        if(engff != null && engff.getMontant() > 0){
                            double m = (resteAEngager <= engff.getMontantreste()) ? resteAEngager : engff.getMontantreste();
                            liaison = new LiaisonEngagement(this.getIdengagement(), this.getId(), m, ConstanteEtat.getEtatCreer());
                            liaison.createObject(u, c);
                            liaison.validerObject(u, c);
                            resteAEngager -= m;
                            id = this.getIdengagement();
                            lies = this.getEngagementLiee(id, c);
                        }
                    }
                    resteAEngager = traiterEngagementLiee(resteAEngager, lies, u, c);
                }
                if(resteAEngager > 0){
                    throw new ValidationException("Le montant de la facture depasse le reste de l'engagement. En cliquant sur Ok, un nouvel engagement sera créé.",null,"validerFF");
                }
            } else {
                if (this.getIdbc() == null) {
                    this.setMontant(ff.getMontant());
                    //si provision dia tsy engagena
                    if(this.getIdcategorie().compareToIgnoreCase(Constante.idBonProvisoire)!=0){
                        this.setTypeEngagement(Constante.typeEngagementFF);
                        this.insertEngagement(u, true, c);
                        LiaisonEngagement liaison = new LiaisonEngagement(this.getIdengagement(), ff.getId(), ff.getMontant(), ConstanteEtat.getEtatCreer());
                        liaison.createObject(u, c);
                        liaison.validerObject(u, c);
                    }
                }
            }
            this.setNomTable("facture_fournisseur_mere");
            if(this.getIdProvision()==null){
                this.verifyOPmtt(u,c);
            }

            super.validerObject(u, c);
            
            if(c != null && ouvert) {
                c.commit();
            }
        }
        catch (Exception ex) {
            if (c != null && ouvert) {
                c.rollback();
            }
            throw ex;
        } finally {
            if (c != null && ouvert) {
                c.close();
            }
        }
        return this;
    }


    public void verifyOPmtt(String u,Connection c) throws Exception{
        try{
            LiaisonIntraTable lt = new LiaisonIntraTable();
            lt.setNomTable("LIAISONINTRATABLE");
            LiaisonIntraTable[] liaisonsop = (LiaisonIntraTable[]) CGenUtil.rechercher(lt, null, null, c, "and id1='" + this.getId()+"'");
            if(liaisonsop.length > 0){
                OrdonnerPayement op = (OrdonnerPayement) (new OrdonnerPayement()).getById(liaisonsop[0].getId2(), "OrdonnerPayement", c); 
                LiaisonIntraTable[] liaisons = (LiaisonIntraTable[]) CGenUtil.rechercher(lt, null, null, c, "and id2='" + op.getId()+"'"); 
                String where = "";
                int t = liaisons.length;
                boolean debut = true;
                if(t > 0){
                    where += " and id in (";
                    for(int i = 0; i < t; i++){
                        if(debut)
                            where += "'" + liaisons[i].getId1() + "'";
                        else
                            where += ",'" + liaisons[i].getId1() + "'";
                        debut = false;
                    }
                    where += ")";
                    FactureFournisseur fact = new FactureFournisseur();
                    fact.setNomTable("factfourn_msum_lib_fiche");
                    FactureFournisseur[] ffs = (FactureFournisseur[]) CGenUtil.rechercher(fact, null, null, c, where);
                    double montant = AdminGen.calculSommeDouble(ffs, "montantttc");
                    this.controlerLiaisonOP(ffs,liaisons,c,u);            
                    if(montant != op.getMontant()){
                        op.setMontant(montant);
                        op.updateToTableWithHisto(u,c);
                    }
                }            
            }
        }catch(Exception e){
            throw e;
        }
    }

    public void controlerLiaisonOP(FactureFournisseur[] ffs,LiaisonIntraTable[] liaisons,Connection c,String u) throws Exception{
        System.out.println("controle liaison intratable");
        for(FactureFournisseur ff : ffs){
            for(LiaisonIntraTable l : liaisons){
                if(l.getId1().compareToIgnoreCase(ff.getId())==0){
                    if(l.getMontant()!=ff.getMontantttc()){
                        l.setMontant(ff.getMontantttc());
                        l.updateToTableWithHisto(u,c);
                    }
                
                }
            }
        }
    }

    public Object validerSansControleResteEngagement(String u, boolean controleMontant, Connection c) throws Exception {
        int verif=0;
        try{
            if(c==null){
                c=new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif=1;
            }
            this.setEstAncienne(1);
            LigneCredit lc = this.getBudget(c);
            if (lc == null) {
                throw new Exception("Budget non trouvé");
            }

            if (this.getIdcategorie() != null && this.getIdcategorie().equals(utilitaire.Constante.categorieFFdefault) && this.getIdProvision() != null) {
                this.genererPaiementDefinitive(u, this.getIdProvision(), c);
            }

            if (this.getIdengagement() == null && this.getIdbc() == null) {
                FactureFournisseur ff = (FactureFournisseur) new FactureFournisseur().getById(this.getId(), "factfourn_msum_lib", c);
                this.setMontant(ff.getMontant());
                //si provision dia tsy engagena
                if(this.getIdcategorie().compareToIgnoreCase(Constante.idBonProvisoire)!=0) this.insertEngagement(u, controleMontant,c);
            }
            if (this.getIdengagement() != null) {
                FactureFournisseur ff = (FactureFournisseur) new FactureFournisseur().getById(this.getId(), "factfourn_msum_lib", c);
                if(this.getTypeEngagement() != null)ff.setTypeEngagement(this.getTypeEngagement());
                double resteAEngager = ff.getMontant();
                LiaisonEngagement liaison = new LiaisonEngagement();
                BonDeCommande bc = findBCResteAFacturer(c);
                Engagement[] lies = this.getEngagementLiee(null, c);
                if(bc != null){
                    resteAEngager -= bc.getMontantreste();
                    FactureFournisseur f = new FactureFournisseur();
                    f.setIdengagement(bc.getIdengagement());
                    Engagement engbc = f.findEngagement("liaisonEngagementBCFF", "idengagement", c);
                    if(engbc.getMontantreste() > 0){
                        liaison = new LiaisonEngagement(engbc.getIdengagement(), ff.getId(), engbc.getMontantreste(), ConstanteEtat.getEtatCreer());
                        liaison.createObject(u, c);
                        liaison.validerObject(u, c);
                        resteAEngager -= engbc.getMontantreste();
                    }
                    resteAEngager = traiterEngagementLiee(resteAEngager, lies, u, c);
                }
                else{
                    String requete = "select * from liaisonengagement where id1 = '" + this.getIdengagement() + "' and id2 = '" + this.getId() + "' and etat = " + ConstanteEtat.getEtatValider();
                    LiaisonEngagement[] liaisonengff = (LiaisonEngagement[]) CGenUtil.rechercher(new LiaisonEngagement(), requete, c);
                    String id = null;
                    if(liaisonengff.length == 0){
                        Engagement engff = this.findEngagement("engagementlib", "id", c);
                        if(engff != null && engff.getMontant() > 0){
                            double m = (resteAEngager - engff.getMontantreste() == 0) ? resteAEngager : engff.getMontantreste();
                            liaison = new LiaisonEngagement(this.getIdengagement(), this.getId(), m, ConstanteEtat.getEtatCreer());
                            liaison.createObject(u, c);
                            liaison.validerObject(u, c);
                            resteAEngager -= m;
                            id = this.getIdengagement();
                            lies = this.getEngagementLiee(id, c);
                        }
                    }
                    resteAEngager = traiterEngagementLiee(resteAEngager, lies, u, c);
                }
                if(resteAEngager > 0){
                    ff.setTypeEngagement(Constante.typeEngagementFF);
                    if(lies.length > 0)ff.setChantier(lies[0].getChantier());
                    ff.createEngagement(u, c, resteAEngager, lc, controleMontant);
                    this.setIdengagement(ff.getIdengagement());
                }
            }

            this.setNomTable("facture_fournisseur_mere");
             if(this.getIdProvision()==null){
                this.verifyOPmtt(u,c);
            }
            super.validerObject(u, c);
            if(verif == 1)c.commit();
        }catch(Exception e){
            if(verif == 1)c.rollback();
            e.printStackTrace();
            throw e;
        }finally{
            if(c!=null && verif==1)c.close();
        }
        return this;
    }

    public Object validerSansControleResteEngagement(String u,boolean controleMontant) throws Exception {
        try {
            return validerSansControleResteEngagement(u,controleMontant,null);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    public static FactureFournisseur grouperFacture(String ids, Connection c) throws Exception {
        FactureFournisseur[] factures = FactureFournisseur.getFactures(ids, c);
        if (factures == null || factures.length == 0) {
            throw new Exception("Factures introuvables ou non visees");
        }
        if (factures.length > 1) {
            throw new Exception("Fournisseur differents!");
        } else if (factures.length == 1) {
            return factures[0];
        }
        return null;
    }

    @Override
    public String calculerCodeSimple(Connection c) throws Exception {
        String daty = Utilitaire.datetostring(Utilitaire.dateDuJourSql());
        String code = "";
        String tableName = "NUMEROCOMPTAVAOVAO";
        code += Utilitaire.genererAnnee(daty);
        code += Utilitaire.genererMois(daty);
        //if(this.getIdcategorie().compareToIgnoreCase(Constante.getCategorieFFBP())==0) tableName = "NUMEROCOMPTABP";
        code += UtilitaireFacture.genererSequence(c, tableName, 4, daty);
        return code;
    }

    public FactureFournisseur modifierEntete(String refUser, Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }

            //this.updateToTableWithHisto(refUser, c);
            this.updateToTable(c);

            if (verif == 1) {
                c.commit();
            }
        } catch (Exception e) {
            if (c != null && verif == 1) {
                c.rollback();
            }
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
        return this;
    }

    public FactureFournisseur(Date daty, String tiers, String designation, String type, String idcategorie, int estAuto) throws Exception {
        setNomTable("facture_Fournisseur_Mere");
        setLiaisonFille("idmere");
        this.setNomClasseFille("facture.FactureFournisseurDetails");
        this.setDaty(daty);
        this.setTiers(tiers);
        this.setDesignation(designation);
        this.setType(type);
        this.setIdcategorie(idcategorie);
        this.setEstAuto(estAuto);
    }

    public Engagement findEngagement(String nomTable, String nomCol, Connection c) throws Exception {
        Engagement e = new Engagement();
        e.setNomTable(nomTable);
        Engagement[] ls = (Engagement[]) CGenUtil.rechercher(e, null, null, c, " and " + nomCol + "='" + this.getIdengagement() + "'");
        if (ls.length > 0) {
            return ls[0];
        }
        return null;
    }
    
    public Engagement findEngagement(Connection c) throws Exception {
        return  findEngagement("engagementlibV", "id", c);
    }

    @Override
    public void controler(Connection c) throws Exception {
        if (this.getIdengagement() != null && this.getIdengagement().compareTo("") != 0) {
            Engagement eg = this.findEngagement(c);
            if (eg == null) {
                throw new Exception("Engagement non visé");
            }
        }

        if (this.getNumeroop()==null || this.getNumeroop().compareToIgnoreCase("")==0) {
            if(this.getIdcategorie().compareToIgnoreCase(Constante.idBonProvisoire) != 0 && (this.getIdProvision()==null || this.getIdProvision().compareToIgnoreCase("")==0)) {
                throw new Exception("Numero facture obligatoire.");
            }
        }

        if((this.getProjet()==null ||  this.getProjet().compareToIgnoreCase("")==0) ) {
            throw new Exception("Code projet obligatoire.");
        }

        if(this.getCode_etablissement()==null || this.getCode_etablissement().compareToIgnoreCase("")==0)
        {
            throw new Exception("Code établissement obligatoire.");
        }

        if(this.getTiers()==null || this.getTiers().compareToIgnoreCase("")==0)
        {
            throw new Exception("Tiers Obligatoire.");
        }

        if(this.getDesignation()==null || this.getDesignation().compareToIgnoreCase("")==0)
        {
            throw new Exception("Designation Obligatoire.");
        }
        super.controler(c);
    }

    public LigneCredit[] findLigneCredit(String nomtable, Connection c, String compte) throws Exception {
        try {
            LigneCredit lncredit = new LigneCredit();
            lncredit.setNomTable(nomtable);
            lncredit.setIdcodeEtablissement(this.getCode_etablissement());
            lncredit.setIdprojet(this.getProjet());
            if (compte != null && compte.compareTo("") != 0) {
                lncredit.setCompte(compte);
            }
            LigneCredit[] res = (LigneCredit[]) CGenUtil.rechercher(lncredit, null, null, c, "");
            return res;
        } catch (Exception e) {
            throw e;
        }
    }

    @Override
    public void checkCode(Connection c) {
    }

    @Override
    public PaiementFacture[] getPaiementFacture(Connection c) throws Exception {
        boolean check = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                check = true;
            }
            PaiementFacture pF = new PaiementFacture();
            pF.setNomTable("paiementfactureF");
            pF.setIdFact(this.getId());
            PaiementFacture[] paiement = (PaiementFacture[]) CGenUtil.rechercher(pF, null, null, c, " ORDER BY id DESC");
            return paiement;
        } catch (Exception ex) {
            throw ex;
        } finally {
            if (c != null && check) {
                c.close();
            }
        }
    }

    public LiaisonIntraTable[] findLiaisonIntratable(Connection c) throws Exception {
        boolean check = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                check = true;
            }
            LiaisonIntraTable lit = new LiaisonIntraTable();
            //add etat liaisonintratable
            LiaisonIntraTable[] liaisonIntraTable = (LiaisonIntraTable[]) CGenUtil.rechercher(lit, null, null, c, " and id1='" + this.getId() + "'");
            return liaisonIntraTable;
        } catch (Exception ex) {
            throw ex;
        } finally {
            if (c != null && check) {
                c.close();
            }
        }
    }

    @Override
    public void controleAnnulerVisa(Connection c) throws Exception {
        c = null;

        try {
            c = (new UtilDB()).GetConn();
            OrdonnerPayement op = findOP(null, c);
            if (op != null) {
                throw new Exception("Impossible, OP ("+op.getNumeroop()+") existant.");
            }

            //LiaisonIntraTable[] liaisons = findLiaisonIntratable(c);
            //if (liaisons != null && liaisons.length > 0) {
            //    throw new Exception("Impossible, OP existant");
            //}

            PaiementFacture[] paiements = getPaiementFacture(c);
            if (paiements != null && paiements.length > 0) {
                throw new Exception("Impossible, paiements existants");
            }
            
            // BordereauFilleFF[] bedfilles = (BordereauFilleFF[]) CGenUtil.rechercher(new BordereauFilleFF(), null, null, c, " and idop = '" + this.getId() + "'");
            // if(bedfilles.length > 0){
            //     throw new Exception("Impossible, la facture est attach\\351e \\340 un BED");
            // }
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public Engagement getEngagement() throws Exception {
        Engagement retour = new Engagement(this.getDesignation(), this.getCode_etablissement(), this.getProjet(), this.getMontant(), 0.0, 0.0, 0.0, null, null, Utilitaire.dateDuJourSql());
        retour.setAvecFacture(0);
        return retour;
    }

    public void insertEngagement(String u, boolean controleMontant,Connection c) throws Exception {
        int verif = 0;
        Engagement engagement = this.getEngagement();
        
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }

            LigneCredit lc = this.getBudget(c);
            if (lc != null) {
                engagement.setIdLC(lc.getTuppleID());
            }
            engagement.setAnnee(Utilitaire.getAnnee(this.getDaty()));
            engagement.setTiers(this.getTiers());
            engagement.construirePK(c);

            FactureFournisseurDetails dets = new FactureFournisseurDetails();
            dets.setNomTable("FACTFOURN_FILL_LIB_REST_TAXE");
            FactureFournisseurDetails[] filles = (FactureFournisseurDetails[]) CGenUtil.rechercher(new FactureFournisseurDetails(), null, null, c, " and idmere = '" + this.getId() + "'");
                    //this.getFille("FACTFOURN_FILL_LIB_REST_TAXE", c, "");

            engagement.setAvecFacture(0);
            engagement.createObject(u, c);

            for (int i = 0; i < filles.length; i++) {
                EngagementFille engFille = filles[i].createEngagementFille(engagement.getTuppleID());
                engFille.construirePK(c);
                engFille.insertToTableWithHisto(u, c);
            }

            if(controleMontant){
                if(this.getTypeEngagement() != null) engagement.setType(this.getTypeEngagement());
                engagement.validerObject(u, c);
            }
            else engagement.validerObjectSansControleMontant(u, c);

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

    public LigneCredit getBudget(Connection c) throws Exception {
        int verif = 0;
        LigneCredit retour = null;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            LigneCredit lc = new LigneCredit();
            lc.setNomTable("LIGNECREDITDEPENSE");
            lc.setCodeEtablissement(this.getCode_etablissement());
            lc.setProjet(this.getProjet());
            LigneCredit[] ligneCredits = (LigneCredit[]) CGenUtil.rechercher(lc, null, null, c, " and annee=" + Utilitaire.getAnnee(this.getDaty()));
            if (ligneCredits.length > 0) {
                retour = ligneCredits[0];
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
        return retour;
    }

        
    public FactureFournisseur updateObjectMultiple(ClassMAPTable mere, String colonneMere, ClassMAPTable[] fille, UserEJB u) throws Exception {
        FactureFournisseur ff = null;
        Connection c = null;
        int verif = 0;
        
        try{
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            verif = 1;
            //this.verifyOPmtt(String.valueOf(u.getUser().getRefuser()),c);
            ff = (FactureFournisseur) u.updateObjectMultiple(mere, colonneMere, fille, c);
            c.commit();
        }
        catch(Exception e){
            c.rollback();
            throw e;
        }
        finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
        
        return ff;
    }

    public BonDeCommande findBCResteAFacturer(Connection c) throws Exception {
        if(this.getIdBL() != null){
            BonDeLivraison bl = (BonDeLivraison) new BonDeLivraison().getById(this.getIdBL(), "AS_BONDELIVRAISON_BC", c);
            BonDeCommande bc = (BonDeCommande)(new BonDeCommande()).getById(bl.getId_bc(), "bc_ff_diff", c);
            
            return bc;
        }
        
        return null;
    }
    
    @Override
    public int annulerVisa(String user,Connection c) throws Exception {
        if(this.getIdengagement() != null){
            LiaisonEngagement[] liaisons = (LiaisonEngagement[]) CGenUtil.rechercher(new LiaisonEngagement(), null, null, c, " and id2 = '" + this.getId() + "' and etat = " + ConstanteEtat.getEtatValider()); 
            for(int i = 0; i < liaisons.length; i++){
                LiaisonEngagement liaison = liaisons[i];
                liaison.setEtat(-2);
                liaison.updateToTableWithHisto(user,c);
            }
        }
        
        return super.annulerVisa(user, c);
    }
    
    public void createEngagement(String u, Connection c, double montant, LigneCredit lc, boolean controleBudget) throws Exception {
        try{
            Engagement engagement = new Engagement(this.getNumeroop(), this.getCode_etablissement() , this.getProjet(), montant, Utilitaire.getAnnee(this.getDaty()), Utilitaire.dateDuJourSql(), this.getTiers(), 0);
            engagement.setChantier(this.getChantier());
            if (lc != null) {
                engagement.setIdLC(lc.getTuppleID());
            }
            engagement.construirePK(c);
            engagement.createObject(u, c);
            
            EngagementFille engFille = new EngagementFille(engagement.getId(),this.getNumeroop(),montant);
            engFille.construirePK(c);
            engFille.insertToTableWithHisto(u, c);
            if(this.getTypeEngagement() != null)
                engagement.setType(this.getTypeEngagement());
            if(controleBudget)
                engagement.validerObject(u, c);
            else 
                engagement.validerObjectSansControleMontant(u, c);

            LiaisonEngagement liaison = new LiaisonEngagement(engagement.getId(), this.getId(), montant, ConstanteEtat.getEtatCreer());
            liaison.createObject(u, c);
            liaison.validerObject(u, c);

            this.setIdengagement(engagement.getId());           
        }
        catch(Exception ex){
            throw ex;
        }
    }

    public void attribuerCode(UserEJB u) throws Exception{
        Connection c = null;
        int verif = 0;        
        try{
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            verif = 1;
            if(this.getCode() == null || this.getCode().isEmpty() || this.getCode().compareToIgnoreCase("")==0){
                String cal = calculerCodeSimple(c);
                this.setDateRegul(Utilitaire.dateDuJourSql());
                this.setCode(cal);
                this.updateToTableWithHisto(String.valueOf(u.getUser().getRefuser()), c);
            }
            else throw new Exception("Ce facture possede deja un numero compta.");  
            c.commit();     
        
        } catch(Exception e){
            c.rollback();
            throw e;
        }
        finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    
    public Engagement[] getEngagementLiee(String id, Connection c) throws Exception {
        Engagement[] liste = null;
        
        try{
            String requete = "SELECT * FROM liaisonEngagementBCFF WHERE IDENGAGEMENT IN (SELECT ID1 FROM LIAISONENGAGEMENT WHERE ID2 = '" + this.getId() + "'";
            if(id != null)
                requete += " and ID1 != '" + id + "'";
            requete += ") AND MONTANTRESTE > 0 ORDER BY DATY";
            Engagement e = new Engagement();
            e.setNomTable("liaisonEngagementBCFF");
            liste = (Engagement[])CGenUtil.rechercher(e, requete, c);
        }
        catch(Exception e){
            throw e;
        }
        
        return liste;
    }
    
    public double traiterEngagementLiee(double resteAEngager, Engagement[] lies, String u, Connection c) throws Exception {
        int t = lies.length;
        double restetemp;
        try{
            for(int i = 0; i < t; i++){
                restetemp = resteAEngager;
                if(resteAEngager > 0){
                    if(resteAEngager > lies[i].getMontantreste())
                        restetemp = lies[i].getMontantreste();
                    LiaisonEngagement liaison = new LiaisonEngagement(lies[i].getIdengagement(), this.getId(), restetemp, ConstanteEtat.getEtatCreer());
                    liaison.createObject(u, c);
                    liaison.validerObject(u, c);
                    resteAEngager -= restetemp;
                }
            }
            return resteAEngager;
        }
        catch(Exception e){
            throw e;
        }
    }
    
    @Override
    public ClassMAPTable dupliquer(String user,Connection c) throws Exception
    { 
        try{
            this.setIdengagement(null);
            this.setNumeroop(null);
            this.setCode(null);
            this.setDatedevise(Utilitaire.dateDuJourSql());
            this.setDaty(Utilitaire.dateDuJourSql());
        }
        catch(Exception e){
            throw e;
        }
        return super.dupliquer(user, c);
    }
    
    public void controleMontant(Connection c) throws Exception {
        try{
            BonDeLivraison bl = (BonDeLivraison)(new BonDeLivraison()).getById(this.getIdBL(), "AS_BONDELIVRAISON", c);
            BonDeCommande bc = (BonDeCommande)(new BonDeCommande()).getById(bl.getId_bc(), "AS_BONDECOMMANDE_LIB_fiche", c);
            double montant = this.getMontantttc();
            if(montant > bc.getMontantTTC()){
                throw new Exception("Montant TTC de la facture fournisseur : " + this.getMontantttc() + " sup\\351rieur au montant TTC du bon de commande : " + bc.getMontantTTC() + ".");
            }
            FactureFournisseur facture = new FactureFournisseur();
            facture.setNomTable("factfourn_msum_lib_ficheB");
            FactureFournisseur[] factures = (FactureFournisseur[])CGenUtil.rechercher(facture, null, null, c, " and id != '" + this.getId() + "' and idbc ='" + bl.getId_bc() + "' and etat >= 11");
            if(factures.length > 0){
                montant += AdminGen.calculSommeDouble(factures, "montantTTC");
                if(montant > bc.getMontantTTC()){
                    throw new Exception("Montant TTC des factures fournisseur : " + montant + " sup\\351rieur au montant TTC du bon de commande : " + bc.getMontantTTC() + ".");
                }
            }
        }
        catch(Exception e){
            throw e;
        }
    }
}
