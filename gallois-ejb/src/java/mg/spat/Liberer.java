/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.CGenUtil;
import bean.ClassEtat;
import java.sql.Connection;

/**
 *
 * @author Nouta
 */
public class Liberer extends ClassEtat {
    private String id,idengagement,idengagementlib;
    private double montant;

    public Liberer() {
        super.setNomTable("liberer");
    }

    public String getIdengagementlib() {
        return idengagementlib;
    }

    public void setIdengagementlib(String idengagementlib) {
        this.idengagementlib = idengagementlib;
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdengagement() {
        return idengagement;
    }

    public void setIdengagement(String idengagement) {
        this.idengagement = idengagement;
    }

   
    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("CR","GETSEQ_LIBERER");
        setId(makePK(c));
    }
    
    
    public Engagement findEngagement(String nomtable,Connection c)throws Exception{
        if(nomtable==null || nomtable.equals("")){
            nomtable = "engagement";
        }
        Engagement engagement = new Engagement();
        engagement.setNomTable(nomtable);
        Engagement[] reponse = (Engagement[])CGenUtil.rechercher(engagement, null, null, c, " and id='"+this.getIdengagement()+"'");
        if(reponse.length>0){
            return reponse[0];
        }
        return null;
    }
    
}
