/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.cnaps.formation;

/**
 *
 * @author anthonyandrianaivoravelona
 */
public class AttestationFormation {
    private String employe;
    private String formation;
    private String date_debut;
    private String date_fin;
    private String formateur;
    private String dg;

    public AttestationFormation() {
    }

    public AttestationFormation(String employe, String formation, String date_debut, String date_fin, String formateur, String dg) {
        this.employe = employe;
        this.formation = formation;
        this.date_debut = date_debut;
        this.date_fin = date_fin;
        this.formateur = formateur;
        this.dg = dg;
    }

    public String getEmploye() {
        return employe;
    }

    public void setEmploye(String employe) {
        this.employe = employe;
    }

    public String getFormation() {
        return formation;
    }

    public void setFormation(String formation) {
        this.formation = formation;
    }

    public String getDate_debut() {
        return date_debut;
    }

    public void setDate_debut(String date_debut) {
        this.date_debut = date_debut;
    }

    public String getDate_fin() {
        return date_fin;
    }

    public void setDate_fin(String date_fin) {
        this.date_fin = date_fin;
    }

    public String getFormateur() {
        return formateur;
    }

    public void setFormateur(String formateur) {
        this.formateur = formateur;
    }

    public String getDg() {
        return dg;
    }

    public void setDg(String dg) {
        this.dg = dg;
    }
    
}
