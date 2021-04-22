/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.relationhumaine;

import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author Asus
 */
public class Avantage_nature extends ClassMAPTable {
    
    private String id,idPersonnel,logement,vehicule,autre_avantage,mode_paiement,numero_virement,numero_cnaps;

    public Avantage_nature() {
         super.setNomTable("Avantage_nature");
    }
    
    
    
    

    public Avantage_nature(String id, String idPersonnel, String logement, String vehicule, String autre_avantage, String mode_paiement, String numero_virement, String numero_cnaps) {
        super.setNomTable("Avantage_nature");
        this.setId(id);
        this.setIdPersonnel(idPersonnel);
        this.setLogement(logement);
        this.setVehicule(vehicule);
        this.setAutre_avantage(autre_avantage);
        this.setMode_paiement(mode_paiement);
        this.setNumero_virement(numero_virement);
        this.setNumero_cnaps(numero_cnaps);
    }
    public Avantage_nature(String idPersonnel, String logement, String vehicule, String autre_avantage, String mode_paiement, String numero_virement, String numero_cnaps) {
        super.setNomTable("Avantage_nature");
        this.setIdPersonnel(idPersonnel);
        this.setLogement(logement);
        this.setVehicule(vehicule);
        this.setAutre_avantage(autre_avantage);
        this.setMode_paiement(mode_paiement);
        this.setNumero_virement(numero_virement);
        this.setNumero_cnaps(numero_cnaps);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdPersonnel() {
        return idPersonnel;
    }

    public void setIdPersonnel(String idPersonnel) {
        this.idPersonnel = idPersonnel;
    }

    public String getLogement() {
        return logement;
    }

    public void setLogement(String logement) {
        this.logement = logement;
    }

    public String getVehicule() {
        return vehicule;
    }

    public void setVehicule(String vehicule) {
        this.vehicule = vehicule;
    }

    public String getAutre_avantage() {
        return autre_avantage;
    }

    public void setAutre_avantage(String autre_avantage) {
        this.autre_avantage = autre_avantage;
    }

    public String getMode_paiement() {
        return mode_paiement;
    }

    public void setMode_paiement(String mode_paiement) {
        this.mode_paiement = mode_paiement;
    }

    public String getNumero_virement() {
        return numero_virement;
    }

    public void setNumero_virement(String numero_virement) {
        this.numero_virement = numero_virement;
    }

    public String getNumero_cnaps() {
        return numero_cnaps;
    }

    public void setNumero_cnaps(String numero_cnaps) {
        this.numero_cnaps = numero_cnaps;
    }

    

    @Override
    public String getTuppleID() {
     return this.id;}

    @Override
    public String getAttributIDName() {
     return "id";}
     public void construirePK(Connection c) throws Exception {
         this.preparePk("AVN", "getseq_avantage_nature");
         this.setId(makePK(c));
        
    }
    
}
