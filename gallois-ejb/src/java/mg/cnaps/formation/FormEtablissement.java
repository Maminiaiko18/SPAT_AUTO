/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.cnaps.formation;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author Jetta
 */
public class FormEtablissement extends ClassMAPTable {

    private String id, nom, specialisation, adresse, pays, contact;
    private Date date_anciennete;
    double valeur;

    public FormEtablissement(String id, String nom, String specialisation, String adresse, String pays, String contact, Date date_anciennete, double valeur) {
        this.setId(id);
        this.setNom(nom);
        this.setSpecialisation(specialisation);
        this.setAdresse(adresse);
        this.setPays(pays);
        this.setContact(contact);
        this.setDate_anciennete(date_anciennete);
        this.setValeur(valeur);
        this.setNomTable("FORM_ETABLISSEMENT");
    }

    public FormEtablissement(String nom, String specialisation, String adresse, String pays, String contact, Date date_anciennete, double valeur) {

        this.setNom(nom);
        this.setSpecialisation(specialisation);
        this.setAdresse(adresse);
        this.setPays(pays);
        this.setContact(contact);
        this.setDate_anciennete(date_anciennete);
        this.setValeur(valeur);
        this.setNomTable("FORM_ETABLISSEMENT");
    }

    public FormEtablissement() {
        this.setNomTable("FORM_ETABLISSEMENT");
    }

    public String getTuppleID() {
        return id;
    }

    public String getAttributIDName() {
        return "id";
    }

    public void construirePK(Connection c) throws Exception {
        this.preparePk("FETB", "getSeqFormEtablissement");
        this.setId(makePK(c));
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getSpecialisation() {
        return specialisation;
    }

    public void setSpecialisation(String specialisation) {
        this.specialisation = specialisation;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public String getPays() {
        return pays;
    }

    public void setPays(String pays) {
        this.pays = pays;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public Date getDate_anciennete() {
        return date_anciennete;
    }

    public void setDate_anciennete(Date date_anciennete) {
        this.date_anciennete = date_anciennete;
    }

    public double getValeur() {
        return valeur;
    }

    public void setValeur(double valeur) {
        this.valeur = valeur;
    }
    public String getValColLibelle(){
        return nom;
    }
}
