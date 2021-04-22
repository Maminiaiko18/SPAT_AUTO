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
 * @author anthonyandrianaivoravelona
 */
public class FormationEtat extends ClassMAPTable{
    private String employe,materiel,matricule,fonction,service,idformation,sexe,formation,lieu, objet,drh;
    private Date date_fin,date_debut;
    private String duree_heure_debut;
    private String autres;
    @Override
    public String getTuppleID() {
        return matricule;
    }

    @Override
    public String getAttributIDName() {
        return "matricule";
    }

    public FormationEtat() {
        super.setNomTable("FORMATION_ETAT");
    }

    
    public String getEmploye() {
        return employe;
    }

    public void setEmploye(String employe) {
        this.employe = employe;
    }

    public String getMateriel() {
        return materiel;
    }

    public void setMateriel(String materiel) {
        this.materiel = materiel;
    }

    public String getMatricule() {
        return matricule;
    }

    public void setMatricule(String matricule) {
        this.matricule = matricule;
    }

    public String getFonction() {
        return fonction;
    }

    public void setFonction(String fonction) {
        this.fonction = fonction;
    }

    public String getService() {
        return service;
    }

    public void setService(String service) {
        this.service = service;
    }

    public String getIdformation() {
        return idformation;
    }

    public void setIdformation(String idformation) {
        this.idformation = idformation;
    }

    public String getSexe() {
        return sexe;
    }

    public void setSexe(String sexe) {
        this.sexe = sexe;
    }

    public String getFormation() {
        return formation;
    }

    public void setFormation(String formation) {
        this.formation = formation;
    }

    public String getLieu() {
        return lieu;
    }

    public void setLieu(String lieu) {
        this.lieu = lieu;
    }

    public Date getDate_fin() {
        return date_fin;
    }

    public void setDate_fin(Date date_fin) {
        this.date_fin = date_fin;
    }

    public Date getDate_debut() {
        return date_debut;
    }

    public void setDate_debut(Date date_debut) {
        this.date_debut = date_debut;
    }

    public String getDuree_heure_debut() {
        return duree_heure_debut;
    }

    public void setDuree_heure_debut(String duree_heure_debut) {
        this.duree_heure_debut = duree_heure_debut;
    }

    public String getObjet() {
        return objet;
    }

    public void setObjet(String objet) {
        this.objet = objet;
    }

    public String getDrh() {
        return drh;
    }

    public void setDrh(String drh) {
        this.drh = drh;
    }

    public String getAutres() {
        return autres;
    }

    public void setAutres(String autres) {
        this.autres = autres;
    }
    
    
}
