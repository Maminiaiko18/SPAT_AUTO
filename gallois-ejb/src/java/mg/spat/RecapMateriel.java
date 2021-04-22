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
public class RecapMateriel extends ClassMAPTable{
    private String idmateriel_naval_occup,denomination_occup,position_occup,position_prev,nature_prev,nature_occup;
    private Date daty_occup,daty_fin_occup;
    private String heuredebut_occup,heurefin_occup,observation_occup;
    private Date daty_prev,daty_fin_prev;
    private String heuredebut_prev,heurefin_prev,observation_prev;

    public String getPosition_prev() {
        return position_prev;
    }

    public void setPosition_prev(String position_prev) {
        this.position_prev = position_prev;
    }

    public String getNature_prev() {
        return nature_prev;
    }

    public void setNature_prev(String nature_prev) {
        this.nature_prev = nature_prev;
    }

    public String getNature_occup() {
        return nature_occup;
    }

    public void setNature_occup(String nature_occup) {
        this.nature_occup = nature_occup;
    }

    public String getIdmateriel_naval_occup() {
        return idmateriel_naval_occup;
    }

    public void setIdmateriel_naval_occup(String idmateriel_naval_occup) {
        this.idmateriel_naval_occup = idmateriel_naval_occup;
    }

    public String getDenomination_occup() {
        return denomination_occup;
    }

    public void setDenomination_occup(String denomination_occup) {
        this.denomination_occup = denomination_occup;
    }

    public String getPosition_occup() {
        return position_occup;
    }

    public void setPosition_occup(String position_occup) {
        this.position_occup = position_occup;
    }

    public Date getDaty_occup() {
        return daty_occup;
    }

    public void setDaty_occup(Date daty_occup) {
        this.daty_occup = daty_occup;
    }

    public Date getDaty_fin_occup() {
        return daty_fin_occup;
    }

    public void setDaty_fin_occup(Date daty_fin_occup) {
        this.daty_fin_occup = daty_fin_occup;
    }

    public String getHeuredebut_occup() {
        return heuredebut_occup;
    }

    public void setHeuredebut_occup(String heuredebut_occup) {
        this.heuredebut_occup = heuredebut_occup;
    }

    public String getHeurefin_occup() {
        return heurefin_occup;
    }

    public void setHeurefin_occup(String heurefin_occup) {
        this.heurefin_occup = heurefin_occup;
    }

    public String getObservation_occup() {
        return observation_occup;
    }

    public void setObservation_occup(String observation_occup) {
        this.observation_occup = observation_occup;
    }

    public Date getDaty_prev() {
        return daty_prev;
    }

    public void setDaty_prev(Date daty_prev) {
        this.daty_prev = daty_prev;
    }

    public Date getDaty_fin_prev() {
        return daty_fin_prev;
    }

    public void setDaty_fin_prev(Date daty_fin_prev) {
        this.daty_fin_prev = daty_fin_prev;
    }

    public String getHeuredebut_prev() {
        return heuredebut_prev;
    }

    public void setHeuredebut_prev(String heuredebut_prev) {
        this.heuredebut_prev = heuredebut_prev;
    }

    public String getHeurefin_prev() {
        return heurefin_prev;
    }

    public void setHeurefin_prev(String heurefin_prev) {
        this.heurefin_prev = heurefin_prev;
    }

    public String getObservation_prev() {
        return observation_prev;
    }

    public void setObservation_prev(String observation_prev) {
        this.observation_prev = observation_prev;
    }

   

    public RecapMateriel() {
        this.setNomTable("recap_materiel_naval");
    }
            
    @Override
    public String getTuppleID() {
        return this.getIdmateriel_naval_occup();
    }

    @Override
    public String getAttributIDName() {
        return "idmateriel_naval_occup";
    }
    
}
