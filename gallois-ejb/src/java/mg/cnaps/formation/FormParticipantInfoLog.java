/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.cnaps.formation;

import bean.ClassMAPTable;
import java.sql.Date;

/**
 *
 * @author Admin
 */
public class FormParticipantInfoLog extends ClassMAPTable {
    private String id;
    private String domaine;
    private String categorie;
    private String formateur;
    private Date date_debut;
    private Date date_fin;
    private String etablissement;
    private int note,absence;
    private String log_personnel;

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public FormParticipantInfoLog() {
        super.setNomTable("FORM_PARTICIPANT_INFO_LOG");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDomaine() {
        return domaine;
    }

    public void setDomaine(String domaine) {
        this.domaine = domaine;
    }

    public String getCategorie() {
        return categorie;
    }

    public void setCategorie(String categorie) {
        this.categorie = categorie;
    }

    public String getFormateur() {
        return formateur;
    }

    public void setFormateur(String formateur) {
        this.formateur = formateur;
    }

    public Date getDate_debut() {
        return date_debut;
    }

    public void setDate_debut(Date date_debut) {
        this.date_debut = date_debut;
    }

    public Date getDate_fin() {
        return date_fin;
    }

    public void setDate_fin(Date date_fin) {
        this.date_fin = date_fin;
    }

    public String getEtablissement() {
        return etablissement;
    }

    public void setEtablissement(String etablissement) {
        this.etablissement = etablissement;
    }

    public int getNote() {
        return note;
    }

    public void setNote(int note) {
        this.note = note;
    }

    public String getLog_personnel() {
        return log_personnel;
    }

    public void setLog_personnel(String log_personnel) {
        this.log_personnel = log_personnel;
    }

    public int getAbsence() {
        return absence;
    }

    public void setAbsence(int absence) {
        this.absence = absence;
    }

    public String getEtatNote(){
        if(note==-1) return "En cours";
        else return String.valueOf(note);
    }
    
}
