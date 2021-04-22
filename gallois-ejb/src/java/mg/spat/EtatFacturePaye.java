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
 * @author Tin
 */
public class EtatFacturePaye extends ClassMAPTable{
    private String idfacturemere, idclient, idfactureen, idscatservice, etat;
    private Date daty;
    private double montantapayer, idcourschange, avoir, paye, idtva;
     
    
    public EtatFacturePaye(){
    this.setNomTable("etatfacturepaye");
    }

    public String getIdfacturemere() {
        return idfacturemere;
    }

    public void setIdfacturemere(String idfacturemere) {
        this.idfacturemere = idfacturemere;
    }

    public String getIdclient() {
        return idclient;
    }

    public void setIdclient(String idclient) {
        this.idclient = idclient;
    }

    public String getIdfactureen() {
        return idfactureen;
    }

    public void setIdfactureen(String idfactureen) {
        this.idfactureen = idfactureen;
    }

    public String getIdscatservice() {
        return idscatservice;
    }

    public void setIdscatservice(String idscatservice) {
        this.idscatservice = idscatservice;
    }

    public String getEtat() {
        return etat;
    }

    public void setEtat(String etat) {
        this.etat = etat;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public double getMontantapayer() {
        return montantapayer;
    }

    public void setMontantapayer(double montantapayer) {
        this.montantapayer = montantapayer;
    }

    public double getIdcourschange() {
        return idcourschange;
    }

    public void setIdcourschange(double idcourschange) {
        this.idcourschange = idcourschange;
    }

    public double getAvoir() {
        return avoir;
    }

    public void setAvoir(double avoir) {
        this.avoir = avoir;
    }

    public double getPaye() {
        return paye;
    }

    public void setPaye(double paye) {
        this.paye = paye;
    }

    public double getIdtva() {
        return idtva;
    }

    public void setIdtva(double idtva) {
        this.idtva = idtva;
    }
    
    public String getTuppleID() {
        return idfacturemere;
    }

    public String getAttributIDName() {
        return "idfacturemere";
    }
    
}
