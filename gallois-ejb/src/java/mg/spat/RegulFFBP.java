/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.CGenUtil;
import bean.ClassEtat;
import data.FactureFData;
import ded.OrdonnerPayement;
import facture.FactureFournisseur;
import facture.PaiementFacture;
import java.sql.Connection;
import user.UserEJBBean;
import utilitaire.Constante;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;

/**
 *
 * @author Valiah Karen
 */
public class RegulFFBP extends ClassEtat {

    private String id, idbp, idff;

    private double montant;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdbp() {
        return idbp;
    }

    public void setIdbp(String idbp) {
        this.idbp = idbp;
    }

    public String getIdff() {
        return idff;
    }

    public void setIdff(String idff) {
        this.idff = idff;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public RegulFFBP() {
        this.setNomTable("regulFFBP");
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public void regulariserFFBP(String u, Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            FactureFData factData = new FactureFData();
            factData.initData(this.getIdbp());
            if (this.getMontant() > factData.getMontantTP()) {
                throw new Exception("Trop percu bon provisoire inférieur au montant de la facture");
            }
            OrdonnerPayement opp = new OrdonnerPayement();
            OrdonnerPayement[] op = (OrdonnerPayement[]) CGenUtil.rechercher(opp, null, null, c, " AND ded_id  like  '%"+this.getIdbp()+"%'");
            if (op.length > 0) {
                op[0].ajouterFF(u, this.getIdff(),c);
            } else {
                throw new Exception("Ordonner paiement inexistant.");
            }

            FactureFournisseur temp = new FactureFournisseur();
            FactureFournisseur facture = (FactureFournisseur) temp.getById(this.getIdff(), temp.getNomTable(), null);
            facture.setIdProvision(this.getIdbp());
            facture.updateToTableWithHisto(u, c);

            PaiementFacture paiement = new PaiementFacture();
            paiement.setNomTable("paiementfacturef");
            PaiementFacture[] paie = (PaiementFacture[]) CGenUtil.rechercher(paiement, null, null, c, String.format(" and idfact = '%s' ", this.getIdbp()));
            if (paie.length > 0) {
                PaiementFacture paiementregul = new PaiementFacture("paiementfacturef", null, paie[0].getIdMvt(), this.getIdff(), this.getMontant());
                paiementregul.construirePK(c);
                paiementregul.insertToTableWithHisto(u, c);
            } else {
                throw new Exception("Bon provisoire non payé.");
            }
        } catch (Exception e) {
            if (c != null ) c.rollback();
            throw e;
        } finally {
            if (c != null && verif == 1) c.close();
        }
    }

    @Override
    public Object validerObject(String u, Connection c) throws Exception{
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            regulariserFFBP(u,c);
            super.validerObject(u, c);
            if (c != null && verif == 1) c.commit();
        } catch (Exception e) {
            if (c != null ) c.rollback();
            throw e;
        } finally {
            if (c != null && verif == 1) c.close();
        }
        return this;
    }

    public void construirePK(Connection c) throws Exception{
        this.preparePk("REGFFBP", "GET_SEQREGULFFBP");
        this.setId(makePK(c));
    }
}
