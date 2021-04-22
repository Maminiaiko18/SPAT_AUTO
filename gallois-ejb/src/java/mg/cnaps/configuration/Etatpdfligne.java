/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package mg.cnaps.configuration;

import bean.ClassMAPTable;

/**
 *
 * @author user
 */
public class Etatpdfligne extends ClassMAPTable{
    private String id;
    private String libelle;
    private String total;
    private String commentaires;
    public Etatpdfligne()
    {
        this.setNomTable("ETAT_PDF_LIGNE");
    }
    public Etatpdfligne(String id,String libelle,String total,String commentaires)
    {
        this.setNomTable("ETAT_PDF_LIGNE");
        this.setId(id);
        this.setLibelle(libelle);
        this.setTotal(total);
        this.setCommentaires(commentaires);
    }
    public Etatpdfligne(String libelle,String total,String commentaires)
    {
        this.setNomTable("ETAT_PDF_LIGNE");
        this.setLibelle(libelle);
        this.setTotal(total);
        this.setCommentaires(commentaires);
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
     * @return the libelle
     */
    public String getLibelle() {
        return libelle;
    }

    /**
     * @param libelle the libelle to set
     */
    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

    /**
     * @return the total
     */
    public String getTotal() {
        return total;
    }

    /**
     * @param total the total to set
     */
    public void setTotal(String total) {
        this.total = total;
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

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
}
