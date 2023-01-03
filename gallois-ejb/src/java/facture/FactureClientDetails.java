/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.CGenUtil;
import bean.ClassFille;
import bean.ClassMAPTable;
import bean.TypeObjet;
import fin.Coursdevise;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import mg.spat.OccupationMaterielNaval;
import mg.spat.Prevision;
import mg.spat.exploitant.Activite;
import mg.spat.exploitant.Rubrique;
import utilitaire.Constante;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author
 */
public class FactureClientDetails extends ClassFille {

    private String id, idmere;
    private double quantite, pu, taux;
    private String compte, idproduit, produit_lib, devise, designation, idProduitLib, idactivite, categorieFacturelib, categorieClientlib, activitelib, rubrique;
    private double montant;
    private double montanttaux;
    private double montantavoirsanstaux;
    private double montantavoiravectaux;
    private double qtelivree, restealivrer, montantTTC;
    private Date datefact, daty, datyActivite;
    private String rubriquelib, idprestation, clientlib, client;
    private int mois, annee;
    private String heureDebut, heureFin, moislib, anneelib;
    private double montantHTEuro, montantTVAEuro, montanttaxe, majoration, reduction, duree, montantnet, tvaDf;
    private int rang;
    private String idrubrique, catClient, libelleRubrique, unite;
    
    public String getClient() {
        return client;
    }

    public void setClient(String client) {
        this.client = client;
    }
    
    public String getUnite() {
        return unite;
    }

    public void setUnite(String unite) {
        this.unite = unite;
    }

    public String getCatClient() {
        return catClient;
    }

    public void setCatClient(String catClient) {
        this.catClient = catClient;
    }

    public String getLibelleRubrique() {
        return libelleRubrique;
    }

    public void setLibelleRubrique(String libelleRubrique) {
        this.libelleRubrique = libelleRubrique;
    }

    public Date getDatyActivite() {
        return datyActivite;
    }

    public void setDatyActivite(Date datyActivite) {
        this.datyActivite = datyActivite;
    }

    public String getIdrubrique() {
        return idrubrique;
    }

    public void setIdrubrique(String idrubrique) {
        this.idrubrique = idrubrique;
    }

    public double getDuree() {
        return duree;
    }

    public void setDuree(double duree) {
        this.duree = duree;
    }

    public double getMontantnet() {
        return montantnet;
    }

    public void setMontantnet(double montantnet) {
        this.montantnet = montantnet;
    }

    public double getTvaDf() {
        return tvaDf;
    }

    public void setTvaDf(double tvaDf) {
        this.tvaDf = tvaDf;
    }

    public double getMontantTTC() {
        return montantTTC;
    }

    public void setMontantTTC(double montantTTC) {
        this.montantTTC = montantTTC;
    }

    public FactureClientDetails(String id, String idmere, double quantite, double pu, double taux, String compte, String idproduit, String produit_lib, String devise, String designation, String idProduitLib, String idactivite, String categorieFacturelib, String categorieClientlib, String activitelib, String rubrique, FactureClient mere, double montant, double montanttaux, double montantavoirsanstaux, double montantavoiravectaux, double qtelivree, double restealivrer, Date datefact, String rubriquelib, String idprestation, String clientlib, int mois, int annee, String heureDebut, String heureFin, String moislib, String anneelib, double montantHTEuro, double montantTVAEuro, double montanttaxe, double majoration, double reduction, double tva) {
        setNomTable("facture_client_fille");
        this.id = id;
        this.idmere = idmere;
        this.quantite = quantite;
        this.pu = pu;
        this.taux = taux;
        this.compte = compte;
        this.idproduit = idproduit;
        this.produit_lib = produit_lib;
        this.devise = devise;
        this.designation = designation;
        this.idProduitLib = idProduitLib;
        this.idactivite = idactivite;
        this.categorieFacturelib = categorieFacturelib;
        this.categorieClientlib = categorieClientlib;
        this.activitelib = activitelib;
        this.rubrique = rubrique;
        this.setMere(mere);
        this.montant = montant;
        this.montanttaux = montanttaux;
        this.montantavoirsanstaux = montantavoirsanstaux;
        this.montantavoiravectaux = montantavoiravectaux;
        this.qtelivree = qtelivree;
        this.restealivrer = restealivrer;
        this.datefact = datefact;
        this.rubriquelib = rubriquelib;
        this.idprestation = idprestation;
        this.clientlib = clientlib;
        this.mois = mois;
        this.annee = annee;
        this.heureDebut = heureDebut;
        this.heureFin = heureFin;
        this.moislib = moislib;
        this.anneelib = anneelib;
        this.montantHTEuro = montantHTEuro;
        this.montantTVAEuro = montantTVAEuro;
        this.montanttaxe = montanttaxe;
        this.majoration = majoration;
        this.reduction = reduction;
        this.tva = tva;
    }

    public double getMajoration() {
        return majoration;
    }

    public void setMajoration(double majoration) {
        this.majoration = majoration;
    }

    public double getReduction() {
        return reduction;
    }

    public void setReduction(double reduction) {
        this.reduction = reduction;
    }
    boolean tauxDonne = false;

    public boolean getTauxDonne() {
        return tauxDonne;
    }

    public void setTauxDonne(boolean tauxDonne) {
        this.tauxDonne = tauxDonne;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public int getRang() {
        return rang;
    }

    public void setRang(int rang) {
        this.rang = rang;
    }

    public static Date getFinMois(int mois, int annee) {
        String moisS = mois < 10 ? "0" + mois : "" + mois;
        Date date = Utilitaire.stringDate("01/" + moisS + "/" + annee);

        return Utilitaire.getLastDayOfDateSQL(date);
    }

    public double getTauxFinDuMois(Connection c, int mois, int annee, String iddevise) throws Exception {
        Date finDuMois = getFinMois(mois, annee);
        String awhere = " and daty = (SELECT max(daty) FROM COURSDEVISE WHERE  daty <= '" + Utilitaire.datetostring(finDuMois) + "' and iddevise = '" + iddevise + "') "
                + " and iddevise = '" + iddevise + "'";
        //System.out.println("apres where "+awhere );
        Coursdevise[] cd = (Coursdevise[]) CGenUtil.rechercher(new Coursdevise(), null, null, c, awhere);

        return cd != null && cd.length > 0 ? cd[0].getMontant() : 0;
    }

    public void setTauxFinDuMois(Connection c, int mois, int annee, String iddevise) throws Exception {
        double tauxFm = getTauxFinDuMois(c, mois, annee, iddevise);
        this.setTaux(tauxFm);
    }

    public double getMontanttaxe() {
        return montanttaxe;
    }

    public void setMontanttaxe(double montanttaxe) {
        this.montanttaxe = montanttaxe;
    }

    public String getProduit_lib() {
        return produit_lib;
    }

    public void setProduit_lib(String produit_lib) {
        this.produit_lib = produit_lib;
    }

    public String getClientlib() {
        return clientlib;
    }

    public void setClientlib(String clientlib) {
        this.clientlib = clientlib;
    }

    public double getMontantMaj(double montant) {
        return montant * this.getMajoration() / 100;
    }

    public double getMontantReduction(double montant) {
        return montant * this.getReduction() / 100;
    }

    public double getMontantAvecMajRed(double montant) {
        return montant - this.getMontantReduction(montant) + this.getMontantMaj(montant);
    }

    public double getMontantHTEuro() {
        return montantHTEuro;
    }

    public void setMontantHTEuro(double montantHTEuro) {
        this.montantHTEuro = montantHTEuro;
    }

    public double getMontantTVAEuro() {
        return montantTVAEuro;
    }

    public void setMontantTVAEuro(double montantTVAEuro) {
        this.montantTVAEuro = montantTVAEuro;
    }

    public OccupationMaterielNaval getPrestation(Connection c) throws Exception {
        OccupationMaterielNaval prestation = new OccupationMaterielNaval();
        prestation.setNomTable("occupationmaterielnavalfacture");
        prestation.setIdfacturelfille(this.getId());
        OccupationMaterielNaval[] prestations = (OccupationMaterielNaval[]) CGenUtil.rechercher(prestation, null, null, c, "");
        if (prestations.length > 0) {
            prestation = prestations[0];
        } else {
            prestation = null;
        }
        return prestation;
    }

    public String getMoislib() {
        return moislib;
    }

    public void setMoislib(String moislib) {
        this.moislib = moislib;
    }

    public String getAnneelib() {
        return anneelib;
    }

    public void setAnneelib(String anneelib) {
        this.anneelib = anneelib;
    }

    public String getRubriquelib() {
        return rubriquelib;
    }

    public void setRubriquelib(String rubriquelib) {
        this.rubriquelib = rubriquelib;
    }

    public String getIdprestation() {
        return idprestation;
    }

    public void setIdprestation(String idprestation) {
        this.idprestation = idprestation;
    }

    public int getMois() {
        return mois;
    }

    public void setMois(int mois) {
        this.mois = mois;
    }

    public int getAnnee() {
        return annee;
    }

    public void setAnnee(int annee) {
        this.annee = annee;
    }

    public String getHeureDebut() {
        return heureDebut;
    }

    public void setHeureDebut(String heureDebut) {
        this.heureDebut = heureDebut;
    }

    public String getHeureFin() {
        return heureFin;
    }

    public void setHeureFin(String heureFin) {
        this.heureFin = heureFin;
    }

    public Date getDatefact() {
        return datefact;
    }

    public void setDatefact(Date datefact) {
        this.datefact = datefact;
    }

    double tva;

    //double montantTva;
    public String getActivitelib() {
        return activitelib;
    }

    public void setActivitelib(String activitelib) {
        this.activitelib = activitelib;
    }

    public double getTva() {
        return tva;
    }

    public void setTva(double tva) {
        this.tva = tva;
    }

    public double getMontantTva() throws Exception {
        return this.getMontanttaux() * this.getTva() / 100;
    }

    @Override
    public String getValColLibelle() {
        return getLibDesignation() + ";" + Utilitaire.formaterAr(montanttaux) + ";" + Utilitaire.formaterAr(montanttaux) + ";" + devise;
    }

    public String getLibDesignation() {
        return designation == null || designation.equals("") ? id : designation;
    }

    public String getIdProduitLib() {
        return idProduitLib;
    }

    public void setIdProduitLib(String idProduitLib) {
        this.idProduitLib = idProduitLib;
    }

    public double getQtelivree() {
        return qtelivree;
    }

    public void setQtelivree(double qtelivree) {
        this.qtelivree = qtelivree;
    }

    public double getRestealivrer() {
        return restealivrer;
    }

    public void setRestealivrer(double restealivrer) {
        this.restealivrer = restealivrer;
    }

    public double getMontantavoirsanstaux() {
        return montantavoirsanstaux;
    }

    public void setMontantavoirsanstaux(double montantavoirsanstaux) {
        this.montantavoirsanstaux = montantavoirsanstaux;
    }

    public double getMontantavoiravectaux() {
        return montantavoiravectaux;
    }

    public void setMontantavoiravectaux(double montantavoiravectaux) {
        this.montantavoiravectaux = montantavoiravectaux;
    }

    public double getMontanttaux() {
        return montanttaux;
    }

    public void setMontanttaux(double montanttaux) {
        this.montanttaux = montanttaux;
    }

    public FactureClientDetails() throws Exception {
        setNomTable("facture_client_fille");
        this.setNomClasseMere("facture.FactureClient");
        this.setLiaisonMere("idmere");
    }

    public FactureClientDetails(String idmere, double quantite, double pu, String compte, String designation, double duree, int annee, int mois, String devise) throws Exception {
        setNomTable("facture_client_fille");
        this.setNomClasseMere("facture.FactureClient");
        this.setLiaisonMere("idmere");
        this.setIdmere(idmere);
        this.setQuantite(quantite);
        this.setPu(pu);
        this.setCompte(compte);
        this.setDesignation(designation);
        this.setDuree(duree);
        this.setAnnee(annee);
        this.setMois(mois);
        this.setDevise(devise);
    }

    public FactureClientDetails(String idmere, double quantite, double pu, String compte, String designation, double duree, int annee, int mois, String devise, double tva) throws Exception {
        setNomTable("facture_client_fille");
        this.setNomClasseMere("facture.FactureClient");
        this.setLiaisonMere("idmere");
        this.setIdmere(idmere);
        this.setQuantite(quantite);
        this.setPu(pu);
        this.setCompte(compte);
        this.setDesignation(designation);
        this.setDuree(duree);
        this.setAnnee(annee);
        this.setMois(mois);
        this.setDevise(devise);
        this.setTva(tva);
    }

    public FactureClientDetails(String idmere, double quantite, double pu, String compte, String designation, double duree) throws Exception {
        setNomTable("facture_client_fille");
        this.setNomClasseMere("facture.FactureClient");
        this.setLiaisonMere("idmere");
        this.setIdmere(idmere);
        this.setQuantite(quantite);
        this.setPu(pu);
        this.setCompte(compte);
        this.setDesignation(designation);
        this.setDuree(duree);
    }

    public FactureClientDetails(String id, String idmere, double quantite, double pu, double taux, String compte, String idproduit, String produit_lib, String devise, String designation, String idProduitLib, String idactivite, String categorieFacturelib, String categorieClientlib, String activitelib, String rubrique, FactureClient mere, double montant, double montanttaux, double montantavoirsanstaux, double montantavoiravectaux, double qtelivree, double restealivrer, double montantTTC, Date datefact, Date daty, String rubriquelib, String idprestation, String clientlib, int mois, int annee, String heureDebut, String heureFin, String moislib, String anneelib, double montantHTEuro, double montantTVAEuro, double montanttaxe, double majoration, double reduction, int rang, double tva) {
        this.id = id;
        this.idmere = idmere;
        this.quantite = quantite;
        this.pu = pu;
        this.taux = taux;
        this.compte = compte;
        this.idproduit = idproduit;
        this.produit_lib = produit_lib;
        this.devise = devise;
        this.designation = designation;
        this.idProduitLib = idProduitLib;
        this.idactivite = idactivite;
        this.categorieFacturelib = categorieFacturelib;
        this.categorieClientlib = categorieClientlib;
        this.activitelib = activitelib;
        this.rubrique = rubrique;
        this.setMere(mere);
        this.montant = montant;
        this.montanttaux = montanttaux;
        this.montantavoirsanstaux = montantavoirsanstaux;
        this.montantavoiravectaux = montantavoiravectaux;
        this.qtelivree = qtelivree;
        this.restealivrer = restealivrer;
        this.montantTTC = montantTTC;
        this.datefact = datefact;
        this.daty = daty;
        this.rubriquelib = rubriquelib;
        this.idprestation = idprestation;
        this.clientlib = clientlib;
        this.mois = mois;
        this.annee = annee;
        this.heureDebut = heureDebut;
        this.heureFin = heureFin;
        this.moislib = moislib;
        this.anneelib = anneelib;
        this.montantHTEuro = montantHTEuro;
        this.montantTVAEuro = montantTVAEuro;
        this.montanttaxe = montanttaxe;
        this.majoration = majoration;
        this.reduction = reduction;
        this.rang = rang;
        this.tva = tva;
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("FCF", "get_seq_facture_client_fille");
        setId(makePK(c));
    }

    @Override
    public String getLiaisonMere() {
        return "idmere";
    }

    @Override
    public ClassMAPTable createObject(String user, Connection c) throws Exception {
        if (getTauxDonne() == false) {
            setTaux(getTauxRecent(c));
        }
        return super.createObject(user, c);
    }

    public void verifActivite(Connection c) throws Exception {
        Activite act = getActivite(c);
        if (act != null && act.getEtat() < ConstanteEtat.getEtatValider()) {
            throw new Exception("Activite non visee !");
        }
    }

    @Override
    public void controlerUpdate(Connection c) throws Exception {
        verifActivite(c);
        if(this.getTaux()<=0) setTaux(getTauxRecent(c));
        super.controlerUpdate(c);
    }

    public Rubrique getRubrique(Connection c) throws Exception {
        String awhere = " and id = '%s'";
        String idRubrique = null;

        if (this.getRubrique() != null) {
            idRubrique = this.getRubrique();
        } else if (this.getIdactivite() != null) {
            idRubrique = this.getActivite(c).getRubrique();
        }

        awhere = String.format(awhere, idRubrique);
        Rubrique[] rub = (Rubrique[]) CGenUtil.rechercher(new Rubrique(), null, null, c, awhere);

        return rub != null && rub.length > 0 ? rub[0] : null;
    }

    public Activite getActivite(Connection c) throws Exception {
        Activite retour = null;
        Boolean estOuvert = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                estOuvert = true;
            }
            Activite ac = new Activite();
            ac.setNomTable("ACTIVITELIBCOMPLET");
            Activite[] liste = (Activite[]) CGenUtil.rechercher(ac, null, null, c, " and id='" + this.getIdactivite() + "'");
            if (liste.length > 0) {
                retour = liste[0];
            }
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && estOuvert) {
                c.close();
            }
        }
        return retour;
    }

    public void remove(String id, String user) throws Exception {
        Connection c = null;

        try {
            c = (new UtilDB()).GetConn();
            c.setAutoCommit(false);
            FactureClientDetails[] factureFArray = (FactureClientDetails[]) CGenUtil.rechercher(new FactureClientDetails(), null, null, c, String.format(" and id = '%s' ", id));
            if (factureFArray == null || factureFArray.length == 0) {
                throw new Exception("Facture details inexistant");
            }

            factureFArray[0].deleteToTableWithHisto(user, c);

            c.commit();
        } catch (Exception e) {
            if (c != null) {
                c.rollback();
            }
        } finally {
            if (c != null) {
                c.close();
            }
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

    public static double getValeurTaux(Connection c, String nomTable, Date date, String idDevise) throws Exception {
        String awhere = " and daty = (SELECT max(daty) FROM " + nomTable + " WHERE  daty <= to_date('" + Utilitaire.datetostring(date) + "', 'dd/mm/yyyy') and iddevise = '" + idDevise + "') "
                + " and iddevise = '" + idDevise + "'";
        Coursdevise cours = new Coursdevise();
        cours.setNomTable(nomTable);
        Coursdevise[] cd = (Coursdevise[]) CGenUtil.rechercher(cours, null, null, c, awhere);

        return cd != null && cd.length > 0 ? cd[0].getMontant() : 0;
    }

    public boolean verifTauxRecentMICTSL(Connection c) throws Exception {
        String getEstMictsl = this.getMere().getEstMictsl();

        if (getEstMictsl != null && getEstMictsl.equals(Constante.estMictsl) && this.getRubrique() != null) {
            Rubrique[] rubs = (Rubrique[]) CGenUtil.rechercher(new Rubrique(), null, null, c, " and CATEGORIE = '" + Constante.idCatRubConteneur + "'");

            for (int i = 0; i < rubs.length; i++) {
                if (this.getRubrique().equals(rubs[i].getId())) {
                    return true;
                }
            }
        }
        return false;
    }

    public double getTauxRecent(Connection c) throws Exception {
        this.findMere(c);
        if (this.getMere() == null) {
            throw new Exception("Facture mere introuvable");
        }
        if (this.getRubrique() != null && this.getRubrique().compareTo(Constante.idRedevanceVariable) == 0) {
            return getTauxFinDuMois(c, this.getMois(), this.getAnnee(), this.getDevise());
        }
        if (verifTauxRecentMICTSL(c)) {
            return getTauxRecentMICTSL(c);
        }

        return getTauxRecentNormal(c);
    }

    public FactureClient findMere(Connection c) throws Exception {
        if (this.getMere() == null) {
            FactureClient fc = new FactureClient();
            fc.setId(this.getIdmere());
            fc.setEstDDPMICTSL(null);
            FactureClient[] tmp = (FactureClient[]) CGenUtil.rechercher(fc, null, null, c, "");

            if (tmp != null && tmp.length > 0) {
                this.setMere(tmp[0]);
                return tmp[0];
            }
        }

        return this.getMere();
    }

    /*public double getTauxRecentNormal(Connection c) throws Exception {
        this.findMere(c);
        Date date = this.getMere().getDaty();
        if(this.getMere().getIdprevision()!=null){
            Prevision prev=this.getMere().findPrevision("previsiontypeBornage",c);
            if(prev==null){ // cas escale
                if (this.getIdactivite() != null && this.getDatefact() != null) {
                    date =this.getDatefact();
                }
            }
        }
        return getValeurTaux(c, "coursdeviseNonMICTSL", date);
    }*/
    public double getTauxRecentNormal(Connection c) throws Exception {
        this.findMere(c);
        FactureClient mere = this.getMere();
        Date date = mere.getDaty();
        if (mere.getIdprevision() != null) {
            Prevision prev = mere.findPrevision("PREVISIONTYPEBORNAGE", c);
            if (prev.getType().compareToIgnoreCase("TYPES0001") != 0) { // cas escale
                if (prev.getDate_depart() != null) {
                    date = prev.getDate_depart();
                }
            }
        } else {
            if (mere.getBateau() != null && mere.getDateDepart() != null && mere.getIdcategorie().compareTo(Constante.idCategorieFCProvision) == 0) {
                date = mere.getDateDepart();
            }
        }
        return getValeurTaux(c, "coursdeviseNonMICTSL", date);
    }

    public double getTauxRecentMICTSL(Connection c) throws Exception {
        this.findMere(c);
        Date date = this.getMere().getDaty();
        return getValeurTaux(c, "coursdeviseMICTSL", date);
    }

    public FactureClientDetails[] getFillesSoeurs(boolean inferieur, Connection c, String nomtable) throws Exception {
        FactureClientDetails facture = new FactureClientDetails();
        if (nomtable == null) {
            nomtable = "facture_client_fille";
        }
        facture.setNomTable(nomtable);
        facture.setIdmere(this.getIdmere());
        String where = " and rang >= " + this.getRang() + " and id != '" + this.getId() + "' order by rang asc";
        if (inferieur) {
            where = " and rang <= " + this.getRang() + " and id != '" + this.getId() + "' order by rang desc";
        }
        FactureClientDetails[] reponse = (FactureClientDetails[]) new CGenUtil().rechercher(facture, null, null, c, where);
        return reponse;
    }

    public void monter(String id, int monter, Connection c, String user) throws Exception {
        boolean ouvert = false;

        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                ouvert = true;
            }

            FactureClientDetails fcd = (FactureClientDetails) CGenUtil.rechercher(new FactureClientDetails(), null, null, c, String.format("and id='%s'", id))[0];
            fcd.monter(monter, c, user);

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

    public void monter(int monter, Connection c, String user) throws Exception {
        FactureClientDetails[] soeurs = getFillesSoeurs(monter == 1, c, null);
        int valeur = monter == 1 ? -1 : 1;

        if (soeurs != null && soeurs.length > 0) {
            if (this.getRang() != soeurs[0].getRang()) {
                valeur = 0;
            }
            int rang = this.getRang();
            this.setRang(soeurs[0].getRang() + valeur);
            this.updateToTableWithHisto(user, c);

            if (valeur == 0) {
                soeurs[0].setRang(rang);
                soeurs[0].updateToTableWithHisto(user, c);
            }
        }
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

    public String getIdmere() {
        return idmere;
    }

    public void setIdmere(String idmere) {
        this.idmere = idmere;
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

    public double getTaux() {
        return taux;
    }

    public void setTaux(double taux) {
        this.taux = taux;
    }

    public String getCompte() {
        return compte;
    }

    public void setCompte(String compte) throws Exception {
        if (this.getMode().compareTo("modif") == 0) {
            if (compte == null || compte.compareTo("") == 0) {
                throw new Exception("Compte obligatoire");
            }
        }
        this.compte = compte;
    }

    public String getIdproduit() {
        return idproduit;
    }

    public void setIdproduit(String idproduit) {
        this.idproduit = idproduit;
    }

    public String getDevise() {
        return devise;
    }

    public void setDevise(String devise) {
        this.devise = devise;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    @Override
    public FactureClient getMere() {
        return (FactureClient) super.getMere();
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public String getIdactivite() {
        return idactivite;
    }

    public void setIdactivite(String idactivite) {
        this.idactivite = idactivite;
    }

    public String getCategorieFacturelib() {
        return categorieFacturelib;
    }

    public void setCategorieFacturelib(String categorieFacturelib) {
        this.categorieFacturelib = categorieFacturelib;
    }

    public String getCategorieClientlib() {
        return categorieClientlib;
    }

    public void setCategorieClientlib(String categorieClientlib) {
        this.categorieClientlib = categorieClientlib;
    }

    public String getRubrique() {
        return rubrique;
    }

    public void setRubrique(String rubrique) {
        this.rubrique = rubrique;
    }

    public void checkActivite(Connection c) throws Exception {
        if (this.getIdactivite() != null && this.getIdactivite().compareTo("") != 0) {
            Activite act = new Activite();
            act.setNomTable("ACTIVITESNONFACTUREES");
            Activite[] activites = (Activite[]) CGenUtil.rechercher(act, null, null, c, " and id ='" + this.getIdactivite() + "'");

            if (activites.length == 0) {
                throw new Exception("Cette activite a deja ete facturee ou n est pas encore visee");
            }
        }
    }

    public void controler(Connection c) throws Exception {
        verifActivite(c);
        this.checkActivite(c);
    }

}
