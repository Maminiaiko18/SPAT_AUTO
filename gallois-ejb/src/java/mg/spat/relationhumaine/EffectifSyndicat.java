/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.relationhumaine;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author rajao
 */
public class EffectifSyndicat extends ClassMAPTable{
    private String id,matriculesalarie,nom,prenom,genre,syndicat,postesyndicat;
    private Date datenaissance;
    private double nombre;
    
    public EffectifSyndicat() {
        super.setNomTable("analyse_effectif_syndicat");
    }
    public EffectifSyndicat(String matriculesalarie, String nom, String prenom, String genre, String syndicat, String postesyndicat, Date datenaissance, Double nombre) {
        super.setNomTable("analyse_effectif_syndicat");
        this.setMatriculesalarie(matriculesalarie);
        this.setNom(nom);
        this.setPrenom(prenom);
        this.setGenre(genre);
        this.setSyndicat(syndicat);
        this.setPostesyndicat(postesyndicat);
        this.setDatenaissance(datenaissance);
        this.setNombre(nombre);
        
    }

    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getMatriculesalarie() {
        return matriculesalarie;
    }

    public void setMatriculesalarie(String matriculesalarie) {
        this.matriculesalarie = matriculesalarie;
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

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public String getSyndicat() {
        return syndicat;
    }

    public void setSyndicat(String syndicat) {
        this.syndicat = syndicat;
    }

    public String getPostesyndicat() {
        return postesyndicat;
    }

    public void setPostesyndicat(String postesyndicat) {
        this.postesyndicat = postesyndicat;
    }

    public Date getDatenaissance() {
        return datenaissance;
    }

    public void setDatenaissance(Date datenaissance) {
        this.datenaissance = datenaissance;
    }

    public double getNombre() {
        return nombre;
    }

    public void setNombre(double nombre) {
        this.nombre = nombre;
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
