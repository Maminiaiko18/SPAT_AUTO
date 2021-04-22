/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilisateur;

import bean.ClassEtat;
import utilitaire.ConstanteEtat;

/**
 *
 * @author Ignafah
 */
public class UtilisateurInterimLibTous extends ClassEtat{
    private String id, nom_u_a_remplacer,matricule_u_a_remplacer, nom_u_interim, matricule_u_interim, fonction;

    public UtilisateurInterimLibTous() {
        this.setNomTable("UTILISATEUR_INTERIM_LIB_TOUS");
    }

    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNom_u_a_remplacer() {
        return nom_u_a_remplacer;
    }

    public void setNom_u_a_remplacer(String nom_u_a_remplacer) {
        this.nom_u_a_remplacer = nom_u_a_remplacer;
    }

    public String getMatricule_u_a_remplacer() {
        return matricule_u_a_remplacer;
    }

    public void setMatricule_u_a_remplacer(String matricule_u_a_remplacer) {
        this.matricule_u_a_remplacer = matricule_u_a_remplacer;
    }

    public String getNom_u_interim() {
        return nom_u_interim;
    }

    public void setNom_u_interim(String nom_u_interim) {
        this.nom_u_interim = nom_u_interim;
    }

    public String getMatricule_u_interim() {
        return matricule_u_interim;
    }

    public void setMatricule_u_interim(String matricule_u_interim) {
        this.matricule_u_interim = matricule_u_interim;
    }    

    public String getFonction() {
        return fonction;
    }

    public void setFonction(String fonction) {
        this.fonction = fonction;
    }

    
    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
    @Override
    public String getEtatText(int value){
        if(value==ConstanteUtilisateur.acteActiver){
            return "ACTIVER";
        }
        if(value==ConstanteUtilisateur.acteTerminer){
            return "TERMINER";
        }
        return chaineEtat(value);
    }
}
