/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ordremission;

import bean.ClassEtat;
import bean.ClassMAPTable;
import java.sql.Date;

/**
 *
 * @author Valiah Karen
 */
public class RetourOM extends ClassEtat{
    private String id, idom, heurearrivee ,autres ;
    private Date datearrivee;
    private int nombres;
    private double prixunitaire , dureereelle ;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdom() {
        return idom;
    }

    public void setIdom(String idom) {
        this.idom = idom;
    }

    public String getHeurearrivee() {
        return heurearrivee;
    }

    public void setHeurearrivee(String heurearrivee) {
        this.heurearrivee = heurearrivee;
    }

    public String getAutres() {
        return autres;
    }

    public void setAutres(String autres) {
        this.autres = autres;
    }

    public Date getDatearrivee() {
        return datearrivee;
    }

    public void setDatearrivee(Date datearrivee) {
        this.datearrivee = datearrivee;
    }

    public int getNombres() {
        return nombres;
    }

    public void setNombres(int nombres) {
        this.nombres = nombres;
    }

    public double getPrixunitaire() {
        return prixunitaire;
    }

    public void setPrixunitaire(double prixunitaire) {
        this.prixunitaire = prixunitaire;
    }

    public double getDureereelle() {
        return dureereelle;
    }

    public void setDureereelle(double dureereelle) {
        this.dureereelle = dureereelle;
    }

    
    @Override
    public String getTuppleID() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String getAttributIDName() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
}
