/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import avoir.AvoirFC;
import avoir.AvoirFF;
import avoir.AvoirFFFille;
import bean.CGenUtil;
import ded.OrdonnerPayement;
import java.sql.Connection;
import mg.spat.JournalCaisse;
import utilitaire.Constante;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author Lionel
 */
public class RegulFFProvision extends RegulFCProvision {
    public RegulFFProvision() {
        this.setNomTable("regulFFProvision");
    }
    public FactureFournisseur getFacture(Connection c, String id) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            FactureFournisseur cc = new FactureFournisseur();
            cc.setNomTable("factfourn_msum_lib");
            String awhere = String.format(" and id = '%s' ", id);
            FactureFournisseur[] result = (FactureFournisseur[]) CGenUtil.rechercher(cc, null, null, c, awhere);
            if (result != null && result.length > 0) {
                return result[0];
            }
            return null;
        } catch (Exception ex) {
            throw ex;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    @Override
    public void controler(Connection c) throws Exception {
        FactureFournisseur pr = getFacture(c, getIdProvision());
        if (pr.getEtat() < ConstanteEtat.getEtatValider()) {
            throw new Exception("Bon provisoire non vise");
        }
        FactureFournisseur fc = getFacture(c, getIdFacture());
        if (fc.getEtat() < ConstanteEtat.getEtatValider()) {
            throw new Exception("Facture non visee");
        }
    }
    public double getResteProvision(Connection c) throws Exception {
        EtatProvision etatP = new EtatProvision();
        etatP.setId(getIdProvision());
        EtatProvision retour=etatP.getEtatProvision("etatbpvrai",c);
        if(retour!=null)return retour.getMontantreste();
        return 0;
    }
    private void genererEntree(AvoirFF avoir, String u, Connection c) throws Exception { //genererSortie amin'ny RegulFC
        String libelle = "Regul Facture Avoir FF " + this.getId();
        JournalCaisse jc = new JournalCaisse(null, Constante.caisseCentrale,
                null, libelle, null, avoir.getTiers(), Constante.typeCheque,
                Utilitaire.dateDuJourSql(), Utilitaire.dateDuJourSql(), 0,avoir.getMontant());
        jc.setIdplacement(avoir.getIdfacture());
        jc.setIddevise(Constante.deviseAr);
        jc.createObject(u, c);
        jc.validerObject(u, c);

        PaiementFacture paiement = new PaiementFacture("paiementfacturef",null, jc.getId(), avoir.getIdfacture(), -avoir.getMontant());
        paiement.createObject(u, c);
    }
    private void genererSortie(AvoirFC avoir, String u, Connection c) throws Exception { //genererEntree amin'ny RegulFC
        String libelle = "Regul Facture Avoir FF " + this.getId();
        JournalCaisse jc = new JournalCaisse(null, Constante.caisseCentrale,
                null, libelle, null, avoir.getTiers(), Constante.typeCheque,
                Utilitaire.dateDuJourSql(), Utilitaire.dateDuJourSql(),  avoir.getMontant(),0);
        jc.setIdplacement(this.getIdFacture());
        jc.setIddevise(Constante.deviseAr);
        jc.createObject(u, c);
        jc.validerObject(u, c);

        PaiementFacture paiementFact = new PaiementFacture("paiementfacturef",null, jc.getId(), this.getIdFacture(), avoir.getMontant());
        paiementFact.createObject(u, c);
    }
    private void genererAvoirFille(String idavoir, String user, Connection c, double montant) throws Exception {
        int verif = 0;

        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }

            FactureFournisseurDetails fcd = new FactureFournisseurDetails();
            fcd.setNomTable("FACTURE_fourn_FILLETTC");
            fcd.setIdmere(this.getIdProvision());
            FactureClientDetails[] details = (FactureClientDetails[]) CGenUtil.rechercher(fcd, null, null, c, " order by montantttc");

            double montantinit = montant;

            for (int i = 0; i < details.length; i++) {
                montant = montantinit > details[i].getMontantTTC() ? details[i].getMontantTTC() : montantinit;

                if (montantinit > 0) {
                    montantinit = montantinit - montant;
                } else {
                    break;
                }

                AvoirFFFille fille = new AvoirFFFille();
                fille.setIdmere(idavoir);
                fille.setMontantdf(details[i].getMontantTTC());
                fille.setIddetailfacture(details[i].getId());
                fille.setMontant(montant);

                fille.createObject(user, c);
            }

            if (verif == 1) {
                c.commit();
            }
        } catch (Exception ex) {
            if (c != null && verif == 1) {
                c.rollback();
            }
            throw ex;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    public AvoirFF genererAvoir(String user, Connection c, double montant) throws Exception {
        int verif = 0;
        AvoirFF avoir = null;

        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }

            avoir = new AvoirFF();

            String designation = "Avoir auto regul provision " + this.getIdProvision();
            avoir.setDaty(utilitaire.Utilitaire.dateDuJourSql());
            avoir.setDesignation(designation);
            avoir.setIdfacture(this.getIdProvision());
            avoir.setCategorie(Constante.categorieAvoirFF);
            avoir.setType("1");
            //avoir.setMotif(Constante.motifAvoirFC);

            avoir.createObject(user, c);

            genererAvoirFille(avoir.getId(), user, c, montant);

            if (verif == 1) {
                c.commit();
            }
        } catch (Exception ex) {
            if (c != null && verif == 1) {
                c.rollback();
            }
            throw ex;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }

        return avoir;
    }
    private void regulariser(String u, Connection c) throws Exception {
        boolean verif = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = true;
                c.setAutoCommit(false);
            }

            EtatProvision etatProv = new EtatProvision();
            etatProv = (EtatProvision) etatProv.getById(this.getIdProvision(), "etatbpvrai", c);

            AvoirFF avoir = genererAvoir(u, c, etatProv.getMontantreste());
            avoir.validerObject(u, c);
            avoir = (AvoirFF) new AvoirFF().getById(avoir.getId(), "avoirFF_montant", c);

            //Entree
            genererEntree(avoir, u, c);

            //Sortie
            genererSortie(avoir, u, c);

            

            if (verif) {
                c.commit();
            }
        } catch (Exception ex) {
            if (c != null && verif) {
                c.rollback();
            }
            throw ex;
        } finally {
            if (c != null && verif) {
                c.close();
            }
        }
    }
    @Override
    public Object validerObject(String u, Connection c) throws Exception {
        regulariser(u, c);
        setMode("modif");
        controler(c);
        this.setEtat(ConstanteEtat.getEtatValider());
        this.updateToTableWithHisto(u, c);
        return this;
    }
}
