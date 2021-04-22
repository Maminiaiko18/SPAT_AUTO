/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassEtat;
import java.sql.Connection;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.concurrent.TimeUnit;
import service.PrevisionService;
import utilitaire.Utilitaire;

/**
 *
 * @author Asus
 */
public class PrevisionMaterielNaval extends ClassEtat {

    private String id, idmateriel_naval, idcommandant, idnatureoperation, idnavire, idclient, observation, idarrivee, idarriveelib;
    private Date daty;
    private double duree;
    private Date date_arrivee;
    private String heure_arrivee;
    private Date date_depart;
    private String heure_depart;

    public PrevisionMaterielNaval() {
        super.setNomTable("previsionmaterielnaval");
    }

    @Override
    public String getValColLibelle() {
        return idmateriel_naval;
    }

    public String getIdarriveelib() {
        return idarriveelib;
    }

    public void setIdarriveelib(String idarriveelib) {
        this.idarriveelib = idarriveelib;
    }

    public String getId() {
        return id;
    }

    public Date getDate_arrivee() {
        return date_arrivee;
    }

    public void setDate_arrivee(Date date_arrivee) {
        this.date_arrivee = date_arrivee;
    }

    public String getHeure_arrivee() {
        return heure_arrivee;
    }

    public void setHeure_arrivee(String heure_arrivee) {
        this.heure_arrivee = heure_arrivee;
    }

    public Date getDate_depart() {
        return date_depart;
    }

    public void setDate_depart(Date date_depart) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (date_depart != null) {
                if (Utilitaire.compareDaty(date_depart, this.getDate_arrivee()) == -1) {
                    throw new Exception("Date depart invalide par rapport à la date d arrivee");
                }
            }
        }
        this.date_depart = date_depart;
    }

    public String getHeure_depart() {
        return heure_depart;
    }

    public void setHeure_depart(String heure_depart) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (heure_depart != null && heure_depart.compareTo("") != 0) {
                Utilitaire.testHeureValide(heure_depart);
                if (Utilitaire.comparerHeure(this.getHeure_arrivee(), heure_depart) == -1) {
                    throw new Exception("Heure de depart invalide par rapport à l heure d arrivee");
                }
            }
        }
        this.heure_depart = heure_depart;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdmateriel_naval() {
        return idmateriel_naval;
    }

    public void setIdmateriel_naval(String idmateriel_naval) {
        this.idmateriel_naval = idmateriel_naval;
    }

    public String getIdcommandant() {
        return idcommandant;
    }

    public void setIdcommandant(String idcommandant) {
        this.idcommandant = idcommandant;
    }

    public String getIdnatureoperation() {
        return idnatureoperation;
    }

    public void setIdnatureoperation(String idnatureoperation) {
        this.idnatureoperation = idnatureoperation;
    }

    public String getIdnavire() {
        return idnavire;
    }

    public void setIdnavire(String idnavire) {
        this.idnavire = idnavire;
    }

    public String getIdclient() {
        return idclient;
    }

    public void setIdclient(String idclient) throws Exception {
        //  if(idclient==null || idclient.compareTo("")==0) throw new Exception("Client obligatoire");
        this.idclient = idclient;
    }

    public String getObservation() {
        return observation;
    }

    public void setObservation(String observation) {
        this.observation = observation;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            this.daty = Utilitaire.dateDuJourSql();
        } else {
            this.daty = daty;
        }
    }

    public double getDuree() {
        return duree;

    }

    public void setDuree(double durre) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (durre < 0) {
                throw new Exception("duree invalide");
            }
        }
        this.duree = durre;

    }

    private void setDureeFromDate() throws Exception {
        if (this.getDate_depart() != null && this.getDate_arrivee() != null) {
            Timestamp hdebut = Utilitaire.convertStringToTimestampHour(this.getHeure_depart(), ":");
            hdebut.setTime(this.getDate_depart().getTime() + hdebut.getTime());
            Timestamp hfin = Utilitaire.convertStringToTimestampHour(this.getHeure_arrivee(), ":");
            hfin.setTime(this.getDate_arrivee().getTime() + hfin.getTime());

            long diffEnMillies = hfin.getTime() - hdebut.getTime();
            duree = TimeUnit.MINUTES.convert(diffEnMillies, TimeUnit.MILLISECONDS);
        }
    }

    @Override
    public void controlerUpdate(Connection c) throws Exception {
        setDureeFromDate();
    }

    public void controler(Connection c) throws Exception {
        try {
            if (this.getDate_depart() != null && this.getHeure_depart() != null && this.getHeure_depart().compareTo("") != 0) {
//                int diffJour=Utilitaire.diffJourDaty(this.getDate_depart(), this.getDate_arrivee());
//                if(diffJour!=0) diffJour--;
//                int diffHeure=Utilitaire.diffDeuxheures(this.getHeure_arrivee(), this.getHeure_depart());
//                duree=(diffJour*24*60);
//                if(diffHeure!=0){
//                    diffHeure=diffHeure/60;
//                }
//                duree+=diffHeure;
                setDureeFromDate();
            }
            //PrevisionService.testerPrevisionMaterielNaval(this,c);
        } catch (Exception e) {
            throw e;
        }
    }

    @Override
    public String getTuppleID() {
        return this.id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public void construirePK(Connection c) throws Exception {
        this.preparePk("PMN", "getseqprevisionMaterielNaval");
        this.setId(makePK(c));

    }

    public String getIdarrivee() {
        return idarrivee;
    }

    public void setIdarrivee(String idarrivee) {
        this.idarrivee = idarrivee;
    }

}
