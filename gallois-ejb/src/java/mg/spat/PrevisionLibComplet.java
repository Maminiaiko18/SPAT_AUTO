/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassEtat;
import java.sql.Date;
import utilitaire.Utilitaire;

/**
 *
 * 
 */
public class PrevisionLibComplet extends Prevision {
    
    private String quaiprovenance,internepovenance,paysprovenance,
            referencenavire,nomnavire,pavillonnavire,remarquenavire,valconsignataire,desceconsignataire,valcargaison,descecargaison,valpilote,descepilote,quaidestination,
            internedestination,paysdestination,valpaysprovenance,descepaysprovenance,valpaysdestination,descepaysdestination,valtypequaisprovenance,descetypequaisprovenance,
            valtypequaisdestination,descetypequaisdestination,valquaisprovenance,descequaisprovenance,valquaisdestination,descequaisdestination,typequaisprovenance,typequaisdestination,type;
    
    @Override
    public String getValColLibelle(){
        String datArr = Utilitaire.formatterDaty(this.getDate_arrivee());
        String datDep = Utilitaire.formatterDaty(this.getDate_depart());
        return this.getEscale()+";"+datArr+";"+this.getHeure_arrivee()+";"+datDep+";"+this.getHeure_depart()+";"+this.getConsignataire()+";"+this.getValconsignataire();
    }
    
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
    
    private double longueurprovenance,tirantprovenance,profondeurprovenance,jntnavire,jbtnavire,pltnavire,lhtnavire,lmnavire,tenavire,volumenavire,longueurdestination,
            tirantdestination,profondeurdestination;
    private int etatnavire;

    public PrevisionLibComplet() {
          super.setNomTable("previsionLibComplet");
    }

    public String getDescepaysprovenance() {
        return descepaysprovenance;
    }

    public void setDescepaysprovenance(String descepaysprovenance) {
        this.descepaysprovenance = descepaysprovenance;
    }

    public String getDescepaysdestination() {
        return descepaysdestination;
    }

    public void setDescepaysdestination(String descepaysdestination) {
        this.descepaysdestination = descepaysdestination;
    }

    public String getValquaisprovenance() {
        return valquaisprovenance;
    }

    public void setValquaisprovenance(String valquaisprovenance) {
        this.valquaisprovenance = valquaisprovenance;
    }

    public String getDescequaisprovenance() {
        return descequaisprovenance;
    }

    public void setDescequaisprovenance(String descequaisprovenance) {
        this.descequaisprovenance = descequaisprovenance;
    }

    public String getValquaisdestination() {
        return valquaisdestination;
    }

    public void setValquaisdestination(String valquaisdestination) {
        this.valquaisdestination = valquaisdestination;
    }

    public String getDescequaisdestination() {
        return descequaisdestination;
    }

    public void setDescequaisdestination(String descequaisdestination) {
        this.descequaisdestination = descequaisdestination;
    }

    public String getTypequaisprovenance() {
        return typequaisprovenance;
    }

    public void setTypequaisprovenance(String typequaisprovenance) {
        this.typequaisprovenance = typequaisprovenance;
    }

    public String getTypequaisdestination() {
        return typequaisdestination;
    }

    public void setTypequaisdestination(String typequaisdestination) {
        this.typequaisdestination = typequaisdestination;
    }
    

    public String getQuaiprovenance() {
        return quaiprovenance;
    }

    public void setQuaiprovenance(String quaiprovenance) {
        this.quaiprovenance = quaiprovenance;
    }

    public String getInternepovenance() {
        return internepovenance;
    }

    public void setInternepovenance(String internepovenance) {
        this.internepovenance = internepovenance;
    }

    public String getPaysprovenance() {
        return paysprovenance;
    }

    public void setPaysprovenance(String paysprovenance) {
        this.paysprovenance = paysprovenance;
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

    public String getValcargaison() {
        return valcargaison;
    }

    public void setValcargaison(String valcargaison) {
        this.valcargaison = valcargaison;
    }

    public String getDescecargaison() {
        return descecargaison;
    }

    public void setDescecargaison(String descecargaison) {
        this.descecargaison = descecargaison;
    }

    public String getValpilote() {
        return valpilote;
    }

    public void setValpilote(String valpilote) {
        this.valpilote = valpilote;
    }

    public String getDescepilote() {
        return descepilote;
    }

    public void setDescepilote(String descepilote) {
        this.descepilote = descepilote;
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


    public double getLongueurprovenance() {
        return longueurprovenance;
    }

    public void setLongueurprovenance(double longueurprovenance) {
        this.longueurprovenance = longueurprovenance;
    }

    public double getTirantprovenance() {
        return tirantprovenance;
    }

    public void setTirantprovenance(double tirantprovenance) {
        this.tirantprovenance = tirantprovenance;
    }

    public double getProfondeurprovenance() {
        return profondeurprovenance;
    }

    public void setProfondeurprovenance(double profondeurprovenance) {
        this.profondeurprovenance = profondeurprovenance;
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

    public double getTirantdestination() {
        return tirantdestination;
    }

    public void setTirantdestination(double tirantdestination) {
        this.tirantdestination = tirantdestination;
    }

    public double getProfondeurdestination() {
        return profondeurdestination;
    }

    public void setProfondeurdestination(double profondeurdestination) {
        this.profondeurdestination = profondeurdestination;
    }

    public int getEtatnavire() {
        return etatnavire;
    }

    public void setEtatnavire(int etatnavire) {
        this.etatnavire = etatnavire;
    }

    public String getValtypequaisprovenance() {
        return valtypequaisprovenance;
    }

    public void setValtypequaisprovenance(String valtypequaisprovenance) {
        this.valtypequaisprovenance = valtypequaisprovenance;
    }

    public String getDescetypequaisprovenance() {
        return descetypequaisprovenance;
    }

    public void setDescetypequaisprovenance(String descetypequaisprovenance) {
        this.descetypequaisprovenance = descetypequaisprovenance;
    }

    public String getValtypequaisdestination() {
        return valtypequaisdestination;
    }

    public void setValtypequaisdestination(String valtypequaisdestination) {
        this.valtypequaisdestination = valtypequaisdestination;
    }

    public String getDescetypequaisdestination() {
        return descetypequaisdestination;
    }

    public void setDescetypequaisdestination(String descetypequaisdestination) {
        this.descetypequaisdestination = descetypequaisdestination;
    }

 
    
}
