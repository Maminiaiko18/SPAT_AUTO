/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package facture;

import java.sql.Date;

/**
 *
 * @author ThinkPad
 */
public class RelicatFF extends FactureFournisseur {
    String idpr, id, tierslib, contact, numeroop, numeroopr;
    double montantpr, montant, diff;
    Date datypr;

    public String getIdpr() {
        return idpr;
    }

    public void setIdpr(String idpr) {
        this.idpr = idpr;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTierslib() {
        return tierslib;
    }

    public void setTierslib(String tierslib) {
        this.tierslib = tierslib;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getNumeroop() {
        return numeroop;
    }

    public void setNumeroop(String numeroop) {
        this.numeroop = numeroop;
    }

    public String getNumeroopr() {
        return numeroopr;
    }

    public void setNumeroopr(String numeroopr) {
        this.numeroopr = numeroopr;
    }

    public double getMontantpr() {
        return montantpr;
    }

    public void setMontantpr(double montantpr) {
        this.montantpr = montantpr;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public double getDiff() {
        return diff;
    }

    public void setDiff(double diff) {
        this.diff = diff;
    }

    public Date getDatypr() {
        return datypr;
    }

    public void setDatypr(Date datypr) {
        this.datypr = datypr;
    }

    public RelicatFF() throws Exception {
        this.setNomTable("RELICAT_FF");
    }
}
