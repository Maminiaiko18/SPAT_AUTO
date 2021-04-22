/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.cnaps.formation;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author Jetta
 */
public class FormAbsence extends ClassMAPTable {

    private String id, id_formation, log_personnel, motif, remarque;
    private Date date_absence;

    public FormAbsence(String id, String id_formation, String log_personnel, String motif, String remarque, Date date_absence) throws Exception {
        this.setId(id);
        this.setId_formation(id_formation);
        this.setLog_personnel(log_personnel);
        this.setMotif(motif);
        this.setRemarque(remarque);
        this.setDate_absence(date_absence);
        this.setNomTable("FORM_ABSENCE");
    }

    public FormAbsence(String id_formation, String log_personnel, String motif, String remarque, Date date_absence) throws Exception {

        this.setId_formation(id_formation);
        this.setLog_personnel(log_personnel);
        this.setMotif(motif);
        this.setRemarque(remarque);
        this.setDate_absence(date_absence);
        this.setNomTable("FORM_ABSENCE");
    }

    public FormAbsence() {

        this.setNomTable("FORM_ABSENCE");
    }

    public String getTuppleID() {
        return id;
    }

    public String getAttributIDName() {
        return "id";
    }

    public void construirePK(Connection c) throws Exception {
        this.preparePk("FABS", "getSeqFormAbsence");
        this.setId(makePK(c));
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getId_formation() {
        return id_formation;
    }

    public void setId_formation(String id_formation) throws Exception {
        if (getMode().compareTo("modif") != 0) {
            this.id_formation = id_formation;
            return;
        }
        if(id_formation=="" || id_formation==null) throw new Exception("Champ Formation manquant");
        this.id_formation = id_formation;
    }

    public String getLog_personnel() {
        return log_personnel;
    }

    public void setLog_personnel(String log_personnel) throws Exception {
        if (getMode().compareTo("modif") != 0) {
            this.log_personnel = log_personnel;
            return;
        }
        if(log_personnel=="" || log_personnel==null) throw new Exception("Champ Personnel manquant");
        this.log_personnel = log_personnel;
    }

    public String getMotif() {
        return motif;
    }

    public void setMotif(String motif) {
        this.motif = motif;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public Date getDate_absence() {
        return date_absence;
    }

    public void setDate_absence(Date date_absence) throws Exception {
        if (getMode().compareTo("modif") != 0) {
            this.date_absence = date_absence;
            return;
        }
        if(date_absence==null) throw new Exception("Champ Date Absence manquant");
        this.date_absence = date_absence;
    }

}
