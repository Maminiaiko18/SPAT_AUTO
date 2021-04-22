/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author Asus
 */
public class Travaux_tiers extends ClassMAPTable{
    
    private String id,idtravaux,idtiers,description;
    private double montant;

    public Travaux_tiers(String id, String idtravaux, String idtiers, String description, double montant) throws Exception {
        this.setNomTable("travaux_tiers");
        this.setId(id);
        this.setIdtravaux(idtravaux);
        this.setIdtiers(idtiers);
        this.setDescription(description);
        this.setMontant(montant);
    }

    public Travaux_tiers() {
          this.setNomTable("travaux_tiers");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdtravaux() {
        return idtravaux;
    }

    public void setIdtravaux(String idtravaux) {
        this.idtravaux = idtravaux;
    }

    public String getIdtiers() {
        return idtiers;
    }

    public void setIdtiers(String idtiers) {
        this.idtiers = idtiers;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) throws Exception {
         if (getMode().compareToIgnoreCase("modif") == 0) {
            if (montant < 0) {
                throw new Exception("montant invalide");
            }
        }
        this.montant = montant;
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
        this.preparePk("TRT", "getseq_travaux_tiers");
        this.setId(makePK(c));
    }
    
}
