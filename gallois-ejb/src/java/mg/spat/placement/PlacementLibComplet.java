/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.placement;

import bean.CGenUtil;
import bean.ClassEtat;
import java.sql.Connection;
import java.sql.Date;
import mg.spat.ConfigPlacement;
import utilitaire.UtilDB;

/**
 *
 * @author pro
 */
public class PlacementLibComplet extends ClassEtat{
    private String id,entite,identite,idbanque,valentite,desceentite,valbanque,descebanque,numero,iddetails,idmeredetails,mois,banque,iddevise;
    private Date date_placement, date_echeance;
    private double duree,ircm, montant, taux, montant_mere, interet_recevoir, interet_net,montantdevise;
    private String ancienplacement;

    public double getIrcm() {
        return ircm;
    }

    public void setIrcm(double ircm) {
        this.ircm = ircm;
    }

    
    public String getAncienplacement() {
        return ancienplacement;
    }

    public void setAncienplacement(String ancienplacement) {
        this.ancienplacement = ancienplacement;
    }
    
    public double getMontantdevise() {
        return montantdevise;
    }

    public void setMontantdevise(double montantdevise) {
        this.montantdevise = montantdevise;
    }

    public String getIddevise() {
        return iddevise;
    }

    public void setIddevise(String iddevise) {
        this.iddevise = iddevise;
    }

    public String getBanque() {
        return banque;
    }

    public void setBanque(String banque) {
        this.banque = banque;
    }
    
    public PlacementLibComplet() {
         super.setNomTable("PLACEMENTLIBCOMPLET");
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getEntite() {
        return entite;
    }

    public void setEntite(String entite) {
        this.entite = entite;
    }

    public String getIdentite() {
        return identite;
    }

    public void setIdentite(String identite) {
        this.identite = identite;
    }

    public String getIdbanque() {
        return idbanque;
    }

    public void setIdbanque(String idbanque) {
        this.idbanque = idbanque;
    }

    public String getValentite() {
        return valentite;
    }

    public void setValentite(String valentite) {
        this.valentite = valentite;
    }

    public String getDesceentite() {
        return desceentite;
    }

    public void setDesceentite(String desceentite) {
        this.desceentite = desceentite;
    }

    public String getValbanque() {
        return valbanque;
    }

    public void setValbanque(String valbanque) {
        this.valbanque = valbanque;
    }

    public String getDescebanque() {
        return descebanque;
    }

    public void setDescebanque(String descebanque) {
        this.descebanque = descebanque;
    }

    public Date getDate_placement() {
        return date_placement;
    }

    public void setDate_placement(Date date_placement) {
        this.date_placement = date_placement;
    }

    public Date getDate_echeance() {
        return date_echeance;
    }

    public void setDate_echeance(Date date_echeance) {
        this.date_echeance = date_echeance;
    }

    public double getDuree() {
        return duree;
    }

    public void setDuree(double duree) {
        this.duree = duree;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public double getTaux() {
        return taux;
    }

    public void setTaux(double taux) {
        this.taux = taux;
    }
    
    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public String getIddetails() {
        return iddetails;
    }

    public void setIddetails(String iddetails) {
        this.iddetails = iddetails;
    }

    public String getIdmeredetails() {
        return idmeredetails;
    }

    public void setIdmeredetails(String idmeredetails) {
        this.idmeredetails = idmeredetails;
    }

    public String getMois() {
        return mois;
    }

    public void setMois(String mois) {
        this.mois = mois;
    }

    public double getMontant_mere() {
        return montant_mere;
    }

    public void setMontant_mere(double montant_mere) {
        this.montant_mere = montant_mere;
    }

    public double getInteret_recevoir() {
        return interet_recevoir;
    }

    public void setInteret_recevoir(double interet_recevoir) {
        this.interet_recevoir = interet_recevoir;
    }

    public double getInteret_net() {
        return interet_net;
    }

    public void setInteret_net(double interet_net) {
        this.interet_net = interet_net;
    }
    public ConfigPlacement getConfigPlacement(Connection conn)throws Exception {
        boolean verify = false;
        try{
            if(conn==null){
                conn = new UtilDB().GetConn();
                verify = true;
            }
        ConfigPlacement config = new ConfigPlacement();
        config.setNature(this.getIdentite());
        config.setBanque(this.getIdbanque());
        ConfigPlacement[] listConf =(ConfigPlacement[]) CGenUtil.rechercher(config, null, null,conn,"");
        if(listConf.length!=0)
            return listConf[0];
        return null;
        }catch(Exception e){
            e.printStackTrace();
            throw e;
        }finally{
            if(conn!=null && verify)conn.close();
        }
    }
}
