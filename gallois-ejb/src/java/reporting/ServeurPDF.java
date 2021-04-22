/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package reporting;

import bean.ClassEtat;
import java.sql.Connection;

/**
 *
 * @author anthonyandrianaivoravelona
 */
public class ServeurPDF extends ClassEtat{
    private String id, nom_objet, idobjet, remarque;

    public ServeurPDF() {
        super.setNomTable("SERVEUR_PDF_CNAPS");
    }
    
    public ServeurPDF(String id, String nom_objet, String idobjet) {
        setId(id);
        setNom_objet(nom_objet);
        setIdobjet(idobjet);
        super.setNomTable("SERVEUR_PDF_CNAPS");
    }

    public ServeurPDF(String nom_objet, String idobjet) {
        setNom_objet(nom_objet);
        setIdobjet(idobjet);
        super.setNomTable("SERVEUR_PDF_CNAPS");
    }

    public ServeurPDF(String id, String nom_objet, String idobjet, String remarque) {
        setId(id);
        setNom_objet(nom_objet);
        setIdobjet(idobjet);
        setRemarque(remarque);
        super.setNomTable("SERVEUR_PDF_CNAPS");
    }
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNom_objet() {
        return nom_objet;
    }

    public void setNom_objet(String nom_objet) {
        this.nom_objet = nom_objet;
    }

    public String getIdobjet() {
        return idobjet;
    }

    public void setIdobjet(String idobjet) {
        this.idobjet = idobjet;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
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
        this.preparePk("PEX", "getSeqServeurPdfCnaps");
        this.setId(makePK(c));
    }
}
