/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture.tr;

import bean.AdminGen;
import bean.CGenUtil;
import bean.ClassEtat;
import facture.FactureClient;
import mg.spat.JournalCaisse;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;

import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author Rado
 */
public class Traite extends ClassEtat {

    String id, tiers, banque, reference;
    Date daty, dateEcheance;
    double montant,escompte,total;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTiers() {
        return tiers;
    }

    public void setTiers(String tiers) {
        this.tiers = tiers;
    }

    public String getBanque() {
        return banque;
    }

    public void setBanque(String banque) {
        this.banque = banque;
    }

    public String getReference() {
        return reference;
    }

    public void setReference(String reference) {
        this.reference = reference;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public Date getDateEcheance() {
        return dateEcheance;
    }

    public void setDateEcheance(Date dateEcheance) {
        this.dateEcheance = dateEcheance;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public double getEscompte() {
        return escompte;
    }

    public void setEscompte(double escompte) {
        this.escompte = escompte;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }
    
    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public Traite() {
        this.setNomTable("traite");
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("TR", "getseqtraite");
        this.setId(makePK(c));
    }

    public Escompte[] getEscompte(Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            Escompte escompte = new Escompte();
            escompte.setIdTraite(this.getId());
            return (Escompte[]) CGenUtil.rechercher(escompte, null, null, c, " AND ETAT=" + ConstanteEtat.getEtatValider());
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    public JournalCaisse[] getRetour(Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            JournalCaisse jc = new JournalCaisse();
            jc.setIdordre(this.getId());
            return (JournalCaisse[]) CGenUtil.rechercher(jc, null, null, c, " AND DEBIT!=0");
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    public FactureClient[] getFactureLiees(Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            FactureClient fact = new FactureClient();
            fact.setNomTable("factureclient_traite");
            fact.setIdtraite(this.getId());
            return (FactureClient[]) CGenUtil.rechercher(fact, null, null, c, "");
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    public double getSolde(Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            FactureClient[] facture = getFactureLiees(c);
            double montantF = AdminGen.calculSommeDouble(facture, "montant");
            return this.getMontant() - montantF;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    
    public String getValColLibelle(){
        return id+";"+montant;
    }
}
