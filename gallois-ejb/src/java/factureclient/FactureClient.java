/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package factureclient;

import bean.ClassEtat;
import ded.OrdonnerPayement;
import java.sql.Connection;
import java.sql.Date;
import mg.allosakafo.fin.MvtCaisse;
import mg.spat.JournalCaisse;

/**
 *
 * @author rasol
 */
public class FactureClient extends ClassEtat{
    private String id, tiers, designation, typee, devise, compte, remarque, entite, antenne, idjournal;
    private Date daty;
    private double montant, tva, montanttva, coursdevise;
    
    public static void updatePaiement(String u, PaiementFactureRemise fac, Connection c) throws Exception {
        OrdonnerPayement ordoPaye = OrdonnerPayement.getOp(fac.getId(), c);
        ordoPaye.setMontant(ordoPaye.getMontant() + fac.getResteavoir());
        ordoPaye.updateToTableWithHisto(u, c);
        
        JournalCaisse mvtCaisse = MvtCaisse.getMvtCaisse(ordoPaye.getId(), c);
        if(mvtCaisse==null){
            throw new Exception("L'ordre de payement n'est pas encore entrée en caisse");
        }
        else{
            mvtCaisse.setCredit(mvtCaisse.getDebit()+  fac.getResteavoir());
            mvtCaisse.updateToTableWithHisto(u, c);
        }
    }

    public FactureClient() {
        this.setNomTable("facture_client");
    }
    
    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
    public void construirePK(Connection c) throws Exception{
        this.preparePk("FC", "getseqfactureclient");
        this.setId(makePK(c));
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTiers() {
        return tiers;
    }

    public void setTiers(String tiers) {
        this.tiers = tiers;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getTypee() {
        return typee;
    }

    public void setTypee(String typee) {
        this.typee = typee;
    }

    public String getDevise() {
        return devise;
    }

    public void setDevise(String devise) {
        this.devise = devise;
    }

    public String getCompte() {
        return compte;
    }

    public void setCompte(String compte) {
        this.compte = compte;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public String getEntite() {
        return entite;
    }

    public void setEntite(String entite) {
        this.entite = entite;
    }

    public String getAntenne() {
        return antenne;
    }

    public void setAntenne(String antenne) {
        this.antenne = antenne;
    }

    public String getIdjournal() {
        return idjournal;
    }

    public void setIdjournal(String idjournal) {
        this.idjournal = idjournal;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public double getTva() {
        return tva;
    }

    public void setTva(double tva) {
        this.tva = tva;
    }

    public double getMontanttva() {
        return montanttva;
    }

    public void setMontanttva(double montanttva) {
        this.montanttva = montanttva;
    }

    public double getCoursdevise() {
        return coursdevise;
    }

    public void setCoursdevise(double coursdevise) {
        this.coursdevise = coursdevise;
    }
}
