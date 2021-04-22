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
public class Quais extends ClassMAPTable{
    
    private String id,val,desce,typequais,pays;
    private double longueur, profondeur;

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
        if(this.getMode().compareTo("modif")==0){
            if(longueur<0) throw new Exception("Longueur de quais invalide");
        }
        this.longueur = longueur;
    }

    public double getProfondeur() {
        return profondeur;
    }

    public void setProfondeur(double profondeur) throws Exception {
        if(this.getMode().compareTo("modif")==0){
            if(profondeur<0) throw new Exception("Profondeur de quais invalide");
        }
        this.profondeur = profondeur;
    }


    public Quais() {
         super.setNomTable("quais");
    }

    public Quais(String id, String val, String desce, String typequais) {
        this.id = id;
        this.val = val;
        this.desce = desce;
        this.typequais = typequais;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getVal() {
        return val;
    }

    public void setVal(String val) {
        this.val = val;
    }

    public String getDesce() {
        return desce;
    }

    public void setDesce(String desce) {
        this.desce = desce;
    }

    public String getTypequais() {
        return typequais;
    }

    public void setTypequais(String typequais) {
        this.typequais = typequais;
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
         this.preparePk("QUA", "GETSEQQUAIS");
        this.setId(makePK(c));
        
    }
    
}
