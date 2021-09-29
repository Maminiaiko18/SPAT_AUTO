/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import avoir.AvoirFC;
import avoir.AvoirFCFille;
import bean.CGenUtil;
import bean.ClassEtat;
import ded.OrdonnerPayement;
import java.sql.Connection;
import mg.spat.JournalCaisse;
import utilitaire.Constante;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;
/**
 *
 * @author rijan
 */
public class RegulFCProvision extends ClassEtat{
    
    private String id, idProvision,idFacture,idProvisionCode,idFactureCode;
    private int etat;
    private String etatlib;
    double resteProvision ;
    
    public RegulFCProvision(String id, String idProvision, String idFacture, String idProvisionCode, String idFactureCode, int etat ,String etatlib, double resteProvision) {
        this.setNomTable("regulFCProvision");
        this.setId(id);
        this.setIdProvision(idProvision);
        this.setIdFacture(idFacture);
        this.setIdProvisionCode(idProvisionCode);
        this.setIdFactureCode(idFactureCode);
        this.setEtat(etat);
        this.setEtatlib(etatlib);
        this.setResteProvision(resteProvision);
    }
    
    public RegulFCProvision(){ 
        this.setNomTable("regulFCProvision");
    }
    
    public double getResteProvision() {
        return resteProvision;
    }

    public void setResteProvision(double resteProvision) {
        this.resteProvision = resteProvision;
    }
    
    public String getEtatlib() {
        return etatlib;
    }

    public void setEtatlib(String etatlib) {
        this.etatlib = etatlib;
    }


    public int getEtat() {
        return etat;
    }

    public void setEtat(int etat) {
        this.etat = etat;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdProvision() {
        return idProvision;
    }

    public void setIdProvision(String idProvision) {
        this.idProvision = idProvision;
    }

    public String getIdFacture() {
        return idFacture;
    }

    public void setIdFacture(String idFacture) {
        this.idFacture = idFacture;
    }

    public String getIdProvisionCode() {
        return idProvisionCode;
    }

    public void setIdProvisionCode(String idProvisionCode) {
        this.idProvisionCode = idProvisionCode;
    }

    public String getIdFactureCode() {
        return idFactureCode;
    }

    public void setIdFactureCode(String idFactureCode) {
        this.idFactureCode = idFactureCode;
    }
    
    public void construirePK(Connection c) throws Exception{
        this.preparePk("RFP", "get_seq_regulFCProvision");
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
    
    public FactureClient getFacture(Connection c, String id)throws Exception{
        int verif = 0;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            FactureClient cc = new FactureClient();
            cc.setNomTable("facture_client_union");
            String awhere = String.format(" and id = '%s' ", id);
            FactureClient[] result = (FactureClient[]) CGenUtil.rechercher(cc, null, null, c, awhere);
            if (result != null && result.length > 0) {
                return result[0];
            }            
            return null;
        } catch(Exception ex) {
            throw ex;
        }  finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }            
    }    
    
    @Override
    public void controler(Connection c) throws Exception {
        FactureClient pr = getFacture(c, getIdProvision());
        if(pr.getEtat() < ConstanteEtat.getEtatValider()){
            throw new Exception("Provision non visee");
        }
        FactureClient fc = getFacture(c, getIdFacture());
        if(fc.getEtat() < ConstanteEtat.getEtatValider()){
            throw new Exception("Facture non visee");
        }
    }
    
    public double getResteProvision(Connection c) throws Exception {
        EtatProvision etatP = new EtatProvision();
        etatP.setId(getIdProvision());
        return etatP.getResteProvision(c);
    }
    
    private void genererSortie(AvoirFC avoir, String u, Connection c) throws Exception {
        OrdonnerPayement op = avoir.genererOP(c);
        op.createObject(u, c);
        op.validerObject(u, c);

        String libelle = "Regul Facture Avoir " + this.getId();
        JournalCaisse jc = new JournalCaisse(null, Constante.caisseCentrale,
                null, libelle, null, avoir.getTiers(), Constante.typeCheque,
                Utilitaire.dateDuJourSql(), Utilitaire.dateDuJourSql(), avoir.getMontant(), 0);
        jc.setIdplacement(avoir.getIdfacture());
        jc.setIddevise(Constante.deviseAr);
        jc.createObject(u, c);
        jc.validerObject(u, c);

        PaiementFacture paiement = new PaiementFacture(null, jc.getId(), avoir.getIdfacture(), -avoir.getMontant());
        paiement.createObject(u, c);
    }
    
    private void genererEntree(AvoirFC avoir, String u, Connection c) throws Exception {
        String libelle = "Regul Facture Avoir " + this.getId();
        JournalCaisse jc = new JournalCaisse(null, Constante.caisseCentrale,
                null, libelle, null, avoir.getTiers(), Constante.typeCheque,
                Utilitaire.dateDuJourSql(), Utilitaire.dateDuJourSql(), 0, avoir.getMontant());
        jc.setIdplacement(this.getIdFacture());
        jc.setIddevise(Constante.deviseAr);
        jc.createObject(u, c);
        jc.validerObject(u, c);
        
        PaiementFacture paiementFact = new PaiementFacture(null, jc.getId(), this.getIdFacture(), avoir.getMontant());
        paiementFact.createObject(u, c);
    }
    
    public AvoirFC genererAvoir(String user, Connection c, double montant)throws Exception{
        int verif = 0;
        AvoirFC avoir = null;
        
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            
            avoir = new AvoirFC();
            
            String designation = "Avoir auto regul provision " + this.getIdProvision();
            avoir.setDaty(utilitaire.Utilitaire.dateDuJourSql());
            avoir.setDesignation(designation);
            avoir.setIdfacture(this.getIdProvision());
            avoir.setCategorie(Constante.categorieAvoirFC);
            avoir.setType(Constante.typeAvoirFC);
            avoir.setMotif(Constante.motifAvoirFC);
            
            avoir.createObject(user, c);
            
            AvoirFCFille fille = new AvoirFCFille();
            fille.setIdmere(avoir.getId());
            fille.setMontant(montant);
            
            fille.createObject(user, c);
            
            if(verif == 1) c.commit();
        } 
        catch(Exception ex) {
            if(c != null && verif == 1) c.rollback();
            throw ex;
        }
        finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }    

        return avoir;
    }  
}
