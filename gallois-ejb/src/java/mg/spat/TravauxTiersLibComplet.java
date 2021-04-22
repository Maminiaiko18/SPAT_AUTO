/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassEtat;
import java.sql.Date;

/**
 *
 * @author Asus
 */
public class TravauxTiersLibComplet extends ClassEtat{
    
    private String id,nom,description,idtypetravaux,valtypetravaux,descetypetravaux,idtravauxtiers,descriptiontravauxtiers,nomtiers,descriptiontiers,nif,stat,contact,responsable,adressetiers,typetiers;
    private Date datedebut,datefin;
    private double avancement,montanttravauxtiers,montant;
    private int etattiers;

    public TravauxTiersLibComplet() {
         this.setNomTable("TRAVAUX_TIERSLIBCOMPLET");
    }

    public TravauxTiersLibComplet(String id, String nom, String description, String idtypetravaux, String valtypetravaux, String descetypetravaux, String idtravauxtiers, String descriptiontravauxtiers, String nomtiers, String descriptiontiers, String nif, String stat, String contact, String responsable, String adressetiers, String typetiers, Date datedebut, Date datefin, double avancement, double montanttravauxtiers, int etattiers) {
        this.setNomTable("TRAVAUX_TIERSLIBCOMPLET");
        this.setId(id);
        this.setNom(nom);
        this.setDescription(description);
        this.setIdtypetravaux(idtypetravaux);
        this.setValtypetravaux(valtypetravaux);
        this.setDescetypetravaux(descetypetravaux);
        this.setIdtravauxtiers(idtravauxtiers);
        this.setDescriptiontravauxtiers(descriptiontravauxtiers);
        this.setNomtiers(nomtiers);
        this.setDescriptiontiers(descriptiontiers);
        this.setNif(nif);
        this.setStat(stat);
        this.setContact(contact);
        this.setResponsable(responsable);
        this.setAdressetiers(adressetiers);
        this.setTypetiers(typetiers);
        this.setDatedebut(datedebut);
        this.setDatefin(datefin);
        this.setAvancement(avancement);
        this.setMontanttravauxtiers(montanttravauxtiers);
        this.setEtattiers(etattiers);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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

    public String getDescetypetravaux() {
        return descetypetravaux;
    }

    public void setDescetypetravaux(String descetypetravaux) {
        this.descetypetravaux = descetypetravaux;
    }

    public String getIdtravauxtiers() {
        return idtravauxtiers;
    }

    public void setIdtravauxtiers(String idtravauxtiers) {
        this.idtravauxtiers = idtravauxtiers;
    }

    public String getDescriptiontravauxtiers() {
        return descriptiontravauxtiers;
    }

    public void setDescriptiontravauxtiers(String descriptiontravauxtiers) {
        this.descriptiontravauxtiers = descriptiontravauxtiers;
    }

    public String getNomtiers() {
        return nomtiers;
    }

    public void setNomtiers(String nomtiers) {
        this.nomtiers = nomtiers;
    }

    public String getDescriptiontiers() {
        return descriptiontiers;
    }

    public void setDescriptiontiers(String descriptiontiers) {
        this.descriptiontiers = descriptiontiers;
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

    public String getAdressetiers() {
        return adressetiers;
    }

    public void setAdressetiers(String adressetiers) {
        this.adressetiers = adressetiers;
    }

    public String getTypetiers() {
        return typetiers;
    }

    public void setTypetiers(String typetiers) {
        this.typetiers = typetiers;
    }

    public Date getDatedebut() {
        return datedebut;
    }

    public void setDatedebut(Date datedebut) {
        this.datedebut = datedebut;
    }

    public Date getDatefin() {
        return datefin;
    }

    public void setDatefin(Date datefin) {
        this.datefin = datefin;
    }

    public double getAvancement() {
        return avancement;
    }

    public void setAvancement(double avancement) {
        this.avancement = avancement;
    }

    public double getMontanttravauxtiers() {
        return montanttravauxtiers;
    }

    public void setMontanttravauxtiers(double montanttravauxtiers) {
        this.montanttravauxtiers = montanttravauxtiers;
    }

    public int getEtattiers() {
        return etattiers;
    }

    public void setEtattiers(int etattiers) {
        this.etattiers = etattiers;
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
    
}
