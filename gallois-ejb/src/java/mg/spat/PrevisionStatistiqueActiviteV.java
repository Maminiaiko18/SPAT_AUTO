/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import java.sql.Date;

/**
 *
 * @author Asus
 */
public class PrevisionStatistiqueActiviteV extends PrevisionStatistiqueActivite {

    private String idprevision, rubriqueprevision, client;
    private Date datyprevision;
    private int annee, mois_precedent, mois_en_cours;

    public PrevisionStatistiqueActiviteV(String idprevision, String rubriqueprevision, String client, Date datyprevision, int annee, int mois_precedent, int mois_en_cours, String id, String idclient, String rubrique, Date daty, double cumul) throws Exception {
        super(id, idclient, rubrique, daty, cumul);
        this.setIdprevision(idprevision);
        this.setRubriqueprevision(rubriqueprevision);
        this.setClient(client);
        this.setDatyprevision(datyprevision);
        this.setAnnee(annee);
        this.setMois_precedent(mois_precedent);
        this.setMois_en_cours(mois_en_cours);
    }

    public String getIdprevision() {
        return idprevision;
    }

    public void setIdprevision(String idprevision) {
        this.idprevision = idprevision;
    }

    public String getRubriqueprevision() {
        return rubriqueprevision;
    }

    public void setRubriqueprevision(String rubriqueprevision) {
        this.rubriqueprevision = rubriqueprevision;
    }

    public String getClient() {
        return client;
    }

    public void setClient(String client) {
        this.client = client;
    }

    public Date getDatyprevision() {
        return datyprevision;
    }

    public void setDatyprevision(Date datyprevision) {
        this.datyprevision = datyprevision;
    }

    public int getAnnee() {
        return annee;
    }

    public void setAnnee(int annee) throws Exception {

        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (annee < 0) {
                throw new Exception("annee invalide");
            }
        }
        this.annee = annee;
    }

    public int getMois_precedent() {
        return mois_precedent;
    }

    public void setMois_precedent(int mois_precedent) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (mois_precedent < 0) {
                throw new Exception("mois_precedent invalide");
            }
        }
        this.mois_precedent = mois_precedent;
    }

    public int getMois_en_cours() {
        return mois_en_cours;
    }

    public void setMois_en_cours(int mois_en_cours) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (mois_en_cours < 0) {
                throw new Exception("mois_en_cours invalide");
            }
        }
        this.mois_en_cours = mois_en_cours;
    }

}
