/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassEtat;
import java.sql.Connection;

/**
 *
 * @author Asus
 */
public class Syndicat extends ClassEtat{
    
    private String id,nom,description;

    public Syndicat() {
         this.setNomTable("syndicat");
    }

    
    public Syndicat(String id, String nom, String description) {
        this.setNomTable("syndicat");
        this.id = id;
        this.nom = nom;
        this.description = description;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    
    

    @Override
    public String getTuppleID() {
       return id; 
    }

    @Override
    public String getAttributIDName() {
       return "id";
    }
    public void construirePK(Connection c) throws Exception {
        this.preparePk("SYN", "getseq_syndicat");
        this.setId(makePK(c));
    }
    
}
