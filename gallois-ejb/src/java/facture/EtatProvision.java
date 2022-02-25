/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.CGenUtil;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.UtilDB;

/**
 *
 * @author Andriamiary
 */
public class EtatProvision extends ClassMAPTable {
    private String id;
    private double montantfacture, montantprovision, ecart,montantpaye,montantreste;
    private String tiers,tierslib;
    private Date daty;
    private String numpiece;
    private String numProvision;
    private String operation;
    private String idnavire, idnavirelib;
    private String idmode, idmodelib;
    private String idbanque, idbanquelib;
    private String idFacture, idFacturelib;
    private String idprovision;
    private String code ;
    
    public EtatProvision(){ 
        this.setNomTable("etat_provision");
    }
    
    public EtatProvision(String id, double montantfacture, double montantprovision, double ecart, double montantpaye, double montantreste, String tiers, String tierslib, Date daty, String numpiece, String numProvision, String operation, String idnavire, String idnavirelib, String idmode, String idmodelib, String idbanque, String idbanquelib, String idFacture, String idFacturelib) {
        this.setNomTable("etat_provision");
        this.setId(id);
        this.setMontantfacture(montantfacture);
        this.setMontantprovision(montantprovision);
        this.setEcart(ecart);
        this.setMontantpaye(montantpaye);
        this.setMontantreste(montantreste);
        this.setTiers(tiers);
        this.setTierslib(tierslib);
        this.setDaty(daty);
        this.setNumpiece(numpiece);
        this.setNumProvision(numProvision);
        this.setOperation(operation);
        this.setIdnavire(idnavire);
        this.setIdnavirelib(idnavirelib);
        this.setIdmode(idmode);
        this.setIdmodelib(idmodelib);
        this.setIdbanque(idbanque);
        this.setIdbanquelib(idbanquelib);
        this.setIdFacture(idFacture);
        this.setIdFacturelib(idFacturelib);
    }

    public EtatProvision(String id, double montantfacture, double montantprovision, double ecart, double montantpaye, String tiers, String tierslib, Date daty, String numpiece, String numProvision, String operation, String idnavire, String idnavirelib, String idmodelib, String idmode, String idbanque, String idbanquelib, String idFacture) {
        this.id = id;
        this.montantfacture = montantfacture;
        this.montantprovision = montantprovision;
        this.ecart = ecart;
        this.montantpaye = montantpaye;
        this.tiers = tiers;
        this.tierslib = tierslib;
        this.daty = daty;
        this.numpiece = numpiece;
        this.numProvision = numProvision;
        this.operation = operation;
        this.idnavire = idnavire;
        this.idnavirelib = idnavirelib;
        this.idmodelib = idmodelib;
        this.idmode = idmode;
        this.idbanque = idbanque;
        this.idbanquelib = idbanquelib;
        this.idFacture = idFacture;
    }
    
    public EtatProvision(String id, double montantfacture, double montantprovision, double ecart, double montantpaye) {
        this.id = id;
        this.montantfacture = montantfacture;
        this.montantprovision = montantprovision;
        this.ecart = ecart;
        this.montantpaye = montantpaye;
    } 

    public EtatProvision(String id, double montantfacture, double montantprovision, double ecart, double montantpaye, String tierslib, Date daty) {
        this.id = id;
        this.montantfacture = montantfacture;
        this.montantprovision = montantprovision;
        this.ecart = ecart;
        this.montantpaye = montantpaye;
        this.tierslib = tierslib;
        this.daty = daty;
    }
    
    public EtatProvision(String id, double montantfacture, double montantprovision, double ecart, double montantpaye, String tiers, String tierslib, Date daty) {
        this.id = id;
        this.montantfacture = montantfacture;
        this.montantprovision = montantprovision;
        this.ecart = ecart;
        this.montantpaye = montantpaye;
        this.tiers = tiers;
        this.tierslib = tierslib;
        this.daty = daty;
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("ETPROV", "get_seq_etat_provision");
        this.setId(makePK(c));
    }

    public String getIdmode() {
        return idmode;
    }

    public void setIdmode(String idmode) {
        this.idmode = idmode;
    }

    public String getIdnavire() {
        return idnavire;
    }

    public void setIdnavire(String idnavire) {
        this.idnavire = idnavire;
    }

    public String getIdbanque() {
        return idbanque;
    }

    public void setIdbanque(String idbanque) {
        this.idbanque = idbanque;
    }

    public String getIdFacturelib() {
        return idFacturelib;
    }

    public void setIdFacturelib(String idFacturelib) {
        this.idFacturelib = idFacturelib;
    }

    public String getIdFacture() {
        return idFacture;
    }

    public void setIdFacture(String idFacture) {
        this.idFacture = idFacture;
    }
    
    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }   
    public double getMontantpaye() {
        return montantpaye;
    }

    public void setMontantpaye(double montantpaye) {
        this.montantpaye = montantpaye;
    }
          
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public double getMontantfacture() {
        return montantfacture;
    }

    public void setMontantfacture(double montantfacture) {
        this.montantfacture = montantfacture;
    }

    public double getMontantprovision() {
        return montantprovision;
    }

    public void setMontantprovision(double montantprovision) {
        this.montantprovision = montantprovision;
    }

    public double getEcart() {
        return ecart;
    }

    public void setEcart(double ecart) {
        this.ecart = ecart;
    }

    @Override
    public String getTuppleID() {return id;}

    @Override
    public String getAttributIDName() {return "id";}

    public String getTierslib() {
        return tierslib;
    }

    public void setTierslib(String tierslib) {
        this.tierslib = tierslib;
    }
    
    public String getTiers() {
        return tiers;
    }

    public void setTiers(String tiers) {
        this.tiers = tiers;
    }

    public String getNumpiece() {
        return numpiece;
    }

    public void setNumpiece(String numpiece) {
        this.numpiece = numpiece;
    }

    public String getNumProvision() {
        return numProvision;
    }

    public void setNumProvision(String numProvision) {
        this.numProvision = numProvision;
    }

    public String getOperation() {
        return operation;
    }

    public void setOperation(String operation) {
        this.operation = operation;
    }

    public String getIdnavirelib() {
        return idnavirelib;
    }

    public void setIdnavirelib(String idnavirelib) {
        this.idnavirelib = idnavirelib;
    }

    public String getIdmodelib() {
        return idmodelib;
    }

    public void setIdmodelib(String idmodelib) {
        this.idmodelib = idmodelib;
    }

    public String getIdbanquelib() {
        return idbanquelib;
    }

    public void setIdbanquelib(String idbanquelib) {
        this.idbanquelib = idbanquelib;
    }
    
    public double getMontantreste() {
        return montantreste;
    }

    public void setMontantreste(double montantreste) {
        this.montantreste = montantreste;
    }
    
    public String getIdprovision() {
        return idprovision;
    }

    public void setIdprovision(String idprovision) {
        this.idprovision = idprovision;
    }
    
    public double getResteProvision(Connection c) throws Exception{
        boolean verif = false;
        try{
            if(c == null) {
                c = new UtilDB().GetConn();
                verif = true;
            }
            EtatProvision base = new EtatProvision();
            base.setNomTable("etatprovisionvrai");
            EtatProvision[] result = (EtatProvision[]) CGenUtil.rechercher(base, null, null, c, String.format(" and id = '%s' ", this.getId()));
//            EtatProvision[] result = (EtatProvision[]) CGenUtil.rechercher(base, null, null, c, String.format(" and id = '%s' ", this.getIdprovision()));
            if(result.length > 0){
                return result[0].getMontantreste();
            }
            return 0;
        } finally{
            if(c != null && verif){
                c.close();
            }
        }
    }
    public EtatProvision getEtatProvision(String nomtable,Connection c) throws Exception{
        boolean verif = false;
        try{
            if(c == null) {
                c = new UtilDB().GetConn();
                verif = true;
            }
            EtatProvision base = new EtatProvision();
            base.setNomTable(nomtable);
            EtatProvision[] result = (EtatProvision[]) CGenUtil.rechercher(base, null, null, c, String.format(" and id = '%s' ", this.getId()));
//            EtatProvision[] result = (EtatProvision[]) CGenUtil.rechercher(base, null, null, c, String.format(" and id = '%s' ", this.getIdprovision()));
            if(result.length > 0){
                return result[0];
            }
            return null;
        } finally{
            if(c != null && verif){
                c.close();
            }
        }
    }

    public FactureClient getFacture(Connection c, String nomTable) throws Exception{
        FactureClient f = new FactureClient();
        f.setNomTable(nomTable);
        FactureClient[] fc = (FactureClient[]) CGenUtil.rechercher(f, null, null, c, " and id='"+this.getIdFacture()+"'");
        if(fc.length > 0) return fc[0];
        return null;
    }
}
