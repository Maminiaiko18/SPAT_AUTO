/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ordremission;

import java.sql.Connection;
import utilitaire.UtilDB;

/**
 *
 * @author Nouta
 */
public class OrdreMissionLib extends OrdreMission{
    private String nom,prenom,fonction,classeprofessionnel,matricule,idindemnitemissionlib,idmotifvoyagelib,estForfaitairelib;
    
    public OrdreMissionLib getByIdAvecOrdreMissionIndemnite(String id) throws Exception{
        Connection connection=null;
        try{
            connection = new UtilDB().GetConn();
            OrdreMissionLib ordreMission=(OrdreMissionLib) new OrdreMissionLib().getById(id, "ordre_mission_lib", connection);
            ordreMission.setIndemnites(ordreMission.getOrdreMissionIndemnites(connection));
            return ordreMission;
        }
        catch(Exception exception){
            throw exception;
        }
        finally{
            if(connection!=null)
                connection.close();
        }
    }
    
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

    public String getIdindemnitemissionlib() {
        return idindemnitemissionlib;
    }

    public void setIdindemnitemissionlib(String idindemnitemissionlib) {
        this.idindemnitemissionlib = idindemnitemissionlib;
    }

    public String getIdmotifvoyagelib() {
        return idmotifvoyagelib;
    }

    public void setIdmotifvoyagelib(String idmotifvoyagelib) {
        this.idmotifvoyagelib = idmotifvoyagelib;
    }

    public String getEstForfaitairelib() {
        return estForfaitairelib;
    }

    public void setEstForfaitairelib(String estForfaitairelib) {
        this.estForfaitairelib = estForfaitairelib;
    }
    
}
    

