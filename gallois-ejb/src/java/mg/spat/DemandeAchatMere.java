/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.Utilitaire;

/**
 *
 * @author Nouta
 */
public class DemandeAchatMere extends ClassMAPTable{
    private String id,codeetablissement,projet,num,idengagement,designation,codeetablissementlib, projetlib, idengagementlib;
    private Date daty;

    public DemandeAchatMere() {
        super.setNomTable("dem_achat_mere");
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCodeetablissement() {
        return codeetablissement;
    }

    public void setCodeetablissement(String codeetablissement)throws Exception {
        if(this.getMode().compareToIgnoreCase("modif")==0&&(codeetablissement==null || codeetablissement.compareTo("")==0 )) throw new Exception("code etablissement obligatoire");
        this.codeetablissement = codeetablissement;
    }

    public String getProjet() {
        return projet;
    }

    public void setProjet(String projet) throws Exception {
        if(this.getMode().compareToIgnoreCase("modif")==0&&(projet==null || projet.compareTo("")==0 )) throw new Exception("projet obligatoire");
        this.projet = projet;
    }

    public String getIdengagement() {
        return idengagement;
    }

    public void setIdengagement(String idengagement) {
        this.idengagement = idengagement;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) throws Exception {
        if(this.getMode().compareToIgnoreCase("modif")==0&&(designation==null || designation.compareTo("")==0 )) throw new Exception("designation obligatoire");
        this.designation = designation;
    }
    public String getNum() {
        return num;
    }

    public void setNum(String num) throws Exception {
        if(this.getMode().compareToIgnoreCase("modif")==0&&(num==null || num.compareTo("")==0 )) throw new Exception("designation obligatoire");
        this.num = num;
    }
    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) throws Exception {
        if(this.getMode().compareToIgnoreCase("modif")==0&&daty==null ) throw new Exception("daty obligatoire");
        this.daty = daty;
    }

    public String getCodeetablissementlib() {
        return codeetablissementlib;
    }

    public void setCodeetablissementlib(String codeetablissementlib) {
        this.codeetablissementlib = codeetablissementlib;
    }

    public String getProjetlib() {
        return projetlib;
    }

    public void setProjetlib(String projetlib) {
        this.projetlib = projetlib;
    }

    public String getIdengagementlib() {
        return idengagementlib;
    }

    public void setIdengagementlib(String idengagementlib) {
        this.idengagementlib = idengagementlib;
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
        preparePk("AM","GETSEQ_DEM_ACHAT_MERE");
        setId(makePK(c));
    }

    @Override
    public ClassMAPTable createObject(String u, Connection c) throws Exception {
        this.setNum(String.valueOf(Utilitaire.getMaxSeq("getseqnumda",c)));
        return super.createObject(u, c); //To change body of generated methods, choose Tools | Templates.
    }

    
    
}
