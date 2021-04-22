/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.cnaps.formation;

import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author Jetta
 */
public class FormParticipantInfoComplet extends ClassMAPTable {

    private String id, id_formation,lieu_formation,idpersonnel, nom, prenom, remarque;
    private double note, cout;
    private int absence;

    public FormParticipantInfoComplet() {
        super.setNomTable("FORM_PARTICIPANT_INFOCOMPLET");
    }

    public String getLieu_formation() {
        return lieu_formation;
    }

    public void setLieu_formation(String lieu_formation) {
        this.lieu_formation = lieu_formation;
    }

    public String getIdpersonnel() {
        return idpersonnel;
    }

    public void setIdpersonnel(String idpersonnel) {
        this.idpersonnel = idpersonnel;
    }

//    public FormParticipantInfoComplet(String id, String id_formation, String log_personnel, String remarque, double note, double cout) throws Exception {
//        this.setId(id);
//        this.setId_formation(id_formation);
//        this.setLog_personnel(log_personnel);
//        this.setRemarque(remarque);
//        this.setNote(note);
//        this.setCout(cout);
//        super.setNomTable("FORM_PARTICIPANT_INFOCOMPLET");
//    }
//
//    public FormParticipantInfoComplet(String id_formation, String log_personnel, String remarque, double note, double cout) throws Exception {
//        this.setId_formation(id_formation);
//        this.setLog_personnel(log_personnel);
//        this.setRemarque(remarque);
//        this.setNote(note);
//        this.setCout(cout);
//        super.setNomTable("FORM_PARTICIPANT_INFOCOMPLET");
//    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public void setId(String id) {
        this.id = id;
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

   

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public void setNote(double note) throws Exception {
        if (getMode().compareTo("modif") != 0) {
            this.note = note;
            return;
        }
        if (note < -1) {
            throw new Exception("Note invalide car <-1");
        }
        this.note = note;
    }

    public void setCout(double cout) throws Exception {
        if (getMode().compareTo("modif") != 0) {
            this.cout = cout;
            return;
        }
        if (cout < 0) {
            throw new Exception("Cout invalide car <0");
        }
        this.cout = cout;
    }

    public String getId() {
        return id;
    }

    public String getId_formation() {
        return id_formation;
    }


    public String getRemarque() {
        return remarque;
    }

    public double getNote() {
        return note;
    }

    public double getCout() {
        return cout;
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

}
