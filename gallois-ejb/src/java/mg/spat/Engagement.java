/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassEtat;
import java.sql.Connection;

/**
 *
 * @author Nouta
 */
public class Engagement extends ClassEtat {
    private String id,designation,codeEtablissement,projet,compte,idLC,idLClib;
    private String codeEtablissementlib,projetlib;
    private double montant,disponible,dispoAvant,dispoApres;

    public Engagement() {
        super.setNomTable("engagement");
    }

    public String getIdLC() {
        return idLC;
    }

    public void setIdLC(String idLC) {
        this.idLC = idLC;
    }

    public String getIdLClib() {
        return idLClib;
    }

    public void setIdLClib(String idLClib) {
        this.idLClib = idLClib;
    }
    
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getCodeEtablissement() {
        return codeEtablissement;
    }

    public void setCodeEtablissement(String codeEtablissement) {
        this.codeEtablissement = codeEtablissement;
    }

    public String getProjet() {
        return projet;
    }

    public void setProjet(String projet) {
        this.projet = projet;
    }

    public String getCompte() {
        return compte;
    }

    public void setCompte(String compte) {
        this.compte = compte;
    }

    

    public String getCodeEtablissementlib() {
        return codeEtablissementlib;
    }

    public void setCodeEtablissementlib(String codeEtablissementlib) {
        this.codeEtablissementlib = codeEtablissementlib;
    }

    public String getProjetlib() {
        return projetlib;
    }

    public void setProjetlib(String projetlib) {
        this.projetlib = projetlib;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public double getDisponible() {
        return disponible;
    }

    public void setDisponible(double disponible) {
        this.disponible = disponible;
    }

    public double getDispoAvant() {
        return dispoAvant;
    }

    public void setDispoAvant(double dispoAvant) {
        this.dispoAvant = dispoAvant;
    }

    public double getDispoApres() {
        return dispoApres;
    }

    public void setDispoApres(double dispoApres) {
        this.dispoApres = dispoApres;
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
        preparePk("CR","getseqengagement");
        setId(makePK(c));
    }

    @Override
    public String getValColLibelle() {
        return this.getDesignation();
    }

    
    
    

    
    
}
