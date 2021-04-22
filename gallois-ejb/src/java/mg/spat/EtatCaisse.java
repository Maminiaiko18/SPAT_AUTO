/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.AdminGen;
import bean.CGenUtil;
import java.sql.Connection;
import java.sql.Date;
import mg.amadia.stock.EtatdeStockDate;
import mg.spat.placement.PlacementLibComplet;
import utilitaire.Constante;
import utilitaire.Utilitaire;
import utilitaire.UtilDB;

/**
 *
 * @author MEVA
 */
public class EtatCaisse {

    private String folio, caisse;
    private Date daty;
    private JournalCaisse[] listeCaisse;
    private JournalCaisse[] debits, credits;
    private double soldeAnterieur, soldeActuel, totalDebitJournal, totalCreditJournal, totalDebit, totalCredit, bonProvisoire;
    private PlacementLibComplet[] listePlacement;

    public EtatCaisse() {
    }

    public EtatCaisse(String caisse, Date daty) {
        this.caisse = caisse;
        this.daty = daty;
    }
    
    public double getSolde(Connection c, String caisse) throws Exception {
        JournalCaisse jc = new JournalCaisse();
        jc.setDateEffet(this.getDaty());
        jc.setCaisse(caisse);
//        Date jAvant = Utilitaire.ajoutJourDate(this.getDaty(), -1);

        Date jAvant = jc.getMaxDate(c);
//        if(jAvant == null) jAvant = Utilitaire.ajoutJourDate(this.getDaty(), -1);

        String date = Utilitaire.datetostring(jAvant);
        
        EtatdeStockDate[] tmp = EtatdeStockDate.calculEtatCaisse(date, null, caisse, c, null, null, date);
        
        return tmp != null && tmp.length > 0 ? tmp[0].getReste() : 0;
    }

    public double getSoldeAnterieur(Connection c) throws Exception {
        double soldeBP = getSolde(c, Constante.caisseCentraleBP);
        double soldeEspece = getSolde(c, Constante.caisseCentraleEspece);

        return soldeBP + soldeEspece;
    }

    public void generer(Connection c) throws Exception {
        boolean verif = false;

        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = true;
            }

            JournalCaisse jc = new JournalCaisse();
            jc.setCaisse(this.getCaisse());

            this.setDebits((JournalCaisse[]) CGenUtil.rechercher(jc, null, null, c, " and debit != 0 and dateeffet = to_date('" + this.getDaty() + "','YYYY-MM-dd') "));

            this.setTotalCreditJournal(AdminGen.calculSommeDouble(this.getDebits(), "credit"));

            this.setCredits((JournalCaisse[]) CGenUtil.rechercher(jc, null, null, c, " and credit != 0 and dateeffet = to_date('" + this.getDaty() + "','YYYY-MM-dd') "));

            this.setTotalDebitJournal(AdminGen.calculSommeDouble(this.getCredits(), "debit"));

            this.setListePlacement(new PlacementLibComplet[0]);
            
            soldeAnterieur = getSoldeAnterieur(c);
            
//            System.out.println("solde anterieur " + soldeAnterieur);
            
            soldeActuel = soldeAnterieur + this.getTotalDebitJournal() - this.getTotalCreditJournal();
            totalDebit = totalDebitJournal + soldeAnterieur;
            totalCredit = totalCreditJournal + soldeActuel;
        } catch (Exception ex) {
            throw ex;
        } finally {
            if (c != null && verif) {
                c.close();
            }
        }
    }

    public double getBonProvisoire() {
        return bonProvisoire;
    }

    public void setBonProvisoire(double bonProvisoire) {
        this.bonProvisoire = bonProvisoire;
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

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public JournalCaisse[] getListeCaisse() {
        return listeCaisse;
    }

    public void setListeCaisse(JournalCaisse[] listeCaisse) {
        this.listeCaisse = listeCaisse;
    }

    public double getSoldeAnterieur() {
        return soldeAnterieur;
    }

    public void setSoldeAnterieur(double soldeAnterieur) {
        this.soldeAnterieur = soldeAnterieur;
    }

    public double getSoldeActuel() {
        return soldeActuel;
    }

    public void setSoldeActuel(double soldeActuel) {
        this.soldeActuel = soldeActuel;
    }

    public double getTotalDebitJournal() {
        return totalDebitJournal;
    }

    public void setTotalDebitJournal(double totalDebitJournal) {
        this.totalDebitJournal = totalDebitJournal;
    }

    public double getTotalCreditJournal() {
        return totalCreditJournal;
    }

    public void setTotalCreditJournal(double totalCreditJournal) {
        this.totalCreditJournal = totalCreditJournal;
    }

    public double getTotalDebit() {
        return totalDebit;
    }

    public void setTotalDebit(double totalDebit) {
        this.totalDebit = totalDebit;
    }

    public JournalCaisse[] getDebits() {
        return debits;
    }

    public void setDebits(JournalCaisse[] debits) {
        this.debits = debits;
    }

    public JournalCaisse[] getCredits() {
        return credits;
    }

    public void setCredits(JournalCaisse[] credits) {
        this.credits = credits;
    }

    public double getTotalCredit() {
        return totalCredit;
    }

    public void setTotalCredit(double totalCredit) {
        this.totalCredit = totalCredit;
    }

    public PlacementLibComplet[] getListePlacement() {
        return listePlacement;
    }

    public void setListePlacement(PlacementLibComplet[] listePlacement) {
        this.listePlacement = listePlacement;
    }
}
