package factureclient;

import bean.ClassEtat;
import java.sql.Date;

public class PayementFacture extends ClassEtat {
    
    @Override
    public String getTuppleID() {
        return id; //To change body of generated methods, choose Tools | Templates.
    }

    public PayementFacture() {
        this.setNomTable("PAIEMENTFACTURECLIENT");
    }

    @Override
    public String getAttributIDName() {
       return "id"; //To change body of generated methods, choose Tools | Templates.
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

    public double getMontantpayer() {
        return montantpayer;
    }

    public void setMontantpayer(double montantpayer) {
        this.montantpayer = montantpayer;
    }

    public double getResteapayer() {
         if(this.getMode().compareToIgnoreCase("modif") != 0){
            if(this.resteapayer < 0) return 0;
        }
        return resteapayer;
    }

    public double getMontanttotal() {
        return montanttotal;
    }

    public void setMontanttotal(double montanttotal) {
        this.montanttotal = montanttotal;
    }

    public double getAvoir() {
        return avoir;
    }

    public void setAvoir(double avoir) {
        this.avoir = avoir;
    }

    public String getIdjournal() {
        return idjournal;
    }

    public void setIdjournal(String idjournal) {
        this.idjournal = idjournal;
    }

    public Date getDate_echeance() {
        return date_echeance;
    }

    public void setDate_echeance(Date date_echeance) {
        this.date_echeance = date_echeance;
    }

    public String getPatient() {
        return patient;
    }

    public void setPatient(String patient) {
        this.patient = patient;
    }

    public String getIdtiers() {
        return idtiers;
    }

    public void setIdtiers(String idtiers) {
        this.idtiers = idtiers;
    }
    
    public void setResteapayer(double resteapayer) {
        this.resteapayer = resteapayer;
    }

    public String getMatricule() {
        return matricule;
    }

    public void setMatricule(String matricule) {
        this.matricule = matricule;
    }
    
    private String id,tiers,patient,designation,typee,devise,compte,remarque,idjournal,idtiers, matricule;
    private Date daty,date_echeance;
    private double montant,tva,montanttva,coursdevise,montantpayer,resteapayer, montanttotal,avoir;
}