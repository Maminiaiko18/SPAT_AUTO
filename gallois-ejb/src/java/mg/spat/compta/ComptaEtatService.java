/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.compta;

import bean.CGenUtil;
import bean.TypeObjet;
import java.sql.Connection;
import java.util.Vector;
import reporting.UtilitaireServeurPDF;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author MEVA
 */
public class ComptaEtatService {
    public static final String TYPE_COMPTE_G = "1";
    public static final String TYPE_COMPTE_AUX = "2";
    private static double montantTotalDeuxChiffresDebit = 0, montantTotalDeuxChiffresCredit = 0;
    private static double montantTotalAntDeuxChiffresDebit = 0, montantTotalAntDeuxChiffresCredit = 0;
    private static double montantTotalUnChiffresDebit = 0, montantTotalUnChiffresCredit = 0, montantTotalAntUnChiffresDebit = 0, montantTotalAntUnChiffresCredit = 0;
    private static double montantTotalGeneralDebit = 0, montantTotalGeneralCredit = 0, montantTotalAntDebit = 0, montantTotalAntCredit = 0, montantSoldeTotalDB = 0, montantSoldeTotalCR = 0;
    private static String valeurTroisChiffres = "";
    private static String valeurDeuxChiffres = "";
    private static String valeurUnChiffre = "";
    private static double montantSoldeMouvementDebit = 0, montantSoldeMouvementCredit = 0, montantTotalSoldeMouvementDebit = 0, montantTotalSoldeMouvementCredit = 0;
    private static double montantTotalPremChiffresDebit = 0, montantTotalPremChiffresCredit = 0, montantTotalAntPremChiffresDebit = 0, montantTotalAntPremChiffresCredit = 0;

    private static double montantSoldeTotalDB1chiffre = 0, montantSoldeTotalCR1chiffre = 0, montantSoldeTotalDB2chiffre = 0, montantSoldeTotalCR2chiffre = 0;

    private static void initValue() {
        montantTotalGeneralDebit = 0;
        montantTotalGeneralCredit = 0;
        montantSoldeTotalDB = 0;
        montantSoldeTotalCR = 0;
        montantTotalAntDebit = 0;
        montantTotalAntCredit = 0;
        montantTotalSoldeMouvementDebit = 0;
        montantTotalSoldeMouvementCredit = 0;
        montantTotalDeuxChiffresDebit = 0;
        montantTotalDeuxChiffresCredit = 0;
        montantTotalAntDeuxChiffresDebit = 0;
        montantTotalAntDeuxChiffresCredit = 0;
        montantTotalUnChiffresDebit = 0;
        montantTotalUnChiffresCredit = 0;
        montantTotalAntUnChiffresDebit = 0;
        montantTotalAntUnChiffresCredit = 0;
        montantSoldeMouvementDebit = 0;
        montantSoldeMouvementCredit = 0;
        valeurTroisChiffres = "";
        valeurDeuxChiffres = "";

        montantSoldeTotalDB1chiffre = 0;
        montantSoldeTotalCR1chiffre = 0;
        montantSoldeTotalDB2chiffre = 0;
        montantSoldeTotalCR2chiffre = 0;
    }
    private static void sommeMontant(double debit, double credit, double antDB, double antCR, double[] solde) {
        montantTotalGeneralDebit = montantTotalGeneralDebit + debit;
        montantTotalGeneralCredit = montantTotalGeneralCredit + credit;
        montantTotalAntDebit = montantTotalAntDebit + antDB;
        montantTotalAntCredit = montantTotalAntCredit + antCR;
        montantTotalDeuxChiffresDebit = montantTotalDeuxChiffresDebit + debit;
        montantTotalDeuxChiffresCredit = montantTotalDeuxChiffresCredit + credit;
        montantTotalUnChiffresDebit = montantTotalUnChiffresDebit + debit;
        montantTotalUnChiffresCredit = montantTotalUnChiffresCredit + credit;
        montantTotalAntDeuxChiffresDebit = montantTotalAntDeuxChiffresDebit + antDB;
        montantTotalAntDeuxChiffresCredit = montantTotalAntDeuxChiffresCredit + antCR;
        montantTotalAntUnChiffresDebit = montantTotalAntUnChiffresDebit + antDB;
        montantTotalAntUnChiffresCredit = montantTotalAntUnChiffresCredit + antCR;
        montantTotalPremChiffresDebit = montantTotalPremChiffresDebit + debit;
        montantTotalPremChiffresCredit = montantTotalPremChiffresCredit + credit;
        montantTotalAntPremChiffresDebit = montantTotalAntPremChiffresDebit + antDB;
        montantTotalAntPremChiffresCredit = montantTotalAntPremChiffresCredit + antCR;
        //BalanceDesComptes bdc = new BalanceDesComptes();
        //double[] solde = bdc.valSolde(debit,credit);
        montantSoldeTotalDB = montantSoldeTotalDB + solde[0];
        montantSoldeTotalCR = montantSoldeTotalCR + solde[1];

        montantSoldeTotalDB2chiffre = montantSoldeTotalDB2chiffre + solde[0];
        montantSoldeTotalCR2chiffre = montantSoldeTotalCR2chiffre + solde[1];
        montantSoldeTotalDB1chiffre = montantSoldeTotalDB1chiffre + solde[0];
        montantSoldeTotalCR1chiffre = montantSoldeTotalCR1chiffre + solde[1];

        double soldesmouvement = debit - credit;
        if (soldesmouvement > 0) {
            montantSoldeMouvementDebit = soldesmouvement;
            montantSoldeMouvementCredit = 0;
            montantTotalSoldeMouvementDebit = montantTotalSoldeMouvementDebit + soldesmouvement;
        } else {
            montantSoldeMouvementDebit = 0;
            montantSoldeMouvementCredit = soldesmouvement * (-1);
            montantTotalSoldeMouvementCredit = montantTotalSoldeMouvementCredit + soldesmouvement * (-1);
        }
    }
    private static void reinit3Chiffre() {
        montantTotalDeuxChiffresDebit = 0;
        montantTotalDeuxChiffresCredit = 0;
        montantTotalAntDeuxChiffresDebit = 0;
        montantTotalAntDeuxChiffresCredit = 0;

        montantSoldeTotalDB2chiffre = 0;
        montantSoldeTotalCR2chiffre = 0;
    }
    private static void reinit2Chiffre() {
        montantTotalUnChiffresDebit = 0;
        montantTotalUnChiffresCredit = 0;
        montantTotalAntUnChiffresDebit = 0;
        montantTotalAntUnChiffresCredit = 0;
        montantTotalAntDeuxChiffresDebit = 0;
        montantTotalAntDeuxChiffresCredit = 0;

        montantSoldeTotalDB1chiffre = 0;
        montantSoldeTotalCR1chiffre = 0;
    }
    
    public static BalanceDesComptes[] traiterBalanceRAnalytiqueSisal(ComptaEtatBalance2[] listes, String exercice, String date1, String date2, String mois, String compte1, String compte2, String typecompte) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
//            return traiterBalanceRAnalytique(listes, exercice, date1, date2, mois, compte1, compte2, typecompte, c);
            return traiterBalanceRAnalytiqueSisal(listes, exercice, date1, date2, mois, compte1, compte2, typecompte, c);
        } catch (Exception e) {
            throw e;
        } finally {
            c.close();
        }
    }
    public static String aWhere(String exercice, String date1, String date2, String mois, String compte1, String compte2, String typecompte) {
        String farany = "";
        if (typecompte.compareTo("1") == 0) {
            farany = "7999999";
        }
        if (typecompte.compareTo("3") == 0) {
            farany = "9999999";
        }
        String awhere = "";
        if (compte1 != null && compte1.compareTo("") != 0 && compte2 != null && compte2.compareTo("") == 0) {
            awhere = " AND COMPTE >= '" + compte1 + "' AND COMPTE <= '" + farany + "'";
        }
        if (compte1 != null && compte1.compareTo("") != 0 && compte2 != null && compte2.compareTo("") != 0) {
            awhere = " AND COMPTE >= '" + compte1 + "' AND COMPTE <='" + compte2 + "'";
        }
        return awhere;
    }
    public static ComptaEtatBalance2[] getSoldeParCompte(String exercice, String date1, String date2, String mois, String compte1, String compte2, String typecompte, String awhere, Connection c, ComptaCompte[] listeCompte) throws Exception {
        try {
            ComptaEtatBalance2 rs = new ComptaEtatBalance2();
            ComptaEtatBalance2[] reportliste = null;
            System.out.println("reportliste = " + Utilitaire.getMois(date1) + " == " + date1);
            if (Utilitaire.stringToInt(Utilitaire.getMois(date1)) != 1) {
                int moisavant = Utilitaire.stringToInt(Utilitaire.getMois(date1)) - 1;
                rs.setNomTable("REPORTSOLDE_GENERAL");
                if (typecompte.equals("3")) {
                    rs.setNomTable("REPORTSOLDE_ANALYTIQUE");
                }
                System.out.println(" Suite awhere  if mois!=1: "+"and annee='" + exercice + "' and typecompte ='" + typecompte + "' and mois >=1 AND mois<=" + moisavant + " " + awhere + " ORDER BY CHIFFRE3, COMPTE ASC");
                //reportliste = (ComptaEtatBalance2[]) CGenUtil.rechercher(rs, null, null, c, " and annee='" + exercice + "' and typecompte ='" + typecompte + "' and mois >=1 AND mois<=" + moisavant + " " + awhere + " ORDER BY CHIFFRE3, COMPTE ASC");
                reportliste = (ComptaEtatBalance2[]) CGenUtil.rechercher(rs, null, null, c, " and annee='" + exercice + "' and mois >=1 AND mois<=" + moisavant + " " + awhere + " ORDER BY CHIFFRE3, COMPTE ASC");
                Vector<ComptaEtatBalance2> v = new Vector();
                double debit = 0, credit = 0;
                String chiffre3 = "", chiffre2 = "";
                boolean isAto = false;
                for (int i = 0; i < listeCompte.length; i++) {
                    for (int j = 0; j < reportliste.length; j++) {
                        if (listeCompte[i].getCompte().compareTo(reportliste[j].getCompte()) == 0) {
                            debit = debit + reportliste[j].getDebit();
                            credit = credit + reportliste[j].getCredit();
                            chiffre3 = reportliste[j].getChiffre3();
                            chiffre2 = reportliste[j].getChiffre2();
                            isAto = true;
                        }
                    }
                    if (isAto) {
                        rs = new ComptaEtatBalance2(debit, credit, listeCompte[i].getCompte(), listeCompte[i].getLibelle(), listeCompte[i].getTypeCompte(), chiffre3, chiffre2);
                        v.add(rs);
                    }
                    debit = 0;
                    credit = 0;
                    isAto = false;
                }
                ComptaEtatBalance2[] ret = new ComptaEtatBalance2[v.size()];
                v.copyInto(ret);
                return ret;
            } else if (Utilitaire.stringToInt(Utilitaire.getMois(date1)) == 1) {
                System.out.println(" Suite awhere  if mois==1: "+" and annee = '" + exercice + "' and typecompte = '" + typecompte + "'" + awhere + " ORDER BY CHIFFRE3, COMPTE ASC");
                System.out.println("nomTable dans mois==1:"+"REPORTSOLDE_JANVIER");
                rs.setNomTable("REPORTSOLDE_JANVIER");
                //reportliste = (ComptaEtatBalance2[]) CGenUtil.rechercher(rs, null, null, c, " and annee = '" + exercice + "' and typecompte = '" + typecompte + "'" + awhere + " ORDER BY CHIFFRE3, COMPTE ASC");
                reportliste = (ComptaEtatBalance2[]) CGenUtil.rechercher(rs, null, null, c, " and annee = '" + exercice + "'" + awhere + " ORDER BY CHIFFRE3, COMPTE ASC");
                return reportliste;
            }
            return null;
        } catch (Exception e) {
            throw e;
        }
    }
    public static BalanceDesComptes[] touslesComptes(ComptaEtatBalance2[] listeMouvement, ComptaEtatBalance2[] report_liste, String typecompte, String awhere, Connection c, ComptaCompte[] listeCompte) throws Exception {
        BalanceDesComptes bdc = null;
        Vector<BalanceDesComptes> v = new Vector();
        for (int i = 0; i < listeCompte.length; i++) {
            double debit = 0, credit = 0;
            String chiffre3 = "", chiffre2 = "";
            boolean isAto = false;
            //System.out.println("listeMouvement.length = " + listeMouvement.length);
            if (listeMouvement.length > 0) {
                for (int j = 0; j < listeMouvement.length; j++) {
                    //System.out.println(" listeCompte[i].getCompte() = " + listeCompte[i].getCompte()+ " == " + listeCompte[i].getId() + " == "+listeMouvement[j].getCompte());
                        
                    if (listeCompte[i].getCompte().compareTo(listeMouvement[j].getCompte()) == 0) {
                        //System.out.println(" listeMouvement[j].getCompte() = " + listeMouvement[j].getCompte());
                        //String compte, String libelle_compte, double mouvementDebit, double mouvementCredit, double anterieurDebit, double anterieurCredit, String chiffre3, String chiffre2
                        debit = debit + listeMouvement[j].getDebit();
                        credit = credit + listeMouvement[j].getCredit();
                        chiffre3 = listeMouvement[j].getChiffre3();
                        chiffre2 = listeMouvement[j].getChiffre2();
                        isAto = true;
                    }
                }
                if (isAto) {
                    bdc = new BalanceDesComptes(listeCompte[i].getCompte(), listeCompte[i].getLibelle(), debit, credit, 0, 0, chiffre3, chiffre2);
                }
            }
            for (int j = 0; j < report_liste.length; j++) {
                if (listeCompte[i].getCompte().compareTo(report_liste[j].getCompte()) == 0) {
                    if (bdc == null) {
                        bdc = new BalanceDesComptes(listeCompte[i].getCompte(), listeCompte[i].getLibelle(), report_liste[j].getChiffre3(), report_liste[j].getChiffre2());
                    }
                    bdc.setAnterieurDebit(report_liste[j].getDebit());
                    bdc.setAnterieurCredit(report_liste[j].getCredit());
                    break;
                }
            }
            if (bdc != null) {
                v.add(bdc);
            }
            bdc = null;
        }
        BalanceDesComptes[] ret = new BalanceDesComptes[v.size()];
        v.copyInto(ret);
        return ret;
    }
    public static BalanceDesComptes[] traiterBalanceRAnalytiqueSisal(ComptaEtatBalance2[] listes, String exercice, String date1, String date2, String mois, String compte1, String compte2, String typecompte, Connection c) throws Exception {
        try {
            initValue();
            String awhere = aWhere(exercice, date1, date2, mois, compte1, compte2, typecompte);
            //System.out.println("awhereeeeeeeeeeeeeeeeeeeeeee = " + awhere);
            ComptaCompte cc = new ComptaCompte();
            cc.setNomTable("compta_compte_3chiffre");
            ComptaCompte[] listeCompte = (ComptaCompte[]) CGenUtil.rechercher(cc, null, null, c, " AND COMPTE not like '9%' " + awhere + " ORDER BY CHIFFRE3, COMPTE ASC");
            //System.out.println("listeCompte = " + listeCompte.length);
            ComptaEtatBalance2[] report_liste = getSoldeParCompte(exercice, date1, date2, mois, compte1, compte2, typecompte, awhere, c, listeCompte);
            //System.out.println("liste.report_liste = " + report_liste.length);
            BalanceDesComptes[] liste = touslesComptes(listes, report_liste, typecompte, awhere, c, listeCompte);
            //System.out.println("liste.length = " + liste.length);
            BalanceDesComptes bdc = new BalanceDesComptes();
            Vector<BalanceDesComptes> balanceDesComptes = new Vector();
            String temps = "", temp = "";
            int j = 1;
            if (liste.length > 0) {
                valeurTroisChiffres = liste[0].getChiffre3();//28-40
                valeurDeuxChiffres = liste[0].getChiffre2();//2-4
                if (liste.length > 1) {
                    temps = liste[j].getChiffre3();//28-40
                    temp = liste[j].getChiffre2();
                }
                for (int i = 0; i < liste.length; i++) {
                    double[] solde = bdc.valSolde(liste[i].getMouvementDebit() + liste[i].getAnterieurDebit(), liste[i].getAnterieurCredit() + liste[i].getMouvementCredit());
                    sommeMontant(liste[i].getMouvementDebit(), liste[i].getMouvementCredit(), liste[i].getAnterieurDebit(), liste[i].getAnterieurCredit(), solde);
                    bdc = new BalanceDesComptes(liste[i].getCompte(), liste[i].getLibelle_compte(), liste[i].getMouvementDebit(), liste[i].getMouvementCredit(), solde[0], solde[1], liste[i].getAnterieurDebit() + liste[i].getMouvementDebit(), liste[i].getAnterieurCredit() + liste[i].getMouvementCredit());
                    balanceDesComptes.add(bdc);
                    if ((i + 1 < liste.length || i == liste.length - 1)) {
                        if ((valeurTroisChiffres != null && temps != null && valeurTroisChiffres.compareToIgnoreCase(temps) != 0) || i == liste.length - 1) {
                            //solde = bdc.valSolde(montantTotalDeuxChiffresDebit+montantTotalAntDeuxChiffresDebit,montantTotalAntDeuxChiffresCredit+montantTotalDeuxChiffresCredit);
                            bdc = new BalanceDesComptes("ST3", "SOUS-TOTAUX " + valeurTroisChiffres, montantTotalDeuxChiffresDebit, montantTotalDeuxChiffresCredit, montantSoldeTotalDB2chiffre, montantSoldeTotalCR2chiffre, montantTotalDeuxChiffresDebit + montantTotalAntDeuxChiffresDebit, montantTotalAntDeuxChiffresCredit + montantTotalDeuxChiffresCredit);
                            valeurTroisChiffres = temps;
                            balanceDesComptes.add(bdc);
                            reinit3Chiffre();
                        }
                        if ((valeurDeuxChiffres != null && temp != null && valeurDeuxChiffres.compareToIgnoreCase(temp) != 0) || i == liste.length - 1) {
                            //solde = bdc.valSolde(montantTotalUnChiffresDebit+montantTotalAntUnChiffresDebit,montantTotalAntUnChiffresCredit+montantTotalUnChiffresCredit);
                            bdc = new BalanceDesComptes("ST2", "SOUS-TOTAUX " + valeurDeuxChiffres, montantTotalUnChiffresDebit, montantTotalUnChiffresCredit, montantSoldeTotalDB1chiffre, montantSoldeTotalCR1chiffre, montantTotalUnChiffresDebit + montantTotalAntUnChiffresDebit, montantTotalAntUnChiffresCredit + montantTotalUnChiffresCredit);
                            valeurDeuxChiffres = temp;
                            balanceDesComptes.add(bdc);
                            reinit2Chiffre();
                        }

                        if (j + 1 < liste.length) {
                            temps = liste[j + 1].getChiffre3();
                            temp = liste[j + 1].getChiffre2();
                        }
                        j++;
                    }
                }
                bdc = new BalanceDesComptes("STT", "TOTAUX", montantTotalGeneralDebit, montantTotalGeneralCredit, montantSoldeTotalDB, montantSoldeTotalCR, montantTotalAntDebit + montantTotalGeneralDebit, montantTotalAntCredit + montantTotalGeneralCredit);
                balanceDesComptes.add(bdc);
            }
            BalanceDesComptes[] retour = new BalanceDesComptes[balanceDesComptes.size()];
            balanceDesComptes.copyInto(retour);
            System.out.println("balanceDesComptes.size().length ====== " + balanceDesComptes.size());
            return retour;
        } catch (Exception e) {
            throw e;
        }
    }  
    public static ComptaEtatGrandLivre[] traiterGrandLivre(ComptaEtatGrandLivre[] liste) throws Exception {
        int i = 0;
        for (ComptaEtatGrandLivre gl : liste) {
            if (i == 0) {
                if (gl.getDebit() > 0) {
                    liste[i].setDebiteur(gl.getDebit());
                } else {
                    liste[i].setCrediteur(gl.getCredit());
                }
            } else {
                double montant = liste[i - 1].getCrediteur() > 0 ? liste[i - 1].getCrediteur() : -liste[i - 1].getDebiteur();
                montant = montant - gl.getDebit() + gl.getCredit();
                if (montant > 0) {
                    liste[i].setCrediteur(montant);
                } else {
                    liste[i].setDebiteur(Math.abs(montant));
                }
            }
            i++;
        }
        return liste;
    }
    public static ComptaBalance[] getBalance(String exercice, String datyMin, String datyMax, String compte) throws Exception {
        String critere = "";
        critere += UtilitaireServeurPDF.makeCritereStringWithTestNull("EXERCICE", exercice, "=");
        critere += UtilitaireServeurPDF.makeCritereStringWithTestNull("DATY", datyMin, ">=");
        critere += UtilitaireServeurPDF.makeCritereStringWithTestNull("DATY", datyMax, "<=");
        critere += UtilitaireServeurPDF.makeCritereStringWithTestNull("COMPTE", compte, "=");
        critere += " ORDER BY COMPTE";
        ComptaBalance comptaBalance = new ComptaBalance();
        comptaBalance.setNomTable("compta_sous_ecriture_vise");
        return (ComptaBalance[]) CGenUtil.rechercher(comptaBalance, null, null, null, critere);
    }
    public static FicheEcriture getFicheEcriture(String id) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            FicheEcriture ficheEcriture = new FicheEcriture();
            ComptaEcriture ecriture = new ComptaEcriture();
            ecriture.setNomTable("COMPTA_ECRITURE_LIBELLE");
            ComptaEcriture[] ecritures = (ComptaEcriture[]) CGenUtil.rechercher(ecriture, null, null, c, " AND ID = '" + id + "'");
            ComptaSousEcriture[] sousEcritures = (ComptaSousEcriture[]) CGenUtil.rechercher(new ComptaSousEcriture(), null, null, null, " AND MERE ='" + id + "'order by debit desc");
            ficheEcriture.setEcritures(ecritures);
            ficheEcriture.setSousEcritures(sousEcritures);
            return ficheEcriture;
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }
    public static JournalCompta getJournalCompta(String exercice, String datyMin, String datyMax, String journal) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            JournalCompta journalCompta = new JournalCompta();
            String critere = "";
            if (UtilitaireServeurPDF.testNullEtVide(exercice)) {
                journalCompta.setTitre("DE L'ANNEE " + exercice);
                critere += UtilitaireServeurPDF.makeCritereStringWithTestNull("EXERCICE", exercice, "=");
            }
            if (UtilitaireServeurPDF.testNullEtVide(datyMin) && UtilitaireServeurPDF.testNullEtVide(datyMax)) {
                critere += UtilitaireServeurPDF.makeCritereStringWithTestNull("DATY", datyMin, ">=");
                critere += UtilitaireServeurPDF.makeCritereStringWithTestNull("DATY", datyMax, "<=");
                journalCompta.setTitre("DU " + datyMin + " AU" + datyMax);
            }
            if (UtilitaireServeurPDF.testNullEtVide(journal)) {
                TypeObjet typeobjet = new TypeObjet();
                typeobjet.setNomTable("COMPTA_JOURNAL");
                String typeCompteId = " AND VAL = '" + journal + "'";
                TypeObjet[] comptaJournalTypeObjet = (TypeObjet[]) CGenUtil.rechercher(typeobjet, null, null, c, typeCompteId);
                if (comptaJournalTypeObjet.length > 0) {
                    critere += UtilitaireServeurPDF.makeCritereStringWithTestNull("JOURNAL", comptaJournalTypeObjet[0].getId(), "=");
                    journalCompta.setType(comptaJournalTypeObjet[0].getDesce());
                }
            }
            critere += " ORDER BY MERE";
            ComptaJournal comptaJournal = new ComptaJournal();
            comptaJournal.setNomTable("COMPTA_JOURNAL_ETAT");
            ComptaJournal[] journals = (ComptaJournal[]) CGenUtil.rechercher(comptaJournal, null, null, c, critere);
            journalCompta.setComptaJournal(journals);
            return journalCompta;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }
    public static ComptaEtatBalance2[] findBalance2AnalytiqueWithEtat(String mois1, String mois2, String daty1, String daty2, String compte1, String compte2, String typecompte, String exercice,String etat) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            return findBalance2AnalytiqueWithEtat(c, mois1, mois2, daty1, daty2, compte1, compte2, typecompte, exercice,etat);
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }
    public static ComptaEtatBalance2[] findBalance2AnalytiqueWithEtat(Connection c, String mois1, String mois2, String daty1, String daty2, String compte1, String compte2, String typecompte, String exercice, String etat) throws Exception {
        try {
            String awhere = aWhere(exercice, daty1, daty2, mois1, compte1, compte2, typecompte);
            if(etat.compareTo("1") == 0){
                awhere = awhere;
            }
            else if(etat.compareTo("2") == 0){
                awhere += " and etat=11";
            }
            else if(etat.compareTo("3") == 0){
                awhere += " and etat=1";
            }
            ComptaEtatBalance2 ceb = new ComptaEtatBalance2();
            ComptaEtatBalance2[] lsBalance = null;
            if (typecompte.compareTo("3") == 0) {
                ceb.setNomTable("COMPTA_MOUVEMENT_ANALYTIQUE");
                lsBalance = (ComptaEtatBalance2[]) CGenUtil.rechercher(ceb, null, null, c, " AND MOIS>=" + Utilitaire.stringToInt(mois1) + " AND MOIS<=" + Utilitaire.stringToInt(mois2) + " AND ANNEE = " + Utilitaire.stringToInt(exercice) + " " + awhere + " ORDER BY CHIFFRE3 ASC");
                
            } else if (typecompte.compareTo("1") == 0) {
                ceb.setNomTable("COMPTA_MOUVEMENT_GENERAL");
                lsBalance = (ComptaEtatBalance2[]) CGenUtil.rechercher(ceb, null, null, c, " AND MOIS>=" + Utilitaire.stringToInt(mois1) + " AND MOIS<=" + Utilitaire.stringToInt(mois2) + " AND ANNEE = " + Utilitaire.stringToInt(exercice) + " " + awhere + " ORDER BY CHIFFRE3 ASC");
                
            }
            return lsBalance;
        } catch (Exception e) {
            throw e;
        }
    }
    public static ComptaEtatBalance2[] findBalance2Analytique(String mois1, String mois2, String daty1, String daty2, String compte1, String compte2, String typecompte, String exercice) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            return findBalance2Analytique(c, mois1, mois2, daty1, daty2, compte1, compte2, typecompte, exercice);
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }
    public static ComptaEtatBalance2[] findBalance2Analytique(Connection c, String mois1, String mois2, String daty1, String daty2, String compte1, String compte2, String typecompte, String exercice) throws Exception {
        try {
            String awhere = aWhere(exercice, daty1, daty2, mois1, compte1, compte2, typecompte);
            ComptaEtatBalance2 ceb = new ComptaEtatBalance2();
            ComptaEtatBalance2[] lsBalance = null;
            if (typecompte.compareTo("3") == 0) {
                ceb.setNomTable("COMPTA_MOUVEMENT_ANALYTIQUE");
                lsBalance = (ComptaEtatBalance2[]) CGenUtil.rechercher(ceb, null, null, c, " AND MOIS>=" + Utilitaire.stringToInt(mois1) + " AND MOIS<=" + Utilitaire.stringToInt(mois2) + " AND ANNEE = " + Utilitaire.stringToInt(exercice) + " " + awhere + " ORDER BY CHIFFRE3 ASC");
            } else if (typecompte.compareTo("1") == 0) {
                ceb.setNomTable("COMPTA_MOUVEMENT_GENERAL");
                lsBalance = (ComptaEtatBalance2[]) CGenUtil.rechercher(ceb, null, null, c, " AND MOIS>=" + Utilitaire.stringToInt(mois1) + " AND MOIS<=" + Utilitaire.stringToInt(mois2) + " AND ANNEE = " + Utilitaire.stringToInt(exercice) + " " + awhere + " ORDER BY CHIFFRE3 ASC");
            }
            return lsBalance;
        } catch (Exception e) {
            throw e;
        }
    }
}
