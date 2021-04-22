/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassMAPTable;
import java.sql.Date;

/**
 *
 * @author MEVA
 */
public class RecapMouvementQuais extends ClassMAPTable{

    private String idquaidestination,quaidestination, escale, occup_navire, occup_consignataire, occup_cargaison,prev_navire;
    private Date occup_date_arrivee, occup_date_depart, prev_date_arrivee,prev_date_depart;
    private String prev_consignataire, prev_cargaison,occup_heure_depart,occup_heure_arrivee,prev_heure_depart,prev_heure_arrivee,occup_typequaidestination,occup_typequaiprovenance,prev_typequaidestination,prev_typequaiprovenance,occup_provenance, occup_destination, prev_provenance, prev_destination;

    public RecapMouvementQuais(String idquaidestination, String occup_navire, String occup_consignataire, String occup_cargaison, Date occup_date_arrivee, Date occup_date_depart, String occup_heure_depart, String occup_heure_arrivee, String occup_provenance, String occup_destination) {
        super.setNomTable("recap_mouvement_quais");
        this.setIdquaidestination(idquaidestination);
        this.setOccup_navire(occup_navire);
        this.setOccup_consignataire(occup_consignataire);
        this.setOccup_cargaison(occup_cargaison);
        this.setOccup_date_arrivee(occup_date_arrivee);
        this.setOccup_date_depart(occup_date_depart);
        this.setOccup_heure_depart(occup_heure_depart);
        this.setOccup_heure_arrivee(occup_heure_arrivee);
        this.setOccup_provenance(occup_provenance);
        this.setOccup_destination(occup_destination);
    }
    
    public RecapMouvementQuais(String idquaidestination,String quaidestination,String escale, String occup_navire, String occup_consignataire, String occup_cargaison, Date occup_date_arrivee, Date occup_date_depart, String occup_heure_depart, String occup_heure_arrivee, String occup_provenance, String occup_destination, int test) {
        super.setNomTable("recap_mouvement_quais");
        this.setIdquaidestination(idquaidestination);
        this.setQuaidestination(quaidestination);
        this.setEscale(escale);
        if(test==0){
            this.setOccup_navire(occup_navire);
            this.setOccup_consignataire(occup_consignataire);
            this.setOccup_cargaison(occup_cargaison);
            this.setOccup_date_arrivee(occup_date_arrivee);
            this.setOccup_date_depart(occup_date_depart);
            this.setOccup_heure_depart(occup_heure_depart);
            this.setOccup_heure_arrivee(occup_heure_arrivee);
            this.setOccup_provenance(occup_provenance);
            this.setOccup_destination(occup_destination);
        }else{
            this.setPrev_navire(occup_navire);
            this.setPrev_consignataire(occup_consignataire);
            this.setPrev_cargaison(occup_cargaison);
            this.setPrev_date_arrivee(occup_date_arrivee);
            this.setPrev_date_depart(occup_date_depart);
            this.setPrev_heure_depart(occup_heure_depart);
            this.setPrev_heure_arrivee(occup_heure_arrivee);
            this.setPrev_provenance(occup_provenance);
            this.setPrev_destination(occup_destination);
        }
    }

    public RecapMouvementQuais(String idquaidestination,String quaidestination) {
        super.setNomTable("recap_mouvement_quais");
        this.setIdquaidestination(idquaidestination);
        this.setQuaidestination(quaidestination);
    }

    public String getOccup_provenance() {
        return occup_provenance;
    }

    public void setOccup_provenance(String occup_provenance) {
        this.occup_provenance = occup_provenance;
    }

    public String getOccup_destination() {
        return occup_destination;
    }

    public void setOccup_destination(String occup_destination) {
        this.occup_destination = occup_destination;
    }

    public String getPrev_provenance() {
        return prev_provenance;
    }

    public void setPrev_provenance(String prev_provenance) {
        this.prev_provenance = prev_provenance;
    }

    public String getPrev_destination() {
        return prev_destination;
    }

    public void setPrev_destination(String prev_destination) {
        this.prev_destination = prev_destination;
    }

    public String getIdquaidestination() {
        return idquaidestination;
    }

    public void setIdquaidestination(String id) {
        this.idquaidestination = id;
    }

    public String getOccup_typequaidestination() {
        return occup_typequaidestination;
    }

    public void setOccup_typequaidestination(String occup_typequaidestination) {
        this.occup_typequaidestination = occup_typequaidestination;
    }

    public String getOccup_typequaiprovenance() {
        return occup_typequaiprovenance;
    }

    public void setOccup_typequaiprovenance(String occup_typequaiprovenance) {
        this.occup_typequaiprovenance = occup_typequaiprovenance;
    }

    public String getPrev_typequaidestination() {
        return prev_typequaidestination;
    }

    public void setPrev_typequaidestination(String prev_typequaidestination) {
        this.prev_typequaidestination = prev_typequaidestination;
    }

    public String getPrev_typequaiprovenance() {
        return prev_typequaiprovenance;
    }

    public void setPrev_typequaiprovenance(String prev_typequaiprovenance) {
        this.prev_typequaiprovenance = prev_typequaiprovenance;
    }

    public String getPrev_consignataire() {
        return prev_consignataire;
    }

    public void setPrev_consignataire(String prev_consignataire) {
        this.prev_consignataire = prev_consignataire;
    }

    public String getPrev_cargaison() {
        return prev_cargaison;
    }

    public String getOccup_heure_depart() {
        return occup_heure_depart;
    }

    public void setOccup_heure_depart(String occup_heure_depart) {
        this.occup_heure_depart = occup_heure_depart;
    }

    public String getOccup_heure_arrivee() {
        return occup_heure_arrivee;
    }

    public void setOccup_heure_arrivee(String occup_heure_arrivee) {
        this.occup_heure_arrivee = occup_heure_arrivee;
    }

    public String getPrev_heure_depart() {
        return prev_heure_depart;
    }

    public void setPrev_heure_depart(String prev_heure_depart) {
        this.prev_heure_depart = prev_heure_depart;
    }

    public String getPrev_heure_arrivee() {
        return prev_heure_arrivee;
    }

    public void setPrev_heure_arrivee(String prev_heure_arrivee) {
        this.prev_heure_arrivee = prev_heure_arrivee;
    }

    public void setPrev_cargaison(String prev_cargaison) {
        this.prev_cargaison = prev_cargaison;
    }

    public RecapMouvementQuais() {
        super.setNomTable("recap_mouvement_quais");
    }

    public String getPrev_navire() {
        return prev_navire;
    }

    public void setPrev_navire(String prev_navire) {
        this.prev_navire = prev_navire;
    }

    public String getQuaidestination() {
        return quaidestination;
    }

    public void setQuaidestination(String quaidestination) {
        this.quaidestination = quaidestination;
    }

    public String getEscale() {
        return escale;
    }

    public void setEscale(String escale) {
        this.escale = escale;
    }

    public String getOccup_navire() {
        return occup_navire;
    }

    public void setOccup_navire(String occup_navire) {
        this.occup_navire = occup_navire;
    }

    public String getOccup_consignataire() {
        return occup_consignataire;
    }

    public void setOccup_consignataire(String occup_consignataire) {
        this.occup_consignataire = occup_consignataire;
    }

    public String getOccup_cargaison() {
        return occup_cargaison;
    }

    public void setOccup_cargaison(String occup_cargaison) {
        this.occup_cargaison = occup_cargaison;
    }

    public Date getOccup_date_arrivee() {
        return occup_date_arrivee;
    }

    public void setOccup_date_arrivee(Date occup_date_arrivee) {
        this.occup_date_arrivee = occup_date_arrivee;
    }

    public Date getOccup_date_depart() {
        return occup_date_depart;
    }

    public void setOccup_date_depart(Date occup_date_depart) {
        this.occup_date_depart = occup_date_depart;
    }

    public Date getPrev_date_arrivee() {
        return prev_date_arrivee;
    }

    public void setPrev_date_arrivee(Date prev_date_arrivee) {
        this.prev_date_arrivee = prev_date_arrivee;
    }

    public Date getPrev_date_depart() {
        return prev_date_depart;
    }

    public void setPrev_date_depart(Date prev_date_depart) {
        this.prev_date_depart = prev_date_depart;
    }

   
    
    
    
    @Override
    public String getTuppleID() {
        return this.quaidestination;
    }

    @Override
    public String getAttributIDName() {
        return "quaidestination";
    }
    
}
