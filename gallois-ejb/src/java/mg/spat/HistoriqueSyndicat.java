/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassEtat;
import java.sql.Connection;
import java.sql.Date;
import service.PrevisionService;
import service.SpatService;

/**
 *
 * @author Asus
 */
public class HistoriqueSyndicat extends ClassEtat{
    
    private String id,idsyndicat,idposte,idpersonnel;
    private Date daty, date_fin;

    public HistoriqueSyndicat() {
         this.setNomTable("historiquesyndicat");
        
    }

    public HistoriqueSyndicat(String idsyndicat, String idposte, Date daty) {
        this.setNomTable("historiquesyndicat");
        this.setIdsyndicat(idsyndicat);
        this.setIdposte(idposte);
        this.setDaty(daty);
    }
    
    public HistoriqueSyndicat(String id, String idsyndicat, String idposte, String idpersonnel, Date daty) {
        this.setNomTable("historiquesyndicat");
        this.setId(id);
        this.setIdsyndicat(idsyndicat);
        this.setIdposte(idposte);
        this.setIdpersonnel(idpersonnel);
        this.setDaty(daty);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdsyndicat() {
        return idsyndicat;
    }

    public void setIdsyndicat(String idsyndicat) {
        this.idsyndicat = idsyndicat;
    }

    public String getIdposte() {
        return idposte;
    }

    public void setIdposte(String idposte) {
        this.idposte = idposte;
    }

    public String getIdpersonnel() {
        return idpersonnel;
    }

    public void setIdpersonnel(String idpersonnel) {
        this.idpersonnel = idpersonnel;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }
    
   public void controler(Connection c) throws Exception {
       SpatService.testerSyndicat(this,c);
      
    } 

    @Override
    public String getTuppleID() {
     return id;}

    @Override
    public String getAttributIDName() {
     return "id"; 
    }
    public void construirePK(Connection c) throws Exception {
        this.preparePk("HIS", "getseq_historiquesyndicat");
        this.setId(makePK(c));
    }

    public Date getDate_fin() {
        return date_fin;
    }

    public void setDate_fin(Date date_fin) {
        this.date_fin = date_fin;
    }
    
}
