/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.compta;

import java.sql.Date;
import bean.ClassMAPTable;

/**
 *
 * @author john
 */
public class DetailsRubrique extends ClassMAPTable{
    private String cpt_rubrique;
    private String rubrique;
    private double ec_montant;
    private Date ec_date;
    private String libelle_cpt_rubrique;

    public String getLibelle_cpt_rubrique() {
        return libelle_cpt_rubrique;
    }

    public void setLibelle_cpt_rubrique(String libelle_cpt_rubrique) {
        this.libelle_cpt_rubrique = libelle_cpt_rubrique;
    }
    
    public DetailsRubrique() {
        this.setNomTable("detailRubriqueVide");
    }

    public DetailsRubrique(String numero_compte, double montant, Date daty) {
        this.setNomTable("detailRubriqueVide");
        this.setCpt_rubrique(numero_compte);
        this.setEc_date(daty);
        this.setEc_montant(montant);
    }
    public DetailsRubrique(String numero_compte,String rubrique, double montant, Date daty) {
        this.setNomTable("detailRubriqueVide");
        this.setCpt_rubrique(numero_compte);
        this.setEc_date(daty);
        this.setEc_montant(montant);
        this.setRubrique(rubrique);
    }

    public String getCpt_rubrique() {
        return cpt_rubrique;
    }

    public void setCpt_rubrique(String numero_compte) {
        this.cpt_rubrique = numero_compte;
    }

    public double getEc_montant() {
        return ec_montant;
    }

    public void setEc_montant(double montant) {
        this.ec_montant = montant;
    }

    public Date getEc_date() {
        return ec_date;
    }

    public void setEc_date(Date daty) {
        this.ec_date = daty;
    }

    public String getRubrique() {
        return rubrique;
    }

    public void setRubrique(String rubrique) {
        this.rubrique = rubrique;
    }
    
    
    @Override
    public String getTuppleID() {
        return cpt_rubrique;
    }

    @Override
    public String getAttributIDName() {
        return "cpt_rubrique";
    }
}
