/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassEtat;
import bean.ClassMAPTable;
import java.sql.Date;

/**
 *
 * @author pro
 */
public class ChantierLibComplet extends ClassEtat{
    
    private String id;
    private String idtravaux;
    private String nom;
    private Date datydebut;
    private Date datyfin;
    private double montant;
    private double avancement;
    private String idtiers, tierslib;
    private String nomtiers;
    private String desctiers;
    private String nif;
    private String stat;
    private String contact;
    private String responsable;
    private String adresse;
    private String type;
    private int etattiers;
    private String nomtravaux;
    private Date datedebuttravaux;
    private Date datefintravaux;
    private double montanttravaux;
    private double avancementtravaux;
    private String desctravaux;
    private int etattravaux;
    private String idtypetravaux;
    private String valtypetravaux;
    private double montantFacture;
    private double montantReste;

    public ChantierLibComplet() {
        this.setNomTable("chantierlibcomplet");
    }

    public String getTierslib() {
        return tierslib;
    }

    public void setTierslib(String tierslib) {
        this.tierslib = tierslib;
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

    public Date getDatydebut() {
        return datydebut;
    }

    public void setDatydebut(Date datydebut) {
        this.datydebut = datydebut;
    }

    public Date getDatyfin() {
        return datyfin;
    }

    public void setDatyfin(Date datyfin) {
        this.datyfin = datyfin;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public double getAvancement() {
        return avancement;
    }

    public void setAvancement(double avancement) {
        this.avancement = avancement;
    }

    public String getIdtiers() {
        return idtiers;
    }

    public void setIdtiers(String idtiers) {
        this.idtiers = idtiers;
    }

    public String getNomtiers() {
        return nomtiers;
    }

    public void setNomtiers(String nomtiers) {
        this.nomtiers = nomtiers;
    }

    public String getDesctiers() {
        return desctiers;
    }

    public void setDesctiers(String desctiers) {
        this.desctiers = desctiers;
    }

    public String getNif() {
        return nif;
    }

    public void setNif(String nif) {
        this.nif = nif;
    }

    public String getStat() {
        return stat;
    }

    public void setStat(String stat) {
        this.stat = stat;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getResponsable() {
        return responsable;
    }

    public void setResponsable(String responsable) {
        this.responsable = responsable;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getEtattiers() {
        return etattiers;
    }

    public void setEtattiers(int etattiers) {
        this.etattiers = etattiers;
    }

    public String getNomtravaux() {
        return nomtravaux;
    }

    public void setNomtravaux(String nomtravaux) {
        this.nomtravaux = nomtravaux;
    }

    public Date getDatedebuttravaux() {
        return datedebuttravaux;
    }

    public void setDatedebuttravaux(Date datedebuttravaux) {
        this.datedebuttravaux = datedebuttravaux;
    }

    public Date getDatefintravaux() {
        return datefintravaux;
    }

    public void setDatefintravaux(Date datefintravaux) {
        this.datefintravaux = datefintravaux;
    }

    public double getMontanttravaux() {
        return montanttravaux;
    }

    public void setMontanttravaux(double montanttravaux) {
        this.montanttravaux = montanttravaux;
    }

    public double getAvancementtravaux() {
        return avancementtravaux;
    }

    public void setAvancementtravaux(double avancementtravaux) {
        this.avancementtravaux = avancementtravaux;
    }

    public String getDesctravaux() {
        return desctravaux;
    }

    public void setDesctravaux(String desctravaux) {
        this.desctravaux = desctravaux;
    }

    public int getEtattravaux() {
        return etattravaux;
    }

    public void setEtattravaux(int etattravaux) {
        this.etattravaux = etattravaux;
    }

    public String getIdtypetravaux() {
        return idtypetravaux;
    }

    public void setIdtypetravaux(String idtypetravaux) {
        this.idtypetravaux = idtypetravaux;
    }

    public String getValtypetravaux() {
        return valtypetravaux;
    }

    public void setValtypetravaux(String valtypetravaux) {
        this.valtypetravaux = valtypetravaux;
    }
    
    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public double getMontantFacture() {
        return montantFacture;
    }

    public void setMontantFacture(double montantFacture) {
        this.montantFacture = montantFacture;
    }

    public double getMontantReste() {
        return montantReste;
    }

    public void setMontantReste(double montantReste) {
        this.montantReste = montantReste;
    }

}
