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
public class Indemnite extends ClassMAPTable{
    
    private String id,idPersonnel;

    private double indemnite_fonction,indemnite_conge_paye,indemnite_deplacement,indemnite_risque;
    
    public Indemnite() {
        super.setNomTable("Indemnite");
    }

    public Indemnite(String id, String idPersonnel, double indemnite_fonction, double indemnite_conge_paye, double indemnite_deplacement, double indemnite_risque) throws Exception {
        super.setNomTable("Indemnite");
        this.setId(id);
        this.setIdPersonnel(idPersonnel);
        this.setIndemnite_fonction(indemnite_fonction);
        this.setIndemnite_conge_paye(indemnite_conge_paye);
        this.setIndemnite_deplacement(indemnite_deplacement);
        this.setIndemnite_risque(indemnite_risque);
    }
    public Indemnite(String idPersonnel, double Indemnite_fonction, double Indemnite_conge_paye, double Indemnite_deplacement, double Indemnite_risque) throws Exception {
        super.setNomTable("Indemnite");
        this.setIdPersonnel(idPersonnel);
        this.setIndemnite_fonction(Indemnite_fonction);
        this.setIndemnite_conge_paye(Indemnite_conge_paye);
        this.setIndemnite_deplacement(Indemnite_deplacement);
        this.setIndemnite_risque(Indemnite_risque);
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

    public double getIndemnite_fonction() {
        return indemnite_fonction;
    }

    public void setIndemnite_fonction(double indemnite_fonction) throws Exception {
         if (getMode().compareToIgnoreCase("modif") == 0) {
            if (indemnite_fonction < 0) {
               throw new Exception("indemnite_fonction invalide");
            } 
        }
        
        this.indemnite_fonction = indemnite_fonction;
    }

    public double getIndemnite_conge_paye() {
        return indemnite_conge_paye;
    }

    public void setIndemnite_conge_paye(double indemnite_conge_paye) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (indemnite_conge_paye < 0) {
               throw new Exception("indemnite_conge_paye invalide");
            } 
        }
        this.indemnite_conge_paye = indemnite_conge_paye;
    }

    public double getIndemnite_deplacement() {
        return indemnite_deplacement;
    }

    public void setIndemnite_deplacement(double indemnite_deplacement) throws Exception {
         if (getMode().compareToIgnoreCase("modif") == 0) {
            if (indemnite_deplacement < 0) {
               throw new Exception("indemnite_deplacement invalide");
            } 
        }
        this.indemnite_deplacement = indemnite_deplacement;
    }

    public double getIndemnite_risque() {
        return indemnite_risque;
    }

    public void setIndemnite_risque(double indemnite_risque) throws Exception {
         if (getMode().compareToIgnoreCase("modif") == 0) {
            if (indemnite_risque < 0) {
               throw new Exception("indemnite_risque invalide");
            } 
        }
        this.indemnite_risque = indemnite_risque;
    }

   

    @Override
    public String getTuppleID() {
    return this.id;}

    @Override
    public String getAttributIDName() {
     return "id"; }
    
    public void construirePK(Connection c) throws Exception {
         this.preparePk("IND", "getseq_indemnite");
         this.setId(makePK(c));
        
    }
    
}
