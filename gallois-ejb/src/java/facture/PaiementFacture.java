/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.AdminGen;
import bean.CGenUtil;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import mg.spat.JournalCaisse;
import utilitaire.UtilDB;

public class PaiementFacture extends ClassMAPTable{
    private String id;
    private String idMvt;
    private String idFact;
    private double montant;
    private String code;
    private Date daty;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public PaiementFacture() {
        this.setNomTable("paiementFacture");
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("PFACT", "get_seq_paiementFacture");
        setId(makePK(c));
    }

    public PaiementFacture(String id, String idMvt, String idFact, double montant) {
        this.setNomTable("paiementFacture");
        setId(id);
        setIdMvt(idMvt);
        setIdFact(idFact);
        setMontant(montant);
    }
    public PaiementFacture(String nomtable,String id, String idMvt, String idFact, double montant) {
        this.setNomTable(nomtable);
        setId(id);
        setIdMvt(idMvt);
        setIdFact(idFact);
        setMontant(montant);
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
            //fc.setNomTable("factureclient");
            fc.setNomTable("facture_client_union");
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
    public double getMontantFactures(JournalCaisse jc,Connection c)throws Exception {
        int verif = 0;
        double retour=0;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                verif = 1;
            }
            if(jc!=null){
                PaiementFacture[] pf=jc.getPayementFacture(c); //factures hors provision ity
                if(pf.length>0)retour=AdminGen.calculSommeDouble(pf, "montant");
            }
            return retour;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
        
    }
    public void controler(Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                verif = 1;
            }
            FactureClient fc = this.getFacture(c);
            if(fc!=null && fc.getMontantreste()<this.getMontant()) throw new Exception("RAP facture inferieur au montant saisi");
        
            JournalCaisse jc=this.getpayement(c); 
            double montantFactures=this.getMontantFactures(jc,c);
            if(this.getNomTable().equalsIgnoreCase("paiementfacture") && montantFactures+this.getMontant()>jc.getCredit()) throw new Exception("Le montant depasse. Montant factures ="+montantFactures+", montant inséré="+this.getMontant()+", montant journal="+jc.getCredit()); //tsy maintsy micomparer nomtable satria ity classe ity ihany no ampiasain'ny fournisseur donc diso ilay getCredit
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    
}
