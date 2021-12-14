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
 * @author Nouta
 */
public class CargaisonAnalyse extends ClassMAPTable{
    private String id,cargaison,cargaisonlib,mois,moislib;
    private double tonnage;
    private Date date_arrivee;

    public CargaisonAnalyse() {
        super.setNomTable("cargaisonanalyse");
    }

    public CargaisonAnalyse(String id, String cargaison, String cargaisonlib, String mois, String moislib, double tonnage, Date date_arrivee) {
        this.id = id;
        this.cargaison = cargaison;
        this.cargaisonlib = cargaisonlib;
        this.mois = mois;
        this.moislib = moislib;
        this.tonnage = tonnage;
        this.date_arrivee = date_arrivee;
    }
    

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCargaison() {
        return cargaison;
    }

    public void setCargaison(String cargaison) {
        this.cargaison = cargaison;
    }

    public String getCargaisonlib() {
        return cargaisonlib;
    }

    public void setCargaisonlib(String cargaisonlib) {
        this.cargaisonlib = cargaisonlib;
    }

    public String getMois() {
        return mois;
    }

    public void setMois(String mois) {
        this.mois = mois;
    }

    public String getMoislib() {
        return moislib;
    }

    public void setMoislib(String moislib) {
        this.moislib = moislib;
    }

    public double getTonnage() {
        return tonnage;
    }

    public void setTonnage(double tonnage) {
        this.tonnage = tonnage;
    }

    public Date getDate_arrivee() {
        return date_arrivee;
    }

    public void setDate_arrivee(Date date_arrivee) {
        this.date_arrivee = date_arrivee;
    }
    
    
    

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
}
