/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package mg.cnaps.configuration;

import bean.ClassEtat;

/**
 *
 * @author user
 */
public class EtatpdfComplet extends ClassEtat{
    private String id;
    private String idetat;
    private String idcolonne;
    private String idligne;
    private String valeur;
    private String formule;
    private int orderetat;
    private String commentaires;
    public EtatpdfComplet()
    {
        this.setNomTable("ETAT_PDF_COMPLET");
    }
    public EtatpdfComplet(String id,String idcolonne,String idligne,String valeur,String formule,int orderetat,String commentaires)
    {
         this.setNomTable("ETAT_PDF_COMPLET");
        this.setId(id);
        this.setIdcolonne(idcolonne);
        this.setIdligne(idligne);
        this.setValeur(valeur);
        this.setFormule(formule);
        this.setOrderetat(orderetat);
        this.setCommentaires(commentaires);
    }
     public EtatpdfComplet(String idcolonne,String idligne,String valeur,String formule,int orderetat,String commentaires)
    {
        this.setNomTable("ETAT_PDF_COMPLET");
        this.setIdcolonne(idcolonne);
        this.setIdligne(idligne);
        this.setValeur(valeur);
        this.setFormule(formule);
        this.setOrderetat(orderetat);
        this.setCommentaires(commentaires);
    }
    @Override
    public String getTuppleID() {
       return getId();
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    /**
     * @return the id
     */
    public String getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(String id) {
        this.id = id;
    }

    /**
     * @return the idcolonne
     */
    public String getIdcolonne() {
        return idcolonne;
    }

    /**
     * @param idcolonne the idcolonne to set
     */
    public void setIdcolonne(String idcolonne) {
        this.idcolonne = idcolonne;
    }

    /**
     * @return the idligne
     */
    public String getIdligne() {
        return idligne;
    }

    /**
     * @param idligne the idligne to set
     */
    public void setIdligne(String idligne) {
        this.idligne = idligne;
    }

    /**
     * @return the valeur
     */
    public String getValeur() {
        return valeur;
    }

    /**
     * @param valeur the valeur to set
     */
    public void setValeur(String valeur) {
        this.valeur = valeur;
    }

    /**
     * @return the formule
     */
    public String getFormule() {
        return formule;
    }

    /**
     * @param formule the formule to set
     */
    public void setFormule(String formule) {
        this.formule = formule;
    }

    /**
     * @return the orderetat
     */
    public int getOrderetat() {
        return orderetat;
    }

    /**
     * @param orderetat the orderetat to set
     */
    public void setOrderetat(int orderetat) {
        this.orderetat = orderetat;
    }

    /**
     * @return the commentaires
     */
    public String getCommentaires() {
        return commentaires;
    }

    /**
     * @param commentaires the commentaires to set
     */
    public void setCommentaires(String commentaires) {
        this.commentaires = commentaires;
    }

    public String getIdetat() {
        return idetat;
    }

    public void setIdetat(String idetat) {
        this.idetat = idetat;
    }
    
}
