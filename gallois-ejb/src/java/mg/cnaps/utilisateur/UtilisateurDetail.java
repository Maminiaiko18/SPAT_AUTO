/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.cnaps.utilisateur;

import bean.ClassMAPTable;

/**
 *
 * @author Jetta
 */
public class UtilisateurDetail extends ClassMAPTable{
    private String id,login,nom,matricule,fonction,service_actuel;

    public UtilisateurDetail() {
        this.setNomTable("UTILISATEEUR_DETAIL");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
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

    public String getService_actuel() {
        return service_actuel;
    }

    public void setService_actuel(String service_actuel) {
        this.service_actuel = service_actuel;
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
