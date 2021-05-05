/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facturefournisseur;

import bean.CGenUtil;
import java.sql.Connection;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author Sanda
 */
public class EtatFactureMontantDaty extends EtatFacture{
    private double montantAvoir, montantAdditif, montantTotalApayer,montanttva,montant;
    private String typefacture,type,tierslib;

    private String code_etablissement,projet,numid,etatlib;

    public String getCode_etablissement() {
        return code_etablissement;
    }

    public void setCode_etablissement(String code_etablissement) {
        this.code_etablissement = code_etablissement;
    }

    public String getProjet() {
        return projet;
    }

    public void setProjet(String projet) {
        this.projet = projet;
    }

    public String getNumid() {
        return numid;
    }

    public void setNumid(String numid) {
        this.numid = numid;
    }
    
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTypefacture() {
        return typefacture;
    }

    public void setTypefacture(String typefacture) {
        this.typefacture = typefacture;
    }
    
    public EtatFactureMontantDaty[] getByIds(String[] ids, Connection c) throws Exception {
        int verif = 0;
        EtatFactureMontantDaty[] factures = new EtatFactureMontantDaty[0];
                
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            
            EtatFactureMontantDaty f = new EtatFactureMontantDaty();
            String in = Utilitaire.tabToString(ids, "'", ",");
            
            factures = (EtatFactureMontantDaty[]) CGenUtil.rechercher(f, null, null, c, " and id in (" + in + ")");
            
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
        
        return factures;
    }
    
    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public double getMontanttva() {
        return montanttva;
    }

    public void setMontanttva(double montanttva) {
        this.montanttva = montanttva;
    }
    
    @Override
    public void setEtat(String etat) {
        super.setEtat(getEtatText(etat));
    }
    
    public EtatFactureMontantDaty()
    {
        this.setNomTable("EtatFactureMontantDaty");
    }

    public double getMontantAvoir() {
        return montantAvoir;
    }

    public void setMontantAvoir(double montantAvoir) {
        this.montantAvoir = montantAvoir;
    }

    public double getMontantAdditif() {
        return montantAdditif;
    }

    public void setMontantAdditif(double montantAdditif) {
        this.montantAdditif = montantAdditif;
    }

    public double getMontantTotalApayer() {
        return montantTotalApayer;
    }

    public void setMontantTotalApayer(double montantTotalApayer) {
        this.montantTotalApayer = montantTotalApayer;
    }

    public String getEtatlib() {
        return etatlib;
    }

    public void setEtatlib(String etatlib) {
        this.etatlib = etatlib;
    }

    public String getTierslib() {
        return tierslib;
    }

    public void setTierslib(String tierslib) {
        this.tierslib = tierslib;
    }
    
}