/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fin;

import bean.CGenUtil;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.Utilitaire;

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
    
    public void checkDoublon(Connection c) throws Exception {
        String apresW = " and iddevise='%s' and daty='%s' and estMICTSL='%s' ";
        apresW = String.format(apresW, this.iddevise, Utilitaire.format(this.daty), this.estMICTSL);
        Coursdevise[] crs = (Coursdevise[]) CGenUtil.rechercher(new Coursdevise(), null, null, c, apresW);
        if(crs!=null && crs.length > 0){
            throw new Exception("Il existe deja un cours pour cette date");
        }
    }
    public static Coursdevise[] getCours(Connection c, String dat) throws Exception
    {
        String apresW = "  and daty='%s' ";
        apresW = String.format(apresW,  dat);
        return (Coursdevise[]) CGenUtil.rechercher(new Coursdevise(), null, null, c, apresW);
    }
    public static Coursdevise[] getCours(Connection c, String dat,String estMicT) throws Exception
    {
        String apresW = "  and daty='%s'  and estMICTSL='%s' ";
        apresW = String.format(apresW,  dat,estMicT);
        return (Coursdevise[]) CGenUtil.rechercher(new Coursdevise(), null, null, c, apresW);
    }
    
    @Override
    public void controler(Connection c) throws Exception {
        this.checkDoublon(c);
    }

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
