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
    
    private String id, idtravaux, travaux, nom, idtiers, nomtiers, nomtravaux, tiers, tierslib, dirTravaux, projet, codeetablissement, projetlib, codeetablissementlib, etatlib;
    private Date datydebut, datyfin;
    private double montant, avancement;

    public Chantier() {
        this.setNomTable("chantier");
    }

    public String getTiers() {
        return tiers;
    }

    public void setTiers(String tiers) {
        this.tiers = tiers;
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
            if(idtiers == null || idtiers.isEmpty())
                throw new Exception("Tiers obligatoire.");
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

    public String getProjet() {
        return projet;
    }

    public void setProjet(String projet) {
        this.projet = projet;
    }

    public String getCodeetablissement() {
        return codeetablissement;
    }

    public void setCodeetablissement(String codeetablissement) {
        this.codeetablissement = codeetablissement;
    }

    public String getTravaux() {
        return travaux;
    }

    public void setTravaux(String travaux) {
        this.travaux = travaux;
    }

    public String getTierslib() {
        return tierslib;
    }

    public void setTierslib(String tierslib) {
        this.tierslib = tierslib;
    }

    public String getDirTravaux() {
        return dirTravaux;
    }

    public void setDirTravaux(String dirTravaux) {
        this.dirTravaux = dirTravaux;
    }

    public String getProjetlib() {
        return projetlib;
    }

    public void setProjetlib(String projetlib) {
        this.projetlib = projetlib;
    }

    public String getCodeetablissementlib() {
        return codeetablissementlib;
    }

    public void setCodeetablissementlib(String codeetablissementlib) {
        this.codeetablissementlib = codeetablissementlib;
    }

    public String getEtatlib() {
        return etatlib;
    }

    public void setEtatlib(String etatlib) {
        this.etatlib = etatlib;
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
    
    @Override
    public void controler(Connection c) throws Exception {
        try{
            Travaux t = new Travaux();
            Travaux travaux = (Travaux)t.getById(this.getIdtravaux(), null, c);
            if((travaux.getDatedebut().after(this.getDatydebut())) || (this.getDatydebut().after(travaux.getDatefin())) || (travaux.getDatefin().before(this.getDatyfin())) || (this.getDatyfin().before(travaux.getDatedebut())))
                throw new Exception("Les dates du chantier doivent etre comprises entre les dates du travaux");
        }
        catch(Exception e){
            throw e;
        }
    }
}
