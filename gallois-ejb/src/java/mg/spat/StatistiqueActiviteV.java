/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author Asus
 */
public class StatistiqueActiviteV extends StatistiqueActivite{
    
    private String client;
    
     private double prevision;
     private int annee,mois_precedent,mois_en_cours;

    public StatistiqueActiviteV() {
        super.setNomTable("v_statistique_activite");
    }

   

    public StatistiqueActiviteV(String client, double prevision, int annee, int mois_precedent, int mois_en_cours, String id, String idclient, String rubrique, Date daty, double cumul) throws Exception {
        
        super(id, idclient, rubrique, daty, cumul);
         super.setNomTable("v_statistique_activite");
        this.setClient(client);
        this.setPrevision(prevision);
        this.setAnnee(annee);
        this.setMois_precedent(mois_precedent);
        this.setMois_en_cours(mois_en_cours);
    }

   
  

    public String getClient() {
        return client;
    }

    public void setClient(String client) {
        this.client = client;
    }

   

    public double getPrevision() {
        return prevision;
    }

    public void setPrevision(double prevision) throws Exception {
      
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (prevision < 0) {
               throw new Exception("prevision invalide");
            } 
        }
         this.prevision = prevision;
    }

    public int getAnnee() {
        return annee;
    }

    public void setAnnee(int annee) throws Exception {
      if (getMode().compareToIgnoreCase("modif") == 0) {
            if (annee < 0) {
               throw new Exception("annee invalide");
            } 
        }
         this.annee = annee;
    }

    public int getMois_precedent() {
        return mois_precedent;
    }

    public void setMois_precedent(int mois_precedent) throws Exception {
     
      if (getMode().compareToIgnoreCase("modif") == 0) {
            if (mois_precedent < 0) {
               throw new Exception("mois_precedent invalide");
            } 
        }
         this.mois_precedent = mois_precedent;
        
    }

    public int getMois_en_cours() {
        return mois_en_cours;
    }

    public void setMois_en_cours(int mois_en_cours) throws Exception {
      if (getMode().compareToIgnoreCase("modif") == 0) {
            if (mois_en_cours < 0) {
               throw new Exception("mois_en_cours invalide");
            } 
        }
         this.mois_en_cours = mois_en_cours;
    }
    

   
    
    
}
