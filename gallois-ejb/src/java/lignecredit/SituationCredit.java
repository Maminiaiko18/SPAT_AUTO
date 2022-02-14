/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lignecredit;

import bean.CGenUtil;
import bean.ResultatEtSomme;
import java.sql.Connection;
import java.sql.Date;
import utilisateur.Utilisateur;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author
 */
public class SituationCredit extends LigneCredit {
    private double pourcEngage,pourcPaye; 
    public SituationCredit() {
        this.setNomTable("ligneCreditDepense");
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

    public void construirePK(Connection c) throws Exception {
        this.preparePk("SCRD", "get_seqligneCreditDepense");
        this.setId(makePK(c));
    }
/*
    public static SituationCredit[] findSituationCreditRecette(String id, String desingation, String compte, String date1, String date2, String etat, String niveau, String exercice, String mois, Connection c) throws Exception {
        SituationCredit[] ret = null;
        boolean newCon = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                newCon = true;
            }

            String where = " where 1<2 ";
            if (id != null && !id.equals("")) {
                where += " and upper(l.id) like upper('%" + id + "%')";
            }
            if (desingation != null && !desingation.equals("")) {
                where += "and upper(l.designation) like upper('%" + desingation + "%')";
            }
            if (compte != null && !compte.equals("")) {
                where += " and upper(l.compte) like upper('%" + compte + "%')";
            }
            if (date1 != null && !date1.equals("")) {
                where += " and mf.daty >= '" + date1 + "'";
            }
            if (date2 != null && !date2.equals("")) {
                where += " and mf.daty <= '" + date2 + "'";
            }
            if (exercice != null && !exercice.equals("")) {
                where += " and mf.annee = " + exercice;
            }
            if (mois != null && !mois.equals("")) {
                where += " and mf.mois = " + mois;
            }
            if (etat != null && !etat.equals("")) {
                where += " and l.etat = " + etat;
            }

            /*String req="SELECT l.id          AS                     id,\n" +
            "       l.DESIGNATION AS                     designation,\n" +
            "       l.COMPTE      AS                     compte,\n" +
            "       l.ANNEE       AS                     annee,\n" +
            "       l.MONTANT     AS                     montant,\n" +
            "       l.etat,\n" +
            "       CAST(sum(mf.QUANTITE*mf.pu*mf.TAUX )AS NUMBER(30, 3))\n" +
            "                     AS                     facture,\n" +
            "       CAST(sum(montantpaye) AS NUMBER(30, 3)) paye\n" +
//            "       ,CAST(mf.DATY AS DATE) AS DATY \n" +
            "FROM LIGNECREDITRECETTE l\n" +
            "         LEFT JOIN FACTURE_CLIENT_MEREF_paye mf\n" +
            "                   ON SUBSTR(mf.COMPTE, 0, LENGTH(l.COMPTE)) LIKE l.COMPTE\n" +
            "                       AND EXTRACT(YEAR FROM DATY) = l.ANNEE\n" +
            "                       AND mf.IDMERE NOT IN (SELECT id\n" +
            "                               FROM ProvisionFactureDefinitive)\n" + 
            where+
            "GROUP BY l.id,\n" +
            "         l.DESIGNATION,\n" +
            "         l.COMPTE,\n" +
            "         l.ANNEE,\n" +
            "         l.MONTANT, l.etat";
//                     + ", mf.DATY";
            String req = "SELECT \n"
                    + //"       l.DESIGNATION AS                        designation,\n" +
                    "       cr.LIBELLE AS DESIGNATION,\n"
                    + "       substr(l.COMPTE, 1, " + niveau + ")      AS                        compte,\n"
                    + "       mf.mois, "
                    + "       l.ANNEE       AS                        annee,\n"
                    + "         cast(sum(l.MONTANT) as number(30,3))   AS                        montant,\n"
                    + "       l.etat,\n"
                    + "       CAST(SUM(mf.MONTANTTTC) AS NUMBER(30, 3))\n"
                    + "                     AS                        facture,\n"
                    + "       CAST(SUM(montantpaye) AS NUMBER(30, 3)) paye\n"
                    + "FROM LIGNECREDITRECETTE l\n"
                    + "         LEFT JOIN FACTURE_CLIENT_MF_PAYE mf\n"
                    + "                   ON substr(mf.COMPTE, 1, " + niveau + ") LIKE substr(l.COMPTE, 1, " + niveau + ")||'%'\n"
                    + //"                       AND EXTRACT(YEAR FROM DATY) = l.ANNEE " +
                    " and mf.annee = l.annee \n"
                    + " and mf.IDMERE not in\n"
                    + "                                                                 (select id from ProvisionFactureDefinitive) "
                    + " LEFT JOIN COMPTE_RUBRIQUE cr ON substr(l.COMPTE, 1, " + niveau + ") = cr.COMPTE "
                    + where
                    + " GROUP BY \n"
                    + //"         l.DESIGNATION,\n" +
                    "         cr.LIBELLE,  "
                    + "         substr(l.COMPTE, 1, " + niveau + "),\n"
                    + "         mf.mois, \n  "
                    + "         l.ANNEE,\n"
                    + "          l.etat";

            //req = String.format(req, where);
            System.out.println("--- fa 0+" + req);
            SituationCredit stock = new SituationCredit();
            stock.setNomTable("situationLC_vide");
            ret = (SituationCredit[]) CGenUtil.rechercher(stock, req, c);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (newCon && c != null) {
                c.close();
            }
        }
        return ret;
    }*/
    
    private static String getReqSituationCreditRecetteSansNiveau(SituationCredit critere, String date1, String date2) throws Exception {
        String where = " where " + CGenUtil.makeWhere(critere);

        where = where.replaceAll("id", "l.id");
        where = where.replaceAll("designation", "l.designation");
        where = where.replaceAll("compte", "l.compte");
        where = where.replaceAll("annee", "l.annee");
        if (date1 != null && !date1.equals("")) where += " and mf.daty >= '" + date1 + "'";
        if (date2 != null && !date2.equals("")) where += " and mf.daty <= '" + date2 + "'";

        String req = "SELECT l.id,\n" +
"            l.DESIGNATION,\n" +
"            l.compte,\n" +
"            l.ANNEE,\n" +
"            l.montant AS montant,\n" +
"            l.etat,\n" +
"            CAST (NVL (SUM (MONTANTHT), 0) AS NUMBER (30, 3)) AS facture,\n" +
"            CAST (NVL (SUM (MONTANTPAYE), 0) AS NUMBER (30, 3)) AS PAYE,\n" +
"            CAST (\n" +
"               (NVL (SUM (MONTANTHT), 0) - NVL (SUM (montantpaye), 0)) AS NUMBER (30, 3))\n" +
"               AS arecouvrir,\n" +
"            CAST ( (l.montant) - NVL (SUM (MONTANTHT), 0) AS NUMBER (30, 3))\n" +
"               AS restebudget,\n" +
"            CAST (\n" +
"               (NVL (SUM (MONTANTHT), 0) / l.MONTANT) * 100 AS NUMBER (30, 3))\n" +
"               AS pourcEngage,\n" +
"            CAST (\n" +
"               ( (NVL (SUM (MONTANTPAYE), 0)) / NVL (SUM (MONTANTHT), 0)) * 100 AS NUMBER (30, 3))\n" +
"               AS pourcPaye\n" +
"       FROM LIGNECREDITRECETTE l\n" +
"            LEFT JOIN FACTURE_CLIENT_MF_PAYE_BDG mf\n" +
"               ON mf.compte LIKE l.compte || '%' AND mf.annee = l.annee\n" +
 where + " and l.etat >= " + ConstanteEtat.getEtatValider() + " \n" +
"   GROUP BY l.id,\n" +
"            l.DESIGNATION,\n" +
"            l.compte,\n" +
"            l.ANNEE,\n" +
"            l.montant,\n" +
"            l.etat";

        return req;
    }
    
    private static String getReqSituationCreditRecetteAvecNiveau(String id, String designation, String compte, String date1, String date2, int etat, String niveau, int exercice, int mois) {
        String where = " where 1<2 ", whereFact = "";
            //if (id != null && !id.equals("")) where += " and upper(l.id) like upper('%" + id + "%')";
//            if (designation != null && !designation.equals("")) where += "and upper(l.designation) like upper('%" + designation + "%')";
            if (compte != null && !compte.equals("")) where += " and upper(l.compte) like upper('%" + compte + "%')";
            if (date1 != null && !date1.equals("")) whereFact += " and mf.daty >= '" + date1 + "'";
            if (date2 != null && !date2.equals("")) whereFact += " and mf.daty <= '" + date2 + "'";
            if (exercice > 0) where += " and l.annee = " + exercice;
            if (mois > 0) whereFact += " and mf.mois = " + mois;
            
        String req = "select sum(MONTANTPAYE) as PAYE,\n" +
"         sum(MONTANTTTC)  as facture,\n" +
"         (sum(MONTANTTTC) - sum(montantpaye)) as arecouvrir,\n" +
"         l.ANNEE,\n" +
"         l.compte,\n" +
"         cr.LIBELLE       as libelle,\n" +
"         l.montant   as montant,\n" +
"         l.montant - sum(MONTANTTTC) as restebudget,\n" +
"          cast(((nvl(sum(MONTANTTTC), 0)) / l.MONTANT) * 100 as NUMBER(30, 3))      as pourcEngage,\n" +
"        cast(((nvl(sum(MONTANTPAYE), 0)) / l.MONTANT) * 100 as number(30, 3))       as pourcPaye\n" +
"  from (\n" +
"           (SELECT\n" +
"                sum(l.QUANTITE)        as QUANTITE,\n" +
"                sum(l.MONTANT)         as montant,\n" +
"                l.ANNEE,\n" +
" substr(COMPTE, 1, "+ niveau +")       as compte\n" +
"                --l.etat\n" +
"            FROM LIGNECREDITRECETTE l \n" +
"            where montant > 0\n" +
"            group by l.ANNEE, substr(COMPTE, 1, "+ niveau +")           --, l.etat\n" +
"            ) l\n" +
"               LEFT JOIN (select sum(mf.MONTANTTTC)      as MONTANTTTC,\n" +
"                                 sum(montantpaye)        as MONTANTPAYE,\n" +
" substr(COMPTE, 1, "+ niveau +")             as compte,\n" +
"                                 mf.ANNEE\n" +
"                          from FACTURE_CLIENT_MF_PAYE mf\n" +
"                          WHERE  mf.IDMERE not in\n" +
"                       (select id from ProvisionFactureDefinitive)\n" +
//"                        and idcategorie!='CATFCO2' and etat>=11\n" +
                whereFact +
"                          group by substr(COMPTE, 1, "+ niveau +"), ANNEE) mf\n" +
"               ON mf.compte LIKE l.compte\n" +
"                   AND mf.annee = l.annee\n" +
"                   )\n" +
"           LEFT JOIN COMPTE_RUBRIQUE cr ON l.COMPTE = cr.COMPTE\n" +
where +
"  group by l.ANNEE, l.compte, cr.LIBELLE, l.montant";
        
        return req;
    }
    
    public static ResultatEtSomme findSituationCreditRecette(SituationCredit critere, String date1, String date2, String niveau, Connection c, String[] colSomme) throws Exception {
        ResultatEtSomme ret = null;
        boolean newCon = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                newCon = true;
            }

            String req = niveau == null || niveau.equals("") ? getReqSituationCreditRecetteSansNiveau(critere, date1, date2)
                                                              :  getReqSituationCreditRecetteAvecNiveau(null, null, critere.getCompte(), date1, date2, critere.getEtat(), niveau, critere.getAnnee(), critere.getMois());
            
            //System.out.println("--- fa 0+" + req);
            SituationCredit stock = new SituationCredit();
            stock.setNomTable("situationLC_vide");
            ret = CGenUtil.rechercher(stock, req, c, colSomme);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (newCon && c != null) {
                c.close();
            }
        }
        return ret;
    }
}
