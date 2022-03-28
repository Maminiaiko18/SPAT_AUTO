/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author Nouta
 */
public class ProformaMere extends FactureClient{
    private String id,tiers,designation,type,remarque,iduser,idprevision,idcategorie,idprovision,devisemere;
    private String estddpmictsl,codeprestation,code,estmictsl,idavoir,typeengagement,pourcompte,heuredepart,heurearrivee,bateau;
    private double tva,exercice,estauto,estancienne;

    public ProformaMere() {
        super.setNomTable(" proforma_mere");
    }
    

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTiers() {
        return tiers;
    }

    public void setTiers(String tiers) {
        this.tiers = tiers;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public String getIduser() {
        return iduser;
    }

    public void setIduser(String iduser) {
        this.iduser = iduser;
    }

   
    public String getIdprevision() {
        return idprevision;
    }

    public void setIdprevision(String idprevision) {
        this.idprevision = idprevision;
    }

    public String getIdcategorie() {
        return idcategorie;
    }

    public void setIdcategorie(String idcategorie) {
        this.idcategorie = idcategorie;
    }

    public String getIdprovision() {
        return idprovision;
    }

    public void setIdprovision(String idprovision) {
        this.idprovision = idprovision;
    }

    public String getDevisemere() {
        return devisemere;
    }

    public void setDevisemere(String devisemere) {
        this.devisemere = devisemere;
    }

    public String getEstddpmictsl() {
        return estddpmictsl;
    }

    public void setEstddpmictsl(String estddpmictsl) {
        this.estddpmictsl = estddpmictsl;
    }

    public String getCodeprestation() {
        return codeprestation;
    }

    public void setCodeprestation(String codeprestation) {
        this.codeprestation = codeprestation;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getEstmictsl() {
        return estmictsl;
    }

    public void setEstmictsl(String estmictsl) {
        this.estmictsl = estmictsl;
    }

    public String getIdavoir() {
        return idavoir;
    }

    public void setIdavoir(String idavoir) {
        this.idavoir = idavoir;
    }

    public String getTypeengagement() {
        return typeengagement;
    }

    public void setTypeengagement(String typeengagement) {
        this.typeengagement = typeengagement;
    }

    public String getPourcompte() {
        return pourcompte;
    }

    public void setPourcompte(String pourcompte) {
        this.pourcompte = pourcompte;
    }

    public String getHeuredepart() {
        return heuredepart;
    }

    public void setHeuredepart(String heuredepart) {
        this.heuredepart = heuredepart;
    }

    public String getHeurearrivee() {
        return heurearrivee;
    }

    public void setHeurearrivee(String heurearrivee) {
        this.heurearrivee = heurearrivee;
    }

    public String getBateau() {
        return bateau;
    }

    public void setBateau(String bateau) {
        this.bateau = bateau;
    }

    public double getTva() {
        return tva;
    }

    public void setTva(double tva) {
        this.tva = tva;
    }

    public double getEstauto() {
        return estauto;
    }

    public void setEstauto(double estauto) {
        this.estauto = estauto;
    }

    public double getEstancienne() {
        return estancienne;
    }

    public void setEstancienne(double estancienne) {
        this.estancienne = estancienne;
    }
    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("CR","GETSEQ_PROFORMA_MERE");
        setId(makePK(c));
    }

    
    
}
