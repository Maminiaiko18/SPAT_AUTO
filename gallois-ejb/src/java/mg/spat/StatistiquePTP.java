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
public class StatistiquePTP extends ClassMAPTable{
    private String id;
    private Date daty;
    private int dechargement,chargement;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    
    public StatistiquePTP() {
        super.setNomTable("statistiquePTP");
    }

    
    
    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public int getDechargement() {
        return dechargement;
    }

    public void setDechargement(int dechargement) {
        this.dechargement = dechargement;
    }

    public int getChargement() {
        return chargement;
    }

    public void setChargement(int chargement) {
        this.chargement = chargement;
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
