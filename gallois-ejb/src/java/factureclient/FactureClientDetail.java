/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package factureclient;

import bean.CGenUtil;
import bean.ClassEtat;
import java.sql.Connection;
import rubrique.RubriqueFactureFournisseur;
import user.UserEJB;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author rasol
 */
public class FactureClientDetail extends ClassEtat{
    private String id, designation, remarque, idfacture, comptedebit, comptecredit, analdebit, analcredit, idacte, medicament;
    private double quantite, montant, montantt, montantremise;

    public FactureClientDetail() {
        this.setNomTable("facture_client_detail");
    }
    
    public RubriqueFactureFournisseur getRubrique(Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            
            RubriqueFactureFournisseur[] tmp = (RubriqueFactureFournisseur[]) CGenUtil.rechercher(new RubriqueFactureFournisseur(), null, null, c, " and designation = '" + this.getMedicament() + "'");
            if(tmp != null && tmp.length > 0) return tmp[0];
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
        
        return null;
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
        this.preparePk("FCD", "getseqfactureclientdetails");
        this.setId(makePK(c));
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public String getIdfacture() {
        return idfacture;
    }

    public void setIdfacture(String idfacture) {
        this.idfacture = idfacture;
    }

    public String getComptedebit() {
        return comptedebit;
    }

    public void setComptedebit(String comptedebit) {
        this.comptedebit = comptedebit;
    }

    public String getComptecredit() {
        return comptecredit;
    }

    public void setComptecredit(String comptecredit) {
        this.comptecredit = comptecredit;
    }

    public String getAnaldebit() {
        return analdebit;
    }

    public void setAnaldebit(String analdebit) {
        this.analdebit = analdebit;
    }

    public String getAnalcredit() {
        return analcredit;
    }

    public void setAnalcredit(String analcredit) {
        this.analcredit = analcredit;
    }

    public String getIdacte() {
        return idacte;
    }

    public void setIdacte(String idacte) {
        this.idacte = idacte;
    }

    public String getMedicament() {
        return medicament;
    }

    public void setMedicament(String medicament) {
        this.medicament = medicament;
    }

    public double getQuantite() {
        return quantite;
    }

    public void setQuantite(double quantite) {
        this.quantite = quantite;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public double getMontantt() {
        return montantt;
    }

    public void setMontantt(double montantt) {
        this.montantt = montantt;
    }

    public double getMontantremise() {
        return montantremise;
    }

    public void setMontantremise(double montantremise) {
        this.montantremise = montantremise;
    }
    
    public String fusionnerFacture(UserEJB user, String[] id, Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            FactureClientDetailsTiers fc = new FactureClientDetailsTiers();
            FactureClientDetailsTiers[] factureClientDetails = (FactureClientDetailsTiers[]) CGenUtil.rechercher(fc, null, null, c, " and id in (" + Utilitaire.tabToString(id, "'", ",") + ")");
            if (factureClientDetails == null || factureClientDetails.length == 0) {
                throw new Exception("Aucune facture n'a été selectionné");
            }
            for (int i = 1; i < factureClientDetails.length; i++) {
                if (factureClientDetails[0].getTiers().compareToIgnoreCase(factureClientDetails[i].getTiers()) != 0) {
                    throw new Exception("Tiers differents pour les factures");
                }
                factureClientDetails[i].setIdfacture(factureClientDetails[0].getIdfacture());
                factureClientDetails[i].setNomTable("FACTURE_CLIENT_DETAIL");
                user.updateObject(factureClientDetails[i], c);
            }
            if (verif == 1) {
                c.commit();
            }
            return factureClientDetails[0].getIdfacture();
        } catch (Exception e) {
            if (c != null && verif == 1) {
                c.rollback();
            }
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
}
