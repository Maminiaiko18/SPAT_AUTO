/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package affichage;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author Jerry
 */
public class Commentaire extends ClassMAPTable {
    private String id;
    private java.sql.Date daty;
    private String iduser;
    private String commentaire;
    private String idobjet;

    public Commentaire() {
        super.setNomTable("commentaire");
    }

    public Commentaire(String id, Date daty, String iduser, String commentaire, String idobjet) {
        super.setNomTable("commentaire");
        this.setId(id);
        this.setDaty(daty);
        this.setIduser(iduser);
        this.setCommentaire(commentaire);
        this.setIdobjet(idobjet);
    }
    
    @Override
    public String getTuppleID() {
        return this.getId();
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
    public void construirePK(Connection c) throws Exception {
        this.preparePk("COM", "GETSEQCOMMENTAIRE");
        this.setId(makePK(c));
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public String getIduser() {
        return iduser;
    }

    public void setIduser(String iduser) {
        this.iduser = iduser;
    }

    public String getCommentaire() {
        return commentaire;
    }

    public void setCommentaire(String commentaire) {
        this.commentaire = commentaire;
    }

    public String getIdobjet() {
        return idobjet;
    }

    public void setIdobjet(String idobjet) {
        this.idobjet = idobjet;
    }
    
    
}
