/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.placement;

import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author Asus
 */
public class DetailsPlacements extends ClassMAPTable{

    private String id , idmere ,mois;
    private double montant_terme,interet_recevoir,interet_net;

    public DetailsPlacements() {
         super.setNomTable("detailsplacement");
    }

    public DetailsPlacements(String idMere, String mois, double montant_terme, double interet_recevoir, double interet_net) throws Exception {
        super.setNomTable("detailsplacement");
        this.setIdmere(idMere);
        this.setMois(mois);
        this.setMontant_terme(montant_terme);
        this.setInteret_recevoir(interet_recevoir);
        this.setInteret_net(interet_net);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdmere() {
        return idmere;
    }

    public void setIdmere(String idmere) {
        this.idmere = idmere;
    }

    public String getMois() {
        return mois;
    }

    public void setMois(String mois) {
        this.mois = mois;
    }

    public double getMontant_terme() {
        return montant_terme;
    }

    public void setMontant_terme(double montant_terme) throws Exception{
        if(montant_terme < 0){
            throw new Exception("montant terme negatif");
        }
        this.montant_terme = montant_terme;
    }

    public double getInteret_recevoir() {
        return interet_recevoir;
    }

    public void setInteret_recevoir(double interet_recevoir)throws Exception {
        if(interet_recevoir < 0){
            throw new Exception("interet recevoir negatif");
        }
        this.interet_recevoir = interet_recevoir;
    }

    public double getInteret_net() {
        return interet_net;
    }

    public void setInteret_net(double interet_net) throws Exception{
        if(interet_net < 0){
            throw new Exception("interet net negatif");
        }
        this.interet_net = interet_net;
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
         this.preparePk("DPL", "getseqdetailsplacement");
        this.setId(makePK(c));
        
    }
    
    
}
