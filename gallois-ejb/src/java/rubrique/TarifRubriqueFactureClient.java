/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rubrique;

/**
 *
 * @author Audace
 */

import bean.ClassEtat;
import java.sql.Connection;

public class TarifRubriqueFactureClient extends ClassEtat{
    private String id;
    private double borne_inf, borne_sup, prixunitaire;
    private String iddevise, idnature;
    private double unite;
    private String compte;
    
    public TarifRubriqueFactureClient(){
        setNomTable("TARIFRUBRIQUEFACTURECLIENT");
    }
    
    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
    public void construirePK(Connection c) throws Exception{
        this.preparePk("TRFC", "getseqtarifrubriquefactureCl");
        this.setId(makePK(c));
    }
    
    

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public double getBorne_inf() {
        return borne_inf;
    }

    public void setBorne_inf(double borne_inf) {
        this.borne_inf = borne_inf;
    }

    public double getBorne_sup() {
        return borne_sup;
    }

    public void setBorne_sup(double borne_sup) {
        this.borne_sup = borne_sup;
    }

    public double getPrixunitaire() {
        return prixunitaire;
    }

    public void setPrixunitaire(double prixunitaire) {
        this.prixunitaire = prixunitaire;
    }

    public String getIddevise() {
        return iddevise;
    }

    public void setIddevise(String iddevise) {
        this.iddevise = iddevise;
    }

    public String getIdnature() {
        return idnature;
    }

    public void setIdnature(String idnature) {
        this.idnature = idnature;
    }

    public double getUnite() {
        return unite;
    }

    public void setUnite(double unite) {
        this.unite = unite;
    }

    public String getCompte() {
        return compte;
    }

    public void setCompte(String compte) {
        this.compte = compte;
    }

    
    
    
}
