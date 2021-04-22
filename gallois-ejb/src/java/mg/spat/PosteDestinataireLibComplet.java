/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassMAPTable;
import java.sql.Date;

/**
 *
 * @author john
 */
public class PosteDestinataireLibComplet extends ClassMAPTable {
    
    private String id,valpays,descepays,valtypequais,descetypequais,quai,interne,valquais,descequais,typequais,paysquais;
    private double profondeur,tirant,longueur;
    
      public String getValColLibelle() {
        return this.valtypequais+" - "+valquais;
    }
    public PosteDestinataireLibComplet(){
          super.setNomTable("POSTEDESTINATAIRELIBCOMPLET");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getValpays() {
        return valpays;
    }

    public void setValpays(String valpays) {
        this.valpays = valpays;
    }

    public String getDescepays() {
        return descepays;
    }

    public void setDescepays(String descepays) {
        this.descepays = descepays;
    }

    public String getValtypequais() {
        return valtypequais;
    }

    public void setValtypequais(String valtypequais) {
        this.valtypequais = valtypequais;
    }

    public String getDescetypequais() {
        return descetypequais;
    }

    public void setDescetypequais(String descetypequais) {
        this.descetypequais = descetypequais;
    }

    public String getQuai() {
        return quai;
    }

    public void setQuai(String quai) {
        this.quai = quai;
    }

    public String getInterne() {
        return interne;
    }

    public void setInterne(String interne) {
        this.interne = interne;
    }

    public String getValquais() {
        return valquais;
    }

    public void setValquais(String valquais) {
        this.valquais = valquais;
    }

    public String getDescequais() {
        return descequais;
    }

    public void setDescequais(String descequais) {
        this.descequais = descequais;
    }

    public String getTypequais() {
        return typequais;
    }

    public void setTypequais(String typequais) {
        this.typequais = typequais;
    }

    public String getPaysquais() {
        return paysquais;
    }

    public void setPaysquais(String paysquais) {
        this.paysquais = paysquais;
    }

    public double getProfondeur() {
        return profondeur;
    }

    public void setProfondeur(double profondeur) {
        this.profondeur = profondeur;
    }

    public double getTirant() {
        return tirant;
    }

    public void setTirant(double tirant) {
        this.tirant = tirant;
    }

    public double getLongueur() {
        return longueur;
    }

    public void setLongueur(double longueur) {
        this.longueur = longueur;
    }
    
    
   
    
    public String getTuppleID() {
        return id;
    }

    public String getAttributIDName() {
        return "id";
    }  
}
