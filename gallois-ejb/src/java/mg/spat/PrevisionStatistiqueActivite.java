/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassEtat;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import service.SpatService;
import utilitaire.Utilitaire;

/**
 *
 * @author Antsa
 */
public class PrevisionStatistiqueActivite extends ClassEtat {

    private String id, idclient, rubrique;
    private Date daty;
    private double cumul,redevance_fixe, redevance_variable,autre;

    public PrevisionStatistiqueActivite() {
        super.setNomTable("prevision_statistique_activite");

    }

    public PrevisionStatistiqueActivite(String id, String idclient, String rubrique, Date daty, double cumul) throws Exception {
        super.setNomTable("prevision_statistique_activite");

        this.setId(id);
        this.setIdclient(idclient);
        this.setRubrique(rubrique);
        this.setDaty(daty);
        this.setCumul(cumul);
    }
    public PrevisionStatistiqueActivite(String idclient, String rubrique, Date daty, double cumul) throws Exception {
        super.setNomTable("prevision_statistique_activite");
        this.setIdclient(idclient);
        this.setRubrique(rubrique);
        this.setDaty(daty);
        this.setCumul(cumul);
    }

    public String getId() {
        return id;
    }

    public double getRedevance_fixe() {
        return redevance_fixe;
    }

    public void setRedevance_fixe(double redevance_fixe) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (redevance_fixe < 0) {
                throw new Exception("redevance_fixe invalide");
            }
        }
        this.redevance_fixe = redevance_fixe;
    }

    public double getRedevance_variable() {
        return redevance_variable;
    }

    public void setRedevance_variable(double redevance_variable) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (redevance_variable < 0) {
                throw new Exception("redevance_variable invalide");
            }
        }
        this.redevance_variable = redevance_variable;
    }

    public double getAutre() {
        return autre;
    }

    public void setAutre(double autre) throws Exception{
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (autre < 0) {
                throw new Exception("autre invalide");
            }
        }
        this.autre = autre;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdclient() {
        return idclient;
    }

    public void setIdclient(String idclient) throws Exception {
        if(this.getMode().compareTo("modif")==0){
            if(idclient==null || idclient.compareTo("")==0){
                throw new Exception("Client obligatoire");
            }
        }
        this.idclient = idclient;
    }

    public String getRubrique() {
        return rubrique;
    }

    public void setRubrique(String rubrique) {
        this.rubrique = rubrique;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public double getCumul() {
        return cumul;
    }

    public void setCumul(double cumul) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (cumul < 0) {
                throw new Exception("cumul invalide");
            }
        }
        this.cumul = cumul;
    }
    public void controler(Connection c) throws Exception{
        try{
            SpatService.testMoisPrevisionStatistiqueActivite(this, c);
        }catch(Exception e){
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
        this.preparePk("PSA", "getseq_prev_stat_activite");
        this.setId(makePK(c));

    }

}
