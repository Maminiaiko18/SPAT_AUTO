/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.relationhumaine;

import bean.ClassEtat;
import java.sql.Connection;
import java.sql.Date;

/**
 * te
 *
 * @author Antsa
 */
public class Conge_libcomplet extends ClassEtat {

    private String id, email, idconge, idpersonnel, telephone, matriculesalarie, disponibilite, prenom, nom, civilite;
    private int etat, nombre;
    private Date datenaissance, date_debut_conge, date_fin_conge;

    public Conge_libcomplet(String id, String email, String idconge, String idpersonnel, String telephone, String matriculesalarie, String disponibilite, String prenom, String nom, String civilite, int etat, int nombre, Date datenaissance, Date date_debut_conge, Date date_fin_conge) {
        super.setNomTable("conge_libcomplet");
        this.setId(id);
        this.setEmail(email);
        this.setIdconge(idconge);
        this.setIdpersonnel(idpersonnel);
        this.setTelephone(telephone);
        this.setMatriculesalarie(matriculesalarie);
        this.setDisponibilite(disponibilite);
        this.setPrenom(prenom);
        this.setNom(nom);
        this.setCivilite(civilite);
        this.setEtat(etat);
        this.setNombre(nombre);
        this.setDatenaissance(datenaissance);
        this.setDate_debut_conge(date_debut_conge);
        this.setDate_fin_conge(date_fin_conge);
    }

    public Conge_libcomplet() {
        super.setNomTable("conge_libcomplet");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getIdconge() {
        return idconge;
    }

    public void setIdconge(String idconge) {
        this.idconge = idconge;
    }

    public String getIdpersonnel() {
        return idpersonnel;
    }

    public void setIdpersonnel(String idpersonnel) {
        this.idpersonnel = idpersonnel;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getMatriculesalarie() {
        return matriculesalarie;
    }

    public void setMatriculesalarie(String matriculesalarie) {
        this.matriculesalarie = matriculesalarie;
    }

    public String getDisponibilite() {
        return disponibilite;
    }

    public void setDisponibilite(String disponibilite) {
        this.disponibilite = disponibilite;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getCivilite() {
        return civilite;
    }

    public void setCivilite(String civilite) {
        this.civilite = civilite;
    }

    public int getEtat() {
        return etat;
    }

    public void setEtat(int etat) {
        this.etat = etat;
    }

    public int getNombre() {
        return nombre;
    }

    public void setNombre(int nombre) {
        this.nombre = nombre;
    }

    public Date getDatenaissance() {
        return datenaissance;
    }

    public void setDatenaissance(Date datenaissance) {
        this.datenaissance = datenaissance;
    }

    public Date getDate_debut_conge() {
        return date_debut_conge;
    }

    public void setDate_debut_conge(Date date_debut_conge) {
        this.date_debut_conge = date_debut_conge;
    }

    public Date getDate_fin_conge() {
        return date_fin_conge;
    }

    public void setDate_fin_conge(Date date_fin_conge) {
        this.date_fin_conge = date_fin_conge;
    }

    @Override
    public String getTuppleID() {
        return this.id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

}
