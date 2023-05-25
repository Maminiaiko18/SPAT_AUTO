/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ordremission;

import bean.CGenUtil;
import bean.ClassEtat;
import facture.NumeroFacture;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author Nouta
 */
public class OrdreMission extends ClassEtat {
    private String id,idindemnitemission,idtiers,idmotifvoyage,lieudeplacement,numOM,idmoyendeplacement,motifvoyage;
    private  double duree;
    private Date datedepart;
    private int estForfaitaire;
    private OrdreMissionIndemnite[] indemnites;
    
    public OrdreMissionIndemnite[] getOrdreMissionIndemnites() throws Exception{
        return this.getOrdreMissionIndemnites(null);
    }
    
    public OrdreMissionIndemnite[] getOrdreMissionIndemnites(Connection connection) throws Exception{
        OrdreMissionIndemnite ordre= new OrdreMissionIndemnite();
        if(this.getEstForfaitaire()==1){
            ordre.setNomTable("ORDRE_MISSION_FORFAITAIRE");
        }
        OrdreMissionIndemnite[] ordreMissionIndemnites= (OrdreMissionIndemnite[]) CGenUtil.rechercher(ordre, null, null, connection, " and id= '"+this.getId()+"'");;
        return ordreMissionIndemnites;
    }

    public OrdreMissionIndemnite[] getIndemnites() {
        return indemnites;
    }

    public void setIndemnites(OrdreMissionIndemnite[] indemnites) {
        this.indemnites = indemnites;
    }
    
    public OrdreMission() {
        super.setNomTable("ordre_mission");
    }

    public String getIdmoyendeplacement() {
        return idmoyendeplacement;
    }

    public void setIdmoyendeplacement(String idmoyendeplacement) {
        this.idmoyendeplacement = idmoyendeplacement;
    }

    public String getMotifvoyage() {
        return motifvoyage;
    }

    public void setMotifvoyage(String motifvoyage) {
        this.motifvoyage = motifvoyage;
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

    public String calculerNumeroOM(Connection c) throws Exception {
        String numOM = "";
        
        try{
            String rqt = "SELECT  nvl(max(TO_NUMBER(numOM))+1,1) AS numerosuivant FROM ordre_mission where EXTRACT(YEAR FROM datedepart) = " + Utilitaire.getAnnee(this.getDatedepart());
            NumeroFacture[] result = (NumeroFacture[])CGenUtil.rechercher(new NumeroFacture(), rqt, c);
            if(result.length>0) numOM = Utilitaire.completerInt(7, result[0].getNumerosuivant());
        }
        catch(Exception e){
            throw e;
        }
        
        return numOM;
    }
    
    @Override
    public Object validerObject(String u, Connection c) throws Exception {
        try{
            if(this.getNumOM() == null || this.getNumOM().isEmpty() || this.getNumOM().compareToIgnoreCase("") == 0){
                String numOM = this.calculerNumeroOM(c);
                this.setNumOM(numOM);
            }
        }
        catch(Exception e){
            throw e;
        }
        
        return super.validerObject(u, c);
    }
}
