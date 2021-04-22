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
public class Etatpdfcolonne extends ClassMAPTable {
    private String id;
    private String libelle;
    private String commentaires;
     public Etatpdfcolonne()
    {
        this.setNomTable("ETAT_PDF_COLONNE");
    }
    public Etatpdfcolonne(String id,String libelle,String commentaires)
    {
         this.setNomTable("ETAT_PDF_COLONNE");
        this.setId(id);
        this.setLibelle(libelle);
        this.setCommentaires(commentaires);
    }
    public Etatpdfcolonne(String libelle,String commentaires)
    {
         this.setNomTable("ETAT_PDF_COLONNE");
        this.setLibelle(libelle);
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
    
}
