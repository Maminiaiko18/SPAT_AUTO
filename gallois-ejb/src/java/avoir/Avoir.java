/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package avoir;

import bean.CGenUtil;
import bean.ClassEtat;
import factureclient.FactureClient;
import factureclient.PaiementFactureRemise;
import facturefournisseur.EtatFacture;
import facturefournisseur.EtatFactureMontantDaty;
import facturefournisseur.FactureFournisseur;
import java.sql.Connection;
import java.sql.Date;
import user.UserEJBBean;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;

/**
 *
 * @author Sam25v14
 */
public class Avoir extends ClassEtat {

    private String id, idfacture, type, designation;
    private Date daty;
    private double montant,tva;
    private String remarque;
    
     public Avoir payer(String u, Connection c) throws Exception {
        Avoir avoir = null;
        boolean in = false;
        try {
            if(c == null){
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                in = true;
            }
            avoir = (Avoir)this.getById(this.id, "avoir", c);
            if(avoir.getEtat() < ConstanteEtat.getEtatValider()){
                throw new Exception("Avoir non validé!");
            }
            
            PaiementFactureRemise fc = PaiementFactureRemise.getFactureClient(avoir.getIdfacture(), c);
            if( fc == null || fc.getResteavoir() >= 0 || (fc.getMontantpayer()==0 && fc.getAvoir() > fc.getMontanttotal())){
                throw new Exception("Cet avoir ne peut pas etre payé!");
            }
            FactureClient.updatePaiement(u, fc, c);
            if(in) c.commit();
        } catch (Exception e) {
            if(c!=null) c.rollback();
            throw e;
        } finally {
            if(in && c!=null) c.close();
        }
        return avoir;
    }
    
    
    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public double getTva() {
        return tva;
    }

    public void setTva(double tva) {
        this.tva = tva;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public Avoir() {
        setNomTable("avoir");
    }

    public Avoir(String idfacture, String type, Date daty, double montant) {
        setNomTable("avoir");
        this.idfacture = idfacture;
        this.type = type;
        this.daty = daty;
        this.montant = montant;
    }

    @Override
    public void controler(Connection c) throws Exception {
        FactureFournisseur facture = new FactureFournisseur();
//        facture.setNomTable("UNION_FCC_ET_FF");
        facture.setId(this.getIdfacture());

        FactureFournisseur[] tmp = (FactureFournisseur[]) CGenUtil.rechercher(facture, null, null, c, "");

        if (tmp != null && tmp.length > 0) {
            if (tmp[0].getEtat() < ConstanteEtat.getEtatValider()) {
                throw new Exception("Facture non visée!");
            }
        }
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("AVR", "GET_seq_AVOIR");
        setId(makePK(c));
    }

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

    public String getIdfacture() {
        return idfacture;
    }

    public void setIdfacture(String idfacture) {
        this.idfacture = idfacture;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    @Override
    public void viser(UserEJBBean user, Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }

            controler(c);
            EtatFactureMontantDaty etat = new EtatFactureMontantDaty();
//            etat.setNomTable("union_fcc_et_ff_avec_reste");
            etat.setNomTable("EtatFactureMontantDaty");
            EtatFactureMontantDaty[] etatFactures = (EtatFactureMontantDaty[]) CGenUtil.rechercher(etat, null, null, c, " and id='" + this.getIdfacture() + "'");
            if(this.getNomTable().equalsIgnoreCase("avoir")){
                for (int i = 0; i < etatFactures.length; i++) {
                    if (etatFactures[i].getReste() < this.getMontant()) {
                        throw new Exception("Montant avoir superieur a reste");
                    }
                }
            }

            this.validerObject(user.getUser().getTuppleID(), c);
            if (verif == 1) {
                c.commit();
            }
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
