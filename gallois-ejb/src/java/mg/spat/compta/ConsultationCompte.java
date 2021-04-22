/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.compta;

import bean.CGenUtil;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Vector;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author MEVA
 */
public class ConsultationCompte extends ClassMAPTable {
    ComptaSousEcritureAvecDevise[] liste;
    double totalCredit;
    double totalDeviseCredit;
    double totalDebit;
    double totalDeviseDebit;
    double cumulDebit;
    double cumulDeviseDebit;
    double cumulCredit;
    double cumulDeviseCredit;
    double soldeDebit;
    double soldeDeviseDebit;
    double soldeCredit;
    double soldeDeviseCredit;
    double ancienCumulDebit;
    double ancienCumulDeviseDebit;
    double ancienCumulCredit;
    double ancienCumulDeviseCredit;
    String comptech;
    String compte;

    public ConsultationCompte() {
        
    }

    public ComptaSousEcritureAvecDevise[] getListe() {
        return liste;
    }

    public void setListe(ComptaSousEcritureAvecDevise[] liste) {
        this.liste = liste;
    }

    public double getTotalCredit() {
        return totalCredit;
    }

    public void setTotalCredit(double totalCredit) {
        this.totalCredit = totalCredit;
    }

    public double getTotalDeviseCredit() {
        return totalDeviseCredit;
    }

    public void setTotalDeviseCredit(double totalDeviseCredit) {
        this.totalDeviseCredit = totalDeviseCredit;
    }

    public double getTotalDebit() {
        return totalDebit;
    }

    public void setTotalDebit(double totalDebit) {
        this.totalDebit = totalDebit;
    }

    public double getTotalDeviseDebit() {
        return totalDeviseDebit;
    }

    public void setTotalDeviseDebit(double totalDeviseDebit) {
        this.totalDeviseDebit = totalDeviseDebit;
    }

    public double getCumulDebit() {
        return cumulDebit;
    }

    public void setCumulDebit(double cumulDebit) {
        this.cumulDebit = cumulDebit;
    }

    public double getCumulDeviseDebit() {
        return cumulDeviseDebit;
    }

    public void setCumulDeviseDebit(double cumulDeviseDebit) {
        this.cumulDeviseDebit = cumulDeviseDebit;
    }

    public double getCumulCredit() {
        return cumulCredit;
    }

    public void setCumulCredit(double cumulCredit) {
        this.cumulCredit = cumulCredit;
    }

    public double getCumulDeviseCredit() {
        return cumulDeviseCredit;
    }

    public void setCumulDeviseCredit(double cumulDeviseCredit) {
        this.cumulDeviseCredit = cumulDeviseCredit;
    }

    public double getSoldeDebit() {
        return soldeDebit;
    }

    public void setSoldeDebit(double soldeDebit) {
        this.soldeDebit = soldeDebit;
    }

    public double getSoldeDeviseDebit() {
        return soldeDeviseDebit;
    }

    public void setSoldeDeviseDebit(double soldeDeviseDebit) {
        this.soldeDeviseDebit = soldeDeviseDebit;
    }

    public double getSoldeCredit() {
        return soldeCredit;
    }

    public void setSoldeCredit(double soldeCredit) {
        this.soldeCredit = soldeCredit;
    }

    public double getSoldeDeviseCredit() {
        return soldeDeviseCredit;
    }

    public void setSoldeDeviseCredit(double soldeDeviseCredit) {
        this.soldeDeviseCredit = soldeDeviseCredit;
    }

    public double getAncienCumulDebit() {
        return ancienCumulDebit;
    }

    public void setAncienCumulDebit(double ancienCumulDebit) {
        this.ancienCumulDebit = ancienCumulDebit;
    }

    public double getAncienCumulDeviseDebit() {
        return ancienCumulDeviseDebit;
    }

    public void setAncienCumulDeviseDebit(double ancienCumulDeviseDebit) {
        this.ancienCumulDeviseDebit = ancienCumulDeviseDebit;
    }

    public double getAncienCumulCredit() {
        return ancienCumulCredit;
    }

    public void setAncienCumulCredit(double ancienCumulCredit) {
        this.ancienCumulCredit = ancienCumulCredit;
    }

    public double getAncienCumulDeviseCredit() {
        return ancienCumulDeviseCredit;
    }

    public void setAncienCumulDeviseCredit(double ancienCumulDeviseCredit) {
        this.ancienCumulDeviseCredit = ancienCumulDeviseCredit;
    }

    public String getComptech() {
        return comptech;
    }

    public void setComptech(String comptech) {
        this.comptech = comptech;
    }

    public String getCompte() {
        return compte;
    }

    public void setCompte(String compte) {
        this.compte = compte;
    }
    
    public ConsultationCompte(ComptaSousEcritureAvecDevise[] liste, double totalCredit, double totalDebit, double cumulDebit, double cumulCredit, double soldeDebit, double soldeCredit, double ancienCumulDebit, double ancienCumulCredit) {
        this.setListe(liste);
        this.setTotalDebit(totalDebit);
        this.setTotalCredit(totalCredit);
        this.setCumulCredit(cumulCredit);
        this.setCumulDebit(cumulDebit);
        this.setSoldeDebit(soldeDebit);
        this.setSoldeCredit(soldeCredit);
        this.setAncienCumulDebit(ancienCumulDebit);
        this.setAncienCumulCredit(ancienCumulCredit);
    }

    public ConsultationCompte(ComptaSousEcritureAvecDevise[] liste, double totalCredit, double totalDebit, double cumulDebit, double cumulCredit, double soldeDebit, double soldeCredit, double ancienCumulDebit, double ancienCumulCredit, String comptech) {
        this.setListe(liste);
        this.setTotalDebit(totalDebit);
        this.setTotalCredit(totalCredit);
        this.setCumulCredit(cumulCredit);
        this.setCumulDebit(cumulDebit);
        this.setSoldeDebit(soldeDebit);
        this.setSoldeCredit(soldeCredit);
        this.setAncienCumulDebit(ancienCumulDebit);
        this.setAncienCumulCredit(ancienCumulCredit);
        this.setComptech(comptech);
    }

    public ConsultationCompte(ComptaSousEcritureAvecDevise[] liste, double totalCredit, double totalDeviseCredit, double totalDebit, double totalDeviseDebit, double cumulDebit, double cumulDeviseDebit, double cumulCredit, double cumulDeviseCredit, double soldeDebit, double soldeDeviseDebit, double soldeCredit, double soldeDeviseCredit, double ancienCumulDebit, double ancienCumulDeviseDebit, double ancienCumulCredit, double ancienCumulDeviseCredit, String comptech) {
        this.setListe(liste);
        this.setTotalDebit(totalDebit);
        this.setTotalDeviseDebit(totalDeviseDebit);
        this.setTotalCredit(totalCredit);
        this.setTotalDeviseCredit(totalDeviseCredit);
        this.setCumulCredit(cumulCredit);
        this.setCumulDeviseCredit(cumulDeviseCredit);
        this.setCumulDebit(cumulDebit);
        this.setCumulDeviseDebit(cumulDeviseDebit);
        this.setSoldeDebit(soldeDebit);
        this.setSoldeDeviseDebit(soldeDeviseDebit);
        this.setSoldeCredit(soldeCredit);
        this.setSoldeDeviseCredit(soldeDeviseCredit);
        this.setAncienCumulDebit(ancienCumulDebit);
        this.setAncienCumulDeviseDebit(ancienCumulDeviseDebit);
        this.setAncienCumulCredit(ancienCumulCredit);
        this.setAncienCumulDeviseCredit(ancienCumulDeviseCredit);
        this.setComptech(comptech);
    }

    public ConsultationCompte(ComptaSousEcritureAvecDevise[] liste, double totalCredit, double totalDeviseCredit, double totalDebit, double totalDeviseDebit, double cumulDebit, double cumulDeviseDebit, double cumulCredit, double cumulDeviseCredit, double soldeDebit, double soldeDeviseDebit, double soldeCredit, double soldeDeviseCredit, double ancienCumulDebit, double ancienCumulDeviseDebit, double ancienCumulCredit, double ancienCumulDeviseCredit) {
        this.setListe(liste);
        this.setTotalDebit(totalDebit);
        this.setTotalDeviseDebit(totalDeviseDebit);
        this.setTotalCredit(totalCredit);
        this.setTotalDeviseCredit(totalDeviseCredit);
        this.setCumulCredit(cumulCredit);
        this.setCumulDeviseCredit(cumulDeviseCredit);
        this.setCumulDebit(cumulDebit);
        this.setCumulDeviseDebit(cumulDeviseDebit);
        this.setSoldeDebit(soldeDebit);
        this.setSoldeDeviseDebit(soldeDeviseDebit);
        this.setSoldeCredit(soldeCredit);
        this.setSoldeDeviseCredit(soldeDeviseCredit);
        this.setAncienCumulDebit(ancienCumulDebit);
        this.setAncienCumulDeviseDebit(ancienCumulDeviseDebit);
        this.setAncienCumulCredit(ancienCumulCredit);
        this.setAncienCumulDeviseCredit(ancienCumulDeviseCredit);
    }
    
    public ConsultationCompte[] traiterConsultation2AnalytiqueMultipleWithEtat(String lettrage, String mois, String mois2, String exercice, String compte1, String compte2, String typecompte,String etat) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            ConsultationCompte[] cc = traiterConsultation2AnalytiqueMultipleWithEtat(lettrage, mois, mois2, exercice, compte1, compte2, typecompte,etat, c);
            return cc;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }
    public HashMap getMouvementMuliple(String daty1, String daty2, String compte1, String compte2, String exercice, String typecompte, String awLettre, Connection c) throws Exception {
        totalCredit = 0;
        totalDebit = 0;
        soldeDebit = 0;
        soldeCredit = 0;
        try {
            HashMap hash = new HashMap();
            ComptaSousEcritureAvecDevise obj = new ComptaSousEcritureAvecDevise();
            obj.setNomTable("COMPTA_MOUVEMENT_DETAILS_GEN");
//            obj.setNomTable("COMPTA_MOUVEMENT_GENERAL_DTS");
            if (typecompte.compareTo("3") == 0) {
                obj.setNomTable("COMPTA_MOUVEMENT_DETAILS_ANAL");
            }
            ComptaSousEcritureAvecDevise[] liste = (ComptaSousEcritureAvecDevise[]) CGenUtil.rechercher(obj, null, null, c, " AND COMPTE >= '" + compte1 + "' AND COMPTE <= '" + compte2 + "' AND DATY >= '" + daty1 + "' AND DATY <= '" + daty2 + "' AND EXERCICE='" + exercice + "' " + awLettre + " ORDER BY COMPTE, DATY ASC");
            List<ComptaSousEcritureAvecDevise> list = new ArrayList();
            if (liste.length > 0) {
                String compte = liste[0].getCompte();
                
                totalCredit = 0;//liste[0].getCredit();
                totalDebit = 0;//liste[0].getDebit();
                for (int i = 0; i < liste.length; i++) {
                    //list.add(liste[0]);
                    if (compte.compareTo(liste[i].getCompte()) == 0) {
                        totalCredit = totalCredit + liste[i].getCredit();
                        totalDebit = totalDebit + liste[i].getDebit();
                        list.add(liste[i]);
                        if (i == liste.length - 1) {
                            ComptaSousEcritureAvecDevise[] listObj = new ComptaSousEcritureAvecDevise[list.size()];
                            list.toArray(listObj);
                            ConsultationCompte cc = new ConsultationCompte(listObj, totalCredit, totalDebit, 0, 0, soldeDebit, soldeCredit, 0, 0, liste[i].getCompte());
                            hash.put(liste[i].getCompte(), cc);
                        }
                    } else if (compte.compareTo(liste[i].getCompte()) != 0) {
                        ComptaSousEcritureAvecDevise[] listObj = new ComptaSousEcritureAvecDevise[list.size()];
                        list.toArray(listObj);
                        ConsultationCompte cc = new ConsultationCompte(listObj, totalCredit, totalDebit, 0, 0, soldeDebit, soldeCredit, 0, 0, compte);
                        hash.put(compte, cc);
                        list = new ArrayList();
                        list.add(liste[i]);
                        totalCredit = liste[i].getCredit();
                        totalDebit = liste[i].getDebit();
                        if (i == liste.length - 1) {
                            listObj = new ComptaSousEcritureAvecDevise[list.size()];
                            list.toArray(listObj);
                            cc = new ConsultationCompte(listObj, totalCredit, totalDebit, 0, 0, soldeDebit, soldeCredit, 0, 0, liste[i].getCompte());
                            hash.put(liste[i].getCompte(), cc);
                        }
                    }
                    compte = liste[i].getCompte();
                }
            }
            return hash;
        } catch (Exception e) {
            throw e;
        }
    }
    public HashMap getReportSoldeMultiple(String mois, String daty1, String daty2, String compte1, String compte2, String exercice, String typecompte, String awLettre, Connection c, ComptaCompte[] listeCompte) throws Exception {
        HashMap map = new HashMap();
        double ancienCumulDebit = 0, ancienCumulCredit = 0;
        String compte = "";
        ReportSolde rs = new ReportSolde();
//        int m = Utilitaire.stringToInt(mois);
//        m = m-1;                
//        if(mois.compareToIgnoreCase("01")!=0){
//                rs.setNomTable("REPORTSOLDE2"); 
//        }
        //ReportSolde[] reportliste = (ReportSolde[]) CGenUtil.rechercher(rs, null, null, c, " and annee = '" + exercice + "' and typecompte = '" + typecompte + "' and mois >=1 and mois<="+m+" AND COMPTE BETWEEN  '"+compte1+"' AND '"+compte2+"' order by COMPTE3CHIFRE, COMPTE asc");
        String awhere = "AND COMPTE >=  '" + compte1 + "' AND COMPTE <='" + compte2 + "'";
        ComptaEtatBalance2[] reportliste = ComptaEtatService.getSoldeParCompte(exercice, daty1, daty2, mois, compte1, compte2, typecompte, awhere, c, listeCompte);
        System.out.println("reportliste = " + reportliste.length);
        if (reportliste.length > 0) {
            compte = reportliste[0].getCompte();
            ancienCumulDebit = 0;//ancienCumulDebit + reportliste[0].getDebit();
            ancienCumulCredit = 0;//ancienCumulCredit + reportliste[0].getCredit();
            for (int i = 0; i < reportliste.length; i++) {
                if (compte.compareTo(reportliste[i].getCompte()) == 0) {
                    ancienCumulDebit = ancienCumulDebit + reportliste[i].getDebit();
                    ancienCumulCredit = ancienCumulCredit + reportliste[i].getCredit();
                    if (i == reportliste.length - 1) {
                        double diffs = ancienCumulDebit - ancienCumulCredit;
                        if (diffs > 0) {
                            ancienCumulDebit = diffs;
                            ancienCumulCredit = 0;
                        } else {
                            ancienCumulCredit = diffs * (-1);
                            ancienCumulDebit = 0;
                        }
                        rs = new ReportSolde(ancienCumulDebit, ancienCumulCredit, compte, null);
                        map.put(compte, rs);
                    }
                } else if (compte.compareTo(reportliste[i].getCompte()) != 0) {
                    double diffs = ancienCumulDebit - ancienCumulCredit;
                    if (diffs > 0) {
                        ancienCumulDebit = diffs;
                        ancienCumulCredit = 0;
                    } else {
                        ancienCumulCredit = diffs * (-1);
                        ancienCumulDebit = 0;
                    }
                    rs = new ReportSolde(ancienCumulDebit, ancienCumulCredit, compte, null);
                    ancienCumulDebit = reportliste[i].getDebit();
                    ancienCumulCredit = reportliste[i].getCredit();
                    map.put(compte, rs);
                }
                compte = reportliste[i].getCompte();
            }
        }
        return map;
    }
    public void calculSolde(ConsultationCompte mvt, ReportSolde rs) {
        double mvtDB = 0, mvtCR = 0;
        double rsDB = 0, rsCR = 0;
        if (mvt != null) {
            mvtDB = mvt.getTotalDebit();
            mvtCR = mvt.getTotalCredit();
        }
        if (rs != null) {
            rsDB = rs.getDebit();
            rsCR = rs.getCredit();
        }
        double solde = (mvtDB + rsDB) - (mvtCR + rsCR);
        if (solde > 0) {
            soldeDebit = solde;
            soldeCredit = 0;
        } else {
            soldeDebit = 0;
            soldeCredit = solde * (-1);
        }
    }
    public ConsultationCompte createObject(ConsultationCompte mvt, ReportSolde rs) {
        if (rs != null && mvt == null) {
            System.out.println("1 ===== ======");
            return new ConsultationCompte(null, 0, 0, rs.getDebit(), rs.getCredit(), soldeDebit, soldeCredit, rs.getDebit(), rs.getCredit(), rs.getCompte());
        } else if (rs == null && mvt != null) {
            System.out.println("2 ===== ======");
            return new ConsultationCompte(mvt.getListe(), mvt.getTotalCredit(), mvt.getTotalDebit(), mvt.getTotalDebit(), mvt.getTotalCredit(), soldeDebit, soldeCredit, 0, 0, mvt.getComptech());
        } else if (rs != null && mvt != null) {
            System.out.println("3 ===== ======");
            return new ConsultationCompte(mvt.getListe(), mvt.getTotalCredit(), mvt.getTotalDebit(), rs.getDebit() + mvt.getTotalDebit(), rs.getCredit() + mvt.getTotalCredit(), soldeDebit, soldeCredit, rs.getDebit(), rs.getCredit(), rs.getCompte());
        }
        return null;
    }
    public ConsultationCompte[] traiterConsultation2AnalytiqueMultipleWithEtat(String lettrage, String mois, String mois2, String exercice, String compte1, String compte2, String typecompte,String etat, Connection c) throws Exception {
        try {
            String awLettre = "";
            String daty1 = "01/" + mois + "/" + exercice;
            String daty2 = Utilitaire.getLastJourInMonth(Utilitaire.string_date("dd/MM/yyyy", "01/" + mois2 + "/" + exercice)) + "/" + mois2 + "/" + exercice;
            String awhere = ComptaEtatService.aWhere(exercice, daty1, daty2, mois, compte1, compte2, typecompte);
            if(etat.compareTo("1") == 0){
                awLettre = awLettre;
            }
            else if(etat.compareTo("2") == 0){
                awLettre += " and etat=11";
            }
            else if(etat.compareTo("3") == 0){
                awLettre += " and etat=1";
            }
            System.out.println("awLettre"+awLettre);
            ComptaCompte co = new ComptaCompte();
            co.setNomTable("COMPTA_COMPTE_3CHIFFRE");
            ComptaCompte[] listeCompte = (ComptaCompte[]) CGenUtil.rechercher(co, null, null, c, awhere + " ORDER BY CHIFFRE3, COMPTE ASC");
            HashMap mapMvt = getMouvementMuliple(daty1, daty2, compte1, compte2, exercice, typecompte, awLettre, c);
            HashMap reportMap = getReportSoldeMultiple(mois, daty1, daty2, compte1, compte2, exercice, typecompte, awLettre, c, listeCompte);

            Vector<ConsultationCompte> v = new Vector();
            for (int i = 0; i < listeCompte.length; i++) {
                ReportSolde rs = (ReportSolde) reportMap.get(listeCompte[i].getCompte());
                //System.out.println("listeCompte[i].getCompte() =============== " + listeCompte[i].getCompte());
                ConsultationCompte mvt = (ConsultationCompte) mapMvt.get(listeCompte[i].getCompte());
                calculSolde(mvt, rs);
                ConsultationCompte cc = createObject(mvt, rs);
                if (cc != null) {
                    cc.setCompte(listeCompte[i].getCompte());
                }
                if (cc != null) {
                    v.add(cc);
                }
            }
            ConsultationCompte[] ret = new ConsultationCompte[v.size()];
            v.copyInto(ret);
            return ret;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public String getTuppleID() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String getAttributIDName() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}
