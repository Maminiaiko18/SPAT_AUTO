package facturefournisseur;

import bean.AdminGen;
import bean.CGenUtil;
import bean.ClassEtat;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import mg.spat.Chantier;
import mg.spat.ChantierLibComplet;
import mg.spat.compta.ContratChantier;
import mg.spat.stock.BonDeCommande;
import mg.spat.stock.BonDeLivraison;
import user.UserEJB;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

public class FactureFournisseur extends ClassEtat {

    public String id;
    public String numfact;
    public java.sql.Date daty;
    public String idfournisseur;
    public String nomfournisseur;
    public String iddevise;
    public double montantttc;
    public String remarque;
    public double idtva;
    public String designation;
    public java.sql.Date dateemission;
    private String resp;
    private java.sql.Date datyecheance;
    private String idfacturefournisseur;
    private String budget;
    private double montantdevise;
    private int exercice;
    private String type;
    private String numid;
    private String numeroop;
    private String projet;
    private String code_etablissement;

    public FactureFournisseur(String numfact, Date daty, String idfournisseur, String nomfournisseur, String iddevise, double montantttc, String remarque, double idtva, String designation, Date dateemission, String resp, Date datyecheance, String idfacturefournisseur, String budget, double montantdevise, int exercice, String type, String numid) throws Exception {
        super.setNomTable("factureFournisseur");
        setNumfact(numfact);
        setDaty(daty);
        setIdfournisseur(idfournisseur);
        setNomfournisseur(nomfournisseur);
        setIddevise(iddevise);
        setMontantttc(montantttc);
        setRemarque(remarque);
        setIdtva(idtva);
        setDesignation(designation);
        setDateemission(dateemission);
        setResp(resp);
        setDatyecheance(datyecheance);
        setIdfacturefournisseur(idfacturefournisseur);
        setBudget(budget);
        setMontantdevise(montantdevise);
        setExercice(exercice);
        setType(type);
        setNumid(numid);
    }

    public void checkDoublon(Connection c) throws Exception {
        int verif = 0;
        
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            
            String where = "";
            where += " and numfact = '" + this.getNumfact() + "'";
            where += " and idfournisseur = '" + this.getIdfournisseur() + "'";
            
            FactureFournisseur ff = new FactureFournisseur();
            FactureFournisseur[] tmp = (FactureFournisseur[]) CGenUtil.rechercher(ff, null, null, c, where);
            
            if(tmp != null && tmp.length > 0) {
                throw new Exception("Erreur! Doublon!");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    
    @Override
    public void controler(Connection c) throws Exception {
        checkDoublon(c);
    }
    
    public String getNumid() {
        return numid;
    }

    public void setNumid(String numid) {
        this.numid = numid;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getExercice() {
        return exercice;
    }

    public void setExercice(int exercice) {
        this.exercice = exercice;
    }

    public String getIdfacturefournisseur() {
        return idfacturefournisseur;
    }

    public void setIdfacturefournisseur(String idfacturefournisseur) {
        this.idfacturefournisseur = idfacturefournisseur;
    }

    public FactureFournisseur() {
        super.setNomTable("factureFournisseur");
    }

    public void construirePK(Connection c) throws Exception {
        this.preparePk("FF", "getseqfacturefournisseur");
        this.setId(makePK(c));
    }

    public String getNomfournisseur() {
        return nomfournisseur;
    }

    public void setNomfournisseur(String nomfournisseur) {
        this.nomfournisseur = nomfournisseur;
    }

    public String getBudget() {
        return budget;
    }

    public void setBudget(String budget) {
        this.budget = budget;
    }

    public String getAttributIDName() {
        return "id";
    }

    public String getTuppleID() {
        return this.getId();
    }

    public String getIdfournisseur() {
        return this.idfournisseur;
    }

    public void setIdfournisseur(String idfournisseur) throws Exception {
        if (this.getMode().compareToIgnoreCase("modif") == 0 && (idfournisseur == null || idfournisseur.compareToIgnoreCase("") == 0)) {
            throw new Exception("Fournisseur non valide");
        }
        this.idfournisseur = idfournisseur;
    }

    public void setIdtva(double idtva) throws Exception {
        if (this.getMode().compareToIgnoreCase("select") == 0) {
            this.idtva = idtva;
            return;
        }
        if (idtva < 0) {
            throw new Exception("tva invalide");
        }
        this.idtva = idtva;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNumfact() {
        return numfact;
    }

    public void setNumfact(String numfact) {
        this.numfact = numfact;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public String getIddevise() {
        return iddevise;
    }

    public void setIddevise(String iddevise) {
        this.iddevise = iddevise;
    }

    public double getMontantttc() {
        return montantttc;
    }

    public void setMontantttc(double montantttc) {
        this.montantttc = montantttc;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public double getIdtva() {
        return idtva;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public Date getDateemission() {
        return dateemission;
    }

    public void setDateemission(Date dateemission) {
        this.dateemission = dateemission;
    }

    public String getResp() {
        return resp;
    }

    public void setResp(String resp) {
        this.resp = resp;
    }

    public Date getDatyecheance() {
        return datyecheance;
    }

    public void setDatyecheance(Date datyecheance) {
        this.datyecheance = datyecheance;
    }

    public double getMontantdevise() {
        return montantdevise;
    }

    public void setMontantdevise(double montantdevise) {
        this.montantdevise = montantdevise;
    }

    public DetailsFactureFournisseur[] getDetails(Connection c, String nomTable) throws Exception {
        int verif = 0;
        DetailsFactureFournisseur[] details = new DetailsFactureFournisseur[0];

        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            DetailsFactureFournisseur det = new DetailsFactureFournisseur();

            if (nomTable != null && nomTable.compareTo("") != 0) {
                det.setNomTable(nomTable);
            }

            details = (DetailsFactureFournisseur[]) CGenUtil.rechercher(det, null, null, c, " and idmere = '" + this.getId() + "'");
        } catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
        return details;
    }

    private boolean estChantier(Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            Chantier[] chantier = (Chantier[]) CGenUtil.rechercher(new Chantier(), null, null, c, " and id = '" + this.getRemarque() + "'");
            if (chantier.length != 0) {
                if (chantier[0].getEtat() < ConstanteEtat.getEtatValider()) {
                    throw new Exception("Chantier  pas encore été validé pour la Facture");
                }
                return true;

            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
        return false;
    }
    
    private boolean estContrat(Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            ContratChantier[] bl = (ContratChantier[]) CGenUtil.rechercher(new ContratChantier(), null, null, c, " and id = '" + this.getRemarque() + "'");
            if (bl.length != 0) {
                if (bl[0].getEtat() < ConstanteEtat.getEtatValider()) {
                    throw new Exception("Contrat pas encore validé pour la Facture");
                }
                return true;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
        return false;
    }

    private boolean estBL(Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            BonDeLivraison[] bl = (BonDeLivraison[]) CGenUtil.rechercher(new BonDeLivraison(), null, null, c, " and id = '" + this.getRemarque() + "'");
            if (bl.length != 0) {
                if (bl[0].getEtat() < ConstanteEtat.getEtatValider()) {
                    throw new Exception("Bon de livraison pas encore validé pour la Facture");
                }
                return true;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
        return false;
    }

    private boolean estBC(Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            BonDeCommande[] bc = (BonDeCommande[]) CGenUtil.rechercher(new BonDeCommande(), null, null, c, " and id = '" + this.getRemarque() + "'");
            if (bc.length != 0) {
                if (bc[0].getEtat() < ConstanteEtat.getEtatValider()) {
                    throw new Exception("Bon de commande  pas encore validé pour la Facture");
                }
                return true;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
        return false;
    }

    private void controlChantier(Connection c) throws Exception {
        ChantierLibComplet chantier = new ChantierLibComplet();
        chantier.setNomTable("chantier_reste_mtt");
        chantier.setId(this.getRemarque());
        ChantierLibComplet[] tabCht = (ChantierLibComplet[]) CGenUtil.rechercher(chantier, null, null, c, "");
        if (tabCht != null && tabCht.length > 0) {
            chantier = tabCht[0];
        }

        DetailsFactureFournisseur[] details = getDetailsACtrl(c, null);

        double montant = details[0].getQte() * details[0].getPu();

        if (montant > chantier.getMontantReste()) {
            throw new Exception("Montant détail incorrect!");
        }
    }

    public DetailsFactureFournisseur[] getDetailsACtrl(Connection c, String nomTable) throws Exception {
        DetailsFactureFournisseur[] details = getDetails(c, nomTable);

        if (details == null || details.length == 0) {
            throw new Exception("Aucun détails pour la facture " + this.getId());
        }

        return details;
    }

    private void controlBC(Connection c) throws Exception {
        DetailsFactureFournisseur[] details = getDetailsACtrl(c, "detailsfacturefournisseurreste");

        for (int i = 0; i < details.length; i++) {
            if (details[i].getQte() > details[i].getQteReste()) {
                throw new Exception("Quantité details supérieur au reste à facturer");
            }
        }
    }

    private void checkQuantite(Connection c) throws Exception {
        try {
            if (estChantier(c)) {
                controlChantier(c);
            }
            if (estBC(c)) {
                controlBC(c);
            }
        } catch (Exception e) {
            throw e;
        }

    }

    public void checkTiersPourFusion(FactureFournisseur[] tFF) throws Exception {
        for (int i = 0; i < tFF.length; i++) {
            if (i > 0 && tFF[0].getIdfournisseur() != null && tFF[i].getIdfournisseur() != null) {
                if (!tFF[0].getIdfournisseur().equalsIgnoreCase(tFF[i].getIdfournisseur())) {
                    throw new Exception("Fusion facture impossible, les tiers sont différents");
                }
            }
        }
    }

    @Override
    public Object validerObject(String u, Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            setMode("modif");
//            checkQuantite(c);
            this.estBL(c);
            this.estContrat(c);
            this.setEtat(ConstanteEtat.getEtatValider());
            this.updateToTableWithHisto(u, c);
            return this;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    public void traitementFusionDetFF(String idFacture, Connection c, UserEJB u) throws Exception {
        DetailsFactureFournisseur detFF = new DetailsFactureFournisseur();
        detFF.setIdmere(idFacture);
        detFF.setPu(this.getMontantttc());
        detFF.setQte(1);
        detFF.setIdingredient(this.getRemarque());
        detFF.setIddqe(this.getDesignation());
        
        detFF.construirePK(c);
        detFF.insertToTableWithHisto(u.getUser().getTuppleID(), c);
    }

    public void deleteFille(String user, Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            setMode("modif");
            
            DetailsFactureFournisseur detF = new DetailsFactureFournisseur();
            DetailsFactureFournisseur[] details = (DetailsFactureFournisseur[]) CGenUtil.rechercher(detF, null, null, c, " and idmere = '" + this.getId() + "'");
            
            for(int i=0; i < details.length; i++) {
                details[i].deleteToTableWithHisto(user, c);
            }
            
            if(verif == 1) {
                c.commit();
            }
        } catch (Exception ex) {
            if(c != null && verif == 1) {
                c.rollback();
            }
            throw ex;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    
    public static FactureFournisseur fusionnerFacture(String[] idFacture, Connection c, UserEJB u) throws Exception {
        int etatC = 1;
        FactureFournisseur fusion = null;

        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                etatC = 0;
                c.setAutoCommit(false);
            }
            if (idFacture == null || idFacture.length == 0) {
                throw new Exception("Vous devez cocher");
            }

            String id = Utilitaire.tabToString(idFacture, "'", ",");

            EtatFactureMontantDaty etatF = new EtatFactureMontantDaty();
            EtatFactureMontantDaty[] tEtatF = (EtatFactureMontantDaty[]) CGenUtil.rechercher(etatF, null, null, c, " and id in (" + id + ")");

            FactureFournisseur ff = new FactureFournisseur();
            FactureFournisseur[] tFF = (FactureFournisseur[]) CGenUtil.rechercher(ff, null, null, c, " and id in (" + id + ")");

            if (tFF != null) {
                String[] atts = {"id"};

                for (int i = 0; i < tFF.length; i++) {
                    String[] values = {idFacture[i]};
                    ClassMAPTable[] tmp = AdminGen.find(tFF, atts, values);

                    if (tmp != null && tmp.length > 0) {
                        ff = (FactureFournisseur) tmp[0];
                    }

                    tmp = AdminGen.find(tEtatF, atts, values);

                    if (tmp != null && tmp.length > 0) {
                        etatF = (EtatFactureMontantDaty) tmp[0];
                    }
                    
                    if (ff.getEtat() >= ConstanteEtat.getEtatValider()) {
                        throw new Exception("Fusion impossible à partir d'une facture déjà visé");
                    }
                    
                    if (i == 0) {
                        ff.checkTiersPourFusion(tFF);
                        
                        fusion = new FactureFournisseur(ff.getNumfact(), Utilitaire.dateDuJourSql(), ff.getIdfournisseur(), ff.getNomfournisseur(), ff.getIddevise(), ff.getMontantttc(), ff.getRemarque(), ff.getIdtva(), ff.getDesignation(), ff.getDateemission(), ff.getResp(), ff.getDatyecheance(), ff.getIdfacturefournisseur(), ff.getBudget(), ff.getMontantdevise(), ff.getExercice(), ff.getType(), ff.getNumid());
//                        fusion.setMontantttc(montant);
                        fusion.construirePK(c);
                        fusion.insertToTableWithHisto(u.getUser().getTuppleID(), c);
//                        System.out.println("insert nouveau------" + fusion.getId());
                    }

                    ff.setMontantttc(etatF.getMontantTTC());
                    ff.setMontantdevise(etatF.getMontantTTDevise());

                    ff.traitementFusionDetFF(fusion.getId(), c, u);
//                    System.out.println("insert------" + fusion.getId() + " dans FFDetail");

                    ff.deleteFille(u.getUser().getTuppleID(), c);

                    ff.deleteToTableWithHisto(u.getUser().getTuppleID(), c);
//                    System.out.println("delete------" + ff.getId() + " dans FF");
                }
            }

            if (etatC == 0) {
                c.commit();
            }
        } catch (Exception e) {
            e.printStackTrace();
            if (c != null) {
                c.rollback();
            }
            throw e;
        } finally {
            if (c != null && etatC == 0) {
                c.close();
            }
        }

        return fusion;
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

    public void setProjet(String projet) {
        this.projet = projet;
    }

    public String getCode_etablissement() {
        return code_etablissement;
    }

    public void setCode_etablissement(String code_etablissement) {
        this.code_etablissement = code_etablissement;
    }
}
