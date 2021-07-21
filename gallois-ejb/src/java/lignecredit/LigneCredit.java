/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lignecredit;

import bean.CGenUtil;
import bean.ClassEtat;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.UtilDB;

/**
 *
 * @author
 */
public class LigneCredit extends ClassEtat {
    
    private String id;
    private String designation,compte;
    private double quantite,montant,facture,paye;
    private int annee;

    private Date daty;

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }
    
    public static LigneCredit[] findSituationCreditDepense(String id,String desingation,String compte,String date1,String date2,Connection c) throws Exception {
         LigneCredit[] ret = null; 
           boolean newCon = false;
           try{
             if(c==null) {
                c = new UtilDB().GetConn();
                newCon=true;
            }
             String where =" where 1<2 ";
             if(id!=null   && !id.equals("")) where+=" and upper(l.id) like upper('%"+id+"%')";
             if(desingation!=null   && !desingation.equals("")) where+= "and upper(l.designation) like upper('%"+desingation+"%')";
             if(compte!=null   && !compte.equals("")) where+= " and upper(l.compte) like upper('%"+compte+"%')";
             if(date1!=null   && !date1.equals("")) where+= " and daty >= '"+date1+"'";
             if(date2!=null   && !date2.equals("")) where+= " and daty <= '"+date2+"'";
             
             String req="SELECT l.id AS id,\n" +
"            l.DESIGNATION AS designation,\n" +
"            l.COMPTE AS compte,\n" +
"            l.ANNEE AS annee,\n" +
"            l.MONTANT AS montant,\n" +
"            l.etat,\n" +
"            CAST (NVL (SUM (pu * l.QUANTITE * tva), 0) AS NUMBER (30, 3))\n" +
"               AS facture,\n" +
"            CAST (NVL (SUM (montantpaye), 0) AS NUMBER (30, 2)) paye,\n" +
"            mf.DATY\n" +
"       FROM LIGNECREDITDEPENSE l\n" +
"            LEFT JOIN DETAILSFACTUREFOURNISSEUR_paye mf\n" +
"               ON     SUBSTR (mf.COMPTE, 0, LENGTH (l.COMPTE)) LIKE l.COMPTE\n" +
"                  AND EXTRACT (YEAR FROM daty) = l.ANNEE\n" +where+
"   GROUP BY l.id,\n" +
"            l.DESIGNATION,\n" +
"            l.COMPTE,\n" +
"            l.ANNEE,\n" +
"            l.MONTANT,l.etat,mf.DATY";
               System.out.println("req=="+req);
             LigneCredit stock = new LigneCredit();
            ret = (LigneCredit[]) CGenUtil.rechercher(stock, req, c);
       }
      catch(Exception e)
        {
            e.printStackTrace();
            throw e;
        }
        finally
        {
            if(newCon && c!=null)
            {
                c.close();
            }
        }
        return ret;
       }

    
    public LigneCredit(){
        this.setNomTable("ligneCreditRecette");
    }
    
    public void construirePK(Connection c) throws Exception {
        this.preparePk("LCRD", "get_seqligneCreditRecette");
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

    public String getCompte() {
        return compte;
    }

    public void setCompte(String compte) {
        this.compte = compte;
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

    public int getAnnee() {
        return annee;
    }

    public void setAnnee(int annee) {
        this.annee = annee;
    }
    
    public double getFacture() {
        return facture;
    }

    public void setFacture(double facture) {
        this.facture = facture;
    }

    public double getPaye() {
        return paye;
    }

    public void setPaye(double paye) {
        this.paye = paye;
    }
}
