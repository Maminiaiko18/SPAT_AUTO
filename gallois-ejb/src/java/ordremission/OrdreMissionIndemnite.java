/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ordremission;

import bean.ClassEtat;
import java.sql.Connection;

/**
 *
 * @author Ny Anjara Mamisoa
 */
public class OrdreMissionIndemnite  extends ClassEtat {
    String id;
    String idindemnitemission;
    String idtiers;
    String typeIndemnite;
    String montant;
    
    public OrdreMissionIndemnite() {
        super.setNomTable("ordre_mission_indemnite  ");
    }

    @Override
    public void construirePK(Connection c) throws Exception {     
        this.preparePk("OM", "GETSEQORDRE_MISSION");
        this.setId(makePK(c));
    }

    @Override
    public String getTuppleID() {
        return getId();
    }

    @Override
    public String getAttributIDName() {
        return "id";
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

    public String getTypeIndemnite() {
        return typeIndemnite;
    }

    public void setTypeIndemnite(String typeIndemnite) {
        this.typeIndemnite = typeIndemnite;
    }

    public String getMontant() {
        return montant;
    }

    public void setMontant(String montant) {
        this.montant = montant;
    }
    
    
}
