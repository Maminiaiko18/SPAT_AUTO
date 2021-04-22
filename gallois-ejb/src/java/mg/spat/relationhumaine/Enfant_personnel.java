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
 * @author Asus
 */
public class Enfant_personnel extends ClassMAPTable{
    
    private String id,idPersonnel,nom_prenom_enfant;
    private Date dateNaissanceEnfant;

    public Enfant_personnel() {
        super.setNomTable("Enfant_personnel");
    }
    
    

    public Enfant_personnel(String id, String idPersonnel, String nom_prenom_enfant, Date dateNaissanceEnfant) {
        super.setNomTable("Enfant_personnel");
        this.setId(id);
        this.setIdPersonnel(idPersonnel);
        this.setNom_prenom_enfant(nom_prenom_enfant);
        this.setDateNaissanceEnfant(dateNaissanceEnfant);
    }
    public Enfant_personnel(String idPersonnel, String nom_prenom_enfant, Date dateNaissanceEnfant) {
        super.setNomTable("Enfant_personnel");
        this.setIdPersonnel(idPersonnel);
        this.setNom_prenom_enfant(nom_prenom_enfant);
        this.setDateNaissanceEnfant(dateNaissanceEnfant);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdPersonnel() {
        return idPersonnel;
    }

    public void setIdPersonnel(String idPersonnel) {
        this.idPersonnel = idPersonnel;
    }

    public String getNom_prenom_enfant() {
        return nom_prenom_enfant;
    }

    public void setNom_prenom_enfant(String nom_prenom_enfant) {
        this.nom_prenom_enfant = nom_prenom_enfant;
    }

    public Date getDateNaissanceEnfant() {
        return dateNaissanceEnfant;
    }

    public void setDateNaissanceEnfant(Date dateNaissanceEnfant) {
        this.dateNaissanceEnfant = dateNaissanceEnfant;
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
         this.preparePk("EFP", "getseq_enfant_personnel");
        this.setId(makePK(c));
        
    }
    
}
