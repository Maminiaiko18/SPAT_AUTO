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
public class StatistiqueSMMC extends ClassMAPTable{
    private String id;
    private Date daty;
    private int debarquement,embarquement;
    

    public StatistiqueSMMC() {
        super.setNomTable("statistiqueSMMC");
    }

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

    public int getDebarquement() {
        return debarquement;
    }

    public void setDebarquement(int debarquement) {
        this.debarquement = debarquement;
    }

    public int getEmbarquement() {
        return embarquement;
    }

    public void setEmbarquement(int embarquement) {
        this.embarquement = embarquement;
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
