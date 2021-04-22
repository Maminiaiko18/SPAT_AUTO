/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;

import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author itu
 */
public class RejetTable extends ClassMAPTable {

    private String id;
    private java.sql.Date daty;
    private String remarque;
    private String mere;
    private String motif;
    private String categorierejet;

    public RejetTable(String id, Date daty, String remarque, String mere, String motif, String categorierejet) {
        this.id = id;
        this.daty = daty;
        this.remarque = remarque;
        this.mere = mere;
        this.motif = motif;
        this.categorierejet = categorierejet;
    }
    
    public RejetTable() {
        
    }

    public RejetTable(Date daty, String remarque, String mere, String motif, String categorierejet) {
        this.daty = daty;
        this.remarque = remarque;
        this.mere = mere;
        this.motif = motif;
        this.categorierejet = categorierejet;
    }
    
    public void construirePK(Connection c) throws Exception{
        this.preparePk("REJ", "getSeqRejet");
        this.setId(this.makePK(c));
    } 
    
    public String getAttributIDName() {
        return "id";
    }

    public String getTuppleID() {
        return this.getId();
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public java.sql.Date getDaty() {
        return daty;
    }

    public void setDaty(java.sql.Date daty) {
        this.daty = daty;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public String getMere() {
        return mere;
    }

    public void setMere(String mere) {
        this.mere = mere;
    }

    public String getMotif() {
        return motif;
    }

    public void setMotif(String motif) {
        this.motif = motif;
    }

    public String getCategorierejet() {
        return categorierejet;
    }

    public void setCategorierejet(String categorierejet) {
        this.categorierejet = categorierejet;
    }

}
