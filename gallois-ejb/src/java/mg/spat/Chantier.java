/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassEtat;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.Utilitaire;

/**
 *
 * @author Asus
 */
public class Chantier extends ClassEtat{
    
    private String id,idtravaux,nom,idtiers,nomtiers,nomtravaux, tiers,tierslib;
    private Date datydebut,datyfin;
    private double montant,avancement;

    public Chantier() {
        this.setNomTable("chantier");
    }

    public String getTierslib() {
        return tierslib;
    }

    public void setTierslib(String tierlib) {
        this.tierslib = tierlib;
    }

    public String getTiers() {
        return tiers;
    }

    public void setTiers(String tiers) {
        this.tiers = tiers;
    }

    public Chantier(String id, String idtravaux, String nom, String idtiers, Date datydebut, Date datyfin, double montant, double avancement) throws Exception {
        this.setNomTable("chantier");
        this.setId(id);
        this.setIdtravaux(idtravaux);
        this.setNom(nom);
        this.setIdtiers(idtiers);
        this.setDatydebut(datydebut);
        this.setDatyfin(datyfin);
        this.setMontant(montant);
        this.setAvancement(avancement);
    }

    public String getNomtiers() {
        return nomtiers;
    }

    public void setNomtiers(String nomtiers) {
        this.nomtiers = nomtiers;
    }

    public String getNomtravaux() {
        return nomtravaux;
    }

    public void setNomtravaux(String nomtravaux) {
        this.nomtravaux = nomtravaux;
    }


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdtravaux() {
        return idtravaux;
    }

    public void setIdtravaux(String idtravaux) {
        this.idtravaux = idtravaux;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getIdtiers() {
        return idtiers;
    }

    public void setIdtiers(String idtiers) throws Exception {
         if(this.getMode().compareTo("modif")==0){
            if(idtiers==null || ""==idtiers)
                throw new Exception("Tier Obligatoire");
        }
        this.idtiers = idtiers;
    }

    public Date getDatydebut() {
        return datydebut;
    }

    public void setDatydebut(Date datydebut) {
        this.datydebut = datydebut;
    }

    public Date getDatyfin() {
        return datyfin;
    }

    public void setDatyfin(Date datyfin) throws Exception {
         if(this.getMode().compareTo("modif")==0){
            if(this.getDatydebut()!=null && Utilitaire.compareDaty(datyfin, this.getDatydebut())==-1)
                throw new Exception("La date de début doit être supérieure à la date de fin");
        }
        this.datyfin = datyfin;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (montant < 0) {
                throw new Exception("montant invalide");
            }
        }
        this.montant = montant;
    }

    public double getAvancement() {
        return avancement;
    }

    public void setAvancement(double avancement) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (avancement < 0) {
                throw new Exception("avancement invalide");
            }
        }
        this.avancement = avancement;
    }
    
    

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
     return "id";
    }
    public void construirePK(Connection c) throws Exception {
        this.preparePk("CHT", "getseq_chantier");
        this.setId(makePK(c));
    }
    public String getValColLibelle(){
        return nom;
    }
    
}
