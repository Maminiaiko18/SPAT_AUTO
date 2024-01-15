/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassEtat;
import data.FactureFData;
import java.sql.Connection;

/**
 *
 * @author Valiah Karen
 */
public class RegulFFBP extends ClassEtat {

    private String id, idbp, idff;

    private double montant;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdbp() {
        return idbp;
    }

    public void setIdbp(String idbp) {
        this.idbp = idbp;
    }

    public String getIdff() {
        return idff;
    }

    public void setIdff(String idff) {
        this.idff = idff;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public RegulFFBP() {
        this.setNomTable("regulFFBP");
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

  /*  public void regulariserFFBP(String u, Connection c) throws Exception {
        FactureFData factData = new FactureFData();
        factData.initData(this.getIdbp());
        if (this.getMontant() > factData.getMontantTP()) {
            throw new Exception("Trop percu bon provisoire inférieur au montant de la facture");
        }
    }
*/
}
