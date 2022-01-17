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
import mg.spat.placement.Placement;

/**
 *
 * @author Nouta
 */
public class RemboursementPlacement extends ClassEtat{
    private String id,idplacement,caisse,entite,banque,caisselib;
    private double montantplace,interet;
    private Date daty;
    
    
    public void checkDoublonRemboursement(Connection c) throws Exception{
        RemboursementPlacement rembourcement =new RemboursementPlacement();
        rembourcement.setNomTable("remboursementplacementV");
        RemboursementPlacement[] liste = (RemboursementPlacement[]) CGenUtil.rechercher(rembourcement, null, null,c, " and idplacement='" + this.getIdplacement() + "'");
        if(liste.length>0){
            throw new Exception("Remboursement Placement deja enregistre");
        }
    }
    public RemboursementPlacement() {
        super.setNomTable("remboursementPlacement");
    }

    public String getEntite() {
        return entite;
    }

    public void setEntite(String entite) {
        this.entite = entite;
    }

    public String getBanque() {
        return banque;
    }

    public void setBanque(String banque) {
        this.banque = banque;
    }

    public String getCaisselib() {
        return caisselib;
    }

    public void setCaisselib(String caisselib) {
        this.caisselib = caisselib;
    }
    

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdplacement() {
        return idplacement;
    }

    public void setIdplacement(String idplacement) {
        this.idplacement = idplacement;
    }

    public String getCaisse() {
        return caisse;
    }

    public void setCaisse(String caisse) {
        this.caisse = caisse;
    }

    public double getMontantplace() {
        return montantplace;
    }

    public void setMontantplace(double montantplace) {
        this.montantplace = montantplace;
    }

    public double getInteret() {
        return interet;
    }

    public void setInteret(double interet) {
        this.interet = interet;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
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
        preparePk("CR","GETSEQREMBOURSEMENTPLACEMENT");
        setId(makePK(c));
    }
    public Placement findPlacement(Connection c) throws Exception{
        try{
        Placement p = new Placement();
        Placement[] liste = (Placement[]) CGenUtil.rechercher(p, null, null,c, " and id='" + this.getIdplacement() + "'");
        if(liste.length!=0){
            return liste[0];
        }
        return null;
        }catch(Exception e){
            e.printStackTrace();
        }
        return null;
    }
    
}
