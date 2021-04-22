/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.stock;

import bean.CGenUtil;
import bean.ClassEtat;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.UtilDB;
import facturefournisseur.Detailsffbonlivraison;
import utilitaire.ConstanteEtat;

/**
 *
 * @author ASUS
 */
public class BonDeLivraison extends ClassEtat {

    private String id, idbc, point, id_bc, remarque,numbc;
    private double montant, montanttva, montantttc, montantfactttc, montantpaye, rap, reste_a_facturer;

    public String getNumbc() {
        return numbc;
    }

    public void setNumbc(String numbc) {
        this.numbc = numbc;
    }
    
    public String getId_bc() {
        return id_bc;
    }

    public void setId_bc(String id_bc) {
        this.id_bc = id_bc;
    }

    public String getPoint() {
        return point;
    }

    public void setPoint(String point) {
        this.point = point;
    }
    private Date daty;

    public BonDeLivraison() {
        this.setNomTable("AS_BONDELIVRAISON");
    }

    public void construirePK(Connection c) throws Exception {
        this.preparePk("BL", "getSeqBondeLivraison");
        this.setId(makePK(c));
    }

    public BonDeLivraison(String remarque, String idbc, Date daty) {
        this.setNomTable("AS_BONDELIVRAISON");
        this.setRemarque(remarque);
        this.setIdbc(idbc);
        this.setDaty(daty);
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
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

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdbc() {
        return idbc;
    }

    public void setIdbc(String idbc) {
        this.idbc = idbc;
    }

    public void controlQuantite(Connection c) throws Exception {
        String[] idbcF = this.getFilleBCIds(c);
        
        Detailsffbonlivraison dts = new Detailsffbonlivraison();
        dts.setNomTable("bc_bl_livre");
        
//        Detailsffbonlivraison[] retour = (Detailsffbonlivraison[]) CGenUtil.rechercher(dts, null, null, c, " and idbc = '" + this.getId_bc() + "'");
        
        String in = utilitaire.Utilitaire.tabToString(idbcF, "'", ",");
        Detailsffbonlivraison[] retour = (Detailsffbonlivraison[]) CGenUtil.rechercher(dts, null, null, c, " and id in (" + in + ")");
        if (retour == null || retour.length == 0) {
            throw new Exception("Bon de livraison fille vide");
        }
        //maka ny reste  : if qte -(sum(qte blfille valider) - qte ao am detailsfacturefournisseur ) raha negative dia mamoka exception
        for (int i = 0; i < retour.length; i++) {
            if (retour[i].getQuantitereste() <= 0) {
                throw new Exception("Le produit " + retour[i].getProduit() + " n a plus de reste à livrer");
            }
        }
    }

    public void controlerVisa(Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            
            controlQuantite(c);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    @Override
    public Object validerObject(String u, Connection c) throws Exception {
        controlerVisa(c);
        return super.validerObject(u, c);
    }
    
    public String[] getFilleBCIds(Connection c) throws Exception {
        BonDeLivraisonFille[] filles = this.getFille(c);
        String[] ids = new String[filles.length];
        
        for(int i=0; i < ids.length; i++) {
            ids[i] = filles[i].getIdbondecommande();
        }
        
        return ids;
    }

    public BonDeLivraisonFille[] getFille(Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            return (BonDeLivraisonFille[]) CGenUtil.rechercher(new BonDeLivraisonFille(), null, null, c, " and numbl='" + this.getId() + "'");
        } catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
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

    public double getMontantttc() {
        return montantttc;
    }

    public void setMontantttc(double montantttc) {
        this.montantttc = montantttc;
    }

    public double getMontantfactttc() {
        return montantfactttc;
    }

    public void setMontantfactttc(double montant_facturer) {
        this.montantfactttc = montant_facturer;
    }

    public double getMontantpaye() {
        return montantpaye;
    }

    public void setMontantpaye(double montant_paye) {
        this.montantpaye = montant_paye;
    }

    public double getRap() {
        return rap;
    }

    public void setRap(double reste_a_payer) {
        this.rap = reste_a_payer;
    }

    public double getReste_a_facturer() {
        return reste_a_facturer;
    }

    public void setReste_a_facturer(double reste_a_facturer) {
        this.reste_a_facturer = reste_a_facturer;
    }

}
