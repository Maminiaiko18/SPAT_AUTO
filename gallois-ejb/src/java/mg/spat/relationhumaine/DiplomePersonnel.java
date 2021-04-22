/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.relationhumaine;

import java.sql.Date;

/**
 * Ampiasaina am diplome lib complet
 * Affichage fotsiny
 * @author John
 */
public class DiplomePersonnel extends Diplome {
    
    private String nom, prenom, civilite, matriculesalarie, telephone, email;
    
    private Date datenaissance;

    /**
     * @return the nom
     */
    public String getNom() {
        return nom;
    }

    /**
     * @param nom the nom to set
     */
    public void setNom(String nom) {
        this.nom = nom;
    }
    
    /**
     * @return the prenom
     */
    public String getPrenom() {
        return prenom;
    }

    /**
     * @param prenom the prenom to set
     */
    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    /**
     * @return the civilite
     */
    public String getCivilite() {
        return civilite;
    }

    /**
     * @param civilite the civilite to set
     */
    public void setCivilite(String civilite) {
        this.civilite = civilite;
    }

    /**
     * @return the matriculesalarie
     */
    public String getMatriculesalarie() {
        return matriculesalarie;
    }

    /**
     * @param matriculesalarie the matriculesalarie to set
     */
    public void setMatriculesalarie(String matriculesalarie) {
        this.matriculesalarie = matriculesalarie;
    }

    /**
     * @return the telephone
     */
    public String getTelephone() {
        return telephone;
    }

    /**
     * @param telephone the telephone to set
     */
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    /**
     * @return the email
     */
    public String getEmail() {
        return email;
    }

    /**
     * @param email the email to set
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * @return the datenaissance
     */
    public Date getDatenaissance() {
        return datenaissance;
    }

    /**
     * @param datenaissance the datenaissance to set
     */
    public void setDatenaissance(Date datenaissance) {
        this.datenaissance = datenaissance;
    }
    
}
