/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.CGenUtil;
import bean.ClassMAPTable;
import java.sql.Connection;
import mg.spat.JournalCaisse;
import utilitaire.UtilDB;

public class PaiementFacture extends ClassMAPTable{
    private String id;
    private String idMvt;
    private String idFact;
    private double montant;

    public PaiementFacture() {
        this.setNomTable("paiementFacture");
    }

    public PaiementFacture(String id, String idMvt, String idFact, double montant) {
        this.id = id;
        this.idMvt = idMvt;
        this.idFact = idFact;
        this.montant = montant;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdMvt() {
        return idMvt;
    }

    public void setIdMvt(String idMvt) {
        this.idMvt = idMvt;
    }

    public String getIdFact() {
        return idFact;
    }

    public void setIdFact(String idFact) {
        this.idFact = idFact;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }
    
    @Override
    public String getTuppleID() {return id;}

    @Override
    public String getAttributIDName() {return "id";}

    public FactureClient getFacture(Connection c) throws Exception{
        int verif = 0;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            FactureClient fc = new FactureClient();
            fc.setNomTable("factureclient");
            String awhere = String.format(" and id = '%s' ", this.getIdFact());
            FactureClient[] result = (FactureClient[])CGenUtil.rechercher(fc, null, null, c, awhere);
            if(result != null && result.length > 0) 
                return result[0];
            return null;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    public JournalCaisse getpayement(Connection c) throws Exception{
        int verif = 0;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                verif = 1;
            }
            JournalCaisse jc = new JournalCaisse();
            jc.setNomTable("journalcaisse");
            String awhere = String.format(" and id = '%s' ", this.getIdMvt());
            JournalCaisse[] result = (JournalCaisse[])CGenUtil.rechercher(jc, null, null, c, awhere);
            if(result != null && result.length > 0) 
                return result[0];
            return null;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    
}
