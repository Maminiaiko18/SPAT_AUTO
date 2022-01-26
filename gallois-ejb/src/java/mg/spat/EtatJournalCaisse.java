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
import utilitaire.UtilDB;

/**
 *
 * @author Nouta
 */
public class EtatJournalCaisse {
    private JournalCaisse[] listeDepenses;
    private double totalRecette,soldeAnterieur,soldeActuel;

    public EtatJournalCaisse(Date d) throws Exception {
        Connection c = null;
        
        try {
            c = (new UtilDB()).GetConn();
            
            String where = String.format("and dateeffet = '%s'", utilitaire.Utilitaire.datetostring(d));
            
        // Liste depenses
            JournalCaisse depense = new JournalCaisse();
            depense.setNomTable("journalcaisselibdepenseV");
            listeDepenses = (JournalCaisse[]) CGenUtil.rechercher(depense, null, null, c, where);
            
        // Total Recette
            JournalCaisse recette = new JournalCaisse();
            recette.setNomTable("JOURNALCAISSELIBRECETTE_VISE");
            JournalCaisse[] listeRecettes = (JournalCaisse[]) CGenUtil.rechercher(recette, null, null, c, where);
            totalRecette = AdminGen.calculSommeDouble(listeRecettes, "credit");
            
        } catch(Exception ex) {
            throw ex;
        }
        finally {
            if(c != null) c.close();
        }
    }
    
    public JournalCaisse[] getListeDepenses() {
        return listeDepenses;
    }

    public void setListeDepenses(JournalCaisse[] listeDepenses) {
        this.listeDepenses = listeDepenses;
    }

    public double getTotalRecette() {
        return totalRecette;
    }

    public void setTotalRecette(double totalRecette) {
        this.totalRecette = totalRecette;
    }

    public double getSoldeAnterieur() {
        return soldeAnterieur;
    }

    public void setSoldeAnterieur(double soldeAnterieur) {
        this.soldeAnterieur = soldeAnterieur;
    }
    
    public double getTotalDepenses()
    {
        return AdminGen.calculSommeDouble(listeDepenses, "debit");
    }
    
    public double getSoldeActuel(){
        return this.getSoldeAnterieur()+this.getTotalRecette()-this.getTotalDepenses();

    }
    public double getTotalDebitEtat()
    {
        return this.getSoldeAnterieur()+this.getTotalRecette();
    }
    public double getTotalCreditEtat()
    {
        return this.getTotalDepenses()+this.getSoldeActuel();
    }


    
    
}
