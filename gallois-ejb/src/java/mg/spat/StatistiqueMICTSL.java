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
 * @author MEVA
 */
public class StatistiqueMICTSL extends ClassMAPTable{
    private Date daty;
    private int conteneursPleins,conteneursVides;
    private String id;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    
    
    
    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public int getConteneursPleins() {
        return conteneursPleins;
    }

    public void setConteneursPleins(int conteneursPleins) {
        this.conteneursPleins = conteneursPleins;
    }

    public int getConteneursVides() {
        return conteneursVides;
    }

    public void setConteneursVides(int conteneursVides) {
        this.conteneursVides = conteneursVides;
    }

    public StatistiqueMICTSL() {
        super.setNomTable("statistiqueMICTSL");
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
