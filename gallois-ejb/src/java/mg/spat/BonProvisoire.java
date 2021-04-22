/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.AdminGen;
import bean.CGenUtil;
import bean.ClassEtat;
import bean.ClassMAPTable;
import bon.RegulBP;
import ded.OrdonnerPayementBP;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import utilitaire.Constante;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author Antsa
 */
public class BonProvisoire extends ClassEtat {

    private String id, folio, caisse, numpiece, libelle, remarque, idfacture, beneficiaire;
    private Date datesaisie, dateeffet;
    private double debit, credit;

    private double reste;
    public BonProvisoire() {
        super.setNomTable("bon_provisoire");
    }

    public BonProvisoire(String id, String folio, String caisse, String numpiece, String libelle, String remarque, Date datesaisie, Date dateeffet, double debit, double credit) throws Exception {
        super.setNomTable("bon_provisoire");

        this.setId(id);
        this.setFolio(folio);
        this.setCaisse(caisse);
        this.setNumpiece(numpiece);
        this.setLibelle(libelle);
        this.setRemarque(remarque);
        this.setDatesaisie(datesaisie);
        this.setDateeffet(dateeffet);
        this.setDebit(debit);
        this.setCredit(credit);
    }

    public String getBeneficiaire() {
        return beneficiaire;
    }

    public void setBeneficiaire(String beneficiaire) {
        this.beneficiaire = beneficiaire;
    }

    public String getIdfacture() {
        return idfacture;
    }

    public void setIdfacture(String idfacture) {
        this.idfacture = idfacture;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getFolio() {
        return folio;
    }

    public void setFolio(String folio) {
        this.folio = folio;
    }

    public String getCaisse() {
        return caisse;
    }

    public void setCaisse(String caisse) {
        this.caisse = caisse;
    }

    public String getNumpiece() {
        return numpiece;
    }

    public void setNumpiece(String numpiece) {
        this.numpiece = numpiece;
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public Date getDatesaisie() {
        return datesaisie;
    }

    public void setDatesaisie(Date datesaisie) {
        if (this.getMode().equals("modif")) {
            datesaisie = Utilitaire.string_date("YYYY-MM-dd", Utilitaire.dateDuJour());
        }
        this.datesaisie = datesaisie;
    }

    public Date getDateeffet() {
        return dateeffet;
    }

    public void setDateeffet(Date dateeffet) {
        this.dateeffet = dateeffet;
    }

    public double getDebit() {
        return debit;
    }

    public void setDebit(double debit) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) 
        {
            if (debit < 0) {
                throw new Exception("debit invalide");
            }
        }
        this.debit = debit;
    }

    public double getCredit() {
        return credit;
    }

    public void setCredit(double credit) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (credit < 0) {
                throw new Exception("credit invalide");
            }
        }
        this.credit = credit;
    }

    @Override
    public String getTuppleID() {
        return this.id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public void construirePK(Connection c) throws Exception {
        this.preparePk("BP", "getseq_bon_provisoire");
        this.setId(makePK(c));

    }

    @Override
    public Object validerObject(String u, Connection c) throws Exception {
        double montant = Math.abs(this.getCredit() - this.getDebit());
        
        JournalCaisse sortie = new JournalCaisse(null, this.getCaisse(), null, "Bon Provisoire " + this.getId(), null, Utilitaire.dateDuJourSql(), Utilitaire.dateDuJourSql(), montant, 0);
        sortie.setIddevise(Constante.deviseAr);
        sortie.setIdmode(Constante.modepaiementDefaut);

        sortie.createObject(u, c);
        sortie.validerObject(u, c);
        
        JournalCaisse entree = new JournalCaisse(null, Constante.caisseCentrale, null, "Bon Provisoire " + this.getId(), null, Utilitaire.dateDuJourSql(), Utilitaire.dateDuJourSql(), 0, montant);
        entree.setIddevise(Constante.deviseAr);
        entree.setIdmode(Constante.modepaiementDefaut);
        entree.setIdplacement(this.getId());
        
        entree.createObject(u, c);
        entree.validerObject(u, c);
        
        return super.validerObject(u, c); //To change body of generated methods, choose Tools | Templates.
    }
    
    public RegulBP getRegulBPVise(Connection c) throws Exception {
        int verif = 0;
        RegulBP regulBP = null;
        
        try{
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            regulBP = new RegulBP();
            
            String where = "";
            where += " and idbon = '" + this.getId() + "'";
            where += " and etat >= " + ConstanteEtat.getEtatValider();
            
            RegulBP[] tmp = (RegulBP[]) CGenUtil.rechercher(regulBP, null, null, c, where);
            
            if(tmp != null && tmp.length > 0) {
                regulBP = tmp[0];
            }
        }catch(Exception e){
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
        
        return regulBP;
    }
    
    public double getMontantFacturePayes(Connection c) throws Exception {
        int verif = 0;
        double montant = 0;
        
        try{
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            OrdonnerPayementBP ordBP = new OrdonnerPayementBP();
            OrdonnerPayementBP[] tmp = (OrdonnerPayementBP[]) CGenUtil.rechercher(ordBP, null, null, c, " and idbon = '" + this.getId() + "'");
            
            if(tmp != null && tmp.length > 0) {
                montant = tmp[0].getMontant();
            }
        }catch(Exception e){
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
        
        return montant;
    }
    
    public RegulBonProvisoire[] getRegulBonPrpvisoire(Connection c) throws Exception{
        int verif = 0;
        try{
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
                c.setAutoCommit(false);
            }
            RegulBonProvisoire[] tRegulBonProvisoire = (RegulBonProvisoire[])CGenUtil.rechercher(new RegulBonProvisoire(), null, null, c, " and idBonProvisoire ='"+this.getId()+"' and montant>0");
            if(verif == 1) c.commit();
            return tRegulBonProvisoire;
        }catch(Exception e){
            c.rollback();
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    public RegulBonProvisoire[] getRetourBonPrpvisoire(Connection c) throws Exception{
        int verif = 0;
        try{
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
                c.setAutoCommit(false);
            }
            RegulBonProvisoire[] tRegulBonProvisoire = (RegulBonProvisoire[])CGenUtil.rechercher(new RegulBonProvisoire(), null, null, c, " and idBonProvisoire ='"+this.getId()+"' and montant<0");
            if(verif == 1) c.commit();
            return tRegulBonProvisoire;
        }catch(Exception e){
            c.rollback();
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    public double getReste() {
        return reste;
    }

    public void setReste(double reste) {
        this.reste = reste;
    }
    
    public double getReste(Connection c) throws Exception{
        int verif = 0;
        double reste = 0;
        try{
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            BonProvisoire bp1=new BonProvisoire();
            bp1.setNomTable("bon_provisoire_rst");
            bp1.setId(this.getId());
            BonProvisoire[] bp=(BonProvisoire[])CGenUtil.rechercher(bp1, null, null, c, "");
            if(bp.length>0){
                reste=bp[0].getReste();
            }
        }catch(Exception e){
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
        
        return reste;
    }
    
    public double getSommeRegulBonPrpvisoire(Connection c) throws Exception{
        int verif = 0;
        try{
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
                c.setAutoCommit(false);
            }
            RegulBonProvisoire[] tRegulBonProvisoire = this.getRegulBonPrpvisoire(c);
            double montantTotal = AdminGen.calculSommeDouble(tRegulBonProvisoire, "montant");
            if(verif == 1) c.commit();
            return montantTotal;
        }catch(Exception e){
            c.rollback();
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    public double getSommeRetourBonPrpvisoire(Connection c) throws Exception{
        int verif = 0;
        try{
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
                c.setAutoCommit(false);
            }
            RegulBonProvisoire[] tRetourBonProvisoire = this.getRetourBonPrpvisoire(c);
            double montantTotal = AdminGen.calculSommeDouble(tRetourBonProvisoire, "montant");
            if(verif == 1) c.commit();
            return montantTotal;
        }catch(Exception e){
            c.rollback();
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

}
