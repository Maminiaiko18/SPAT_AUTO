/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.cnaps.formation;

/**
 *
 * @author anthonyandrianaivoravelona
 */
public class AttestationPriseCharge {
    private String annee, personnel, matricule, fonction, drh, service, direction, etablissement;

    public AttestationPriseCharge(String annee, String personnel, String matricule, String fonction, String drh, String service, String direction, String etablissement) {
        this.annee = annee;
        this.personnel = personnel;
        this.matricule = matricule;
        this.fonction = fonction;
        this.drh = drh;
        this.service = service;
        this.direction = direction;
        this.etablissement = etablissement;
    }

    public AttestationPriseCharge() {
    }

    public String getAnnee() {
        return annee;
    }

    public void setAnnee(String annee) {
        this.annee = annee;
    }

    public String getPersonnel() {
        return personnel;
    }

    public void setPersonnel(String personnel) {
        this.personnel = personnel;
    }

    public String getMatricule() {
        return matricule;
    }

    public void setMatricule(String matricule) {
        this.matricule = matricule;
    }

    public String getFonction() {
        return fonction;
    }

    public void setFonction(String fonction) {
        this.fonction = fonction;
    }

    public String getDrh() {
        return drh;
    }

    public void setDrh(String drh) {
        this.drh = drh;
    }

    public String getService() {
        return service;
    }

    public void setService(String service) {
        this.service = service;
    }

    public String getDirection() {
        return direction;
    }

    public void setDirection(String direction) {
        this.direction = direction;
    }

    public String getEtablissement() {
        return etablissement;
    }

    public void setEtablissement(String etablissement) {
        this.etablissement = etablissement;
    }
    
    
}
