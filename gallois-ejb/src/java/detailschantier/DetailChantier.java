/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package detailschantier;

import bean.ClassEtat;
import java.sql.Connection;

/**
 *
 * @author rasol
 */
public class DetailChantier  extends ClassEtat{
    private String id, mere, idelement;
    private double qte, pu;

    public DetailChantier() {
        this.setNomTable("DetailChantier");
    }
    
    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
    public void construirePK(Connection c) throws Exception{
        this.preparePk("det", "getseqdetailchantier");
        this.setId(makePK(c));
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getMere() {
        return mere;
    }

    public void setMere(String mere) {
        this.mere = mere;
    }

    public String getIdelement() {
        return idelement;
    }

    public void setIdelement(String idelement) {
        this.idelement = idelement;
    }

    public double getQte() {
        return qte;
    }

    public void setQte(double qte) {
        this.qte = qte;
    }

    public double getPu() {
        return pu;
    }

    public void setPu(double pu) {
        this.pu = pu;
    }
}
