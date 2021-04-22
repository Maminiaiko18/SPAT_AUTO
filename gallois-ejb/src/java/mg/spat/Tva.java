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
public class Tva extends ClassMAPTable{
    private String idtva, valeurtva;
    private Date datydebutvalid;

    public Tva() {
        this.setNomTable("tva");
    }

    
    public String getIdtva() {
        return idtva;
    }

    public void setIdtva(String idtva) {
        this.idtva = idtva;
    }

    public String getValeurtva() {
        return valeurtva;
    }

    public void setValeurtva(String valeurtva) {
        this.valeurtva = valeurtva;
    }

    public Date getDatydebutvalid() {
        return datydebutvalid;
    }

    public void setDatydebutvalid(Date datydebutvalid) {
        this.datydebutvalid = datydebutvalid;
    }

    @Override
    public String getTuppleID() {
        return this.getIdtva();
    }

    @Override
    public String getAttributIDName() {
        return "idtva";
    }
    
    
}
