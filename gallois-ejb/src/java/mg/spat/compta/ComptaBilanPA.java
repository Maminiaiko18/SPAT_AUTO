/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.compta;

import bean.ClassEtat;
import bean.ClassMAPTable;
import java.sql.Date;

/**
 *
 * @author MEVA
 */
public class ComptaBilanPA extends ClassEtat{

    private String rubrique_actif, rubrique_passif;
    private Date date_actif, date_passif;
    private double montant_actif, montant_passif;

    public ComptaBilanPA() {
        super.setNomTable("comptabilanpa");
    }

    public String getRubrique_actif() {
        return rubrique_actif;
    }

    public void setRubrique_actif(String rubrique_actif) {
        this.rubrique_actif = rubrique_actif;
    }

    public String getRubrique_passif() {
        return rubrique_passif;
    }

    public void setRubrique_passif(String rubrique_passif) {
        this.rubrique_passif = rubrique_passif;
    }

    public Date getDate_actif() {
        return date_actif;
    }

    public void setDate_actif(Date date_actif) {
        this.date_actif = date_actif;
    }

    public Date getDate_passif() {
        return date_passif;
    }

    public void setDate_passif(Date date_passif) {
        this.date_passif = date_passif;
    }

    public double getMontant_actif() {
        return montant_actif;
    }

    public void setMontant_actif(double montant_actif) {
        this.montant_actif = montant_actif;
    }

    public double getMontant_passif() {
        return montant_passif;
    }

    public void setMontant_passif(double montant_passif) {
        this.montant_passif = montant_passif;
    }
    
    
    @Override
    public String getTuppleID() {
        return this.rubrique_actif;
    }

    @Override
    public String getAttributIDName() {
        return "rubrique_actif";
    }
    
    
}
