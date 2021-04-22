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
 * @author Axel
 */
public class Statistique extends ClassMAPTable{
    
    private String id;
    private String titre;
    private Date daty;
    private double nombre;
    private double volume;
    private String navire;

    public Statistique() {
        this.setNomTable("statistique");
    }

     public void construirePK(Connection c) throws Exception {
        this.preparePk("STAT", "GETSEQstatistique");
        this.setId(makePK(c));
    }
    
    
    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitre() {
        return titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public double getNombre() {
        return nombre;
    }

    public void setNombre(double nombre) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (nombre < 0) {
               throw new Exception("nombre invalide");
            } 
        }
        this.nombre = nombre;
    }

    public double getVolume() {
        return volume;
    }

    public void setVolume(double volume) throws Exception {
         if (getMode().compareToIgnoreCase("modif") == 0) {
            if (volume < 0) {
               throw new Exception("volume invalide");
            } 
        }
        this.volume = volume;
    }

    public String getNavire() {
        return navire;
    }

    public void setNavire(String navire) {
        this.navire = navire;
    }
    
    
    
}
