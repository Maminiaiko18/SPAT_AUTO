/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author Nouta
 */
public class Liberer extends ClassMAPTable {
    private String id,idengagement,etat,idengagementlib;
    private double montant;

    public Liberer() {
        super.setNomTable("liberer");
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdengagement() {
        return idengagement;
    }

    public void setIdengagement(String idengagement) {
        this.idengagement = idengagement;
    }

    public String getEtat() {
        return etat;
    }

    public void setEtat(String etat) {
        this.etat = etat;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
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
        preparePk("CR","GETSEQ_LIBERER");
        setId(makePK(c));
    }
    
    
    
    
}
