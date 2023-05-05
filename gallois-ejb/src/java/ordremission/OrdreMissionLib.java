/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ordremission;

/**
 *
 * @author Nouta
 */
public class OrdreMissionLib extends OrdreMission{
    private String nom,prenom,fonction,classeprofessionnel,matricule;

    public OrdreMissionLib() {
        super.setNomTable("ordre_mission_lib");
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

    public String getFonction() {
        return fonction;
    }

    public void setFonction(String fonction) {
        this.fonction = fonction;
    }

    public String getClasseprofessionnel() {
        return classeprofessionnel;
    }

    public void setClasseprofessionnel(String classeprofessionnel) {
        this.classeprofessionnel = classeprofessionnel;
    }

    public String getMatricule() {
        return matricule;
    }

    public void setMatricule(String matricule) {
        this.matricule = matricule;
    }
    
}
    

