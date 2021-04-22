/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.cnaps.formation;

import bean.ClassUser;
import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author user
 */
public class FormEmploiTemp extends ClassUser {

    private String id, id_formation, id_personnel, heure_debut, heure_fin, matiere, duree_trajet, remarque;
    private double duree_hdeb, duree_hfin;
    private Date date_formation;

    @Override
    public void construirePK(Connection c) throws Exception {
	this.preparePk("FET", "GETSEQFORMEMPLOITEMP");
	this.setId(makePK(c));
    }

    public FormEmploiTemp() {
	this.setNomTable("FORM_EMPLOI_TEMP");
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

    public String getHeure_debut() {
	return heure_debut;
    }

    public void setHeure_debut(String heure_debut) throws Exception {
	if (getMode().compareTo("modif") != 0) {
            this.heure_debut = heure_debut;
            return;
        }
        if(heure_debut=="" || heure_debut==null) throw new Exception("Champ heure debut manquant");
        this.heure_debut = heure_debut;
    }

    public String getHeure_fin() {
	return heure_fin;
    }

    public String getRemarque() {
	return remarque;
    }

    public void setRemarque(String remarque) {
	this.remarque = remarque;
    }

    public double getDuree_hdeb() {
	return duree_hdeb;
    }

    public void setDuree_hdeb(double duree_hdeb) {
	this.duree_hdeb = duree_hdeb;
    }

    public double getDuree_hfin() {
	return duree_hfin;
    }

    public void setDuree_hfin(double duree_hfin) {
	this.duree_hfin = duree_hfin;
    }

    public void setHeure_fin(String heure_fin) throws Exception {
	if (getMode().compareTo("modif") != 0) {
            this.heure_fin = heure_fin;
            return;
        }
        if(heure_fin=="" || heure_fin==null) throw new Exception("Champ heure fin manquant");
        this.heure_fin = heure_fin;
    }

    public String getMatiere() {
	return matiere;
    }

    public void setMatiere(String matiere) {
	this.matiere = matiere;
    }

    public String getDuree_trajet() {
	return duree_trajet;
    }

    public void setDuree_trajet(String duree_trajet) {
	this.duree_trajet = duree_trajet;
    }

    public Date getDate_formation() {
	return date_formation;
    }

    public void setDate_formation(Date date_formation) throws Exception {
	if (getMode().compareTo("modif") != 0) {
            this.date_formation = date_formation;
            return;
        }
        if(date_formation==null) throw new Exception("Champ date manquant ");
        this.date_formation = date_formation;
    }

    @Override
    public String getTuppleID() {
	return id;
    }

    @Override
    public String getAttributIDName() {
	return "id";
    }

}
