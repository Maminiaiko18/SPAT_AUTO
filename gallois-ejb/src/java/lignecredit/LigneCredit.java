/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lignecredit;

import bean.CGenUtil;
import bean.ClassEtat;
import bean.ResultatEtSomme;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;

/**
 *
 * @author
 */
public class LigneCredit extends ClassEtat {

    private String id;
    private String designation, compte, compteCpl, compteInv, compteSimple, directon, projet, directionProjet, comptestr, compteG, codeEtablissement, direction;
    private String codeEtablissementlib, projetlib;
    private String idprojet, idcodeEtablissement;
    private double resteApresEngmt;

    public double getResteApresEngmt() {
        return resteApresEngmt;
    }

    public void setResteApresEngmt(double resteApresEngmt) {
        this.resteApresEngmt = resteApresEngmt;
    }

    public String getDirection() {
        return direction;
    }

    public void setDirection(String direction) {
        this.direction = direction;
    }

    public String getIdprojet() {
        return idprojet;
    }

    public void setIdprojet(String idprojet) {
        this.idprojet = idprojet;
    }

    public String getIdcodeEtablissement() {
        return idcodeEtablissement;
    }

    public void setIdcodeEtablissement(String idcodeEtablissement) {
        this.idcodeEtablissement = idcodeEtablissement;
    }

    public String getCompteG() {
        return compteG;
    }

    public String getCodeEtablissementlib() {
        return codeEtablissementlib;
    }

    public void setCodeEtablissementlib(String codeEtablissementlib) {
        this.codeEtablissementlib = codeEtablissementlib;
    }

    public String getProjetlib() {
        return projetlib;
    }

    public void setProjetlib(String projetlib) {
        this.projetlib = projetlib;
    }

    public String getCodeEtablissement() {
        return codeEtablissement;
    }

    public void setCodeEtablissement(String codeEtablissement) {
        this.codeEtablissement = codeEtablissement;
    }

    public void setCompteG(String compteG) {
        this.compteG = compteG;
    }

    public String getComptestr() {
        return comptestr;
    }

    public void setComptestr(String comptestr) {
        this.comptestr = comptestr;
    }
    private double quantite, montant, engageer, facture, paye;
    private int annee, mois;
    private double arecouvrir, restebudget, pourcEngage, pourcPaye;
    private Date daty;

    public String getCompteInv() {
        return compteInv;
    }

    public void setCompteInv(String compteInv) {
        this.compteInv = compteInv;
    }

    public double getEngageer() {
        return engageer;
    }

    public void setEngageer(double engageer) {
        this.engageer = engageer;
    }

    public String getCompteSimple() {
        return compteSimple;
    }

    public void setCompteSimple(String compteSimple) {
        this.compteSimple = compteSimple;
    }

    public String getDirecton() {
        return directon;
    }

    public void setDirecton(String directon) {
        this.directon = directon;
    }

    public String getProjet() {
        return projet;
    }

    public void setProjet(String projet) {
        this.projet = projet;
    }

    public String getDirectionProjet() {
        return directionProjet;
    }

    public void setDirectionProjet(String directionProjet) {
        this.directionProjet = directionProjet;
    }

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

    public static ResultatEtSomme findSituationCreditDepense(LigneCredit critere, String date1, String date2, Connection c, String[] colSomme) throws Exception {
        boolean newCon = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                newCon = true;
            }

            String where = " where " + CGenUtil.makeWhere(critere);

            where = where.replaceAll("designation", "l.designation");
            where = where.replaceAll("compte", "l.compte");
            where = where.replaceAll("annee", "l.annee");
            where = where.replaceAll("direction", "l.direction");
            where = where.replaceAll("projet", "l.projet");

            String whereDaty = "";

            if (date1 != null && !date1.isEmpty()) {
                whereDaty += " and daty >= '" + date1 + "'";
            }
            if (date2 != null && !date2.isEmpty()) {
                whereDaty += " and daty <= '" + date2 + "'";
            }

            String req = "select l.direction,\n"
                    + "       l.projet,\n"
                    + "       l.COMPTEFULL                                                                         as compte,\n"
                    + "       sum(l.montant)                                                                     as montant,\n"
                    + "       cast(nvl(n.montant, 0) + nvl(nt.MONTANT, 0) - nvl(gr.MONTANT, 0) as NUMBER(30, 3)) as engageer,\n"
                    + "       cast(nvl(fd.facture, 0) as NUMBER(30, 3))                                          as facture,\n"
                    + "       cast(nvl(fd.PAYE, 0) as number(30, 3))                                             as PAYE,\n"
                    + "       cast(nvl(fd.facture, 0) - nvl(fd.PAYE, 0) as NUMBER(30, 3))                        as arecouvrir,\n"
                    + "       cast(sum(l.montant) - nvl(fd.facture, 0) as NUMBER(30, 3))                         as restebudget,\n"
                    + "       cast(nvl(fd.facture, 0) / sum(l.MONTANT) * 100 as NUMBER(30, 3))                   as pourcEngage,\n"
                    + "       cast(nvl(fd.PAYE, 0) / sum(l.MONTANT) * 100 as number(30, 3))                      as pourcPaye\n"
                    + " from SITUATIONLCDEPENSE_FULL l\n"
                    + "         LEFT JOIN (SELECT cast(nvl(sum(MONTANTTTC), 0) as NUMBER(30, 3))  as facture,\n"
                    + "                           cast(nvl(sum(MONTANTPAYE), 0) as number(30, 3)) as PAYE,\n"
                    + "                           substr(mf.COMPTE, 1, 6)                         as comptefull,\n"
                    + "                           mf.ANNEE\n"
                    + "\n"
                    + "                    FROM DETAILSFACTUREFOURNISSEUR_paye mf\n"
                    + "                    group by comptecpl, mf.COMPTE, mf.ANNEE) fd on l.COMPTEFULL = fd.comptefull\n"
                    + "         left join (select COMPTECPL as compte, sum(MONTANTTTC) as montant, annee\n"
                    + "                    from DETAILSFACTUREFOURNISSEUR_paye\n"
                    + "                    where IDENGAGEMENT is null \n"
                    + whereDaty
                    + "                    group by COMPTECPL, annee) n on n.compte = l.COMPTE\n"
                    + "         left join (SELECT sum(montant) AS montant, PROJET, codeetablissement, projetlib, codeetablissementlib\n"
                    + "                    FROM engagementlibv ev\n"
                    + "                    WHERE 1 < 2 " + whereDaty.replaceAll("daty", "ev.daty")
                    + "                    GROUP BY PROJET, codeetablissement, projetlib, codeetablissementlib) nt\n"
                    + "                   on nt.projet = l.idprojet AND nt.codeetablissement = l.iddirection\n"
                    + "         left join (select en.ID, sum(li.MONTANT) as MONTANT, DATY as DATYENGAGEMENT, PROJET, codeetablissement\n"
                    + "                    from LIBERER li\n"
                    + "                             left join ENGAGEMENT en on en.ID = li.IDENGAGEMENT\n"
                    + "                    where li.ETAT >= 11 \n"
                    + whereDaty.replaceAll("daty", "en.daty")
                    + "                    group by en.ID, DATY, PROJET, codeetablissement) gr\n"
                    + "                   on nt.PROJET = gr.PROJET and nt.CODEETABLISSEMENT = gr.CODEETABLISSEMENT\n"
                    + where
                    + " GROUP BY l.DIRECTION, l.projet, n.montant, nt.MONTANT, gr.MONTANT, fd.facture, fd.PAYE,\n"
                    + "         l.direction, l.projet, l.COMPTEFULL";

            LigneCredit stock = new LigneCredit();
            stock.setNomTable("situationLC_vide");
            return CGenUtil.rechercher(stock, req, c, colSomme);

        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (newCon && c != null) {
                c.close();
            }
        }
    }

//    public static ResultatEtSomme findSituationCreditDepense(LigneCredit critere, String date1, String date2, Connection c, String[] colSomme) throws Exception {
//        boolean newCon = false;
//        try {
//            if (c == null) {
//                c = new UtilDB().GetConn();
//                newCon = true;
//            }
//
//            String where = " where " + CGenUtil.makeWhere(critere);
//
//            where = where.replaceAll("id", "l.id");
//            where = where.replaceAll("designation", "l.designation");
//            where = where.replaceAll("compte", "l.compte");
//            where = where.replaceAll("annee", "l.annee");
//            
//            where += " and (";
//            
//            String whereDaty = "";
//            
//            boolean estInterval = date1 != null && !date1.isEmpty() && date2 != null && !date2.isEmpty();
//            
//            if (date1 != null && !date1.isEmpty()) {
//                whereDaty += " daty >= '" + date1 + "'";
//                
//            }
//            if(estInterval) whereDaty += " and ";
//            if (date2 != null && !date2.isEmpty()) {
//                whereDaty += " daty <= '" + date2 + "'";
//            }
//            
//            where += whereDaty.replaceAll("daty", "mf.daty") + " or mf.daty is null)";
//            
//            if(!whereDaty.isEmpty()) whereDaty = " and " + whereDaty;
//            
////            where += whereDaty;
//
//            String req = "select l.id,\n"
//                    + "       l.DESIGNATION,\n"
//                    + "       l.compte,\n"
//                    + "       l.ANNEE,\n"
//                    + "       l.montant                                                                   as montant,\n"
//                    + "       l.etat,\n"
//                    + "       comptestr,\n"
//                    + "       cast(nvl(n.montant,0)+nvl(nt.MONTANT,0)-nvl(gr.MONTANT,0) as NUMBER(30, 3)) as engageer,\n"
//                    + "       cast(nvl(sum(MONTANTTTC), 0) as NUMBER(30, 3))                              as facture,\n"
//                    + "       cast(nvl(sum(MONTANTPAYE), 0) as number(30, 3))                             as PAYE,\n"
//                    + "       cast((nvl(sum(montantttc), 0) - nvl(sum(montantpaye), 0)) as NUMBER(30, 3)) as arecouvrir,\n"
//                    + "       cast((l.montant) - nvl(sum(montantttc), 0) as NUMBER(30, 3))                as restebudget,\n"
//                    + "       cast(((nvl(sum(MONTANTTTC), 0)) / l.MONTANT) * 100 as NUMBER(30, 3))        as pourcEngage,\n"
//                    + "       cast(((nvl(sum(MONTANTPAYE), 0)) / l.MONTANT) * 100 as number(30, 3))       as pourcPaye,\n"
//                    + "       comptecpl,\n"
//                    + "        compteinv,\n"
//                    + "        comptesimple,\n"
//                    + "        directionProjet ,\n"
//                    + "        direction,\n"
//                    + "        projet\n"
//                    + "from SITUATIONLCDEPENSE_CPL l\n"
//                    + "         LEFT JOIN DETAILSFACTUREFOURNISSEUR_paye mf\n"
//                    + "                   on l.compte = mf.comptecpl AND mf.annee = l.annee\n"
//                    + "         left join (select COMPTECPL as compte, sum(MONTANTTTC) as montant, annee\n"
//                    + "                    from DETAILSFACTUREFOURNISSEUR_paye\n"
//                    + "                    where IDENGAGEMENT is null\n"
//                    + whereDaty
//                    + "                    group by COMPTECPL, annee) n on n.compte = l.COMPTE\n"
//                    + "         left join FACTFOURN_MONTANT_notNULL nt on nt.IDLC = l.id\n"
//                    + "         left join LIBERER_GRP gr on gr.IDLC = l.ID\n"
//                    + where + " and l.etat >= " + ConstanteEtat.getEtatValider() + "\n"
//                    + "      --and mf.comptecpl is not null\n"
//                    + "-- WHERE mf.IDMERE not in       (select id from ProvisionFactureDefinitive)\n"
//                    + "group by l.id, l.DESIGNATION, l.compte, l.ANNEE, l.montant, l.etat, substr(l.compte, 7, length(l.compte)), comptecpl,"
//                    + " n.montant, nt.MONTANT, gr.MONTANT";
//
//            LigneCredit stock = new LigneCredit();
//            stock.setNomTable("situationLC_vide");
//            return CGenUtil.rechercher(stock, req, c, colSomme);
//
//        } catch (Exception e) {
//            e.printStackTrace();
//            throw e;
//        } finally {
//            if (newCon && c != null) {
//                c.close();
//            }
//        }
//    }
    public static LigneCredit[] findSituationCreditDepense(String id, String desingation, String compte, String date1, String date2, String etat, String niveau, String exercice, String mois, Connection c) throws Exception {
        LigneCredit[] ret = null;
        boolean newCon = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                newCon = true;
            }
            String where = " where 1<2 ";
            //if(id!=null   && !id.equals("")) where+=" and upper(l.id) like upper('%"+id+"%')";
//             if(desingation!=null   && !desingation.equals("")) where+= "and upper(l.designation) like upper('%"+desingation+"%')";
            if (compte != null && !compte.equals("")) {
                where += " and upper(l.compte) like upper('%" + compte + "%')";
            }
            if (date1 != null && !date1.equals("")) {
                where += " and daty >= '" + date1 + "'";
            }
            if (date2 != null && !date2.equals("")) {
                where += " and daty <= '" + date2 + "'";
            }
            if (exercice != null && !exercice.equals("")) {
                where += " and l.annee = " + exercice;
            }
            if (mois != null && !mois.equals("")) {
                where += " and mf.mois = " + mois;
            }
            //if(etat != null && !etat.equals("")) where += " and l.etat = " + etat;

            String req = "select nvl(sum(MONTANTPAYE), 0) as PAYE,\n"
                    + "         nvl(sum(montantttc), 0)  as facture,\n"
                    + "        ( nvl(sum(montantttc), 0) - nvl(sum(MONTANTPAYE), 0)) as arecouvrir,\n"
                    + "        l.ANNEE,\n"
                    + //"        l.designation,\n" +
                    "        l.compte,\n"
                    + "        cr.LIBELLE       as libelle,\n"
                    + "        l.montant   as montant,\n"
                    + "        l.montant -  nvl(sum(montantttc), 0) as restebudget,\n"
                    + "         (((nvl(sum(MONTANTTTC), 0)) / l.MONTANT) * 100)      as pourcEngage,\n"
                    + "       (((nvl(sum(MONTANTPAYE), 0)) / l.MONTANT) * 100)       as pourcPaye \n"
                    + " from (\n"
                    + "          (SELECT\n"
                    + "               sum(l.QUANTITE)        as QUANTITE,\n"
                    + "               sum(l.MONTANT)         as montant,\n"
                    + "               l.ANNEE,\n"
                    + //"               l.designation,\n" +
                    "               substr(l.COMPTE, 1, " + niveau + ") as compte\n"
                    + "               --l.etat\n"
                    + "           FROM LIGNECREDITDEPENSE l\n"
                    + "           group by l.ANNEE, substr(l.COMPTE, 1, " + niveau + ")\n"
                    + //"           group by l.ANNEE, l.designation, substr(l.COMPTE, 1, " + niveau + ")\n" +
                    "           --, l.etat\n"
                    + "           ) l\n"
                    + "              LEFT JOIN (select sum(mf.MONTANTTTC)      as MONTANTTTC,\n"
                    + "                                sum(MONTANTPAYE)        as MONTANTPAYE,\n"
                    + "                                substr(mf.COMPTECPL, 1, " + niveau + ") as compte,\n"
                    + "                                mf.ANNEE,\n"
                    + "                                mois                    as mois,\n"
                    + "                                mf.daty\n"
                    + "                         from DETAILSFACTUREFOURNISSEUR_paye mf\n"
                    + "                         WHERE  mf.IDMERE not in\n"
                    + "                      (select id from ProvisionFactureDefinitive)\n"
                    + "                         group by substr(mf.COMPTECPL, 1, " + niveau + "), ANNEE, mois, daty) mf\n"
                    + "              ON l.compte = mf.compte\n"
                    + "                  AND mf.annee = l.annee\n"
                    + "                  )\n"
                    + "          LEFT JOIN COMPTE_RUBRIQUE cr ON l.COMPTE = cr.COMPTE\n"
                    + where
                    + "  group by l.ANNEE, l.compte, cr.LIBELLE, l.MONTANT";
//"  group by l.ANNEE, l.compte, cr.LIBELLE, l.designation, l.MONTANT";

            //req = String.format(req, where);
            //System.out.println("req=="+req);
            LigneCredit stock = new LigneCredit();
            stock.setNomTable("SITUATIONLC_VIDE");
            ret = (LigneCredit[]) CGenUtil.rechercher(stock, req, c);
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
    public LigneCredit() {
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

    public String getValColLibelle() {
        return comptestr + ";" + comptestr + ";" + designation + ";" + this.getCompte() + ";" + this.getCompte();
    }
}
