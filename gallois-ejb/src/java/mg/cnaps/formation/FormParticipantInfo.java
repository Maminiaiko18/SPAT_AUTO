/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.cnaps.formation;

import bean.ClassMAPTable;

/**
 *
 * @author Admin
 */
public class FormParticipantInfo extends ClassMAPTable {

    private String id;
    private String id_formation;
    private String nom;
    private String prenom;
    private String lieu_formation;
    private String remarque;
    private int note;
    private double cout;
    private double indemnite;
    private int absence;
    private String sexe;

    public double getIndemnite() {
	return indemnite;
    }

    public void setIndemnite(double indemnite) {
	this.indemnite = indemnite;
    }

    @Override
    public String getTuppleID() {
	return id;
    }

    @Override
    public String getAttributIDName() {
	return "id";
    }

    public FormParticipantInfo() {
	super.setNomTable("FORM_PARTICIPANT_INFO");
    }

    public String getId() {
	return id;
    }

    public void setId(String id) {
	this.id = id;
    }

    public String getId_formation() {
	return id_formation;
    }

    public void setId_formation(String id_formation) {
	this.id_formation = id_formation;
    }

    public String getNom() {
	return nom;
    }

    public void setNom(String nom) {
	this.nom = nom;
    }

    public String getPrenom() {
	return prenom;
    }

    public void setPrenom(String prenom) {
	this.prenom = prenom;
    }

    public String getRemarque() {
	return remarque;
    }

    public void setRemarque(String remarque) {
	this.remarque = remarque;
    }

    public int getNote() {
	return note;
    }

    public void setNote(int note) {
	this.note = note;
    }

    public double getCout() {
	return cout;
    }

    public void setCout(double cout) {
	this.cout = cout;
    }

    public int getAbsence() {
	return absence;
    }

    public void setAbsence(int absence) {
	this.absence = absence;
    }

    public String getEtatNote() {
	if (note == -1) {
	    return "En cours";
	} else {
	    return String.valueOf(note);
	}
    }

    public String getSexe() {
	return sexe;
    }

    public void setSexe(String sexe) {
	this.sexe = sexe;
    }

    /**
     * @return the lieu_formation
     */
    public String getLieu_formation() {
	return lieu_formation;
    }

    /**
     * @param lieu_formation the lieu_formation to set
     */
    public void setLieu_formation(String lieu_formation) {
	this.lieu_formation = lieu_formation;
    }

}
