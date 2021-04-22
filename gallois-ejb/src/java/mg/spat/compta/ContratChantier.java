/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.compta;

import bean.ClassEtat;
import java.sql.Connection;
import utilitaire.ConstanteEtat;
import historique.HistoriqueContrat;
import utilitaire.Utilitaire;

/**
 *
 * @author rasol
 */
public class ContratChantier extends ClassEtat {

    private String id, idchantier, idtravaux, designation, prestataire, nom_chantier, nom_prestataire, projet, code_etab, projetlib, code_etablib;
    private double tva, nocontrat;

    public String getProjetlib() {
        return projetlib;
    }

    public void setProjetlib(String projetlib) {
        this.projetlib = projetlib;
    }

    public String getCode_etablib() {
        return code_etablib;
    }

    public void setCode_etablib(String code_etablib) {
        this.code_etablib = code_etablib;
    }

    public String getNom_chantier() {
        return nom_chantier;
    }

    public void setNom_chantier(String nom_chantier) {
        this.nom_chantier = nom_chantier;
    }
    private double montant;

    @Override
    public void controlerUpdate(Connection c) throws Exception {
        ContratChantier cc = (ContratChantier) this.getById(this.getId(), this.getNomTable(), c);

        if (cc != null && cc.getEtat() >= ConstanteEtat.getEtatValider()) {
            HistoriqueContrat hC = new HistoriqueContrat(cc.getId(), Utilitaire.dateDuJourSql(), this.getMontant());
            hC.controler(c);
            hC.construirePK(c);
            hC.insertToTable(c);
            
            this.setEtat(cc.getEtat());
        }
    }

    public ContratChantier() {
        this.setNomTable("contrat_chantier");
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public void construirePK(Connection c) throws Exception {
        this.preparePk("CC", "GET_SEQ_contrat_chantier");
        this.setId(makePK(c));
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdchantier() {
        return idchantier;
    }

    public void setIdchantier(String idchantier) {
        this.idchantier = idchantier;
    }

    public String getIdtravaux() {
        return idtravaux;
    }

    public void setIdtravaux(String idtravaux) {
        this.idtravaux = idtravaux;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getPrestataire() {
        return prestataire;
    }

    public void setPrestataire(String prestataire) {
        this.prestataire = prestataire;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public String getNom_prestataire() {
        return nom_prestataire;
    }

    public void setNom_prestataire(String nom_prestataire) {
        this.nom_prestataire = nom_prestataire;
    }

    public String getProjet() {
        return projet;
    }

    public void setProjet(String projet) {
        this.projet = projet;
    }

    public String getCode_etab() {
        return code_etab;
    }

    public void setCode_etab(String code_etab) {
        this.code_etab = code_etab;
    }

    public double getTva() {
        return tva;
    }

    public void setTva(double tva) {
        this.tva = tva;
    }

    public double getNocontrat() {
        return nocontrat;
    }

    public void setNocontrat(double nocontrat) {
        this.nocontrat = nocontrat;
    }
}
