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
 * @author Tin
 */
public class MouvementLibelleComplet extends ClassEtat{
    
    private String id, escale, navire, consignataire, heure, provenance, destination, remarque, typemvt, valconsignataire, desceconsignataire, referencenavire, 
           nomnavire, pavillonnavire, remarquenavire, quaiprovenance, interneprovenance, paysprovenance, quaidestination, internedestination, paysdestination, idtypemvt, idquaiprovenance, idquaidestination,
            cargaison,cargval,cargdesce,heure_depart;

    private Date daty, datearrivee ,date_depart;

    private double duree, jntnavire, jbtnavire, pltnavire, lhtnavire, lmnavire, tenavire, volumenavire, longueurdestination, profondeurdestination, tirantdestination, longueurprovenance, profondeurprovenance, tirantprovenance;
    //private int etat;
    
    
    
    public MouvementLibelleComplet(){
    super.setNomTable("mouvementlibellecomplet");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getEscale() {
        return escale;
    }

    public void setEscale(String escale) {
        this.escale = escale;
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

    public String getHeure() {
        return heure;
    }

    public void setHeure(String heure) {
        this.heure = heure;
    }

    public String getProvenance() {
        return provenance;
    }

    public void setProvenance(String provenance) {
        this.provenance = provenance;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public String getTypemvt() {
        return typemvt;
    }

    public void setTypemvt(String typemvt) {
        this.typemvt = typemvt;
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

    public String getIdtypemvt() {
        return idtypemvt;
    }

    public void setIdtypemvt(String idtypemvt) {
        this.idtypemvt = idtypemvt;
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

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public Date getDatearrivee() {
        return datearrivee;
    }

    public void setDatearrivee(Date datearrivee) {
        this.datearrivee = datearrivee;
    }

    public double getDuree() {
        return duree;
    }

    public void setDuree(double duree) {
        this.duree = duree;
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

    /*public int getEtat() {
        return etat;
    }

    public void setEtat(int etat) {
        this.etat = etat;
    }*/

    public String getTuppleID() {
        return id;
    }

    public String getAttributIDName() {
        return "id";
    }

    public String getCargaison() {
        return cargaison;
    }

    public void setCargaison(String cargaison) {
        this.cargaison = cargaison;
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

    public String getHeure_depart() {
        return heure_depart;
    }

    public void setHeure_depart(String heure_depart) {
        this.heure_depart = heure_depart;
    }

    public Date getDate_depart() {
        return date_depart;
    }

    public void setDate_depart(Date date_depart) {
        this.date_depart = date_depart;
    }

    
    
    
 }
