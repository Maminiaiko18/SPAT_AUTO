/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.relationhumaine;

import bean.AdminGen;
import bean.CGenUtil;
import java.sql.Connection;
import recapitulation.RecapitulationRH;
import utilitaire.UtilDB;

/**
 *
 * @author ACER
 */
public class StatistiqueRH {
    private RecapitulationRH permanent;
    private RecapitulationRH prestataire;
    private RecapitulationRH temporaire;
    private RecapitulationRH autres;
    private double total;

    public StatistiqueRH() throws Exception{
        Connection c = new UtilDB().GetConn();
        try{
            RecapitulationRH rec = new RecapitulationRH();
            permanent = new RecapitulationRH(); prestataire = new RecapitulationRH(); temporaire = new RecapitulationRH(); autres = new RecapitulationRH();
            RecapitulationRH[] permListe = (RecapitulationRH[])CGenUtil.rechercher(rec, null, null, c, " and type='Permanent'");
            setPermanent(permListe.length!=0 ? permListe[0] : permanent);
            RecapitulationRH[] tempListe = (RecapitulationRH[])CGenUtil.rechercher(rec, null, null, c, " and type='Temporaire'");
            setTemporaire(tempListe.length!=0 ? tempListe[0] : temporaire);
            RecapitulationRH[] recListe = (RecapitulationRH[])CGenUtil.rechercher(rec, null, null, c, " and type='Autres' or type is null");
            setAutres(recListe.length!=0 ? recListe[0] : autres);
            
            //RecapitulationRH[] presListe = (RecapitulationRH[])CGenUtil.rechercher(rec, null, null, c, " and type='Prestataire'");
            //setPrestataire(presListe.length!=0 ? presListe[0] : prestataire);
            RecapitulationRH[] recap = {permanent, temporaire, prestataire, autres};
            setTotal(AdminGen.calculSommeDouble(recap, "nombre"));
        }catch(Exception ex){
            throw ex;
        }finally{
            if(c!=null)c.close();
        }
    }

    public RecapitulationRH getAutres() {
        return autres;
    }

    public void setAutres(RecapitulationRH autres) {
        this.autres = autres;
    }
    
    public RecapitulationRH getPermanent() {
        return permanent;
    }

    public void setPermanent(RecapitulationRH permanent) {
        this.permanent = permanent;
    }

    public RecapitulationRH getPrestataire() {
        return prestataire;
    }

    public void setPrestataire(RecapitulationRH prestataire) {
        this.prestataire = prestataire;
    }

    public RecapitulationRH getTemporaire() {
        return temporaire;
    }

    public void setTemporaire(RecapitulationRH temporaire) {
        this.temporaire = temporaire;
    }
    
    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }
}
