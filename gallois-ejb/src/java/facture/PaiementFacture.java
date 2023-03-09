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
import utilitaire.Constante;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

public class PaiementFacture extends ClassMAPTable{
    private String id;
    private String idMvt;
    private String idFact;
    private double montant;
    private String code;
    private Date daty;
    private FactureClient facture;
    private String designation;
    private String numFact;
    private String idProvision;

    public void setIdProvision(String idProvision){
        this.idProvision=idProvision;
    }
    public String getIdProvision(){
        return this.idProvision;
    }

    public void setNumFact(String numFact){
        this.numFact=numFact;
    }
    public String getNumFact(){
        return this.numFact;
    }

    public void setDesignation(String designation){
        this.designation=designation;
    }
    public String getDesignation(){
        return this.designation;
    }

    
    public FactureClient getFacture() {
        return facture;
    }

    public void setFacture(FactureClient facture) {
        this.facture = facture;
    }

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

    public PaiementFacture(String idMvt,String idFact,double montant){
        this.setNomTable("paiementFacture");
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
            FactureClient fc = this.getFacture();
            if(fc==null)fc = this.getFacture(c);
            if(fc!=null){
                if(fc.getMontantreste() * this.getMontant() < 0){
                    throw new Exception("Opération non autorisée");
                }
                if(Math.abs((float)fc.getMontantreste()) - Math.abs((float)this.getMontant()) < -0.000001){
                    throw new Exception("Reste a payer facture inferieur au montant saisi");
                }
            }
            JournalCaisse jc=this.getpayement(c); 
            double montantFactures=this.getMontantFactures(jc,c);
            if(this.getNomTable().equalsIgnoreCase("paiementfacture") && Double.valueOf(Utilitaire.enleverExponentielleDouble(montantFactures+this.getMontant()))>Double.valueOf(Utilitaire.enleverExponentielleDouble(jc.getCredit()))) {
                throw new Exception("Le montant depasse. Montant factures ="+montantFactures+", montant inséré="+this.getMontant()+", montant journal="+jc.getCredit()); //tsy maintsy micomparer nomtable satria ity classe ity ihany no ampiasain'ny fournisseur donc diso ilay getCredit
            }

            if(jc.getNumPiece()==null) {
                jc.setNumPiece(jc.calculerNumeroPiece(c));
                jc.updateToTable(c);
            }

            //if(fc==null) throw new Exception("Veuillez choisir une facture");
            //if(jc!=null && fc!=null && !jc.getTiers().equals(fc.getTiers()))throw new Exception("Tiers differents pour le journal caisse et la facture");
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    
    public static void genererPaiementFacture(PaiementFacture[] listePaiement,String refUser)throws Exception{
        Connection c = null;
        try{
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            
            for(int i=0;i<listePaiement.length;i++){
                for(int j=0;j<i;j++){
                    if(listePaiement[j].getIdFact().equals(listePaiement[i].getIdFact())){
                        throw new Exception("Facture dupliquee");
                    }
                }
                listePaiement[i].setNomTable("PaiementFacture");
                listePaiement[i].createObject(refUser,c);
            }
            c.commit();
        }catch(Exception e){
            if(c!=null)c.rollback();
            e.printStackTrace();
            throw e;
        }finally{
            if(c!=null)c.close();
        }
    }
    
    public static void genererPaiementFacture(PaiementFacture[] listePaiement,String refUser, String idmvt)throws Exception{
        Connection c = null;
        try{
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            double montantFacture = AdminGen.calculSommeDouble(listePaiement, "montant");
            JournalCaisse journal = new JournalCaisse();
            journal.setId(idmvt);
            JournalCaisse[] journals = (JournalCaisse[])CGenUtil.rechercher(journal, null, null, c, "");
            if(journals.length<1) throw new Exception("Le Piece Caisse que vous avez choisi n'existe pas!");
            
            if(journals[0].getEtat()<ConstanteEtat.getEtatValider()) throw new Exception("Piece de Caisse pas encore valider!");
            if(journals[0].getCredit()!=montantFacture) throw new Exception("La somme du montant des Factures Choisies doit etre egale au montant du Piece de Caisse!");
            for(int i=0;i<listePaiement.length;i++){
                for(int j=0;j<i;j++){
                    if(listePaiement[j].getIdFact().equals(listePaiement[i].getIdFact())){
                        throw new Exception("Facture dupliquee");
                    }
                }
                
                listePaiement[i].setIdMvt(idmvt);
                listePaiement[i].setNomTable("PaiementFacture");
                listePaiement[i].createObject(refUser,c);
            }
            c.commit();
        }catch(Exception e){
            if(c!=null)c.rollback();
            e.printStackTrace();
            throw e;
        }finally{
            if(c!=null)c.close();
        }
    }
    
}
