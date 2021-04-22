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
import utilitaire.UtilDB;

/**
 *
 * @author Asus
 */
public class Renseigement_interne extends ClassMAPTable{
    
    private String id,idPersonnel,libelle, type,observation;
    private Date daty;

    public Renseigement_interne() {
         super.setNomTable("Renseignement_interne");
    }
    
    

    public Renseigement_interne(String id, String idPersonnel, String libelle, String type, String observation, Date daty)throws Exception {
        super.setNomTable("Renseignement_interne");
        this.setId(id);
        this.setIdPersonnel(idPersonnel);
        this.setLibelle(libelle);
        this.setType(type);
        this.setObservation(observation);
        this.setDaty(daty);
    }
    public Renseigement_interne(String idPersonnel, String libelle, String type, String observation, Date daty) throws Exception{
        super.setNomTable("Renseignement_interne");
        this.setIdPersonnel(idPersonnel);
        this.setLibelle(libelle);
        this.setType(type);
        this.setObservation(observation);
        this.setDaty(daty);
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

    public void setIdPersonnel(String idPersonnel) throws Exception{
        if(idPersonnel==null) throw new Exception("personnel manquant");
        this.idPersonnel = idPersonnel;
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getObservation() {
        return observation;
    }

    public void setObservation(String observation) {
        this.observation = observation;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public void controler(Connection c) throws Exception{
        try{
            //SpatService.testDoublonRenseignement(this,c);
        }catch(Exception e){
            throw e;
        }
    }

    @Override
    public String getTuppleID() {
     return this.id;}

    @Override
    public String getAttributIDName() {
         return "id";
    }
    
    public void construirePK(Connection c) throws Exception {
         this.preparePk("RIN", "getseq_renseignement_interne");
        this.setId(makePK(c));
        
    }

    public void inserer(String tuppleID, Connection c) throws Exception{
        int verif=0;
        try{
            if(c==null){
                c=new UtilDB().GetConn();
                verif=1;
            }
            String [] listepers = this.getIdPersonnel().split(";");
            if(listepers!=null){
                for(int i=0;i<listepers.length;i++){
                    this.setIdPersonnel(listepers[i]);
                    this.construirePK(c);
                    this.insertToTableWithHisto(tuppleID, c);
                }
            }
            if(verif==1)c.commit();
        }
        catch(Exception ex){
            ex.printStackTrace();
            c.rollback();
            throw ex;
        }
        finally{
            if(c!=null && verif==1){
                c.close();
            }
        }
    }
    
}
