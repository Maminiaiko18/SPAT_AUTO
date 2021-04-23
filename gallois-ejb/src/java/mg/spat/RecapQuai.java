/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassEtat;
import bean.ClassMAPTable;
import java.sql.Date;

/**
 *
 * @author MEVA
 */

public class RecapQuai extends ClassEtat {
    
    private String idquai, nomquai, numeroescale_prev, nomnavire_prev, valconsignataire_prev, cargval_prev, numeroescale_occup, nomnavire_occup, valconsignataire_occup, cargval_occup;
    private Date date_arrivee_prev, date_depart_prev, date_arrivee_occup, date_depart_occup;
    private String idTypeQuais,typequaidestination;
    private String valmvt;

    public String getValmvt() {
        return valmvt;
    }

    public void setValmvt(String valmvt) {
        this.valmvt = valmvt;
    }

    public String getIdTypeQuais() {
        return idTypeQuais;
    }

    public void setIdTypeQuais(String idTypeQuais) {
        this.idTypeQuais = idTypeQuais;
    }

    public String getTypequaidestination() {
        return typequaidestination;
    }

    public void setTypequaidestination(String typequaidestination) {
        this.typequaidestination = typequaidestination;
    }
    
    public String getIdquai() {
        return idquai;
    }

    public void setIdquai(String idquai) {
        this.idquai = idquai;
    }

    public String getNomquai() {
        return nomquai;
    }

    public void setNomquai(String nomquai) {
        this.nomquai = nomquai;
    }

    public String getNumeroescale_prev() {
        return numeroescale_prev;
    }

    public void setNumeroescale_prev(String numeroescale_prev) {
        this.numeroescale_prev = numeroescale_prev;
    }

    public String getNomnavire_prev() {
        return nomnavire_prev;
    }

    public void setNomnavire_prev(String nomnavire_prev) {
        this.nomnavire_prev = nomnavire_prev;
    }

    public String getValconsignataire_prev() {
        return valconsignataire_prev;
    }

    public void setValconsignataire_prev(String valconsignataire_prev) {
        this.valconsignataire_prev = valconsignataire_prev;
    }

    public String getCargval_prev() {
        return cargval_prev;
    }

    public void setCargval_prev(String cargval_prev) {
        this.cargval_prev = cargval_prev;
    }

    public String getNumeroescale_occup() {
        return numeroescale_occup;
    }

    public void setNumeroescale_occup(String numeroescale_occup) {
        this.numeroescale_occup = numeroescale_occup;
    }

    public String getNomnavire_occup() {
        return nomnavire_occup;
    }

    public void setNomnavire_occup(String nomnavire_occup) {
        this.nomnavire_occup = nomnavire_occup;
    }

    public String getValconsignataire_occup() {
        return valconsignataire_occup;
    }

    public void setValconsignataire_occup(String valconsignataire_occup) {
        this.valconsignataire_occup = valconsignataire_occup;
    }

    public String getCargval_occup() {
        return cargval_occup;
    }

    public void setCargval_occup(String cargval_occup) {
        this.cargval_occup = cargval_occup;
    }

    public Date getDate_arrivee_prev() {
        return date_arrivee_prev;
    }

    public void setDate_arrivee_prev(Date date_arrivee_prev) {
        this.date_arrivee_prev = date_arrivee_prev;
    }

    public Date getDate_depart_prev() {
        return date_depart_prev;
    }

    public void setDate_depart_prev(Date date_depart_prev) {
        this.date_depart_prev = date_depart_prev;
    }

    public Date getDate_arrivee_occup() {
        return date_arrivee_occup;
    }

    public void setDate_arrivee_occup(Date date_arrivee_occup) {
        this.date_arrivee_occup = date_arrivee_occup;
    }

    public Date getDate_depart_occup() {
        return date_depart_occup;
    }

    public void setDate_depart_occup(Date date_depart_occup) {
        this.date_depart_occup = date_depart_occup;
    }
    
    
    public RecapQuai() {
        this.setNomTable("recap_quais");
    }
    
    @Override
    public String getTuppleID() {
        return this.idquai;
    }

    @Override
    public String getAttributIDName() {
        return "idquai";
    }
    
}
