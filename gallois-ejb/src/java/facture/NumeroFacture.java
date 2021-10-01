/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.ClassMAPTable;
import java.sql.Date;

/**
 *
 * @author Sam25v14
 */
public class NumeroFacture extends ClassMAPTable {

    private Date daty;
    private int numeroactuelle, numerosuivant;
    private int mois, annee;

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public int getNumeroactuelle() {
        return numeroactuelle;
    }

    public void setNumeroactuelle(int numeroactuelle) {
        this.numeroactuelle = numeroactuelle;
    }

    public int getNumerosuivant() {
        return numerosuivant;
    }

    public void setNumerosuivant(int numerosuivant) {
        this.numerosuivant = numerosuivant;
    }

    public int getMois() {
        return mois;
    }

    public void setMois(int mois) {
        this.mois = mois;
    }

    public int getAnnee() {
        return annee;
    }

    public void setAnnee(int annee) {
        this.annee = annee;
    }

    @Override
    public String getTuppleID() {
        return mois + "/" + annee;
    }

    @Override
    public String getAttributIDName() {
        return null;
    }
}
