/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.relationhumaine;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import service.SpatService;

/**
 *
 * @author Asus
 */
public class Parcours_professionnel extends ClassMAPTable {

    private String id, idPersonnel, poste_occupe, societe;
    private double duree;
    private int annee_parcours_pro;

    public Parcours_professionnel() {
        super.setNomTable("Parcours_professionnel");
    }

    public Parcours_professionnel(String id, String idPersonnel, String poste_occupe, String societe, double duree, int annee_parcours_pro) throws Exception {
        super.setNomTable("Parcours_professionnel");
        this.setId(id);
        this.setIdPersonnel(idPersonnel);
        this.setPoste_occupe(poste_occupe);
        this.setSociete(societe);
        this.setDuree(duree);
        this.setAnnee_parcours_pro(annee_parcours_pro);
    }

    public Parcours_professionnel(String idPersonnel, String poste_occupe, String societe, double duree, int annee_parcours_pro) throws Exception {
        super.setNomTable("Parcours_professionnel");
        this.setIdPersonnel(idPersonnel);
        this.setPoste_occupe(poste_occupe);
        this.setSociete(societe);
        this.setDuree(duree);
        this.setAnnee_parcours_pro(annee_parcours_pro);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdPersonnel() {
        return idPersonnel;
    }

    public void setIdPersonnel(String idPersonnel) {
        this.idPersonnel = idPersonnel;
    }

    public String getPoste_occupe() {
        return poste_occupe;
    }

    public void setPoste_occupe(String poste_occupe) {
        this.poste_occupe = poste_occupe;
    }

    public String getSociete() {
        return societe;
    }

    public void setSociete(String societe) {
        this.societe = societe;
    }

    public double getDuree() {

        return duree;
    }

    public void setDuree(double duree) throws Exception {

        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (duree < 0) {
                throw new Exception("duree invalide");
            }
        }
        this.duree = duree;
    }

    public int getAnnee_parcours_pro() {
        return annee_parcours_pro;
    }

    public void setAnnee_parcours_pro(int annee_parcours_pro) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (annee_parcours_pro < 0) {
                throw new Exception("annee_parcours_pro invalide");
            }
        }
        this.annee_parcours_pro = annee_parcours_pro;
    }

    public void controler(Connection c) throws Exception {
        try {
            //SpatService.testDoublonParcours_professionnel(this,c);
        } catch (Exception e) {
            throw e;
        }
    }

    @Override
    public String getTuppleID() {
        return this.id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public void construirePK(Connection c) throws Exception {
        this.preparePk("PPF", "getseq_parcours_professionnel");
        this.setId(makePK(c));

    }

}
