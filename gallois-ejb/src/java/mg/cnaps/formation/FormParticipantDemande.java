
package mg.cnaps.formation;

import bean.ClassMAPTable;
import java.sql.Connection;

public class FormParticipantDemande  extends ClassMAPTable{
    private String id, id_formation, log_personnel,remarque;
    private double note=-1, cout,indemnite;

    public void setIndemnite(double indemnite) {
        this.indemnite = indemnite;
    }

    public double getIndemnite() {
        return indemnite;
    }
    private int absence;

    public FormParticipantDemande() {
        super.setNomTable("form_participant_demande");
    }
    public FormParticipantDemande(String id,String id_formation,String log_personnel,String remarque,double note, double cout)throws Exception {
        this.setId(id);
        this.setId_formation(id_formation);
        this.setLog_personnel(log_personnel);
        this.setRemarque(remarque);
        this.setNote(note);
        this.setCout(cout);
        super.setNomTable("form_participant_demande");
    }

    public FormParticipantDemande(String id, String id_formation, String log_personnel, String remarque, double cout, int absence) throws Exception {
        this.setId_formation(id_formation);
        this.setLog_personnel(log_personnel);
        this.setRemarque(remarque);
        this.setNote(note);
        this.setCout(cout);
        this.setAbsence(absence);
        super.setNomTable("form_participant_demande");
    }
    public FormParticipantDemande(String id_formation,String log_personnel,String remarque,double note, double cout) throws Exception{
        this.setId_formation(id_formation);
        this.setLog_personnel(log_personnel);
        this.setRemarque(remarque);
        this.setNote(note);
        this.setCout(cout);
        super.setNomTable("form_participant_demande");
    }
    public FormParticipantDemande(String id, String id_formation, String log_personnel, String remarque, double cout, int absence,double indemnite) throws Exception {
        this.setId_formation(id_formation);
        this.setLog_personnel(log_personnel);
        this.setRemarque(remarque);
        this.setNote(note);
        this.setCout(cout);
        this.setAbsence(absence);
        this.setIndemnite(indemnite);
        super.setNomTable("form_participant_demande");
    }
    public FormParticipantDemande(String id_formation,String log_personnel,String remarque,double note, double cout,double indemnite) throws Exception{
        this.setId_formation(id_formation);
        this.setLog_personnel(log_personnel);
        this.setRemarque(remarque);
        this.setNote(note);
        this.setCout(cout);
        this.setIndemnite(indemnite);
        super.setNomTable("form_participant_demande");
    }
    
    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    @Override
    public void construirePK(Connection c) throws Exception {
       
        this.preparePk("FRP", "GETSEQFORMPARTICIPANTDEMANDE");
        this.setId(makePK(c));
    }
    public void setId(String id) {
        this.id = id;
    }

    public void setId_formation(String id_formation) {
        this.id_formation = id_formation;
    }

    public void setLog_personnel(String log_personnel) {
        this.log_personnel = log_personnel;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public void setNote(double note)throws Exception {
         if(getMode().compareTo("modif")!=0)
        {
            this.note = note;
            return;
        }
        if(note<-1) throw new Exception("Note invalide car <-1");
        this.note = note;
    }

    public void setCout(double cout)throws Exception {
        if(getMode().compareTo("modif")!=0)
        {
            this.cout = cout;
            return;
        }
        if(cout<0) throw new Exception("Cout invalide car <0");
        this.cout = cout;
    }

    public String getId() {
        return id;
    }

    public String getId_formation() {
        return id_formation;
    }

    public String getLog_personnel() {
        return log_personnel;
    }

    public String getRemarque() {
        return remarque;
    }

    public double getNote() {
        return note;
    }

    public double getCout() {
        return cout;
    }

    public int getAbsence() {
        return absence;
    }

    public void setAbsence(int absence) {
        this.absence = absence;
    }
    
    public String getEtatNote(){
        if(this.getNote()==-1) return "En cours";
        else return String.valueOf(this.getNote());
    }
}
