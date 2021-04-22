/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.relationhumaine;

import bean.ClassMAPTable;

/**
 *
 * @author Asus
 */
public class InfoSalaire extends ClassMAPTable{
    
    
    private String id,idPersonnel,categorie,palier,logement,vehicule,autre_avantage,mode_paiement,numero_virement,numero_cnaps,idIndemnite,idAvantagenature;
    private double indemnite_fonction,indemnite_conge_paye,indemnite_deplacement,
            indemnite_risque;
   
    
    private int indice;

    private double salaire_base;

    public InfoSalaire() {
         super.setNomTable("infoSalaire");
    }
    
    
    

    public InfoSalaire(String id, String idPersonnel, String categorie, String palier, double indemnite_fonction, double indemnite_conge_paye, double indemnite_deplacement, double indemnite_risque, String logement, String vehicule, String autre_avantage, String mode_paiement, String numero_virement, String numero_cnaps, int indice, double salaire_base) throws Exception {
         super.setNomTable("infoSalaire");
        this.setId(id);
        this.setIdPersonnel(idPersonnel);
        this.setCategorie(categorie);
        this.setPalier(palier);
        this.setIndemnite_fonction(indemnite_fonction);
        this.setIndemnite_conge_paye(indemnite_conge_paye);
        this.setIndemnite_deplacement(indemnite_deplacement);
        this.setIndemnite_risque(indemnite_risque);
        this.setLogement(logement);
        this.setVehicule(vehicule);
        this.setAutre_avantage(autre_avantage);
        this.setMode_paiement(mode_paiement);
        this.setNumero_virement(numero_virement);
        this.setNumero_cnaps(numero_cnaps);
        this.setIndice(indice);
        this.setSalaire_base(salaire_base);
    }
     public InfoSalaire(String idPersonnel, String categorie, String palier, double indemnite_fonction, double indemnite_conge_paye, double indemnite_deplacement, double indemnite_risque, String logement, String vehicule, String autre_avantage, String mode_paiement, String numero_virement, String numero_cnaps, int indice, double salaire_base) throws Exception {
         super.setNomTable("infoSalaire");
        this.setIdPersonnel(idPersonnel);
        this.setCategorie(categorie);
        this.setPalier(palier);
        this.setIndemnite_fonction(indemnite_fonction);
        this.setIndemnite_conge_paye(indemnite_conge_paye);
        this.setIndemnite_deplacement(indemnite_deplacement);
        this.setIndemnite_risque(indemnite_risque);
        this.setLogement(logement);
        this.setVehicule(vehicule);
        this.setAutre_avantage(autre_avantage);
        this.setMode_paiement(mode_paiement);
        this.setNumero_virement(numero_virement);
        this.setNumero_cnaps(numero_cnaps);
        this.setIndice(indice);
        this.setSalaire_base(salaire_base);
    }
    public String getIdAvantagenature() {
        return idAvantagenature;
    }

    public void setIdAvantagenature(String idAvantagenature) {
        this.idAvantagenature = idAvantagenature;
    }

    public String getIdIndemnite() {
        return idIndemnite;
    }

    public void setIdIndemnite(String idIndemnite) {
        this.idIndemnite = idIndemnite;
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

    public String getCategorie() {
        return categorie;
    }

    public void setCategorie(String categorie) {
        this.categorie = categorie;
    }

    public String getPalier() {
        return palier;
    }

    public void setPalier(String palier) {
        this.palier = palier;
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

    public String getLogement() {
        return logement;
    }

    public void setLogement(String logement) {
        this.logement = logement;
    }

    public String getVehicule() {
        return vehicule;
    }

    public void setVehicule(String vehicule) {
        this.vehicule = vehicule;
    }

    public String getAutre_avantage() {
        return autre_avantage;
    }

    public void setAutre_avantage(String autre_avantage) {
        this.autre_avantage = autre_avantage;
    }

    public String getMode_paiement() {
        return mode_paiement;
    }

    public void setMode_paiement(String mode_paiement) {
        this.mode_paiement = mode_paiement;
    }

    public String getNumero_virement() {
        return numero_virement;
    }

    public void setNumero_virement(String numero_virement) {
        this.numero_virement = numero_virement;
    }

    public String getNumero_cnaps() {
        return numero_cnaps;
    }

    public void setNumero_cnaps(String numero_cnaps) {
        this.numero_cnaps = numero_cnaps;
    }

    public int getIndice() {
        return indice;
    }

    public void setIndice(int indice) throws Exception {
        
         if (getMode().compareToIgnoreCase("modif") == 0) {
            if (indice < 0) {
               throw new Exception("indice invalide");
            } 
        }
        
        
        this.indice = indice;
    }

    public double getSalaire_base() {
        return salaire_base;
    }

    public void setSalaire_base(double salaire_base) throws Exception {
      
        
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (salaire_base < 0) {
               throw new Exception("salaire_base invalide");
            } 
        }
        this.salaire_base=salaire_base;
        
    }
    
    
    

    @Override
    public String getTuppleID() {
        return this.id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
}
