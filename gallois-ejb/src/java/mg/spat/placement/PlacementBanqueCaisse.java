/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package mg.spat.placement;

import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author Valiah Karen
 */
public class PlacementBanqueCaisse extends ClassMAPTable {

    private String id, val, desce, banquelib, caisselib;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getVal() {
        return val;
    }

    public void setVal(String val) {
        this.val = val;
    }

    public String getDesce() {
        return desce;
    }

    public void setDesce(String desce) {
        this.desce = desce;
    }

    public String getBanquelib() {
        return banquelib;
    }

    public void setBanquelib(String banquelib) {
        this.banquelib = banquelib;
    }

    public String getCaisselib() {
        return caisselib;
    }

    public void setCaisselib(String caisselib) {
        this.caisselib = caisselib;
    }

    public PlacementBanqueCaisse() {
        this.setNomTable("PLACEMENT_BANQUE_CAISSE");
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("BQCA", "getseqbqca");
        this.setId(makePK(c));
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
