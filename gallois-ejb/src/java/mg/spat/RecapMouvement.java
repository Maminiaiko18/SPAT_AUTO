/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import java.sql.Date;

/**
 *
 * @author MEVA
 */
public class RecapMouvement {
    private String quaidestination, escale, navire, consignataire, cargaison;
    private Date dateArrivee, dateDepart;

    public RecapMouvement() {
    }

    public RecapMouvement(String quaidestination, String escale, String navire, String consignataire, String cargaison, Date dateArrivee, Date dateDepart) {
        this.setQuaidestination(quaidestination);
        this.setEscale(escale);
        this.setNavire(navire);
        this.setConsignataire(consignataire);
        this.setCargaison(cargaison);
        this.setDateArrivee(dateArrivee);
        this.setDateDepart(dateDepart);
    }

    public String getQuaidestination() {
        return quaidestination;
    }

    public void setQuaidestination(String quaidestination) {
        this.quaidestination = quaidestination;
    }

    public String getEscale() {
        return escale;
    }

    public void setEscale(String escale) {
        this.escale = escale;
    }

    public String getNavire() {
        return navire;
    }

    public void setNavire(String navire) {
        this.navire = navire;
    }

    public String getConsignataire() {
        return consignataire;
    }

    public void setConsignataire(String consignataire) {
        this.consignataire = consignataire;
    }

    public String getCargaison() {
        return cargaison;
    }

    public void setCargaison(String cargaison) {
        this.cargaison = cargaison;
    }

    public Date getDateArrivee() {
        return dateArrivee;
    }

    public void setDateArrivee(Date dateArrivee) {
        this.dateArrivee = dateArrivee;
    }

    public Date getDateDepart() {
        return dateDepart;
    }

    public void setDateDepart(Date dateDepart) {
        this.dateDepart = dateDepart;
    }
    
    
}
