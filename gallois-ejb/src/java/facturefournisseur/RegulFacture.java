/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facturefournisseur;

import bean.AdminGen;
import bean.CGenUtil;
import bean.ClassEtat;
import java.sql.Date;
import bean.ClassMAPTable;
import ded.OrdonnerPayement;
import java.lang.reflect.Field;
import java.sql.Connection;
import mg.spat.BonProvisoire;
import mg.spat.JournalCaisse;
import utilitaire.Constante;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author Sanda
 */
public class RegulFacture extends ClassEtat {

    private String id, idbon, remarque, idfacture;
    private Date daty;
    private double montant;

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public RegulFacture() {
        super.setNomTable("regulFacture");
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("RF", "get_seq_regulFacture");
        this.setId(makePK(c));
    }

    @Override
    public Object validerObject(String u, Connection c) throws Exception {
        controler(c);
        
        OrdonnerPayement op = new OrdonnerPayement(this.getIdfacture(), this.getMontant(), Utilitaire.dateDuJourSql(), u, "Regularisation Facture " + this.getIdfacture(), ConstanteEtat.getEtatCreer());
        BonProvisoire bp = getBonProvisoire(c);
        op.setTiers(bp.getBeneficiaire());
        op.createObject(u, c);
        op.validerObject(u, c);
        
        JournalCaisse sortie = new JournalCaisse(null, Constante.caisseCentrale, null, "Regularisation Facture " + this.getIdfacture(), null, Utilitaire.dateDuJourSql(), Utilitaire.dateDuJourSql(), op.getMontant(), 0);
        sortie.setIdordre(op.getTuppleID());
        sortie.setIdplacement(bp.getId());
        sortie.setIddevise(Constante.deviseAr);
        sortie.setIdmode(Constante.modepaiementDefaut);

        
        sortie.createObject(u, c);
        sortie.validerObject(u, c);

        /*JournalCaisse entree = new JournalCaisse(null, bp.getCaisse(), null, "Regularisation Facture " + this.getIdfacture(), null, Utilitaire.dateDuJourSql(), Utilitaire.dateDuJourSql(), 0, op.getMontant());
        entree.setIddevise(Constante.deviseAr);
        entree.setIdmode(Constante.modepaiementDefaut);
        entree.createObject(u, c);
        entree.validerObject(u, c);*/

        setMode("modif");
        this.setEtat(ConstanteEtat.getEtatValider());
        this.updateToTableWithHisto(u, c);
        return this;
    }

    @Override
    public void controler(Connection c) throws Exception {
        EtatFactureMontantDaty[] ff = getFactures(c);
        if (ff == null || ff.length != this.getIdfacture().split(";").length) {
            throw new Exception("Veuillez viser les factures avant");
        }
        BonProvisoire bp = getBonProvisoire(c);
        if (bp == null) {
            throw new Exception("Bon provisoire inexistant");
        }
        if (bp.getEtat() == ConstanteEtat.getEtatRegulariser()) {
            throw new Exception("Ce bon est déjà regularisé");
        }
    }

    public OrdonnerPayement getOP(Connection c, String nomTable) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }

            OrdonnerPayement op = new OrdonnerPayement();

            if (nomTable != null) {
                op.setNomTable(nomTable);
            }

            OrdonnerPayement[] tmp = (OrdonnerPayement[]) CGenUtil.rechercher(op, null, null, c, " and ded_id = '" + this.getIdfacture() + "'");

            if (tmp != null && tmp.length > 0) {
                return tmp[0];
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

    public EtatFactureMontantDaty[] getFactures(Connection c) throws Exception {
        int verif = 0;
        EtatFactureMontantDaty[] factures = new EtatFactureMontantDaty[0];

        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }

            EtatFactureMontantDaty ff = new EtatFactureMontantDaty();
            ff.setNomTable("ETATFACTUREMONTANTDATYVISE");
            String[] idFacts = this.getIdfacture().split(";");
            String in = Utilitaire.tabToString(idFacts, "'", ",");
            factures = (EtatFactureMontantDaty[]) CGenUtil.rechercher(ff, null, null, c, " and id in (" + in + ") ");
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }

        return factures;
    }

//    public EtatFactureMontantDaty getFacture(Connection c) throws Exception {
//        int verif = 0;
//        try {
//            if (c == null) {
//                c = new UtilDB().GetConn();
//                verif = 1;
//            }
//
//            EtatFactureMontantDaty ff = new EtatFactureMontantDaty();
//            ff.setNomTable("ETATFACTUREMONTANTDATYVISE");
//            EtatFactureMontantDaty[] tmp = (EtatFactureMontantDaty[]) CGenUtil.rechercher(ff, null, null, c, " and id = '" + this.getIdfacture() + "'");
//
//            if (tmp != null && tmp.length > 0) {
//                return tmp[0];
//            }
//        } catch (Exception e) {
//            throw e;
//        } finally {
//            if (c != null && verif == 1) {
//                c.close();
//            }
//        }
//
//        return null;
//    }
    public BonProvisoire getBonProvisoire(Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }

            BonProvisoire bp = new BonProvisoire();
            BonProvisoire[] tmp = (BonProvisoire[]) CGenUtil.rechercher(bp, null, null, c, " and id = '" + this.getIdbon() + "'");

            if (tmp != null && tmp.length > 0) {
                return tmp[0];
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

    public double getMontantAPayer(Connection c) throws Exception {
        int verif = 0;
        double montant = 0;

        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }

            EtatFactureMontantDaty[] factures = getFactures(c);
            double resteFacture = AdminGen.calculSommeDouble(factures, "montantttc");

            OrdonnerPayement op = getOP(c, "ORDONNERPAYEMENTGROUPEFACT");

            if (op != null) {
                resteFacture = resteFacture - op.getMontant();
            }

            BonProvisoire bp = getBonProvisoire(c);

            double resteBP = bp.getReste(c);
            double tmp = resteFacture - resteBP;
//            System.out.println("Reste BP=" + resteBP);
//            System.out.println("Reste FF=" + resteFacture);
//            System.out.println("Control=" + tmp);

            montant = tmp > 0 ? resteBP : resteFacture;
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }

        return montant;
    }

    public ClassMAPTable createObject(String u, Connection c) throws Exception {
        this.setMontant(this.getMontantAPayer(c));
        return super.createObject(u, c);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdbon() {
        return idbon;
    }

    public void setIdbon(String idbon) {
        this.idbon = idbon;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public String getIdfacture() {
        return idfacture;
    }

    public void setIdfacture(String idfacture) {
        this.idfacture = idfacture;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

}
