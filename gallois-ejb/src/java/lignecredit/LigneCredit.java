/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lignecredit;

import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author rasol
 */
public class LigneCredit  extends ClassMAPTable{
    private String id, designation, compte, idtypelingecredit;
    private double annee, mois, creditinitial;

    public LigneCredit() {
        this.setNomTable("lignecredit");
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
        this.preparePk("LC", "getseqlignecredit");
        this.setId(makePK(c));
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getCompte() {
        return compte;
    }

    public void setCompte(String compte) {
        this.compte = compte;
    }

    public String getIdtypelingecredit() {
        return idtypelingecredit;
    }

    public void setIdtypelingecredit(String idtypelingecredit) {
        this.idtypelingecredit = idtypelingecredit;
    }
    
    
    public double getAnnee() {
        return annee;
    }

    public void setAnnee(double annee) {
        this.annee = annee;
    }

    public double getMois() {
        return mois;
    }

    public void setMois(double mois) {
        this.mois = mois;
    }

    public double getCreditinitial() {
        return creditinitial;
    }

    public void setCreditinitial(double creditinitial) {
        this.creditinitial = creditinitial;
    }
}
