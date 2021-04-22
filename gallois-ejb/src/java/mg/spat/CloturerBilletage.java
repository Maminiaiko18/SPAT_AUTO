/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import service.ClotureService;

/**
 *
 * @author john
 */
public class CloturerBilletage extends ClassMAPTable {
    private String id, caisse, remarque;
    private double solde;
    private Date daty;
    
    public CloturerBilletage() {
        super.setNomTable("cloturerbilletage");
    }
    
     public void construirePK(Connection c) throws Exception {
        this.preparePk("CLOB", "getseqclotureBillet");
        this.setId(makePK(c));
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCaisse() {
        return caisse;
    }

    public void setCaisse(String caisse) {
        this.caisse = caisse;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public double getSolde() {
        return solde;
    }

    public void setSolde(double solde) throws Exception {
         if (getMode().compareToIgnoreCase("modif") == 0) {
            if (solde < 0) {
               throw new Exception("solde invalide");
            } 
        }
        this.solde = solde;
    }
    
    public void controler(Connection c) throws Exception{
        try{
            this.solde = ClotureService.getMontantBilletage(this.daty, this.caisse, c);
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
