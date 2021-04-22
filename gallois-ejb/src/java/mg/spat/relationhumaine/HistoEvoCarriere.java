/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.relationhumaine;

import bean.ClassMAPTable;
import java.sql.Date;

/**
 *
 * @author MEVA
 */
public class HistoEvoCarriere extends ClassMAPTable{
    private int idhisto,matricule_interne;
    private String matricule, nom, lieu_affectation,code_ets,statut,fonctions,classif,motif;
    private Date debut_fct,fin_fct;

    public HistoEvoCarriere() {
        this.setNomTable("histo_evo_carriere");
    }

    public int getIdhisto() {
        return idhisto;
    }

    public void setIdhisto(int idhisto) {
        this.idhisto = idhisto;
    }

    public int getMatricule_interne() {
        return matricule_interne;
    }

    public void setMatricule_interne(int matricule_interne) {
        this.matricule_interne = matricule_interne;
    }

    public String getMatricule() {
        return matricule;
    }

    public void setMatricule(String matricule) {
        this.matricule = matricule;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getLieu_affectation() {
        return lieu_affectation;
    }

    public void setLieu_affectation(String lieu_affectation) {
        this.lieu_affectation = lieu_affectation;
    }

    public String getCode_ets() {
        return code_ets;
    }

    public void setCode_ets(String code_ets) {
        this.code_ets = code_ets;
    }

    public String getStatut() {
        return statut;
    }

    public void setStatut(String statut) {
        this.statut = statut;
    }

    public String getFonctions() {
        return fonctions;
    }

    public void setFonctions(String fonctions) {
        this.fonctions = fonctions;
    }

    public String getClassif() {
        return classif;
    }

    public void setClassif(String classif) {
        this.classif = classif;
    }

    public String getMotif() {
        return motif;
    }

    public void setMotif(String motif) {
        this.motif = motif;
    }

    public Date getDebut_fct() {
        return debut_fct;
    }

    public void setDebut_fct(Date debut_fct) {
        this.debut_fct = debut_fct;
    }

    public Date getFin_fct() {
        return fin_fct;
    }

    public void setFin_fct(Date fin_fct) {
        this.fin_fct = fin_fct;
    }
    
    @Override
    public String getTuppleID() {
        return ""+this.idhisto;
    }

    @Override
    public String getAttributIDName() {
        return "idhisto";
    }
    
}
