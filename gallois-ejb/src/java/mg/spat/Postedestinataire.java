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
 * @author Notiavina
 */
public class Postedestinataire extends ClassMAPTable{
    private String id, quai, interne, pays,valquais;
    private double longueur, profondeur,tirant;
    
    public Postedestinataire(){
        
        super.setNomTable("postedestinataire");
    }

    public Postedestinataire(String id, String quai, String interne, String pays, double longueur, double profondeur, double tirant) throws Exception {
        super.setNomTable("postedestinataire");
        this.setId(id);
        this.setQuai(quai);
        this.setInterne(interne);
        this.setPays(pays);
        this.setLongueur(longueur);
        this.setProfondeur(profondeur);
        this.setTirant(tirant);
    }

    public String getValquais() {
        return valquais;
    }

    public void setValquais(String valquais) {
        this.valquais = valquais;
    }
    

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getQuai() {
        return quai;
    }

    public void setQuai(String quai) {
        this.quai = quai;
    }

    public String getInterne() throws Exception {
       
        return interne;
    }

    public void setInterne(String interne) throws Exception {
          if (getMode().compareToIgnoreCase("modif") == 0) {
            if (interne.equalsIgnoreCase("") ) {
                throw new Exception("interne invalide");
            }
         }
        this.interne = interne;
    }

    public String getPays() {
        return pays;
    }

    public void setPays(String pays) {
        this.pays = pays;
    }

    public double getLongueur() {
        return longueur;
    }

    public void setLongueur(double longueur) throws Exception {
      if (getMode().compareToIgnoreCase("modif") == 0) {
            if (longueur < 0) {
                throw new Exception("longueur invalide");
            }
         }
        this.longueur = longueur;
    }

    public double getProfondeur() {
        return profondeur;
    }

    public void setProfondeur(double profondeur) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (profondeur < 0) {
                throw new Exception("profondeur invalide");
            }
         }
        this.profondeur = profondeur;
    }

    public double getTirant() {
        return tirant;
    }

    public void setTirant(double tirant) throws Exception {
         if (getMode().compareToIgnoreCase("modif") == 0) {
            if (tirant < 0) {
                throw new Exception("tirant invalide");
            }
         }
        this.tirant = tirant;
    }
    
    public void construirePK(Connection c) throws Exception {
        this.preparePk("PST", "getseqpostedestinataire");
        this.setId(makePK(c));
    }
    
    public String getTuppleID() {
        return id;
    }

    public String getAttributIDName() {
        return "id";
    }
}
