/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassEtat;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author HP
 */
public class ContratEngagementBonCommande extends ClassEtat{
    
       private String id;
       private String num_bc;
       private String organe_demandeur;
       private String type_commande;
       private Date daty;
       private double montant_ht;
       private double tva;
       private double montant_ttc;
       private double montant_autoriser;
       private String fournisseur_id;
       private String bon_livraison;
       private String bon_entre;
       private Date date_livraison;
       private int facturer;
       private int ordre_de_paiement;
       private int reference_paiement;
       private String type_paiement;
       private int tva_valider;
       private int id_organe_demandeur;
       private String type;
       private String condition_reglement;
       private String mode_reglement;
       private String note;

       public ContratEngagementBonCommande(){
           this.setNomTable("contrat_engagement_boncommande");
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
        this.preparePk("CEBC", "getseqcontractengagementbc");
        this.setId(makePK(c));
    }  

    public String getId() {
        return id;
    }

    public String getNum_bc() {
        return num_bc;
    }

    public String getOrgane_demandeur() {
        return organe_demandeur;
    }

    public String getType_commande() {
        return type_commande;
    }

    public Date getDaty() {
        return daty;
    }

    public double getMontant_ht() {
        return montant_ht;
    }

    public double getTva() {
        return tva;
    }

    public double getMontant_ttc() {
        return montant_ttc;
    }

    public double getMontant_autoriser() {
        return montant_autoriser;
    }

    public String getFournisseur_id() {
        return fournisseur_id;
    }

    public String getBon_livraison() {
        return bon_livraison;
    }

    public String getBon_entre() {
        return bon_entre;
    }

    public Date getDate_livraison() {
        return date_livraison;
    }

    public int getFacturer() {
        return facturer;
    }

    public int getOrdre_de_paiement() {
        return ordre_de_paiement;
    }

    public int getReference_paiement() {
        return reference_paiement;
    }

    public String getType_paiement() {
        return type_paiement;
    }

    public int getTva_valider() {
        return tva_valider;
    }

    public int getId_organe_demandeur() {
        return id_organe_demandeur;
    }

    public String getType() {
        return type;
    }

    public String getCondition_reglement() {
        return condition_reglement;
    }

    public String getMode_reglement() {
        return mode_reglement;
    }

    public String getNote() {
        return note;
    }

    public void setId(String id_bc) {
        this.id = id_bc;
    }

    public void setNum_bc(String num_bc) {
        this.num_bc = num_bc;
    }

    public void setOrgane_demandeur(String organe_demandeur) {
        this.organe_demandeur = organe_demandeur;
    }

    public void setType_commande(String type_commande) {
        this.type_commande = type_commande;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public void setMontant_ht(double montant_ht) {
        this.montant_ht = montant_ht;
    }

    public void setTva(double tva) {
        this.tva = tva;
    }

    public void setMontant_ttc(double montant_ttc) {
        this.montant_ttc = montant_ttc;
    }

    public void setMontant_autoriser(double montant_autoriser) {
        this.montant_autoriser = montant_autoriser;
    }

    public void setFournisseur_id(String fournisseur_id) {
        this.fournisseur_id = fournisseur_id;
    }

    public void setBon_livraison(String bon_livraison) {
        this.bon_livraison = bon_livraison;
    }

    public void setBon_entre(String bon_entre) {
        this.bon_entre = bon_entre;
    }

    public void setDate_livraison(Date date_livraison) {
        this.date_livraison = date_livraison;
    }

    public void setFacturer(int facturer) {
        this.facturer = facturer;
    }

    public void setOrdre_de_paiement(int ordre_de_paiement) {
        this.ordre_de_paiement = ordre_de_paiement;
    }

    public void setReference_paiement(int reference_paiement) {
        this.reference_paiement = reference_paiement;
    }

    public void setType_paiement(String type_paiement) {
        this.type_paiement = type_paiement;
    }

    public void setTva_valider(int tva_valider) {
        this.tva_valider = tva_valider;
    }

    public void setId_organe_demandeur(int id_organe_demandeur) {
        this.id_organe_demandeur = id_organe_demandeur;
    }

    public void setType(String type) {
        this.type = type;
    }

    public void setCondition_reglement(String condition_reglement) {
        this.condition_reglement = condition_reglement;
    }

    public void setMode_reglement(String mode_reglement) {
        this.mode_reglement = mode_reglement;
    }

    public void setNote(String note) {
        this.note = note;
    }
}
