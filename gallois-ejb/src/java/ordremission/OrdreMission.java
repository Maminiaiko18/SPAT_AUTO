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
public class OrdreMission extends ClassEtat {
    private String id,idindemnitemission,idtiers,idmotifvoyage,lieudeplacement,numOM;
    private  double duree;
    private Date datedepart;
    private int estForfaitaire;

    public OrdreMission() {
        super.setNomTable("ordre_mission");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdindemnitemission() {
        return idindemnitemission;
    }

    public void setIdindemnitemission(String idindemnitemission) {
        this.idindemnitemission = idindemnitemission;
    }

    public String getIdtiers() {
        return idtiers;
    }

    public void setIdtiers(String idtiers) {
        this.idtiers = idtiers;
    }

    public String getIdmotifvoyage() {
        return idmotifvoyage;
    }

    public void setIdmotifvoyage(String idmotifvoyage) {
        this.idmotifvoyage = idmotifvoyage;
    }

    public String getLieudeplacement() {
        return lieudeplacement;
    }

    public void setLieudeplacement(String lieudeplacement) {
        this.lieudeplacement = lieudeplacement;
    }

    public String getNumOM() {
        return numOM;
    }

    public void setNumOM(String numOM) {
        this.numOM = numOM;
    }

    public double getDuree() {
        return duree;
    }

    public void setDuree(double duree) {
        this.duree = duree;
    }

    public Date getDatedepart() {
        return datedepart;
    }

    public void setDatedepart(Date datedepart) {
        this.datedepart = datedepart;
    }

    public int getEstForfaitaire() {
        return estForfaitaire;
    }

    public void setEstForfaitaire(int estForfaitaire) {
        this.estForfaitaire = estForfaitaire;
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
        this.preparePk("OM", "GETSEQORDRE_MISSION");
        this.setId(makePK(c));
    }

    
}
