/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package data;

import bean.CGenUtil;
import java.sql.Connection;
import java.sql.SQLException;
import mg.spat.OccupationMaterielNavalLibComplet;
import mg.spat.exploitant.Rubrique;
import utilitaire.UtilDB;

/**
 *
 * @author nyamp
 */
public class SaisieActiviteData {
    OccupationMaterielNavalLibComplet occupation;
    Rubrique rubrique;
    String idPrestation;

    public SaisieActiviteData(String idPrestation) {
        this.idPrestation = idPrestation;
    }
    public void initData() throws SQLException, Exception{
         Connection c=null;
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            occupation= new OccupationMaterielNavalLibComplet();
            occupation.setNomTable("occupationmaterielnavallibcpl");
            OccupationMaterielNavalLibComplet[] pres = (OccupationMaterielNavalLibComplet[]) CGenUtil.rechercher(occupation, null, null,c, " and id='"+idPrestation+"' ");
            Rubrique[] rubriques={};
            rubrique=new Rubrique();
            if(pres.length>0){
                
                occupation=pres[0];
                if(occupation.getIdnatureoperation().equalsIgnoreCase("Lamanage")){
                    rubriques = (Rubrique[]) CGenUtil.rechercher(rubrique, null, null,c, " and DESIGNATION  like '%Lamanage calculé%'");
                }
                else  if(occupation.getIdnatureoperation().equalsIgnoreCase("Remorquage")){
                    
                    rubriques = (Rubrique[]) CGenUtil.rechercher(rubrique, null, null,c, " and DESIGNATION  like '%Remorquage calculé%'");
                }
                else  if(occupation.getIdnatureoperation().equalsIgnoreCase("Pilotage")){
                    
                    rubriques = (Rubrique[]) CGenUtil.rechercher(rubrique, null, null,c, " and DESIGNATION  like '%Pilotage calculé%'");
                }
                if(rubriques.length>0){
                    rubrique=rubriques[0];
                }
            }
            
            if(c!=null && verif==1) c.commit();
        } catch (Exception e) {
            if (c != null && verif == 1) {
                c.rollback();
            }
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    public String getIdPrestation() {
        return idPrestation;
    }

    public void setIdPrestation(String idPrestation) {
        this.idPrestation = idPrestation;
    }
    
    public OccupationMaterielNavalLibComplet getOccupation() {
        return occupation;
    }

    public void setOccupation(OccupationMaterielNavalLibComplet occupation) {
        this.occupation = occupation;
    }

    public Rubrique getRubrique() {
        return rubrique;
    }

    public void setRubrique(Rubrique rubrique) {
        this.rubrique = rubrique;
    }
    
    
}
