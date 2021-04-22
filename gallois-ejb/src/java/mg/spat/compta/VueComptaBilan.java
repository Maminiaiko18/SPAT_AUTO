/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.compta;

import java.sql.Date;

/**
 *
 * @author JESSI
 */
public class VueComptaBilan extends ComptaBilan {
    private String id,reference,cpt_rubrique,libelle_cpt_rubrique,type;
    private int etat;
    private Date ec_date;

    public VueComptaBilan() {
      this.setNomTable("comptabilan");
    
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getReference() {
        return reference;
    }

    public void setReference(String reference) {
        this.reference = reference;
    }

    public String getCpt_rubrique() {
        return cpt_rubrique;
    }

    public void setCpt_rubrique(String cpt_rubrique) {
        this.cpt_rubrique = cpt_rubrique;
    }

    public String getLibelle_cpt_rubrique() {
        return libelle_cpt_rubrique;
    }

    public void setLibelle_cpt_rubrique(String libelle_cpt_rubrique) {
        this.libelle_cpt_rubrique = libelle_cpt_rubrique;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getEtat() {
        return etat;
    }

    public void setEtat(int etat) {
        this.etat = etat;
    }

    public Date getEc_date() {
        return ec_date;
    }

    public void setEc_date(Date ec_date) {
        this.ec_date = ec_date;
    }

    public VueComptaBilan(String id, String reference, String cpt_rubrique, String libelle_cpt_rubrique, String type, int etat, Date ec_date) {
        this.setNomTable("comptabilan");
        this.id = id;
        this.reference = reference;
        this.cpt_rubrique = cpt_rubrique;
        this.libelle_cpt_rubrique = libelle_cpt_rubrique;
        this.type = type;
        this.etat = etat;
        this.ec_date = ec_date;
    }
}
