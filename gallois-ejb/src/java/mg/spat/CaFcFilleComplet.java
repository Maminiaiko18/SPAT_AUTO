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
 * @author Nouta
 */
public class CaFcFilleComplet extends ClassEtat {
    private String id,idmere,compte,designation,idproduit,devise,devisemere,idactivite,moislib,rubrique,heuredebut,heurefin,rubriquecpl,idcategorie,type,nomnavire;
    private double quantite,pu,taux,tva,montanttva,montantttc,montant,reduction,majoration,test,rang,duree;
    private int mois,annee;
    private double montantav;
    String client,mereca,code,numpiece ;
    private Date datefact,daty;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }
    
    public String getMereca() {
        return mereca;
    }

    public void setMereca(String mereca) {
        this.mereca = mereca;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public CaFcFilleComplet() {
        super.setNomTable("CAFCFILLECOMPLET");
    }

    public String getClient() {
        return client;
    }

    public void setClient(String client) {
        this.client = client;
    }

    public String getNomnavire() {
        return nomnavire;
    }

    public void setNomnavire(String nomnavire) {
        this.nomnavire = nomnavire;
    }

    public String getDevisemere() {
        return devisemere;
    }

    public void setDevisemere(String devisemere) {
        this.devisemere = devisemere;
    }

    public String getHeuredebut() {
        return heuredebut;
    }

    public void setHeuredebut(String heuredebut) {
        this.heuredebut = heuredebut;
    }

    public String getHeurefin() {
        return heurefin;
    }

    public void setHeurefin(String heurefin) {
        this.heurefin = heurefin;
    }

    public String getRubriquecpl() {
        return rubriquecpl;
    }

    public void setRubriquecpl(String rubriquecpl) {
        this.rubriquecpl = rubriquecpl;
    }

    public String getIdcategorie() {
        return idcategorie;
    }

    public void setIdcategorie(String idcategorie) {
        this.idcategorie = idcategorie;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public double getReduction() {
        return reduction;
    }

    public void setReduction(double reduction) {
        this.reduction = reduction;
    }

    public double getMajoration() {
        return majoration;
    }

    public void setMajoration(double majoration) {
        this.majoration = majoration;
    }

    public double getTest() {
        return test;
    }

    public void setTest(double test) {
        this.test = test;
    }

    public double getRang() {
        return rang;
    }

    public void setRang(double rang) {
        this.rang = rang;
    }

    public double getDuree() {
        return duree;
    }

    public void setDuree(double duree) {
        this.duree = duree;
    }

    public double getMontantav() {
        return montantav;
    }

    public void setMontantav(double montantav) {
        this.montantav = montantav;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdmere() {
        return idmere;
    }

    public void setIdmere(String idmere) {
        this.idmere = idmere;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getIdproduit() {
        return idproduit;
    }

    public void setIdproduit(String idproduit) {
        this.idproduit = idproduit;
    }

    public String getDevise() {
        return devise;
    }

    public void setDevise(String devise) {
        this.devise = devise;
    }

    public String getIdactivite() {
        return idactivite;
    }

    public void setIdactivite(String idactivite) {
        this.idactivite = idactivite;
    }

    public String getMoislib() {
        return moislib;
    }

    public void setMoislib(String moislib) {
        this.moislib = moislib;
    }

    public String getRubrique() {
        return rubrique;
    }

    public void setRubrique(String rubrique) {
        this.rubrique = rubrique;
    }

    public double getQuantite() {
        return quantite;
    }

    public void setQuantite(double quantite) {
        this.quantite = quantite;
    }

    public double getPu() {
        return pu;
    }

    public void setPu(double pu) {
        this.pu = pu;
    }

    public String getCompte() {
        return compte;
    }

    public void setCompte(String compte) {
        this.compte = compte;
    }

    

    public double getTaux() {
        return taux;
    }

    public void setTaux(double taux) {
        this.taux = taux;
    }

    public double getTva() {
        return tva;
    }

    public void setTva(double tva) {
        this.tva = tva;
    }

    public double getMontanttva() {
        return montanttva;
    }

    public void setMontanttva(double montanttva) {
        this.montanttva = montanttva;
    }

    public double getMontantttc() {
        return montantttc;
    }

    public void setMontantttc(double montantttc) {
        this.montantttc = montantttc;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public int getMois() {
        return mois;
    }

    public void setMois(int mois) {
        this.mois = mois;
    }

    public int getAnnee() {
        return annee;
    }

    public void setAnnee(int annee) {
        this.annee = annee;
    }

    public Date getDatefact() {
        return datefact;
    }

    public void setDatefact(Date datefact) {
        this.datefact = datefact;
    }

    public String getNumpiece() {
        return numpiece;
    }

    public void setNumpiece(String numpiece) {
        this.numpiece = numpiece;
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
