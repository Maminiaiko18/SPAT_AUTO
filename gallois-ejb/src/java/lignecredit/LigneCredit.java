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
    private String designation,compte,compteCpl;
    private double quantite,montant,facture,paye;
    private int annee, mois;
    private double arecouvrir, restebudget,pourcEngage,pourcPaye;
    private Date daty;

    public String getCompteCpl() {
        return compteCpl;
    }

    public void setCompteCpl(String compteCpl) {
        this.compteCpl = compteCpl;
    }

    
    public double getPourcEngage() {
        return pourcEngage;
    }

    public void setPourcEngage(double pourcEngage) {
        this.pourcEngage = pourcEngage;
    }

    public double getPourcPaye() {
        return pourcPaye;
    }

    public void setPourcPaye(double pourcPaye) {
        this.pourcPaye = pourcPaye;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }
    
    public static LigneCredit[] findSituationCreditDepense(String id,String desingation,String compte,String date1,String date2, String etat, String niveau, String exercice, String mois, Connection c) throws Exception {
         LigneCredit[] ret = null; 
           boolean newCon = false;
           try{
             if(c==null) {
                c = new UtilDB().GetConn();
                newCon=true;
            }
             String where =" where 1<2 ";
             //if(id!=null   && !id.equals("")) where+=" and upper(l.id) like upper('%"+id+"%')";
             if(desingation!=null   && !desingation.equals("")) where+= "and upper(l.designation) like upper('%"+desingation+"%')";
             if(compte!=null   && !compte.equals("")) where+= " and upper(l.compte) like upper('%"+compte+"%')";
             if(date1!=null   && !date1.equals("")) where+= " and daty >= '"+date1+"'";
             if(date2!=null   && !date2.equals("")) where+= " and daty <= '"+date2+"'";
             if(exercice!=null   && !exercice.equals("")) where+= " and l.annee = " + exercice;
             if (mois != null && !mois.equals("")) where += " and mf.mois = " + mois;
             //if(etat != null && !etat.equals("")) where += " and l.etat = " + etat;
             
             String req = "select nvl(sum(MONTANTPAYE), 0) as PAYE,\n" +
"         nvl(sum(montantttc), 0)  as facture,\n" +
"        ( nvl(sum(montantttc), 0) - nvl(sum(MONTANTPAYE), 0)) as arecouvrir,\n" +
"        l.ANNEE,\n" +
"        l.compte,\n" +
"        cr.LIBELLE       as libelle,\n" +
"        l.montant   as montant,\n" +
"        l.montant -  nvl(sum(montantttc), 0) as restebudget,\n" +
"         (((nvl(sum(MONTANTTTC), 0)) / l.MONTANT) * 100)      as pourcEngage,\n" +
"       (((nvl(sum(MONTANTPAYE), 0)) / l.MONTANT) * 100)       as pourcPaye \n"+                     
" from (\n" +
"          (SELECT\n" +
"               sum(l.QUANTITE)        as QUANTITE,\n" +
"               sum(l.MONTANT)         as montant,\n" +
"               l.ANNEE,\n" +
"               substr(l.COMPTE, 1, " + niveau + ") as compte\n" +
"               --l.etat\n" +
"           FROM LIGNECREDITDEPENSE l\n" +
"           group by l.ANNEE, substr(l.COMPTE, 1, " + niveau + ")\n" +
"           --, l.etat\n" +
"           ) l\n" +
"              LEFT JOIN (select sum(mf.MONTANTTTC)      as MONTANTTTC,\n" +
"                                sum(MONTANTPAYE)        as MONTANTPAYE,\n" +
"                                substr(mf.COMPTECPL, 1, " + niveau + ") as compte,\n" +
"                                mf.ANNEE,\n" +
"                                mois                    as mois,\n" +
"                                mf.daty\n" +
"                         from DETAILSFACTUREFOURNISSEUR_paye mf\n" +
"                         WHERE  mf.IDMERE not in\n" +
"                      (select id from ProvisionFactureDefinitive)\n" +
"                         group by substr(mf.COMPTECPL, 1, " + niveau + "), ANNEE, mois, daty) mf\n" +
"              ON l.compte = mf.compte\n" +
"                  AND mf.annee = l.annee\n" +
"                  )\n" +
"          LEFT JOIN COMPTE_RUBRIQUE cr ON l.COMPTE = cr.COMPTE\n" +
where +
"  group by l.ANNEE, l.compte, cr.LIBELLE, l.MONTANT";
             
             //req = String.format(req, where);
               //System.out.println("req=="+req);
             LigneCredit stock = new LigneCredit();
             stock.setNomTable("SITUATIONLC_VIDE");
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
    
    /*public static LigneCredit[] findSituationCreditDepense(String id,String desingation,String compte,String date1,String date2, String etat, String niveau, String exercice, Connection c) throws Exception {
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
             if(exercice!=null   && !exercice.equals("")) where+= " and mf.exercice = " + exercice;
             if(etat != null && !etat.equals("")) where += " and l.etat = " + etat;
             /*String req = "SELECT \n" +
                        "	   l.id          AS                                id,\n" +
                        "       l.DESIGNATION AS                                designation,\n" +
                        "       l.COMPTE      AS                                compte,\n" +
                        "       l.ANNEE       AS                                annee,\n" +
                        "       l.MONTANT     AS                                montant,\n" +
                        "       l.etat,\n" +
                        "       CAST(NVL(SUM(nvl(pu, 0) * mf.QTE * tva), 0) AS NUMBER(30, 3))\n" +
                        "                     AS                                facture,\n" +
                        "       CAST(NVL(SUM(montantpaye), 0) AS NUMBER(30, 2)) paye\n" +
                        "FROM LIGNECREDITDEPENSE l\n" +
                        "LEFT JOIN DETAILSFACTUREFOURNISSEUR_paye mf\n" +
                        "ON SUBSTR(mf.COMPTE, 0, LENGTH(l.COMPTE)) LIKE l.COMPTE\n" +
                        "AND EXTRACT(YEAR FROM daty) = l.ANNEE\n" +
                        where +
                        "GROUP BY l.id,\n" +
                        "         l.DESIGNATION,\n" +
                        "         l.COMPTE,\n" +
                        "         l.ANNEE,\n" +
                        "         l.MONTANT, l.etat";
             String req = "SELECT l.id                   AS                       id,\n" +
"       l.DESIGNATION          AS                       designation,\n" +
"       substr(l.COMPTE, 1, "+niveau+") AS                       compte,\n" +
"       l.ANNEE                AS                       annee,\n" +
"       sum(l.MONTANT)              AS                       montant,\n" +
"       l.etat,\n" +
"       CAST(nvl(sum(MONTANTTTC), 0) AS NUMBER(30, 3))\n" +
"                              AS                       facture,\n" +
"       CAST(NVL(SUM(montantpaye), 0) AS NUMBER(30, 2)) paye\n" +
"FROM LIGNECREDITDEPENSE l\n" +
"         LEFT JOIN DETAILSFACTUREFOURNISSEUR_paye mf\n" +
"                   ON substr(mf.COMPTE, 1, "+niveau+") LIKE substr(l.COMPTE, 1, "+niveau+")\n" +
//"                       AND EXTRACT(YEAR FROM daty) = l.ANNEE  \n" +
                     " and mf.exercice = l.annee %s \n" +
"GROUP BY l.id,\n" +
"         l.DESIGNATION,\n" +
"         substr(l.COMPTE, 1, "+niveau+"),\n" +
"         l.ANNEE,\n" +
"          l.etat";
             req = String.format(req, where);
               System.out.println("req=="+req);
             LigneCredit stock = new LigneCredit();
             stock.setNomTable("situationLC_vide");
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
       }*/

    
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

    public double getRestebudget() {
        return restebudget;
    }

    public void setRestebudget(double restebudget) {
        this.restebudget = restebudget;
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

    public double getArecouvrir() {
        return arecouvrir;
    }

    public void setArecouvrir(double arecouvrir) {
        this.arecouvrir = arecouvrir;
    }

    public int getMois() {
        return mois;
    }

    public void setMois(int mois) {
        this.mois = mois;
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
