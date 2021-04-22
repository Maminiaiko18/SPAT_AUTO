/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package service;

import bean.CGenUtil;
import bean.TypeObjet;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import mg.spat.compta.ComptaEtatGrandLivre;
import mg.spat.compta.ComptaEtatService;
import mg.spat.compta.ComptaSousEcritureAvecDevise;
import mg.spat.compta.ConsultationCompte;
import mg.spat.compta.ConsultationComptePDF;
import mg.spat.compta.EtatDeveloppementSolde;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author MEVA
 */
public class ComptaEcritureService {
    public static List<ConsultationComptePDF> getConsultationComptePDF(ConsultationCompte c, String type) {
        List<ConsultationComptePDF> consultationCompte = new ArrayList<>();
        ConsultationComptePDF consultationComptePDFCumul = new ConsultationComptePDF();
        consultationComptePDFCumul.setDate("");
        consultationComptePDFCumul.setFolio("");
        consultationComptePDFCumul.setContrepartie("");
        consultationComptePDFCumul.setLibelle("Ancien cumul...");
        consultationComptePDFCumul.setMontant_debit(c.getAncienCumulDebit() != 0 ? c.getAncienCumulDebit() : 0);
        consultationComptePDFCumul.setMontant_credit(c.getAncienCumulCredit() != 0 ? c.getAncienCumulCredit() : 0);
        consultationComptePDFCumul.setCours_devise("");
        consultationComptePDFCumul.setMontant_devise("");
        consultationComptePDFCumul.setLettrage("");
        consultationComptePDFCumul.setCours_deviseC("");
        consultationComptePDFCumul.setCours_deviseD("");
        consultationComptePDFCumul.setEtat("11");
        consultationCompte.add(consultationComptePDFCumul);
        int a = 0;
        if (c.getListe() != null && c.getListe().length != 0) {
            for (ComptaSousEcritureAvecDevise comptaSousEcriture : c.getListe()) {
                if (comptaSousEcriture != null) {
                    ConsultationComptePDF consultationComptePDF = new ConsultationComptePDF();
                    consultationComptePDF.setDate(Utilitaire.formatterDaty(comptaSousEcriture.getDaty()));
                    consultationComptePDF.setFolio(comptaSousEcriture.getJournal() + "/" + comptaSousEcriture.getFolio());
                    consultationComptePDF.setContrepartie(comptaSousEcriture.getContrep());
                    consultationComptePDF.setLibelle(comptaSousEcriture.getRemarque());
                    if (type != null && type.equalsIgnoreCase("xls")) {
                        consultationComptePDF.setCompte(comptaSousEcriture.getCompte());
                        consultationComptePDF.setIdMvt(comptaSousEcriture.getId());
                    }

                    consultationComptePDF.setMontant_debit(comptaSousEcriture.getDebit() != 0 ? comptaSousEcriture.getDebit() : 0);
                    consultationComptePDF.setMontant_credit(comptaSousEcriture.getCredit() != 0 ? comptaSousEcriture.getCredit() : 0);
                    consultationComptePDF.setLettrage(comptaSousEcriture.getLettrage());
                    consultationComptePDF.setCours_devise(Utilitaire.formaterAr(String.valueOf(comptaSousEcriture.getCoursdevise())));
                    consultationComptePDF.setMontant_devise("");
                    consultationComptePDF.setCours_deviseC(comptaSousEcriture.getCredit() != 0 ? Utilitaire.formaterAr(String.valueOf(comptaSousEcriture.getMontantdevise())) : "");
                    consultationComptePDF.setCours_deviseD(comptaSousEcriture.getDebit() != 0 ? Utilitaire.formaterAr(String.valueOf(comptaSousEcriture.getMontantdevise())) : "");
                    consultationComptePDF.setEtat(String.valueOf(comptaSousEcriture.getEtat()));
                    consultationCompte.add(consultationComptePDF);
                }
            }
        }
        return consultationCompte;
    }
    public static List<ConsultationComptePDF> getConsultationComptePDF(ConsultationCompte c) {
        List<ConsultationComptePDF> consultationCompte = new ArrayList<>();
        ConsultationComptePDF consultationComptePDFCumul = new ConsultationComptePDF();
        consultationComptePDFCumul.setDate("");
        consultationComptePDFCumul.setFolio("");
        consultationComptePDFCumul.setContrepartie("");
        consultationComptePDFCumul.setLibelle("Ancien cumul...");
        consultationComptePDFCumul.setMontant_debit(c.getAncienCumulDebit() != 0 ? c.getAncienCumulDebit() : 0);
        consultationComptePDFCumul.setMontant_credit(c.getAncienCumulCredit() != 0 ? c.getAncienCumulCredit() : 0);
        consultationComptePDFCumul.setCours_devise("");
        consultationComptePDFCumul.setMontant_devise("");
        consultationComptePDFCumul.setLettrage("");
        consultationComptePDFCumul.setCours_deviseC("");
        consultationComptePDFCumul.setCours_deviseD("");
        consultationComptePDFCumul.setEtat("11");
        consultationCompte.add(consultationComptePDFCumul);
        int a = 0;
        if (c.getListe() != null && c.getListe().length != 0) {
            for (ComptaSousEcritureAvecDevise comptaSousEcriture : c.getListe()) {
                if (comptaSousEcriture != null) {
                    ConsultationComptePDF consultationComptePDF = new ConsultationComptePDF();
                    consultationComptePDF.setDate(Utilitaire.formatterDaty(comptaSousEcriture.getDaty()));
                    consultationComptePDF.setFolio(comptaSousEcriture.getJournal() + "/" + comptaSousEcriture.getFolio());
                    consultationComptePDF.setContrepartie(comptaSousEcriture.getContrep());
                    consultationComptePDF.setLibelle(comptaSousEcriture.getRemarque());
                    consultationComptePDF.setMontant_debit(comptaSousEcriture.getDebit() != 0 ? comptaSousEcriture.getDebit() : 0);
                    consultationComptePDF.setMontant_credit(comptaSousEcriture.getCredit() != 0 ? comptaSousEcriture.getCredit() : 0);
                    consultationComptePDF.setLettrage(comptaSousEcriture.getLettrage());
                    consultationComptePDF.setCours_devise(Utilitaire.formaterAr(String.valueOf(comptaSousEcriture.getCoursdevise())));
                    consultationComptePDF.setMontant_devise("");
                    consultationComptePDF.setCours_deviseC(comptaSousEcriture.getCredit() != 0 ? Utilitaire.formaterAr(String.valueOf(comptaSousEcriture.getMontantdevise())) : "");
                    consultationComptePDF.setCours_deviseD(comptaSousEcriture.getDebit() != 0 ? Utilitaire.formaterAr(String.valueOf(comptaSousEcriture.getMontantdevise())) : "");
                    consultationComptePDF.setEtat(String.valueOf(comptaSousEcriture.getEtat()));
                    consultationCompte.add(consultationComptePDF);
                }
            }
        }
        return consultationCompte;
    }
    public static EtatDeveloppementSolde getEtatDeveloppementSolde(int mois, int annee, String compte, String libelle_compte, String auxiliaire, String typecompte, String table) throws Exception {
        EtatDeveloppementSolde eds = new EtatDeveloppementSolde();
        eds.setMois(Utilitaire.nbToMois(mois));
        eds.setAnnee(annee);
        double soldecomptedebut = 0.00;
        if (mois != 1) {
            ComptaEtatGrandLivre comptaEtatGrandLivre = new ComptaEtatGrandLivre();
            if (compte != null && !compte.isEmpty()) {
                if (compte.compareToIgnoreCase("null") != 0) {
                    comptaEtatGrandLivre.setCompte(compte);
                }
            }
            if (auxiliaire != null && !auxiliaire.isEmpty() && typecompte != null && !typecompte.isEmpty()) {
                if (auxiliaire.compareToIgnoreCase("null") != 0) {
                    comptaEtatGrandLivre.setAuxiliaire(auxiliaire);
                }
                if (compte == null && compte.compareToIgnoreCase("null") == 0) {
                    comptaEtatGrandLivre.setCompte(typecompte);
                }

            }
            if (table != null && table.compareToIgnoreCase("") != 0) {
                if (table.compareToIgnoreCase("null") != 0) {
                    comptaEtatGrandLivre.setNomTable(table);
                }
            }
            ComptaEtatGrandLivre[] lsGrandLivre2;
            if (mois - 1 < 10) {
                lsGrandLivre2 = (ComptaEtatGrandLivre[]) CGenUtil.rechercher(comptaEtatGrandLivre, null, null, "AND daty BETWEEN '01/" + "0" + (mois - 1) + "/" + annee + "' AND '" + Utilitaire.getNombreJourMois(String.valueOf(mois - 1), String.valueOf(annee)) + "/0" + (mois - 1) + "/" + annee + "'");
            } else {
                lsGrandLivre2 = (ComptaEtatGrandLivre[]) CGenUtil.rechercher(comptaEtatGrandLivre, null, null, "AND daty BETWEEN '01/" + (mois - 1) + "/" + annee + "' AND '" + Utilitaire.getNombreJourMois(String.valueOf(mois - 1), String.valueOf(annee)) + "/" + (mois - 1) + "/" + annee + "'");
            }
            for (int i = 0; i < lsGrandLivre2.length; i++) {
                soldecomptedebut += lsGrandLivre2[i].getDebit() - lsGrandLivre2[i].getCredit();
            }
        }
        ComptaEtatGrandLivre comptaEtatGrandLivre2 = new ComptaEtatGrandLivre();
        if (compte != null && !compte.isEmpty()) {
            if (compte.compareToIgnoreCase("null") != 0) {
                comptaEtatGrandLivre2.setCompte(compte);
            }
        }
        if (auxiliaire != null && !auxiliaire.isEmpty() && typecompte != null && !typecompte.isEmpty()) {
            if (auxiliaire.compareToIgnoreCase("null") != 0) {
                comptaEtatGrandLivre2.setAuxiliaire(auxiliaire);
            }
            if (compte == null && compte.compareToIgnoreCase("null") == 0) {
                comptaEtatGrandLivre2.setCompte(typecompte);
            }

        }
        if (table != null && table.compareToIgnoreCase("") != 0) {
            if (table.compareToIgnoreCase("null") != 0) {
                comptaEtatGrandLivre2.setNomTable(table);
            }
        }
        ComptaEtatGrandLivre[] lsGrandLivre;
        if (mois < 10) {
            lsGrandLivre = (ComptaEtatGrandLivre[]) CGenUtil.rechercher(comptaEtatGrandLivre2, null, null, "AND daty BETWEEN '01/" + "0" + mois + "/" + annee + "' AND '" + Utilitaire.getNombreJourMois(String.valueOf(mois), String.valueOf(annee)) + "/0" + mois + "/" + annee + "'");
        } else {
            lsGrandLivre = (ComptaEtatGrandLivre[]) CGenUtil.rechercher(comptaEtatGrandLivre2, null, null, "AND daty BETWEEN '01/" + mois + "/" + annee + "' AND '" + Utilitaire.getNombreJourMois(String.valueOf(mois), String.valueOf(annee)) + "/" + mois + "/" + annee + "'");
        }
        ComptaEtatService.traiterGrandLivre(lsGrandLivre);
        if (mois < 10) {
            eds.setSolde_compte_debut_mois_date("01/" + "0" + mois + "/" + annee);
        } else {
            eds.setSolde_compte_debut_mois_date("01/" + mois + "/" + annee);
        }
        if (compte == null || compte.compareToIgnoreCase("null") == 0) {
            eds.setNumero_compte(typecompte);
        } else {
            eds.setNumero_compte(compte);
        }
        eds.setIntitule_compte(libelle_compte);
        eds.setSolde_compte_debut(soldecomptedebut);
        double debitCompte = 0.00;
        double creditCompte = 0.00;
        List<TypeObjet> lto = new ArrayList();
        for (int i = 0; i < lsGrandLivre.length; i++) {
            TypeObjet to = new TypeObjet();
            debitCompte += lsGrandLivre[i].getDebit();
            creditCompte += lsGrandLivre[i].getCredit();
            to.setId(Utilitaire.formatterDaty(lsGrandLivre[i].getDaty()));
            to.setVal(lsGrandLivre[i].getLibelle());
            to.setDesce(Utilitaire.formaterAr(lsGrandLivre[i].getDebit() - lsGrandLivre[i].getCredit()));
            lto.add(to);
        }
        double soldeCompte = debitCompte - creditCompte;
        eds.setDebit_compte(debitCompte);
        eds.setCredit_compte(creditCompte);
        eds.setSolde_compte(soldeCompte);
        eds.setLto(lto);
        eds.setDate_jour(Utilitaire.datedujourlettre(Utilitaire.dateDuJour()));
        return eds;
    }
    /*public static EtatDeResteARecouvrer getEtatDeResteARecouvrer(int mois, int annee) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            EtatDeResteARecouvrer etatDeResteARecouvrer = new EtatDeResteARecouvrer();
            etatDeResteARecouvrer.setDate_jour(Utilitaire.dateDuJour());
            etatDeResteARecouvrer.setExercice(String.valueOf(annee));
            etatDeResteARecouvrer.setPeriode(Utilitaire.nbToMois(mois) + annee);
            double montant = 0.00;
            List<EtatResteRecouvrerSubReport> listeEtatResteRecouvrerSubReport = new ArrayList<EtatResteRecouvrerSubReport>();
            for (int i = 0; i < i; i++) {
                EtatResteRecouvrerSubReport etatResteRecouvrer = new EtatResteRecouvrerSubReport();
                etatResteRecouvrer.setDate("");
                etatResteRecouvrer.setMontant("");
                etatResteRecouvrer.setNature("");
                etatResteRecouvrer.setReference("");
                listeEtatResteRecouvrerSubReport.add(etatResteRecouvrer);
            }
            etatDeResteARecouvrer.setTotal_montant(Utilitaire.formaterAr(montant));
            etatDeResteARecouvrer.setListeEtatResteRecouvrerSubReport(listeEtatResteRecouvrerSubReport);
            return etatDeResteARecouvrer;
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null) {
                c.close();
            }
        }

    }*/
}
