/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bordereau;

import bean.CGenUtil;
import bean.ClassEtat;
import bean.ClassMAPTable;
import bean.TypeObjet;
import ded.OrdonnerPayement;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.Constante;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author rasol
 */
public class Bordereau extends ClassEtat {

    private String id, numero, designation, tiers;
    private Date daty;
    private double montant;
    private String nomTableFille, nomFonctionSequence;

    public Bordereau() {
        this.setNomTable("bordereau");
        this.setNomTableFille("liaisonbordereau");
        this.setNomFonctionSequence("get_seqnumerobordereau");
    }
    
     @Override
    public ClassMAPTable createObject(String u, Connection c) throws Exception {
        setNumero(creerNumeroSequence(c));
        
        return super.createObject(u, c);
    }
    
    public String creerNumeroSequence(Connection c) throws Exception {
        checkAnnee(c);
        
        int maxSeq = Utilitaire.getMaxSeq(getNomFonctionSequence(), c);
        String numero = Utilitaire.completerInt(Constante.longueurNumeroBordereau, maxSeq);
        
        return numero;
    }
    
    public void checkAnnee(Connection c) throws Exception {
        TypeObjet obj = new TypeObjet();
        obj.setNomTable("ANNEE");
        obj = (TypeObjet)CGenUtil.rechercher(obj, null, null, c, "")[0];
        
        int anneeEnCours = Utilitaire.stringToInt(obj.getVal());
        
        if(Utilitaire.getAneeEnCours() > anneeEnCours) {
            obj.setVal(""+Utilitaire.getAneeEnCours());
            obj.setDesce(obj.getVal());
            
            obj.updateToTable(c);
            
            String prefix = "GET_";
            String seq = this.getNomFonctionSequence().substring(prefix.length());
            resetSequence(c, seq);
        }
    }

    @Override
    public Object validerObject(String u, Connection c) throws Exception {
        if (estPresent(c)) {
            throw new Exception("L'un(e) de ces OP/factures est déjà présent(e) dans un autre bordereau");
        }

        return super.validerObject(u, c);
    }

    private String[] getOps(BordereauFille[] filles) {
        String[] ops = new String[filles.length];

        for (int i = 0; i < filles.length; i++) {
            ops[i] = filles[i].getIdop();
        }

        return ops;
    }

    public boolean estPresent(Connection c) throws Exception {
        int verif = 0;
        boolean retour = false;

        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }

            BordereauFille[] filles = getFilles(c);
            BordereauFille[] tmp = null;

            if (filles != null && filles.length > 0) {

                String obj = Utilitaire.tabToString(getOps(filles), "'", ",");

                String req = "SELECT f.* FROM " + this.getNomTableFille() + " f "
                        + " JOIN " + this.getNomTable() + " b ON b.id = f.idbordereau "
                        + " WHERE idop in (" + obj + ") AND idbordereau != '" + this.getId() + "'"
                        + " and b.etat >= " + ConstanteEtat.getEtatValider();

                System.out.println("req " + req);

                tmp = (BordereauFille[]) CGenUtil.rechercher(new BordereauFille(), req, c);
            }
            
            retour = tmp != null && tmp.length > 0;
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }

        return retour;
    }

    public BordereauFille[] getFilles(Connection c) throws Exception {
        int verif = 0;
        BordereauFille[] res = new BordereauFille[0];

        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }

            BordereauFille op = new BordereauFille();
            op.setNomTable(this.getNomTableFille());
            res = (BordereauFille[]) CGenUtil.rechercher(op, null, null, c, " and idbordereau = '" + this.getId() + "'");
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }

        return res;
    }

    public void payer(String u, Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            Bordereau bordereau = (Bordereau) this.getById(this.getId(), "BORDEREAU", c);

            if (bordereau == null) {
                throw new Exception("Bordereau " + this.getId() + " non trouvé");
            }
            if (bordereau.getEtat() < ConstanteEtat.getEtatValider()) {
                throw new Exception("Bordereau non visé");
            }

            OrdonnerPayement[] ops = bordereau.getOPs(c);

            for (int i = 0; i < ops.length; i++) {
                if (ops[i].getEtat() < ConstanteEtat.getEtatValider()) {
                    throw new Exception("OP " + ops[i].getId() + " non visé");
                }
                ops[i].setTiers(bordereau.getTiers());
                ops[i].setRemarque("Paiement bordereau " + bordereau.getId());
                ops[i].payer(u, c);
            }
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
    }

    public OrdonnerPayement[] getOPs(Connection c) throws Exception {
        int verif = 0;
        OrdonnerPayement[] res = new OrdonnerPayement[0];

        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }

            OrdonnerPayement op = new OrdonnerPayement();
            op.setNomTable("ORDONNERPAYEMENT_BORDEREAU");
            res = (OrdonnerPayement[]) CGenUtil.rechercher(op, null, null, c, " and idbordereau = '" + this.getId() + "'");

            if (res.length > 0) {
                String[] idsOP = new String[res.length];
                for (int i = 0; i < res.length; i++) {
                    idsOP[i] = res[i].getId();
                }
                op.setNomTable("ORDONNERPAYEMENT_PAYE_LIB");
                OrdonnerPayement[] tab = (OrdonnerPayement[]) CGenUtil.rechercher(op, null, null, c, " and id in ( " + Utilitaire.tabToString(idsOP, "'", ",") + ")");
                if (tab.length > 0) {
                    throw new Exception("Il existe un OP déjà payé");
                }
            }
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }

        return res;
    }

    public String getNomTableFille() {
        return nomTableFille;
    }

    public void setNomTableFille(String nomTableFille) {
        this.nomTableFille = nomTableFille;
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

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public String getTiers() {
        return tiers;
    }

    public void setTiers(String tiers) {
        this.tiers = tiers;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public String getNomFonctionSequence() {
        return nomFonctionSequence;
    }

    public void setNomFonctionSequence(String nomFonctionSequence) {
        this.nomFonctionSequence = nomFonctionSequence;
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("BRD", "get_seq_bordereau");
        this.setId(makePK(c));
    }
    public static void resetSequence(Connection c, String seq) throws Exception {
        CallableStatement cs = null;
        try {
//            cs = c.prepareCall("ALTER SEQUENCE SEQNUMEROBORDEREAUFF RESTART WITH 1");
            
            System.out.println("seq " + seq);
            cs = c.prepareCall("CALL reset_seq('" + seq + "')");
            cs.executeUpdate();
        } catch (Exception e) {
            throw e;
        } finally {
            if (cs != null) {
                cs.close();
            }
        }
    }
}
