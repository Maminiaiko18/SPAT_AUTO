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
public class Renseignement_salaire extends ClassMAPTable{
    
    private String id, idPersonnel,categorie,palier;
    private int indice;
    private double Salaire_base;

    public Renseignement_salaire() {
          super.setNomTable("Renseignement_salaire");
    }

    public Renseignement_salaire(String id, String idPersonnel, String categorie, String palier, int indice, double Salaire_base) throws Exception {
         super.setNomTable("Renseignement_salaire");
        this.setId(id);
        this.setIdPersonnel(idPersonnel);
        this.setCategorie(categorie);
        this.setPalier(palier);
        this.setIndice(indice);
        this.setSalaire_base(Salaire_base);
    }
    public Renseignement_salaire(String idPersonnel, String categorie, String palier, int indice, double Salaire_base) throws Exception {
         super.setNomTable("Renseignement_salaire");
        this.setIdPersonnel(idPersonnel);
        this.setCategorie(categorie);
        this.setPalier(palier);
        this.setIndice(indice);
        this.setSalaire_base(Salaire_base);
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
        return Salaire_base;
    }

    public void setSalaire_base(double Salaire_base) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (Salaire_base < 0) {
               throw new Exception("Salaire_base invalide");
            } 
        }
        this.Salaire_base = Salaire_base;
    }
    
    
    
    @Override
    public String getTuppleID() {
    return this.id;}

    @Override
    public String getAttributIDName() {
    return "id";  }
    
     public void construirePK(Connection c) throws Exception {
         this.preparePk("RES", "getseq_renseignement_salaire");
        this.setId(makePK(c));
        
    }
    
}
