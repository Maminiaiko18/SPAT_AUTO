/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.compta;

import bean.ClassEtat;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.Utilitaire;

/**
 *
 * @author MEVA
 */
public class ComptaSousEcriture extends ClassEtat {

    private String id;
    private String compte;
    private double debit;
    private double credit;
    private String remarque;
    private String libellePiece;
    private String mere;
    private String reference_engagement;
    private String compte_aux;
    private String lettrage;
    private String journal;
    private String exercice;
    private String folio;
    private Date daty;
    private String analytique;

    public String getAnalytique() {
        return analytique;
    }

    public void setAnalytique(String analytique) {
        this.analytique = analytique;
    }
    
    public String getFolio() {
        return Utilitaire.champNull(folio);
    }

    public void setFolio(String folio) {
        this.folio = folio;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public String getJournal() {
        return Utilitaire.champNull(journal);
    }

    public void setJournal(String journal) throws Exception{
       // if(getMode().compareTo("modif")!=0){   
            this.journal = journal;
      /*  }
        else
        {
            if(journal==null || (journal!=null && journal.compareTo("")==0))
            {
                 throw new Exception ("Journal invalide");
            }
            else{
                this.journal = journal;
            }
        }*/
    }

    public String getExercice() {
        return exercice;
    }

    public void setExercice(String exercice) {
        this.exercice = exercice;
    }

    public String getReference_engagement() {
        return Utilitaire.champNull(reference_engagement);
    }

    public void setReference_engagement(String reference_engagement) {
        this.reference_engagement = reference_engagement;
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("MVT", "GETSEQCOMPTASOUSECRITURE");
        this.setId(makePK(c));
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
    public ComptaSousEcriture(String id, String compte, double debit, double credit, String remarque, String libellePiece, String ecriture, String ref_engag, String compte_a) throws Exception {
        super.setNomTable("compta_sous_ecriture");
        this.setCompte(compte);
        this.setDebit(debit);
        this.setCredit(credit);
        this.setRemarque(remarque);
        this.setLibellePiece(libellePiece);
        this.setMere(ecriture);
        this.setReference_engagement(ref_engag);
        this.setCompte_aux(compte_a);
    }
 
    public ComptaSousEcriture(String compte, double debit, double credit, String remarque, String libellePiece, String ecriture, String ref_engag, String compte_a) throws Exception {
        super.setNomTable("compta_sous_ecriture");
        this.setCompte(compte);
        this.setDebit(debit);
        this.setCredit(credit);
        this.setRemarque(remarque);
        this.setLibellePiece(libellePiece);
        this.setMere(ecriture);
        this.setReference_engagement(ref_engag);
        this.setCompte_aux(compte_a);
    }

    public ComptaSousEcriture(String compte, double debit, double credit, String remarque, String libellePiece, String ecriture, String ref_engag) throws Exception {
        super.setNomTable("compta_sous_ecriture");
        this.setCompte(compte);
        this.setDebit(debit);
        this.setCredit(credit);
        this.setRemarque(remarque);
        this.setLibellePiece(libellePiece);
        this.setMere(ecriture);
        this.setReference_engagement(ref_engag);
    }
    public ComptaSousEcriture(String compte, String tiers, double debit, double credit, String remarque, String libellePiece, String ecriture, String ref_engag) throws Exception {
        super.setNomTable("compta_sous_ecriture");
        this.setCompte(compte);
        this.setCompte_aux(tiers);
        this.setDebit(debit);
        this.setCredit(credit);
        this.setRemarque(remarque);
        this.setLibellePiece(libellePiece);
        this.setMere(ecriture);
        this.setReference_engagement(ref_engag);
    }
    
    public ComptaSousEcriture() {
        super.setNomTable("compta_sous_ecriture");

    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCompte() {
        return Utilitaire.champNull(compte);
    }

    public void setCompte(String compte) throws Exception {
        this.compte = compte;
    }

    public double getDebit() {
        return debit;
    }

    public void setDebit(double debit) {
        this.debit = debit;
    }

    public double getCredit() {
        return credit;
    }

    public void setCredit(double credit) {
        this.credit = credit;
    }

    public String getRemarque() {
        return Utilitaire.champNull(remarque).replace('"',' ');
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public String getLibellePiece() {
        return Utilitaire.champNull(libellePiece);
    }

    public void setLibellePiece(String libellePiece) {
        this.libellePiece = libellePiece;
    }

    public String getMere() {
        return Utilitaire.champNull(mere);
    }

    public void setMere(String mere) throws Exception {
        if (getMode().compareTo("modif") != 0) {
            this.mere = mere;
            return;
        }
        if (mere == "") {
            throw new Exception("Champ ecriture manquant");
        }
        this.mere = mere;
    }

    public String getCompte_aux() {
        return Utilitaire.champNull(compte_aux);
    }

    public void setCompte_aux(String compte_aux) throws Exception{
        this.compte_aux = compte_aux;
    }

    /**
     * @return the lettrage
     */
    public String getLettrage() {
        return Utilitaire.champNull(lettrage);
    }

    /**
     * @param lettrage the lettrage to set
     */
    public void setLettrage(String lettrage) {
        this.lettrage = lettrage;
    }
}

