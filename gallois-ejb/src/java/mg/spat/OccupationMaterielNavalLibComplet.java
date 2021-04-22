/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import java.sql.Date;

/**
 *
 * @author Sanda
 */
public class OccupationMaterielNavalLibComplet extends OccupationMaterielNaval{
    private String denomination,
            idmarque,
            detenteur,
            maintenance,
            idtype_materiel,
            immatriculation,
            valmarque,
            descemarque,
            valtypemateriel,
            descetypemateriel,
            valpilote,
            valcommandant,
            descecommandant,
            valnatureoperation,
            descenatureoperation,
            valmanoeuvrebord,
            descemanoeuvrebord,
            reference,
            nomnavire,
            pavillonnavire,
            remarque,
            valpavillon,
            descepavillon
            ;
    private double jnt,jbt,plt,lht,lm,te,volume;
    private double puissance,etatmaterielnaval;
    private Date datefin,date_aquisition;
    
    public OccupationMaterielNavalLibComplet(){
        super.setNomTable("OCCUPMATERIELNAVALLIBCOMPLET");
    }

    public String getDenomination() {
        return denomination;
    }

    public void setDenomination(String denomination) {
        this.denomination = denomination;
    }

    public String getIdmarque() {
        return idmarque;
    }

    public void setIdmarque(String idmarque) {
        this.idmarque = idmarque;
    }

    public String getDetenteur() {
        return detenteur;
    }

    public void setDetenteur(String detenteur) {
        this.detenteur = detenteur;
    }

    public String getMaintenance() {
        return maintenance;
    }

    public void setMaintenance(String maintenance) {
        this.maintenance = maintenance;
    }

    public String getIdtype_materiel() {
        return idtype_materiel;
    }

    public void setIdtype_materiel(String idtype_materiel) {
        this.idtype_materiel = idtype_materiel;
    }

    public String getImmatriculation() {
        return immatriculation;
    }

    public void setImmatriculation(String immatriculation) {
        this.immatriculation = immatriculation;
    }

    public String getValmarque() {
        return valmarque;
    }

    public void setValmarque(String valmarque) {
        this.valmarque = valmarque;
    }

    public String getDescemarque() {
        return descemarque;
    }

    public void setDescemarque(String descemarque) {
        this.descemarque = descemarque;
    }

    public String getValtypemateriel() {
        return valtypemateriel;
    }

    public void setValtypemateriel(String valtypemateriel) {
        this.valtypemateriel = valtypemateriel;
    }

    public String getDescetypemateriel() {
        return descetypemateriel;
    }

    public void setDescetypemateriel(String descetypemateriel) {
        this.descetypemateriel = descetypemateriel;
    }

    public String getValpilote() {
        return valpilote;
    }

    public void setValpilote(String valpilote) {
        this.valpilote = valpilote;
    }

    public String getValcommandant() {
        return valcommandant;
    }

    public void setValcommandant(String valcommandant) {
        this.valcommandant = valcommandant;
    }

    public String getDescecommandant() {
        return descecommandant;
    }

    public void setDescecommandant(String descecommandant) {
        this.descecommandant = descecommandant;
    }

    public String getValnatureoperation() {
        return valnatureoperation;
    }

    public void setValnatureoperation(String valnatureoperation) {
        this.valnatureoperation = valnatureoperation;
    }

    public String getDescenatureoperation() {
        return descenatureoperation;
    }

    public void setDescenatureoperation(String descenatureoperation) {
        this.descenatureoperation = descenatureoperation;
    }

    public String getValmanoeuvrebord() {
        return valmanoeuvrebord;
    }

    public void setValmanoeuvrebord(String valmanoeuvrebord) {
        this.valmanoeuvrebord = valmanoeuvrebord;
    }

    public String getDescemanoeuvrebord() {
        return descemanoeuvrebord;
    }

    public void setDescemanoeuvrebord(String descemanoeuvrebord) {
        this.descemanoeuvrebord = descemanoeuvrebord;
    }

    public String getReference() {
        return reference;
    }

    public void setReference(String reference) {
        this.reference = reference;
    }

    public String getNomnavire() {
        return nomnavire;
    }

    public void setNomnavire(String nomnavire) {
        this.nomnavire = nomnavire;
    }

    public String getPavillonnavire() {
        return pavillonnavire;
    }

    public void setPavillonnavire(String pavillonnavire) {
        this.pavillonnavire = pavillonnavire;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public String getValpavillon() {
        return valpavillon;
    }

    public void setValpavillon(String valpavillon) {
        this.valpavillon = valpavillon;
    }

    public String getDescepavillon() {
        return descepavillon;
    }

    public void setDescepavillon(String descepavillon) {
        this.descepavillon = descepavillon;
    }

    public double getJnt() {
        return jnt;
    }

    public void setJnt(double jnt) {
        this.jnt = jnt;
    }

    public double getJbt() {
        return jbt;
    }

    public void setJbt(double jbt) {
        this.jbt = jbt;
    }

    public double getPlt() {
        return plt;
    }

    public void setPlt(double plt) {
        this.plt = plt;
    }

    public double getLht() {
        return lht;
    }

    public void setLht(double lht) {
        this.lht = lht;
    }

    public double getLm() {
        return lm;
    }

    public void setLm(double lm) {
        this.lm = lm;
    }

    public double getTe() {
        return te;
    }

    public void setTe(double te) {
        this.te = te;
    }

    public double getVolume() {
        return volume;
    }

    public void setVolume(double volume) {
        this.volume = volume;
    }

    public double getPuissance() {
        return puissance;
    }

    public void setPuissance(double puissance) {
        this.puissance = puissance;
    }

    public double getEtatmaterielnaval() {
        return etatmaterielnaval;
    }

    public void setEtatmaterielnaval(double etatmaterielnaval) {
        this.etatmaterielnaval = etatmaterielnaval;
    }

    public Date getDatefin() {
        return datefin;
    }

    public void setDatefin(Date datefin) {
        this.datefin = datefin;
    }

    public Date getDate_aquisition() {
        return date_aquisition;
    }

    public void setDate_aquisition(Date date_aquisition) {
        this.date_aquisition = date_aquisition;
    }
    

}
