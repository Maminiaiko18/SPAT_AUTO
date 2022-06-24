/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.CGenUtil;
import bean.ClassMAPTable;
import bean.TypeObjet;
import ded.OrdonnerPayement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import lignecredit.LigneCredit;
import mg.allosakafo.produits.LiaisonIntraTable;
import mg.spat.Engagement;
import mg.spat.JournalCaisse;
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
    private String  idengagement , idengagementlib;
    private String id2;
    private String codeEtablissement;
    private Date dateRegul;
    private double montantHTSansRemise;

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
    
    public OrdonnerPayement findOP(String nomtable, Connection c) throws SQLException, Exception{
        int verif = 0;
        try{
            if (c == null) {
                c = (new UtilDB()).GetConn();
                verif = 1;
            }
            OrdonnerPayement oo = new OrdonnerPayement();
            if(nomtable == null){
                nomtable= "ordonnerpayement";
            }
            oo.setNomTable(nomtable);
            OrdonnerPayement[] results  =(OrdonnerPayement[]) CGenUtil.rechercher(oo, null, null, c, " and ded_id like '%" + this.getId() + "%'");
            if (results != null && results.length > 0) {
                return results[0];
            }
        }catch(Exception e){
            throw e;
        }finally{
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
        this.setNomClasseFille("facture.FactureFournisseurDetails");
        this.setIduser(iduser);
        this.setId(null);
        this.setCode(calculerCodeSimple(cnctn));
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
          return getBP(null,c);
      }
    
    
    public BonDeLivraisonFilleReste[] getBP(String BC ,Connection c) throws Exception {
        boolean ouvert = false;
        BonDeLivraisonFilleReste[] livraisons = new BonDeLivraisonFilleReste[0];
        if ((this.getIdBL() == null || this.getIdBL().trim().equals(""))&& (BC == null || BC.trim().equals(""))) {
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

            if (type == 1) {
                fc.controlerDefinitive(c);
                categorie = Constante.categorieFFdefault;
            } else {
                JournalCaisse[] jc = this.getPaiement(c);
                if (jc.length == 0) {
                    throw new Exception("Pas de paiement pour ce bon provisoire");
                }
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
        try{
            if(con == null){
                con = new UtilDB().GetConn();
                con.setAutoCommit(false);
                verif = true;
            }
            if(this.getDateRegul() == null || this.getDateRegul().equals("")) throw new Exception("Date de regul vide");
            
            Date dateDuJour = this.getDateRegul();
            JournalCaisse transfert = new JournalCaisse(null, Constante.caisseCentraleBP, null, "Transfert bon provisoire", null, dateDuJour, dateDuJour, montant, 0,this.getId());
            transfert.setIddevise(this.getDeviseMere());
            transfert.setIdmode(Constante.modePaiementEspece);
            transfert.setEtat(ConstanteEtat.getEtatValider());
            
            transfert.createObject(u, con);
            
            if(verif) con.commit();
        }
        catch(Exception ex) {
            if(con != null && verif) con.rollback();
            throw ex;
        }
        finally {
            if(con != null && verif) con.close();
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

    @Override
    public Object validerObject(String u, Connection c) throws Exception {
        if (this.getIdcategorie() != null && this.getIdcategorie().equals(utilitaire.Constante.categorieFFdefault) && this.getIdProvision() != null) {
            this.genererPaiementDefinitive(u, this.getIdProvision(), c);
        }
        if(this.getIdengagement() != null){
          Engagement eg = this.findEngagement(c);
          if(eg != null){
              double reste = eg.getResteAFacturer(c);
              FactureFournisseur ff = (FactureFournisseur)new FactureFournisseur().getById(this.getId(), "factfourn_msum_lib", c);
              if(ff!=null && reste < ff.getMontant()) throw new Exception("Le montant de la facture depasse le reste de l'engagement");
          }
        } 
        this.setNomTable("facture_fournisseur_mere");
        super.validerObject(u, c);
        return this;
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
        String daty = Utilitaire.datetostring(this.getDaty());
        String code = "";
        code += Utilitaire.genererAnnee(daty);
        code += Utilitaire.genererMois(daty);
        code += UtilitaireFacture.genererSequence(c, "NUMEROCOMPTA", 4, daty);
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

            this.updateToTableWithHisto(refUser, c);
//            this.updateToTable(c);

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
    
    public Engagement findEngagement(Connection c) throws Exception{
        Engagement e = new Engagement();
        e.setNomTable("engagementlibV");
        Engagement[] ls = (Engagement[])CGenUtil.rechercher(e, null, null, c, " and id='"+this.getIdengagement()+"'");
        if(ls.length > 0 ) return ls[0];
        return null;
    }
    
    @Override
    public void controler(Connection c) throws Exception {
        super.controler(c); 
        if(this.getIdengagement() != null && this.getIdengagement().compareTo("") != 0){
            Engagement eg = this.findEngagement(c);
            if(eg == null) throw new Exception("Engagement non visé");
        }
    }
    
    public LigneCredit[] findLigneCredit(String nomtable, Connection c, String compte) throws Exception{   
        try{
            LigneCredit lncredit = new LigneCredit();
            lncredit.setNomTable(nomtable);
            lncredit.setIdcodeEtablissement(this.getCode_etablissement());
            lncredit.setIdprojet(this.getProjet());
            if(compte!=null&&compte.compareTo("")!=0) lncredit.setCompte(compte);
            LigneCredit[] res = (LigneCredit[]) CGenUtil.rechercher(lncredit, null, null, c, "");
            return res;
        }catch(Exception e){
            throw e;
        }
    }
    
    @Override
    public void checkCode(Connection c){}
    
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
            if (c != null && check) c.close();
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
            LiaisonIntraTable[] liaisonIntraTable = (LiaisonIntraTable[]) CGenUtil.rechercher(lit, null, null, c, " and id1='"+this.getId()+"'");
            return liaisonIntraTable;
        } catch (Exception ex) {
            throw ex;
        } finally {
            if (c != null && check) c.close();
        }
    }
    
    @Override
    public void controleAnnulerVisa() throws Exception {
        Connection c = null;
        
        try {
            c = (new UtilDB()).GetConn();
            OrdonnerPayement op = findOP(null, c);
            if(op != null) throw new Exception("Impossible, OP existant");
            
            LiaisonIntraTable[] liaisons = findLiaisonIntratable(c);
            if(liaisons != null && liaisons.length > 0) throw new Exception("Impossible, OP existant");
            
            PaiementFacture[] paiements = getPaiementFacture(c);
            if(paiements != null && paiements.length > 0) throw new Exception("Impossible, paiements existants");
        } catch (Exception e) {
            throw e;
        } finally {
            if(c != null) c.close();
        }
    }
}
