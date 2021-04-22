/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package mg.cnaps.configuration;

import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author user
 */
public class Etatpdf extends ClassMAPTable{
    private String id;
    private String etat;
    private String commentaires;
    public Etatpdf()
    {
        this.setNomTable("ETAT_PDF");
    }
    public Etatpdf(String id,String etat,String commentaires)
    {
        this.setNomTable("ETAT_PDF");
        this.setId(id);
        this.setEtat(etat);
        this.setCommentaires(commentaires);
    }
    public Etatpdf(String etat,String commentaires)
    {
        this.setNomTable("ETAT_PDF");
        this.setEtat(etat);
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
     * @return the etat
     */
    public String getEtat() {
        return etat;
    }

    /**
     * @param etat the etat to set
     */
    public void setEtat(String etat) {
        this.etat = etat;
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
