package facturefournisseur;

import bean.*;
import java.sql.Connection;
import mg.spat.stock.BonDeLivraison;
import mg.spat.stock.BonDeLivraisonFille;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

public class FactureFournisseurLettre extends ClassMAPTable {

    public String id;
    public String designation;
    public String remarque;
    public double idTVA;
    public java.sql.Date dateEmission;
    private String resp;
    private java.sql.Date datyecheance;
    public java.sql.Date daty;
    public String idFournisseur;
    public String idDevise;
    public double montantTTC;
    private String entite;
    private String budget;
    private String etat;
    String numFact;
    private String numid;

    public String getEtatText(String etat) {
        FactureFournisseur f = new FactureFournisseur();
        return f.getEtatText(Utilitaire.stringToInt(etat));
    }

    public String getNumid() {
        return numid;
    }

    public void setNumid(String numid) {
        this.numid = numid;
    }

    public String getBudget() {
        return budget;
    }

    public void setBudget(String budget) {
        this.budget = budget;
    }

    public String getEntite() {
        return entite;
    }

    public void setEntite(String entite) {
        this.entite = entite;
    }

    public String getEtat() {
        return etat;
    }

    public void setEtat(String etat) {
        this.etat = etat;
    }

    public FactureFournisseurLettre() {
        super.setNomTable("FactureFournisseur");
    }

    public String getAttributIDName() {
        return "id";
    }

    public String getTuppleID() {
        return this.getId();
    }

    public void setNumFact(String numFact) {
        this.numFact = numFact;
    }

    public java.sql.Date getDateEmission() {
        return dateEmission;
    }

    public String getNumFact() {
        return numFact;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getDesignation() {
        return designation;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

    public void setDaty(java.sql.Date daty) {
        this.daty = daty;
    }

    public java.sql.Date getDaty() {
        return daty;
    }

    public void setIdFournisseur(String idFournisseur) {
        this.idFournisseur = idFournisseur;
    }

    public String getIdFournisseur() {
        return idFournisseur;
    }

    public void setIdDevise(String idDevise) {
        this.idDevise = idDevise;
    }

    public String getIdDevise() {
        return idDevise;
    }

    public void setMontantTTC(double montantTTC) {
        this.montantTTC = montantTTC;
    }

    public double getMontantTTC() {
        return montantTTC;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setIdTVA(double idTVA) {
        this.idTVA = idTVA;
    }

    public double getIdTVA() {
        return idTVA;
    }

    public double calculMontantTva() {
        return getIdTVA();
    }

    public void setDateEmission(java.sql.Date dateEmission) {
        this.dateEmission = dateEmission;
    }

    public void setResp(String resp) {
        this.resp = resp;
    }

    public String getResp() {
        return resp;
    }

    public void setDatyecheance(java.sql.Date datyecheance) {
        this.datyecheance = datyecheance;
    }

    public java.sql.Date getDatyecheance() {
        return datyecheance;
    }

    public Detailsffbonlivraison[] getFilleBL(String nomtable, Connection c) throws Exception {
        Detailsffbonlivraison[] retour = null;
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;

            }
            Detailsffbonlivraison df = new Detailsffbonlivraison();
            df.setNomTable(nomtable);
            retour = (Detailsffbonlivraison[]) CGenUtil.rechercher(df, null, null, c, " and idmere='" + this.getId() + "'");
            return retour;
        } catch (Exception ex) {
            throw ex;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    public FactureFournisseur getFactureFournisseur(Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            FactureFournisseur[] factfournisseur = (FactureFournisseur[]) CGenUtil.rechercher(new FactureFournisseur(), null, null, c, " and  id='" + this.getId() + "'");
            if (factfournisseur == null || factfournisseur.length == 0) {
                throw new Exception("facture fournisseur introuvable");
            }
            return factfournisseur[0];
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
    }

    public FactureFournisseur getFactureFournisseur(String nomtable, Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            FactureFournisseur ff = new FactureFournisseur();
            if (nomtable != null && nomtable.compareToIgnoreCase("") != 0) {
                ff.setNomTable(nomtable);
            }
            FactureFournisseur[] factfournisseur = (FactureFournisseur[]) CGenUtil.rechercher(ff, null, null, c, " and  id='" + this.getId() + "'");
            if (factfournisseur == null || factfournisseur.length == 0) {
                throw new Exception("facture fournisseur introuvable");
            }
            return factfournisseur[0];
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
    }

    public String livrerBL(String user, String nomtable, Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            //controle de doublon
            // this.controlerDoublonBL(c);
            FactureFournisseur ff = this.getFactureFournisseur(nomtable, c);
            if (ff.getEtat() < ConstanteEtat.getEtatValider()) {
                throw new Exception("facture fournisseur non vis&eacute;");
            }

            BonDeLivraison bl = new BonDeLivraison(ff.getDesignation(), ff.getId(), ff.getDaty());
//            bl.setPoint(ff.getEntite());
            //String remarque, String idbc, Date daty
            bl.construirePK(c);
            bl.insertToTableWithHisto(user, c);
            Detailsffbonlivraison[] lsfille = this.getFilleBL("Detailsffbonlivraison", c);
            for (Detailsffbonlivraison tmp : lsfille) {
                BonDeLivraisonFille bdf = new BonDeLivraisonFille(tmp.getIdingredient(), bl.getId(), 1, tmp.getReste(), tmp.getId());
                bdf.construirePK(c);
                bdf.insertToTableWithHisto(user, c);
            }

            if (c != null && verif == 1) {
                c.commit();
            }
            return bl.getId();
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

    }

    public String livrerBL(String user, Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            //controle de doublon
            // this.controlerDoublonBL(c);
            FactureFournisseur ff = this.getFactureFournisseur(c);
            if (ff.getEtat() < ConstanteEtat.getEtatValider()) {
                throw new Exception("facture fournisseur non vis&eacute;");
            }

            BonDeLivraison bl = new BonDeLivraison(ff.getDesignation(), ff.getId(), ff.getDaty());
//            bl.setPoint(ff.getEntite());
            //String remarque, String idbc, Date daty
            bl.construirePK(c);
            bl.insertToTableWithHisto(user, c);
            Detailsffbonlivraison[] lsfille = this.getFilleBL("Detailsffbonlivraison", c);
            for (Detailsffbonlivraison tmp : lsfille) {
                BonDeLivraisonFille bdf = new BonDeLivraisonFille(tmp.getIdingredient(), bl.getId(), 1, tmp.getReste(), tmp.getId());
                bdf.construirePK(c);
                bdf.insertToTableWithHisto(user, c);
            }

            if (c != null && verif == 1) {
                c.commit();
            }
            return bl.getId();
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

    }
}
