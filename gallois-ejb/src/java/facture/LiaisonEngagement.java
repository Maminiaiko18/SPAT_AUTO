/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.CGenUtil;
import bean.ClassEtat;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;

import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;

/**
 *
 * @author Itokiana
 */
public class LiaisonEngagement extends ClassEtat {
    
    private String id, id1, id2;
    private double montant;
    private Date daty;

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

    public LiaisonEngagement(String id1, String id2, double montant, int etat) {
        this.setNomTable("liaisonengagement");
        this.setId1(id1);
        this.setId2(id2);
        this.setMontant(montant);
        this.setEtat(etat);
    }

    @Override
    public void controler(Connection c) throws Exception {
        if(this.getMontant()<0) this.setMontant(0);
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }
    
    public String libererLiaison(String u, Connection c) throws Exception {
        try{
            c = (new UtilDB()).GetConn();
            FactureFournisseur facture = (FactureFournisseur) (new FactureFournisseur()).getById(this.getId2(), "FACTFOURN_MSUM_LIB", c);
            if(facture.getMontantttc() < this.getMontant()){
                throw new Exception("Le montant \\340 lib\\351rer sup\\351rieur au montant TTC.");
            }
            String requete = "SELECT * FROM liaisonengagement_datefact WHERE ID2 = '" + this.getId2() + "' and etat = 11 ORDER BY DATY";
            LiaisonEngagement[] liste = (LiaisonEngagement[])CGenUtil.rechercher(new LiaisonEngagement(), requete, c);
            LiaisonEngagement liaison;
            int t = liste.length;
            double montant = this.getMontant();
            for(int i = 0; i < t; i++){
                if(montant > 0){
                    liaison = new LiaisonEngagement();
                    liaison.setId1(liste[i].getId1());
                    liaison.setId2(liste[i].getId2());
                    double montantAlib = (liste[i].getMontant() <= montant) ? liste[i].getMontant() : montant;
                    liaison.setMontant(montantAlib * (-1));
                    montant -= montantAlib;
                    liaison.createObject(u, c);
                    liaison.validerObject(u, c);
                }
            }
            
            c.commit();
        }
        catch(Exception e){
            c.rollback();
            throw e;
        }
        finally{
            c.close();
        }
        
        return this.getId2();
    }
}
