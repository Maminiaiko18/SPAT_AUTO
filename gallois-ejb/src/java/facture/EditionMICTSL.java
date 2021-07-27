/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author Andri
 */
public class EditionMICTSL extends ClassMAPTable{
    private String id, type, noteexplicative;
    private Date daty;
    private int mois, annee;
    
    public EditionMICTSL(){
        this.setNomTable("editionMICTSLvide");
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getNoteexplicative() {
        return noteexplicative;
    }

    public void setNoteexplicative(String noteExplicative) {
        this.noteexplicative = noteExplicative;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public int getMois() {
        return mois;
    }

    public void setMois(int mois) {
        this.mois = mois;
    }

    public int getAnnee() {
        return annee;
    }

    public void setAnnee(int annee) {
        this.annee = annee;
    }
    
    public void construirePK(Connection c) throws Exception {
        this.preparePk("EM", "GETseq_editionmictslvide");
        this.setId(makePK(c));
    }

    @Override
    public String getTuppleID() {
        return this.getId(); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String getAttributIDName() {
        return "id"; //To change body of generated methods, choose Tools | Templates.
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
}
