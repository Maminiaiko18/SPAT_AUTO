/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package facture;

import bean.AdminGen;
import bean.CGenUtil;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import utilitaire.UtilDB;

/**
 *
 * @author bruel
 */
public class EtatFacture extends ClassMAPTable {
    
    private String tiers, type, tierslib, typelib;
    private List<FactureClient> factures= new ArrayList<>();

    public EtatFacture() {
    }

    public EtatFacture(String tiers, String type, String tierslib, String typelib) {
        this.tiers = tiers;
        this.type = type;
        this.tierslib = tierslib;
        this.typelib = typelib;
    }
    
    public String getTiers() {
        return tiers;
    }

    public void setTiers(String tiers) {
        this.tiers = tiers;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTierslib() {
        return tierslib;
    }

    public void setTierslib(String tierslib) {
        this.tierslib = tierslib;
    }

    public String getTypelib() {
        return typelib;
    }

    public void setTypelib(String typelib) {
        this.typelib = typelib;
    }

    public double getTotalmontant() {
        double totalmontant = AdminGen.calculSommeDouble(this.getFactures().toArray(new FactureClient[0]), "montant");
        return totalmontant;
    }

    public double getTotalmontantregl() {
        double totalmontantregl = AdminGen.calculSommeDouble(this.getFactures().toArray(new FactureClient[0]), "montantpaye");
        return totalmontantregl;
    }

    public double getTotalmontnatrap() {
        double totalmontnatrap = AdminGen.calculSommeDouble(this.getFactures().toArray(new FactureClient[0]), "montantreste");
        return totalmontnatrap;
    }

    public double getTotalmontantprov() {
        double totalmontantprov = AdminGen.calculSommeDouble(this.getFactures().toArray(new FactureClient[0]), "montantprov");
        return totalmontantprov;
    }

    public double getTotalmontantavoir() {
        double totalmontantavoir = AdminGen.calculSommeDouble(this.getFactures().toArray(new FactureClient[0]), "montantavoir");
        return totalmontantavoir;
    }


    public List<FactureClient> getFactures() {
        return factures;
    }

    public void setFactures(List<FactureClient> factures) {
        this.factures = factures;
    }
    
    public static HashMap<String, EtatFacture> getListeFactureEmise(String tiers, String tierslib, String etat, String dateMin, String dateMax,Connection c)throws Exception{
        
        tiers = tiers==null || tiers.compareToIgnoreCase("null")==0 || tiers.compareToIgnoreCase("")==0 ? "%" : tiers;
        tierslib = tierslib==null || tierslib.compareToIgnoreCase("null")==0 || tierslib.compareToIgnoreCase("")==0 || tiers != null ? "%" : tierslib;
        HashMap<String, EtatFacture> resp = new HashMap<>();
        boolean estOuvert = false;
        if(c==null){
            c = new UtilDB().GetConn();
            estOuvert = true;
        }
        FactureClient fc = new FactureClient();
        fc.setNomTable(etat);
        try{
            String aWhere = " AND daty>=TO_DATE('"+dateMin+"','DD/MM/YYYY') AND daty<=TO_DATE('"+dateMax+"','DD/MM/YYYY') AND TIERS like '"+tiers+"' and tierslib like '"+tierslib+"'";
            FactureClient[] factures = (FactureClient[]) CGenUtil.rechercher(fc, null, null, c, aWhere);
            if(factures.length>0){
                EtatFacture etatFacture = new EtatFacture(factures[0].getTiers(), factures[0].getTierslib(), factures[0].getType(), factures[0].getTypelib());
                resp.put(factures[0].getTiers(), etatFacture);
                for(FactureClient facture : factures){
                    int find = 0;
                    for(Map.Entry mapentry: resp.entrySet()){
                        if(((String)mapentry.getKey()).compareTo(facture.getTiers())==0){
                            ((EtatFacture)mapentry.getValue()).addEtatFacture(facture);
                            find = 1;
                            break;
                        }
                    }
                    if(find == 0){
                        EtatFacture etatFactureManaraka = new EtatFacture(facture.getTiers(), facture.getTierslib(), facture.getType(), facture.getTypelib());
                        resp.put(facture.getTiers(), etatFactureManaraka);
                    }
                }
            }
        } catch(Exception e){
            e.printStackTrace();
            throw e;
        }
        finally{
            if(estOuvert && c!=null) c.close();
        }
        return resp;
    }
    
    public void addEtatFacture(FactureClient facture){
        this.getFactures().add(facture);
    }
    
    
    @Override
    public String getTuppleID() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public String getAttributIDName() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
}
