/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ordremission;

import bean.ClassEtat;
import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author Nouta
 */
public class IndemniteMission extends ClassEtat {
    private String id,idcategorieprofessionnel,idcategorieprofessionnellib;
    private double fraishebergement,fraisrestauration,fraisdeplacement,fraisforfaitaire;
    private Date daty;

    public IndemniteMission() {
        super.setNomTable("indemnite_mission");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdcategorieprofessionnel() {
        return idcategorieprofessionnel;
    }

    public void setIdcategorieprofessionnel(String idcategorieprofessionnel) {
        this.idcategorieprofessionnel = idcategorieprofessionnel;
    }

    public String getIdcategorieprofessionnellib() {
        return idcategorieprofessionnellib;
    }

    public void setIdcategorieprofessionnellib(String idcategorieprofessionnellib) {
        this.idcategorieprofessionnellib = idcategorieprofessionnellib;
    }

    public double getFraishebergement() {
        return fraishebergement;
    }

    public void setFraishebergement(double fraishebergement) {
        this.fraishebergement = fraishebergement;
    }

    public double getFraisrestauration() {
        return fraisrestauration;
    }

    public void setFraisrestauration(double fraisrestauration) {
        this.fraisrestauration = fraisrestauration;
    }

    public double getFraisdeplacement() {
        return fraisdeplacement;
    }

    public void setFraisdeplacement(double fraisdeplacement) {
        this.fraisdeplacement = fraisdeplacement;
    }

    public double getFraisforfaitaire() {
        return fraisforfaitaire;
    }

    public void setFraisforfaitaire(double fraisforfaitaire) {
        this.fraisforfaitaire = fraisforfaitaire;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    public void construirePK(Connection c) throws Exception {     
        this.preparePk("IM", "GETSEQINDEMNITE_MISSION");
        this.setId(makePK(c));
    }

    
}
