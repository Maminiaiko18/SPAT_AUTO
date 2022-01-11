/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.AdminGen;

/**
 *
 * @author Nouta
 */
public class EtatJournalCaisse {
    private JournalCaisse[] listeDepenses;
    private double totalRecette,soldeAnterieur,soldeActuel;
   
    
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
    
    double getTotalDepenses()
    {
        return AdminGen.calculSommeDouble(listeDepenses, "debit");
    }
    
    double getSoldeActuel(){
        return this.getSoldeAnterieur()+this.getTotalRecette()-this.getTotalDepenses();

    }
    double getTotalDebitEtat()
    {
        return this.getSoldeAnterieur()+this.getTotalRecette();
    }
    double getTotalCreditEtat()
    {
        return this.getTotalDepenses()+this.getSoldeActuel();
    }


    
    
}
