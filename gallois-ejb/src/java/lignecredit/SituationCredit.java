/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lignecredit;

import bean.CGenUtil;
import java.sql.Connection;
import java.sql.Date;
import utilisateur.Utilisateur;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author
 */
public class SituationCredit extends LigneCredit{
    public SituationCredit(){
        this.setNomTable("ligneCreditDepense");
    }
    
    public void construirePK(Connection c) throws Exception {
        this.preparePk("SCRD", "get_seqligneCreditDepense");
        this.setId(makePK(c));
    }
    public static SituationCredit[] findSituationCreditRecette(String id,String desingation,String compte,String date1,String date2,String etat, String niveau, String exercice, Connection c) throws Exception {
         SituationCredit[] ret = null; 
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
             if(date1!=null   && !date1.equals("")) where+= " and mf.daty >= '"+date1+"'";
             if(date2!=null   && !date2.equals("")) where+= " and mf.daty <= '"+date2+"'";
             if(exercice!=null   && !exercice.equals("")) where+= " and mf.exercice = " + exercice;
             if(etat!=null   && !etat.equals("")) where+= " and l.etat = "+ etat;
             
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
            "         l.MONTANT, l.etat";*/
//                     + ", mf.DATY";
            String req = "SELECT \n" +
"       l.DESIGNATION AS                        designation,\n" +
"       substr(l.COMPTE, 1, "+niveau+")      AS                        compte,\n" +
"       l.ANNEE       AS                        annee,\n" +
"         cast(sum(l.MONTANT) as number(30,3))   AS                        montant,\n" +
"       l.etat,\n" +
"       CAST(SUM(mf.MONTANTTTC) AS NUMBER(30, 3))\n" +
"                     AS                        facture,\n" +
"       CAST(SUM(montantpaye) AS NUMBER(30, 3)) paye\n" +
"FROM LIGNECREDITRECETTE l\n" +
"         LEFT JOIN FACTURE_CLIENT_MF_PAYE mf\n" +
"                   ON substr(mf.COMPTE, 1, "+niveau+") LIKE substr(l.COMPTE, 1, "+niveau+")\n" +
//"                       AND EXTRACT(YEAR FROM DATY) = l.ANNEE " +
                    " and mf.exercice = l.annee \n" +
                    " and mf.IDMERE not in\n" +
"                                                                 (select id from ProvisionFactureDefinitive) %s \n" +
"GROUP BY \n" +
"         l.DESIGNATION,\n" +
"         substr(l.COMPTE, 1, "+niveau+"),\n" +
"         l.ANNEE,\n" +
"          l.etat";
            
            req = String.format(req, where);
            System.out.println("--- fa 0+"+req);
            SituationCredit stock = new SituationCredit();
            stock.setNomTable("situationLC_vide");
            ret = (SituationCredit[]) CGenUtil.rechercher(stock, req, c);
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
}
