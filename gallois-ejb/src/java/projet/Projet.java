/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package projet;

import bean.ClassEtat;
import java.sql.Connection;

/**
 *
 * @author rasol
 */
public class Projet extends ClassEtat{
    private String id, projet, section_budget, compte, designation, programme, activite, objectif;
    private double montant_credit, paye, engage, liquide;
    private int  exercice;

    public Projet() {
        this.setNomTable("projet");
    }
    
    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
    public void construirePK(Connection c) throws Exception{
        this.preparePk("PR", "get_seq_Projet");
        this.setId(makePK(c));
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getProjet() {
        return projet;
    }

    public void setProjet(String projet) {
        this.projet = projet;
    }

    public String getSection_budget() {
        return section_budget;
    }

    public void setSection_budget(String section_budget) {
        this.section_budget = section_budget;
    }

    public String getCompte() {
        return compte;
    }

    public void setCompte(String compte) {
        this.compte = compte;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getProgramme() {
        return programme;
    }

    public void setProgramme(String programme) {
        this.programme = programme;
    }

    public String getActivite() {
        return activite;
    }

    public void setActivite(String activite) {
        this.activite = activite;
    }

    public String getObjectif() {
        return objectif;
    }

    public void setObjectif(String objectif) {
        this.objectif = objectif;
    }

    public double getMontant_credit() {
        return montant_credit;
    }

    public void setMontant_credit(double montant_credit) {
        this.montant_credit = montant_credit;
    }

    public double getPaye() {
        return paye;
    }

    public void setPaye(double paye) {
        this.paye = paye;
    }

    public double getEngage() {
        return engage;
    }

    public void setEngage(double engage) {
        this.engage = engage;
    }

    public double getLiquide() {
        return liquide;
    }

    public void setLiquide(double liquide) {
        this.liquide = liquide;
    }

    public int getExercice() {
        return exercice;
    }

    public void setExercice(int exercice) {
        this.exercice = exercice;
    }
    
    @Override
    public String getValColLibelle(){
        return designation;
    }
}
