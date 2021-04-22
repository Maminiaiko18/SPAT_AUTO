/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.compta;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author Asus
 */
public class DetailConcessionnairePaye extends ClassMAPTable{
    
    private String identree,designation,client,idtypeentree,nmfact,iddevise,idmodepaiement,
            idcaisse,idetat,remarque;         
    private Date daty;
    private double montant;

    public DetailConcessionnairePaye() {
        super.setNomTable("entreemat");
    }

    public String getIdentree() {
        return identree;
    }

    public void setIdentree(String identree) {
        this.identree = identree;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getClient() {
        return client;
    }

    public void setClient(String client) {
        this.client = client;
    }

    public String getIdtypeentree() {
        return idtypeentree;
    }

    public void setIdtypeentree(String idtypeentree) {
        this.idtypeentree = idtypeentree;
    }

    public String getNmfact() {
        return nmfact;
    }

    public void setNmfact(String nmfact) {
        this.nmfact = nmfact;
    }
    
    public String getIddevise() {
        return iddevise;
    }

    public void setIddevise(String iddevise) {
        this.iddevise = iddevise;
    }

    public String getIdmodepaiement() {
        return idmodepaiement;
    }

    public void setIdmodepaiement(String idmodepaiement) {
        this.idmodepaiement = idmodepaiement;
    }

    public String getIdcaisse() {
        return idcaisse;
    }

    public void setIdcaisse(String idcaisse) {
        this.idcaisse = idcaisse;
    }

    public String getIdetat() {
        return idetat;
    }

    public void setIdetat(String idetat) {
        this.idetat = idetat;
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
    

    @Override
    public String getTuppleID() {
      return this.identree;
    }

    @Override
    public String getAttributIDName() {
      return "identree"; 
    }
    
    public void construirePK(Connection c) throws Exception {
        
    }
    
}
