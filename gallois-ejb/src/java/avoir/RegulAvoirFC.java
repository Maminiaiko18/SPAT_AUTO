/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package avoir;

import bean.CGenUtil;
import bean.ClassMAPTable;
import ded.OrdonnerPayement;
import facture.FactureClient;
import facture.PaiementFacture;
import java.sql.Connection;
import mg.spat.JournalCaisse;
import utilitaire.Constante;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author Rija Ramilison
 */
public class RegulAvoirFC extends ClassMAPTable {

    private String id, idAvoir, idFacture;

    public RegulAvoirFC() {
        this.setNomTable("regulAvoirFC");
    }

    public RegulAvoirFC(String id, String idAvoir, String idFacture) {
        this.setNomTable("regulAvoirFC");
        this.setId(id);
        this.setIdAvoir(idAvoir);
        this.setIdFacture(idFacture);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdAvoir() {
        return idAvoir;
    }

    public void setIdAvoir(String idAvoir) {
        this.idAvoir = idAvoir;
    }

    public String getIdFacture() {
        return idFacture;
    }

    public void setIdFacture(String idFacture) {
        this.idFacture = idFacture;
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("RGA", "get_seq_regulAvoirFC");
        setId(makePK(c));
    }

    public FactureClient getFacture(Connection c) throws Exception {
        boolean verif = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = true;
                c.setAutoCommit(false);
            }

            FactureClient fc = new FactureClient();
            fc.setNomTable("facture_client_union");
            FactureClient[] result = (FactureClient[]) CGenUtil.rechercher(fc, null, null, c, String.format(" and id = '%s' ", this.getIdFacture()));
            if (result.length > 0) {
                return result[0];
            }
            return null;
        } finally {
            if (c != null && verif) {
                c.close();
            }
        }
    }

    @Override
    public void controler(Connection c) throws Exception {
        FactureClient fc = getFacture(c);
        if (fc == null) {
            throw new Exception("Facture absente");
        }
        if (fc.getEtat() < ConstanteEtat.getEtatValider()) {
            throw new Exception("Facture client non visee");
        }

        AvoirFC avoir = getAvoir(c);
        if (avoir == null) {
            throw new Exception("Avoir absent");
        }
        if (avoir.getEtat() < ConstanteEtat.getEtatValider()) {
            throw new Exception("Avoir non vise");
        }

        super.controler(c);
    }

    public AvoirFC getAvoir(Connection c) throws Exception {
        boolean verif = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = true;
                c.setAutoCommit(false);
            }

            AvoirFC afc = new AvoirFC();
            afc.setNomTable("avoirFC_montant");
            AvoirFC[] result = (AvoirFC[]) CGenUtil.rechercher(afc, null, null, c, String.format(" and id = '%s' ", this.getIdAvoir()));
            if (result.length > 0) {
                return result[0];
            }
            return null;
        } finally {
            if (c != null && verif) {
                c.close();
            }
        }
    }

    @Override
    public ClassMAPTable createObject(String u, Connection c) throws Exception {
        boolean verif = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = true;
                c.setAutoCommit(false);
            }

            this.regulariser(u, c);
            super.createObject(u, c);
            if (verif) {
                c.commit();
            }
            return this;
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

    private void genererSortie(AvoirFC avoir, String u, Connection c) throws Exception {
        OrdonnerPayement op = avoir.genererOP(c);
        op.createObject(u, c);
        op.validerObject(u, c);

        String libelle = "Regul Facture Avoir " + this.getId();
        JournalCaisse jc = new JournalCaisse(null, Constante.caisseCentrale,
                null, libelle, null, avoir.getTiers(), Constante.typeCheque,
                Utilitaire.dateDuJourSql(), Utilitaire.dateDuJourSql(), avoir.getMontant(), 0);
        jc.setIdplacement(avoir.getIdfacture());
        jc.setIddevise(Constante.deviseAr);
        jc.construirePK(c);
        jc.setEtat(ConstanteEtat.getEtatValider());
        jc.insertToTableWithHisto(u, c);

        PaiementFacture paiement = new PaiementFacture(null, jc.getId(), avoir.getIdfacture(), avoir.getMontant());
        paiement.createObject(u, c);
    }
    
    private void genererEntree(AvoirFC avoir, String u, Connection c) throws Exception {
        String libelle = "Regul Facture Avoir " + this.getId();
        JournalCaisse jc = new JournalCaisse(null, Constante.caisseCentrale,
                null, libelle, null, avoir.getTiers(), Constante.typeCheque,
                Utilitaire.dateDuJourSql(), Utilitaire.dateDuJourSql(), 0, avoir.getMontant());
        jc.setIdplacement(avoir.getIdfacture());
        jc.setIddevise(Constante.deviseAr);
        jc.construirePK(c);
        jc.setEtat(ConstanteEtat.getEtatValider());
        jc.insertToTableWithHisto(u, c);
    }

    private void regulariser(String u, Connection c) throws Exception {
        boolean verif = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = true;
                c.setAutoCommit(false);
            }

            AvoirFC avoir = getAvoir(c);

            //Sortie
            genererSortie(avoir, u, c);
            
            //Entree
            genererEntree(avoir, u, c);
            
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

}
