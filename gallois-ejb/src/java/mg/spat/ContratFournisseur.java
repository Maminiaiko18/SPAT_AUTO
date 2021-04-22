/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author HP
 */
public class ContratFournisseur extends ClassMAPTable{
    private String id, nom, stat, nif, rc, fax, telephone, mail, adresse,  condition_reglement, mode_reglement, ref_fournisseur, cp;
    private int beneficiaire,ville;

    public ContratFournisseur(){
           this.setNomTable("contrat_engagement_fournisseur");
    }

    @Override
    public String getTuppleID() {
        return getId();
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public void construirePK(Connection c) throws Exception {
        this.preparePk("CEBC", "getseqcontractengagementf");
        this.setId(makePK(c));
    }  
    
    public String getId() {
        return id;
    }

    public String getNom() {
        return nom;
    }

    public String getStat() {
        return stat;
    }

    public String getNif() {
        return nif;
    }

    public String getRc() {
        return rc;
    }

    public String getFax() {
        return fax;
    }

    public String getTelephone() {
        return telephone;
    }

    public String getMail() {
        return mail;
    }

    public String getAdresse() {
        return adresse;
    }

    public String getCondition_reglement() {
        return condition_reglement;
    }

    public String getMode_reglement() {
        return mode_reglement;
    }

    public String getRef_fournisseur() {
        return ref_fournisseur;
    }

    public String getCp() {
        return cp;
    }

    public int getBeneficiaire() {
        return beneficiaire;
    }

    public int getVille() {
        return ville;
    }

    public void setId(String id_fournisseur) {
        this.id = id_fournisseur;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public void setStat(String stat) {
        this.stat = stat;
    }

    public void setNif(String nif) {
        this.nif = nif;
    }

    public void setRc(String rc) {
        this.rc = rc;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public void setCondition_reglement(String condition_reglement) {
        this.condition_reglement = condition_reglement;
    }

    public void setMode_reglement(String mode_reglement) {
        this.mode_reglement = mode_reglement;
    }

    public void setRef_fournisseur(String ref_fournisseur) {
        this.ref_fournisseur = ref_fournisseur;
    }

    public void setCp(String cp) {
        this.cp = cp;
    }

    public void setBeneficiaire(int beneficiaire) {
        this.beneficiaire = beneficiaire;
    }

    public void setVille(int ville) {
        this.ville = ville;
    }

    
    
}
