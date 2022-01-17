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
import mg.spat.placement.PlacementLibComplet;
import utilitaire.UtilDB;

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

    @Override
    public Object validerObject(String u, Connection c) throws Exception {
        checkDoublonRemboursement(c);
        echu(c);
        return super.validerObject(u, c); 
    }

    private void echu(Connection c) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
    public ConfigPlacement getConfigPlacement(Connection conn,PlacementLibComplet pl)throws Exception {
        boolean verify = false;
        try{
            if(conn==null){
                conn = new UtilDB().GetConn();
                verify = true;
            }
        ConfigPlacement config = new ConfigPlacement();
        config.setNature(pl.getIdentite());
        config.setBanque(pl.getIdbanque());
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
