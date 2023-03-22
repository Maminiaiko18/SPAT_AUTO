/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ded;

import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author Itokiana
 */
public class PaiementOP extends ClassMAPTable{
    
    private String id, idop, idmvt;
    private double montant;

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdop() {
        return idop;
    }

    public void setIdop(String idop) {
        this.idop = idop;
    }

    public String getIdmvt() {
        return idmvt;
    }

    public void setIdmvt(String idmvt) {
        this.idmvt = idmvt;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }
    
    public void construirePK(Connection c) throws Exception {
        this.preparePk("POP", "getseqpaiemntop");
        this.setId(makePK(c));
    }
    
    public PaiementOP() {
        this.setNomTable("PaiementOP");
    }
}
