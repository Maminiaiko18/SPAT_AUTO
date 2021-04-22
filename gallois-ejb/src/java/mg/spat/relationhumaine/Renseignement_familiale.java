/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.relationhumaine;

import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author Asus
 */
public class Renseignement_familiale extends ClassMAPTable{
    
    private String id,idpersonnel,situation_matrimoniale,nom_prenom_epoux,
            nom_prenom_pere,nom_prenom_mere;

    public Renseignement_familiale() {
            super.setNomTable("renseignement_familiale");
    }

    public Renseignement_familiale(String id, String idpersonnel, String situation_matrimoniale, String nom_prenom_epoux, String nom_prenom_pere, String nom_prenom_mere) {
        super.setNomTable("renseignement_familiale");
        this.setId(id);
        this.setIdpersonnel(idpersonnel);
        this.setSituation_matrimoniale(situation_matrimoniale);
        this.setNom_prenom_epoux(nom_prenom_epoux) ;
        this.setNom_prenom_pere(nom_prenom_pere);
        this.setNom_prenom_mere(nom_prenom_mere);
    }
    public Renseignement_familiale(String idpersonnel, String situation_matrimoniale, String nom_prenom_epoux, String nom_prenom_pere, String nom_prenom_mere) {
        super.setNomTable("renseignement_familiale");
        this.setIdpersonnel(idpersonnel);
        this.setSituation_matrimoniale(situation_matrimoniale);
        this.setNom_prenom_epoux(nom_prenom_epoux) ;
        this.setNom_prenom_pere(nom_prenom_pere);
        this.setNom_prenom_mere(nom_prenom_mere);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdpersonnel() {
        return idpersonnel;
    }

    public void setIdpersonnel(String idpersonnel) {
        this.idpersonnel = idpersonnel;
    }

    public String getSituation_matrimoniale() {
        return situation_matrimoniale;
    }

    public void setSituation_matrimoniale(String situation_matrimoniale) {
        this.situation_matrimoniale = situation_matrimoniale;
    }

    public String getNom_prenom_epoux() {
        return nom_prenom_epoux;
    }

    public void setNom_prenom_epoux(String nom_prenom_epoux) {
        this.nom_prenom_epoux = nom_prenom_epoux;
    }

    public String getNom_prenom_pere() {
        return nom_prenom_pere;
    }

    public void setNom_prenom_pere(String nom_prenom_pere) {
        this.nom_prenom_pere = nom_prenom_pere;
    }

    public String getNom_prenom_mere() {
        return nom_prenom_mere;
    }

    public void setNom_prenom_mere(String nom_prenom_mere) {
        this.nom_prenom_mere = nom_prenom_mere;
    }
    

    @Override
    public String getTuppleID() {
        return this.id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
     public void construirePK(Connection c) throws Exception {
         this.preparePk("RFA", "getseq_renseignement_familiale");
        this.setId(makePK(c));
        
    }
    
    
    
}
