/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bordereau;

import bean.CGenUtil;
import bean.ClassEtat;
import ded.OrdonnerPayement;
import java.sql.Connection;
import java.sql.Date;
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

    public Bordereau() {
        this.setNomTable("bordereau");
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
            if(bordereau.getEtat() < ConstanteEtat.getEtatValider()) throw new Exception("Bordereau non visé");
            
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
            
            if(res.length>0){
                String[] idsOP=new String[res.length];
                for(int i=0;i<res.length;i++){
                    idsOP[i]=res[i].getId();
                }
                op.setNomTable("ORDONNERPAYEMENT_PAYE_LIB");
                OrdonnerPayement[] tab = (OrdonnerPayement[]) CGenUtil.rechercher(op, null, null, c, " and id in ( " + Utilitaire.tabToString(idsOP, "'", ",") + ")");
                if(tab.length>0) throw new Exception("Il existe un OP déjà payé");
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
    
    @Override
    public void construirePK(Connection c) throws Exception{
        this.preparePk("BRD","get_seq_bordereau");
        this.setId(makePK(c));
    }
}
