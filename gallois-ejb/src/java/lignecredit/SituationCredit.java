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
    public static SituationCredit[] findSituationCreditRecette(String id,String desingation,String compte,String date1,String date2,String etat,Connection c) throws Exception {
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
             if(date1!=null   && !date1.equals("")) where+= " and daty >= '"+date1+"'";
             if(date2!=null   && !date2.equals("")) where+= " and daty <= '"+date2+"'";
             if(etat!=null   && !etat.equals("")) where+= " and l.etat = "+ etat;
             
             String req="SELECT l.id          AS                     id,\n" +
            "       l.DESIGNATION AS                     designation,\n" +
            "       l.COMPTE      AS                     compte,\n" +
            "       l.ANNEE       AS                     annee,\n" +
            "       l.MONTANT     AS                     montant,\n" +
            "       l.etat,\n" +
            "       CAST(sum(mf.QUANTITE*mf.pu*mf.TAUX )AS NUMBER(30, 3))\n" +
            "                     AS                     facture,\n" +
            "       CAST(sum(montantpaye) AS NUMBER(30, 3)) paye,\n" +
            "       CAST(mf.DATY AS DATE) AS DATY \n" +
            "FROM LIGNECREDITRECETTE l\n" +
            "         LEFT JOIN FACTURE_CLIENT_MEREF_paye mf\n" +
            "                   ON SUBSTR(mf.COMPTE, 0, LENGTH(l.COMPTE)) LIKE l.COMPTE\n" +
            "                       AND EXTRACT(YEAR FROM DATY) = l.ANNEE\n" +where+
            "GROUP BY l.id,\n" +
            "         l.DESIGNATION,\n" +
            "         l.COMPTE,\n" +
            "         l.ANNEE,\n" +
            "         l.MONTANT, l.etat, mf.DATY";
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
