/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.cnaps.formation;

import bean.ClassMAPTable;

/**
 *
 * @author anthonyandrianaivoravelona
 */
public class FormPartInfoComplet extends ClassMAPTable{
    private String id, form_formation, id_personnel, log_personnel, log_service, paie_fonction, matricule;
    private int note, absence;

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public FormPartInfoComplet() {
        super.setNomTable("FORM_PART_INFO_COMPLET");
    }

    public FormPartInfoComplet(String id, String form_formation, String id_personnel, String log_personnel, String log_service, String paie_fonction, String matricule, int note, int absence) {
        super.setNomTable("FORM_PART_INFO_COMPLET");
        this.id = id;
        this.form_formation = form_formation;
        this.id_personnel = id_personnel;
        this.log_personnel = log_personnel;
        this.log_service = log_service;
        this.paie_fonction = paie_fonction;
        this.matricule = matricule;
        this.note = note;
        this.absence = absence;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getForm_formation() {
        return form_formation;
    }

    public void setForm_formation(String form_formation) {
        this.form_formation = form_formation;
    }

    public String getId_personnel() {
        return id_personnel;
    }

    public void setId_personnel(String id_personnel) {
        this.id_personnel = id_personnel;
    }

    public String getLog_personnel() {
        return log_personnel;
    }

    public void setLog_personnel(String log_personnel) {
        this.log_personnel = log_personnel;
    }

    public String getLog_service() {
        return log_service;
    }

    public void setLog_service(String log_service) {
        this.log_service = log_service;
    }

    public String getPaie_fonction() {
        return paie_fonction;
    }

    public void setPaie_fonction(String paie_fonction) {
        this.paie_fonction = paie_fonction;
    }

    public String getMatricule() {
        return matricule;
    }

    public void setMatricule(String matricule) {
        this.matricule = matricule;
    }

    public int getNote() {
        return note;
    }

    public void setNote(int note) {
        this.note = note;
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
