/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.allosakafo.fin;

import bean.CGenUtil;
import bean.ClassEtat;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.UtilDB;

/**
 *
 * @author Joe
 */
public class OrdreDePaiement extends ClassEtat{
 
    private String id, ded_id, idligne,remarque, modepaiement;
    private double montant;
    private Date daty;

    public String getModepaiement() {
        return modepaiement;
    }

    public void setModepaiement(String modepaiement) {
        this.modepaiement = modepaiement;
    }

    public String getDed_id() {
        return ded_id;
    }

    public void setDed_id(String ded_id) {
        this.ded_id = ded_id;
    }

    public String getIdligne() {
        return idligne;
    }

    public void setIdligne(String idligne) {
        this.idligne = idligne;
    }

    public OrdreDePaiement() {
        this.setNomTable("AS_ORDONNERPAYEMENT");
    }
    
    
    public String getTuppleID() {
        return id;
    }

    public String getAttributIDName() {
        return "id";
    }

    public void construirePK(Connection c) throws Exception {
        this.preparePk("ORPR", "getSeqAsOrdrePaiement");
        this.setId(makePK(c));
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
	
    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
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
    
    
}
