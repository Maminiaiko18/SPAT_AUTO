/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fin;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author Sanda
 */
public class Coursdevise extends ClassMAPTable {
    
    private String id;
    private String iddevise;
    private double montant;
    private Date daty;
    private String estMICTSL;

    public String getEstMICTSL() {
        return estMICTSL;
    }

    public void setEstMICTSL(String estMICTSL) {
        this.estMICTSL = estMICTSL;
    }
    private String estMICTSLlib;

    public String getEstMICTSLlib() {
        return estMICTSLlib;
    }

    public void setEstMICTSLlib(String estMICTSLlib) {
        this.estMICTSLlib = estMICTSLlib;
    }

    public Coursdevise() {
        this.setNomTable("coursdevise");
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIddevise() {
        return iddevise;
    }

    public void setIddevise(String iddevise) {
        this.iddevise = iddevise;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
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
    
    public void construirePK(Connection c) throws Exception {
        this.preparePk("CD", "get_seq_coursdevise");
        this.setId(makePK(c));
    }

    
}
