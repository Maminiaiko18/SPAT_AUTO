/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.CGenUtil;
import bean.ClassEtat;
import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author rajao
 */
public class MaterielNaval extends ClassEtat {
    private String id;
    private String denomination;
    private Date date_aquisition;
    private String idMarque;
    private int puissance;
    private String detenteur;
    private String maintenance;
    private String idType_materiel,idcategorie ;
    private String immatriculation;
    
    public MaterielNaval()
    {
        super.setNomTable("Materiel_naval");
    }

    public String getIdcategorie() {
        return idcategorie;
    }

    public void setIdcategorie(String idcategorie) {
        this.idcategorie = idcategorie;
    }
    

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDenomination() {
        return denomination;
    }

    public void setDenomination(String denomination) {
        this.denomination = denomination;
    }

    public Date getDate_aquisition() {
        return date_aquisition;
    }

    public void setDate_aquisition(Date date_aquisition) {
        this.date_aquisition = date_aquisition;
    }

    public String getIdMarque() {
        return idMarque;
    }

    public void setIdMarque(String idMarque) {
        this.idMarque = idMarque;
    }

    public int getPuissance() {
        return puissance;
    }

    public void setPuissance(int puissance) throws Exception {
        if(this.getMode().compareTo("modif")==0){
            if(puissance<0) throw new Exception("Puissance négative pour ce matériel naval");
        }
        this.puissance = puissance;
    }

    public String getDetenteur() {
        return detenteur;
    }

    public void setDetenteur(String detenteur) {
        this.detenteur = detenteur;
    }

    public String getMaintenance() {
        return maintenance;
    }

    public void setMaintenance(String maintenance) {
        this.maintenance = maintenance;
    }

    public String getIdType_materiel() {
        return idType_materiel;
    }

    public void setIdType_materiel(String idType_material) {
        this.idType_materiel = idType_material;
    }

    public String getImmatriculation() {
        return immatriculation;
    }

    public void setImmatriculation(String immatriculation) {
        this.immatriculation = immatriculation;
    }
     public void construirePK(Connection c) throws Exception {
        this.preparePk("MTN", "getseqMateriel_naval");
        this.setId(makePK(c));
    }
    public void controler(Connection c)throws Exception{
        try{
            MaterielNaval[] liste=(MaterielNaval[]) CGenUtil.rechercher(this, "select * from "+this.getNomTable()+" where immatriculation='"+this.getImmatriculation()+"'", c);
            if(liste.length>0)
                throw new Exception("Immatriculation déjà prise");
        }catch(Exception e){
            throw e;
        }
    }
    
    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
}
