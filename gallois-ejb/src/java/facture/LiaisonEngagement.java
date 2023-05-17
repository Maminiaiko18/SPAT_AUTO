/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.ClassEtat;
import java.sql.Connection;

/**
 *
 * @author Itokiana
 */
public class LiaisonEngagement extends ClassEtat {
    
    private String id, id1, id2;
    private double montant;

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getId1() {
        return id1;
    }

    public void setId1(String id1) {
        this.id1 = id1;
    }

    public String getId2() {
        return id2;
    }

    public void setId2(String id2) {
        this.id2 = id2;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public LiaisonEngagement() {
        this.setNomTable("liaisonengagement");
    }
    
    public void construirePK(Connection c) throws Exception {
        this.preparePk("LIE", "getseqliaisonengagement");
        this.setId(makePK(c));
    }
}
