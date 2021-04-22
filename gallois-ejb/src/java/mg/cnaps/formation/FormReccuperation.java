/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.cnaps.formation;

import bean.ClassEtat;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.ConstanteEtat;
import utilitaire.Utilitaire;

/**
 *
 * @author user
 */
public class FormReccuperation extends ClassEtat {

    private String id, id_formation, id_personnel, heure_debut_am, heure_fin_am, heure_debut_pm, heure_fin_pm, remarque;
    private Date date_reccup;
    private double heure;

    public FormReccuperation() {
	this.setNomTable("FORM_RECCUPERATION");
    }

    public FormReccuperation(String id, String id_formation, String id_personnel, String heure_debut_am, String heure_fin_am, String heure_debut_pm, String heure_fin_pm, String remarque, Date date_reccup, double heure) throws Exception {
	this.setId(id);
	this.setId_formation(id_formation);
	this.setId_personnel(id_personnel);
	this.setHeure_debut_am(heure_debut_am);
	this.setHeure_fin_am(heure_fin_am);
	this.setHeure_debut_pm(heure_debut_pm);
	this.setHeure_fin_pm(heure_fin_pm);
	this.setRemarque(remarque);
	this.setDate_reccup(date_reccup);
	this.setHeure(heure);
	this.setNomTable("FORM_RECCUPERATION");
    }

    public FormReccuperation(String id_formation, String id_personnel, String heure_debut_am, String heure_fin_am, String heure_debut_pm, String heure_fin_pm, String remarque, Date date_reccup, double heure) throws Exception {
	this.setId_formation(id_formation);
	this.setId_personnel(id_personnel);
	this.setHeure_debut_am(heure_debut_am);
	this.setHeure_fin_am(heure_fin_am);
	this.setHeure_debut_pm(heure_debut_pm);
	this.setHeure_fin_pm(heure_fin_pm);
	this.setRemarque(remarque);
	this.setDate_reccup(date_reccup);
	this.setHeure(heure);
	this.setNomTable("FORM_RECCUPERATION");
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

    public String getId_personnel() {
	return id_personnel;
    }

    public void setId_personnel(String id_personnel) {
	this.id_personnel = id_personnel;
    }

    public String getRemarque() {
	return remarque;
    }

    public void setRemarque(String remarque) {
	this.remarque = remarque;
    }

    public Date getDate_reccup() {
	return date_reccup;
    }

    public void setDate_reccup(Date date_reccup) throws Exception {
        if (getMode().compareTo("modif") != 0) {
            this.date_reccup = date_reccup;
            return;
        }
        if(date_reccup==null) throw new Exception("Date de récupération manquant");
        this.date_reccup = date_reccup;
    }

    public double getHeure() {
	return heure;
    }

    public String getHeure_debut_am() {
	return heure_debut_am;
    }

    public void setHeure_debut_am(String heure_debut_am) throws Exception {
	if (getMode().compareTo("modif") != 0) {
            this.heure_debut_am = heure_debut_am;
            return;
        }
        if(heure_debut_am!=null && heure_debut_am!=""){
            if(!Utilitaire.validerHeureMinute(heure_debut_am)) throw new Exception("Format Heure début (Matin) = HH:MM");
            if(!Utilitaire.isHeureMatin(heure_debut_am)) throw new Exception("Heure début (Matin) invalide car > 12:00");
        }
        this.heure_debut_am = heure_debut_am;
    }

    public String getHeure_fin_am() {
	return heure_fin_am;
    }

    public void setHeure_fin_am(String heure_fin_am) throws Exception {
	if (getMode().compareTo("modif") != 0) {
            this.heure_fin_am = heure_fin_am;
            return;
        }
        if(heure_fin_am!=null && heure_fin_am!=""){
            String[] heuretemp = heure_fin_am.split(":");
            if(Integer.valueOf(heuretemp[0])>12) throw new Exception("Heure fin (Matin) invalide car > 12:30");
            if(heuretemp.length>1)
                if(Integer.valueOf(heuretemp[1])<0 || Integer.valueOf(heuretemp[1])>30) throw new Exception("Heure fin (Matin) invalide car > 12:30");
        }
        this.heure_fin_am = heure_fin_am;
    }

    public String getHeure_debut_pm() {
	return heure_debut_pm;
    }

    public void setHeure_debut_pm(String heure_debut_pm) throws Exception {
	if (getMode().compareTo("modif") != 0) {
            this.heure_debut_pm = heure_debut_pm;
            return;
        }
        if(heure_debut_pm!=null && heure_debut_pm!=""){
            if(!Utilitaire.validerHeureMinute(heure_debut_pm)) throw new Exception("Format Heure début (Après-midi) = HH:MM");
            if(Utilitaire.isHeureMatin(heure_debut_pm)) throw new Exception("Heure début (Après-midi) invalide car <= 12:00");
        }
        this.heure_debut_pm = heure_debut_pm;
    }

    public String getHeure_fin_pm() {
	return heure_fin_pm;
    }

    public void setHeure_fin_pm(String heure_fin_pm) throws Exception {
	if (getMode().compareTo("modif") != 0) {
            this.heure_fin_pm = heure_fin_pm;
            return;
        }
        if(heure_fin_pm!=null && heure_fin_pm!=""){
            if(!Utilitaire.validerHeureMinute(heure_debut_pm)) throw new Exception("Format Heure fin (Après-midi) = HH:MM");
            if(Utilitaire.isHeureMatin(heure_debut_pm)) throw new Exception("Heure fin (Après-midi) invalide car <= 12:00");
        }
        this.heure_fin_pm = heure_fin_pm;
    }

    public void setHeure(double heure) {
	this.heure = heure;
    }

    @Override
    public String getTuppleID() {
	return id;
    }

    @Override
    public String getAttributIDName() {
	return "id";
    }

    public void construirePK(Connection c) throws Exception {
	this.preparePk("FRECC", "getSeqFormReccuperation");
	this.setId(makePK(c));
    }
    @Override
    public String getEtatText(int value){
        return chaineEtat(value);
    }
}
