/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.CGenUtil;
import bean.ClassEtat;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author Maharo R.
 */
public class MouvementLibComplet extends Mouvement{
    private String valmvt,descemvt,valcargaison,descecargaison,
            quaiprovenance,interneprovenance,paysprovenance,valquaisprovenance,descequaisprovenance,typequaisprovenance,valpaysprovenance,descepaysprovenance,
            quaisdestination,internedestination,paysdestination,valquaisdestination,descequaisdestination,typequaisdestianantion,valpaysdestination,descepaysdestination,
            referencenavire,nomnavire,pavillonnavire,remarquenavire,valconsignataire,desceconsignataire,valtypequaisprovenance,descetypequaisprovenance,valtypequaisdestination,descetypequaisdestination,noVoyage;
    private Date date_depart_prev;

    public Date getDate_depart_prev() {
        return date_depart_prev;
    }

    public void setDate_depart_prev(Date date_depart_prev) {
        this.date_depart_prev = date_depart_prev;
    }

    @Override
    public String getValColLibelle(){
        return getNomnavire()+";"+Utilitaire.formatterDaty(getDatearrivee());
    }

   
    @Override
    public MouvementLibComplet[] getMouvementMemeEscale(Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
//            return (MouvementLibComplet[]) CGenUtil.rechercher(new MouvementLibComplet(), null, null, c, " and escale ='" + this.getEscale() + "' and id != '"+this.getId()+"' order by datearrivee asc");
            return (MouvementLibComplet[]) CGenUtil.rechercher(new MouvementLibComplet(), null, null, c, " and escale ='" + this.getEscale() + "' and id != '"+this.getId()+"' order by id asc");
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }        
    private double tirantprovenance,longueurprovenance,profondeurprovenance,tirantdestination,longueurdestination,profondeurdestination,jntnavire,jbtnavire,
                pltnavire,lhtnavire,lmnavire,tenavire,volumenavire;
    private int etatnavire;
    private String etatlib, idprevision;

    public MouvementLibComplet() {
        super.setNomTable("mouvementLibComplet");
    }

    

    public String getValmvt() {
        return valmvt;
    }

    public void setValmvt(String valmvt) {
        this.valmvt = valmvt;
    }

    public String getDescemvt() {
        return descemvt;
    }

    public void setDescemvt(String descemvt) {
        this.descemvt = descemvt;
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

    public String getTypequaisprovenance() {
        return typequaisprovenance;
    }

    public void setTypequaisprovenance(String typequaisprovenance) {
        this.typequaisprovenance = typequaisprovenance;
    }

    public String getValpaysprovenance() {
        return valpaysprovenance;
    }

    public void setValpaysprovenance(String valpaysprovenance) {
        this.valpaysprovenance = valpaysprovenance;
    }

    public String getDescepaysprovenance() {
        return descepaysprovenance;
    }

    public void setDescepaysprovenance(String descepaysprovenance) {
        this.descepaysprovenance = descepaysprovenance;
    }

    public String getQuaisdestination() {
        return quaisdestination;
    }

    public void setQuaisdestination(String quaisdestination) {
        this.quaisdestination = quaisdestination;
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

    public String getTypequaisdestianantion() {
        return typequaisdestianantion;
    }

    public void setTypequaisdestianantion(String typequaisdestianantion) {
        this.typequaisdestianantion = typequaisdestianantion;
    }

    public String getValpaysdestination() {
        return valpaysdestination;
    }

    public void setValpaysdestination(String valpaysdestination) {
        this.valpaysdestination = valpaysdestination;
    }

    public String getDescepaysdestination() {
        return descepaysdestination;
    }

    public void setDescepaysdestination(String descepaysdestination) {
        this.descepaysdestination = descepaysdestination;
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

    

    public double getTirantprovenance() {
        return tirantprovenance;
    }

    public void setTirantprovenance(double tirantprovenance) {
        this.tirantprovenance = tirantprovenance;
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

    public double getTirantdestination() {
        return tirantdestination;
    }

    public void setTirantdestination(double tirantdestination) {
        this.tirantdestination = tirantdestination;
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
    
    public String getNoVoyage() {
        return noVoyage;
    }

    public void setNoVoyage(String noVoyage) {
        this.noVoyage = noVoyage;
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

    public String getEtatlib() {
        return etatlib;
    }

    public void setEtatlib(String etatlib) {
        this.etatlib = etatlib;
    }

    public String getIdprevision() {
        return idprevision;
    }

    public void setIdprevision(String idprevision) {
        this.idprevision = idprevision;
    }

       
    


}
