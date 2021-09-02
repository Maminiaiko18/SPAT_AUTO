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
public class PrevisionLibelleComplet extends ClassEtat{
    
    private String id,provenance,navire,consignataire,cargaison,pilote,heure_arrivee,heure_depart,destination,valconsignataire,desceconsignataire,referencenavire,nomnavire,pavillonnavire,remarquenavire,quaiprovenance,interneprovenance;
    private String paysprovenance,quaidestination,internedestination,paysdestination,idquaiprovenance,idquaidestination,cargval,cargdesce,idtypequaiprovenance,typequaiprovenance,idtypequaidestination,typequaidestination;
    private Date date_rade,date_arrivee,date_depart;
    private double jntnavire,jbtnavire,pltnavire,lhtnavire,lmnavire,tenavire,volumenavire,longueurprovenance,profondeurprovenance,tirantprovenance,longueurdestination,profondeurdestination,tirantdestination;
    private String pavillonlib , escale , armateurlib, valquaisprovenance, valquaisdestination,valpaysprovenance,valpaysdestination; 

    public String getValpaysprovenance() {
        return valpaysprovenance;
    }

    public void setValpaysprovenance(String valpaysprovenance) {
        this.valpaysprovenance = valpaysprovenance;
    }

    public String getValpaysdestination() {
        return valpaysdestination;
    }

    public void setValpaysdestination(String valpaysdestination) {
        this.valpaysdestination = valpaysdestination;
    }
    
    
    public PrevisionLibelleComplet() {
        super.setNomTable("mouvementLibComplet");
    }

    public String getValquaisprovenance() {
        return valquaisprovenance;
    }

    public void setValquaisprovenance(String valquaisprovenance) {
        this.valquaisprovenance = valquaisprovenance;
    }

    public String getValquaisdestination() {
        return valquaisdestination;
    }

    public void setValquaisdestination(String valquaisdestination) {
        this.valquaisdestination = valquaisdestination;
    }

    
    
    public String getArmateurlib() {
        return armateurlib;
    }

    public void setArmateurlib(String armateurlib) {
        this.armateurlib = armateurlib;
    }

    
    
    public String getEscale() {
        return escale;
    }

    public void setEscale(String escale) {
        this.escale = escale;
    }

    
    
    public String getPavillonlib() {
        return pavillonlib;
    }

    public void setPavillonlib(String pavillonlib) {
        this.pavillonlib = pavillonlib;
    }
    
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getProvenance() {
        return provenance;
    }

    public void setProvenance(String provenance) {
        this.provenance = provenance;
    }

    public String getNavire() {
        return navire;
    }

    public void setNavire(String navire) {
        this.navire = navire;
    }

    public String getConsignataire() {
        return consignataire;
    }

    public void setConsignataire(String consignataire) {
        this.consignataire = consignataire;
    }

    public String getCargaison() {
        return cargaison;
    }

    public void setCargaison(String cargaison) {
        this.cargaison = cargaison;
    }

    public String getPilote() {
        return pilote;
    }

    public void setPilote(String pilote) {
        this.pilote = pilote;
    }

    public String getHeure_arrivee() {
        return heure_arrivee;
    }

    public void setHeure_arrivee(String heure_arrivee) {
        this.heure_arrivee = heure_arrivee;
    }

    public String getHeure_depart() {
        return heure_depart;
    }

    public void setHeure_depart(String heure_depart) {
        this.heure_depart = heure_depart;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public String getValconsignataire() {
        return valconsignataire;
    }

    public void setValconsignataire(String valconsignataire) {
        this.valconsignataire = valconsignataire;
    }

    public String getDesceconsignataire() {
        return desceconsignataire;
    }

    public void setDesceconsignataire(String desceconsignataire) {
        this.desceconsignataire = desceconsignataire;
    }

    public String getReferencenavire() {
        return referencenavire;
    }

    public void setReferencenavire(String referencenavire) {
        this.referencenavire = referencenavire;
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

    public String getRemarquenavire() {
        return remarquenavire;
    }

    public void setRemarquenavire(String remarquenavire) {
        this.remarquenavire = remarquenavire;
    }

    public String getQuaiprovenance() {
        return quaiprovenance;
    }

    public void setQuaiprovenance(String quaiprovenance) {
        this.quaiprovenance = quaiprovenance;
    }

    public String getInterneprovenance() {
        return interneprovenance;
    }

    public void setInterneprovenance(String interneprovenance) {
        this.interneprovenance = interneprovenance;
    }

    public String getPaysprovenance() {
        return paysprovenance;
    }

    public void setPaysprovenance(String paysprovenance) {
        this.paysprovenance = paysprovenance;
    }

    public String getQuaidestination() {
        return quaidestination;
    }

    public void setQuaidestination(String quaidestination) {
        this.quaidestination = quaidestination;
    }

    public String getInternedestination() {
        return internedestination;
    }

    public void setInternedestination(String internedestination) {
        this.internedestination = internedestination;
    }

    public String getPaysdestination() {
        return paysdestination;
    }

    public void setPaysdestination(String paysdestination) {
        this.paysdestination = paysdestination;
    }

    public String getIdquaiprovenance() {
        return idquaiprovenance;
    }

    public void setIdquaiprovenance(String idquaiprovenance) {
        this.idquaiprovenance = idquaiprovenance;
    }

    public String getIdquaidestination() {
        return idquaidestination;
    }

    public void setIdquaidestination(String idquaidestination) {
        this.idquaidestination = idquaidestination;
    }

    public String getCargval() {
        return cargval;
    }

    public void setCargval(String cargval) {
        this.cargval = cargval;
    }

    public String getCargdesce() {
        return cargdesce;
    }

    public void setCargdesce(String cargdesce) {
        this.cargdesce = cargdesce;
    }

    public String getIdtypequaiprovenance() {
        return idtypequaiprovenance;
    }

    public void setIdtypequaiprovenance(String idtypequaiprovenance) {
        this.idtypequaiprovenance = idtypequaiprovenance;
    }

    public String getTypequaiprovenance() {
        return typequaiprovenance;
    }

    public void setTypequaiprovenance(String typequaiprovenance) {
        this.typequaiprovenance = typequaiprovenance;
    }

    public String getIdtypequaidestination() {
        return idtypequaidestination;
    }

    public void setIdtypequaidestination(String idtypequaidestination) {
        this.idtypequaidestination = idtypequaidestination;
    }

    public String getTypequaidestination() {
        return typequaidestination;
    }

    public void setTypequaidestination(String typequaidestination) {
        this.typequaidestination = typequaidestination;
    }

    public Date getDate_rade() {
        return date_rade;
    }

    public void setDate_rade(Date date_rade) {
        this.date_rade = date_rade;
    }

    public Date getDate_arrivee() {
        return date_arrivee;
    }

    public void setDate_arrivee(Date date_arrivee) {
        this.date_arrivee = date_arrivee;
    }

    public Date getDate_depart() {
        return date_depart;
    }

    public void setDate_depart(Date date_depart) {
        this.date_depart = date_depart;
    }

    public double getJntnavire() {
        return jntnavire;
    }

    public void setJntnavire(double jntnavire) {
        this.jntnavire = jntnavire;
    }

    public double getJbtnavire() {
        return jbtnavire;
    }

    public void setJbtnavire(double jbtnavire) {
        this.jbtnavire = jbtnavire;
    }

    public double getPltnavire() {
        return pltnavire;
    }

    public void setPltnavire(double pltnavire) {
        this.pltnavire = pltnavire;
    }

    public double getLhtnavire() {
        return lhtnavire;
    }

    public void setLhtnavire(double lhtnavire) {
        this.lhtnavire = lhtnavire;
    }

    public double getLmnavire() {
        return lmnavire;
    }

    public void setLmnavire(double lmnavire) {
        this.lmnavire = lmnavire;
    }

    public double getTenavire() {
        return tenavire;
    }

    public void setTenavire(double tenavire) {
        this.tenavire = tenavire;
    }

    public double getVolumenavire() {
        return volumenavire;
    }

    public void setVolumenavire(double volumenavire) {
        this.volumenavire = volumenavire;
    }

    public double getLongueurprovenance() {
        return longueurprovenance;
    }

    public void setLongueurprovenance(double longueurprovenance) {
        this.longueurprovenance = longueurprovenance;
    }

    public double getProfondeurprovenance() {
        return profondeurprovenance;
    }

    public void setProfondeurprovenance(double profondeurprovenance) {
        this.profondeurprovenance = profondeurprovenance;
    }

    public double getTirantprovenance() {
        return tirantprovenance;
    }

    public void setTirantprovenance(double tirantprovenance) {
        this.tirantprovenance = tirantprovenance;
    }

    public double getLongueurdestination() {
        return longueurdestination;
    }

    public void setLongueurdestination(double longueurdestination) {
        this.longueurdestination = longueurdestination;
    }

    public double getProfondeurdestination() {
        return profondeurdestination;
    }

    public void setProfondeurdestination(double profondeurdestination) {
        this.profondeurdestination = profondeurdestination;
    }

    public double getTirantdestination() {
        return tirantdestination;
    }

    public void setTirantdestination(double tirantdestination) {
        this.tirantdestination = tirantdestination;
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
