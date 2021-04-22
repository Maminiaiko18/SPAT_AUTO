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
public class RecapMaterielNaval extends ClassMAPTable{

    private String id,typemateriel,denomination, occup_operation,occup_client, position, occup_heure_depart, occup_heure_arrivee,prev_heure_depart, prev_heure_arrivee,prev_operation,prev_client;

    public String getTypemateriel() {
        return typemateriel;
    }

    public void setTypemateriel(String typemateriel) {
        this.typemateriel = typemateriel;
    }
    private Date occup_date_depart,occup_date_arrivee,prev_date_depart,prev_date_arrivee;

    public RecapMaterielNaval(String denomination) {
        super.setNomTable("recap_materiel_naval");
        this.denomination = denomination;
    }

    public RecapMaterielNaval(String denomination, String occup_operation, String occup_client, String position, String occup_heure_depart, String occup_heure_arrivee, String prev_heure_depart, String prev_heure_arrivee, String prev_operation, String prev_client, Date occup_date_depart, Date occup_date_arrivee, Date prev_date_depart, Date prev_date_arrivee) {
        super.setNomTable("recap_materiel_naval");
        this.setDenomination(denomination);
        this.setOccup_operation(occup_operation);
        this.setOccup_client(occup_client);
        this.setPosition(position);
        this.setOccup_heure_depart(occup_heure_depart);
        this.setOccup_heure_arrivee(occup_heure_arrivee);
        this.setPrev_heure_depart(prev_heure_depart);
        this.setPrev_heure_arrivee(prev_heure_arrivee);
        this.setPrev_operation(prev_operation);
        this.setPrev_client(prev_client);
        this.setOccup_date_depart(occup_date_depart);
        this.setOccup_date_arrivee(occup_date_arrivee);
        this.setPrev_date_depart(prev_date_depart);
        this.setPrev_date_arrivee(prev_date_arrivee);
    }

    public RecapMaterielNaval(String id, String typemateriel, String denomination, String position,String occup_operation, String occup_client, String occup_heure_depart, String occup_heure_arrivee, Date occup_date_depart, Date occup_date_arrivee,int test) {
        super.setNomTable("recap_materiel_naval");
        this.setId(id);
        this.setTypemateriel(typemateriel);
        this.setDenomination(denomination);
        this.setPosition(position);
        if(test==0){
            this.setOccup_operation(occup_operation);
            this.setOccup_client(occup_client);
            this.setOccup_heure_depart(occup_heure_depart);
            this.setOccup_heure_arrivee(occup_heure_arrivee);
            this.setOccup_date_depart(occup_date_depart);
            this.setOccup_date_arrivee(occup_date_arrivee);
        }else{
            this.setPrev_operation(occup_operation);
            this.setPrev_client(occup_client);
            this.setPrev_heure_depart(occup_heure_depart);
            this.setPrev_heure_arrivee(occup_heure_arrivee);
            this.setPrev_date_depart(occup_date_depart);
            this.setPrev_date_arrivee(occup_date_arrivee);
        }
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    
    public Date getOccup_date_depart() {
        return occup_date_depart;
    }

    public void setOccup_date_depart(Date occup_date_depart) {
        this.occup_date_depart = occup_date_depart;
    }

    public Date getOccup_date_arrivee() {
        return occup_date_arrivee;
    }

    public void setOccup_date_arrivee(Date occup_date_arrivee) {
        this.occup_date_arrivee = occup_date_arrivee;
    }

    public Date getPrev_date_depart() {
        return prev_date_depart;
    }

    public void setPrev_date_depart(Date prev_date_depart) {
        this.prev_date_depart = prev_date_depart;
    }

    public Date getPrev_date_arrivee() {
        return prev_date_arrivee;
    }

    public void setPrev_date_arrivee(Date prev_date_arrivee) {
        this.prev_date_arrivee = prev_date_arrivee;
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
    
    public RecapMaterielNaval() {
        super.setNomTable("recap_materiel_naval");
    }

    public String getDenomination() {
        return denomination;
    }

    public void setDenomination(String denomination) {
        this.denomination = denomination;
    }

    public String getOccup_operation() {
        return occup_operation;
    }

    public void setOccup_operation(String occup_operation) {
        this.occup_operation = occup_operation;
    }

    public String getOccup_client() {
        return occup_client;
    }

    public void setOccup_client(String occup_client) {
        this.occup_client = occup_client;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getPrev_operation() {
        return prev_operation;
    }

    public void setPrev_operation(String prev_operation) {
        this.prev_operation = prev_operation;
    }

    public String getPrev_client() {
        return prev_client;
    }

    public void setPrev_client(String prev_client) {
        this.prev_client = prev_client;
    }
    
    
    
    @Override
    public String getTuppleID() {
        return this.denomination;
    }

    @Override
    public String getAttributIDName() {
        return "denomination";
    }
    
}
