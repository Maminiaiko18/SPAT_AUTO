/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package caisse;

import bean.CGenUtil;
import bean.AdminGen;
import bean.ClassMAPTable;
import bean.SituationCaisse;
import fin.Coursdevise;
import java.sql.Connection;
import utilitaire.UtilDB;
import mg.amadia.stock.EtatdeStockDate;
import mg.spat.EtatCaisseBP;

/**
 *
 * @author Sam25v14
 */
public class SituationComptesData {

    public static final String deviseAr = "Ar";
    public static final String deviseEuro = "Eur";
    public static final String deviseEuroLib = "Euro";
    private EtatdeStockDate[] etatcaisse;
    private ClassMAPTable[] caisseAr;
    private EtatdeStockDate[] placementAr;
    private EtatdeStockDate[] placementDevise;
    private ClassMAPTable[] banqueAr;
    private EtatdeStockDate totalComptes;
    private ClassMAPTable[] banqueDevise;
    private EtatdeStockDate totalBanqueDevise;
    private double totalPlacementAr;
    private double totalPlacementDevise;
    private EtatdeStockDate[] recapitulatifComptes;
    private EtatdeStockDate[] recapitulatifPlacement;
    private double totalTresorerie;
    private double totalPlacement;
    private double montantBP;
    private double total;

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public double getMontantBP() {
        return montantBP;
    }

    public void setMontantBP(double montantBP) {
        this.montantBP = montantBP;
    }

    public double getTotalTresorerie() {
        return totalTresorerie;
    }

    public void setTotalTresorerie(double totalTresorerie) {
        this.totalTresorerie = totalTresorerie;
    }

    public double getTotalPlacement() {
        return totalPlacement;
    }

    public void setTotalPlacement(double totalPlacement) {
        this.totalPlacement = totalPlacement;
    }

    public EtatdeStockDate[] getRecapitulatifPlacement() {
        return recapitulatifPlacement;
    }

    public void setRecapitulatifPlacement(EtatdeStockDate[] recapitulatifPlacement) {
        this.recapitulatifPlacement = recapitulatifPlacement;
    }

    public EtatdeStockDate[] getRecapitulatifComptes() {
        return recapitulatifComptes;
    }

    public void setRecapitulatifComptes(EtatdeStockDate[] recapitulatifComptes) {
        this.recapitulatifComptes = recapitulatifComptes;
    }

    public double getTotalPlacementAr() {
        return totalPlacementAr;
    }

    public void setTotalPlacementAr(double totalPlacementAr) {
        this.totalPlacementAr = totalPlacementAr;
    }

    public double getTotalPlacementDevise() {
        return totalPlacementDevise;
    }

    public void setTotalPlacementDevise(double totalPlacementDevise) {
        this.totalPlacementDevise = totalPlacementDevise;
    }

    public EtatdeStockDate[] getPlacementDevise() {
        return placementDevise;
    }

    public void setPlacementDevise(EtatdeStockDate[] placementDevise) {
        this.placementDevise = placementDevise;
    }

    public EtatdeStockDate[] getPlacementAr() {
        return placementAr;
    }

    public void setPlacementAr(EtatdeStockDate[] placementAr) {
        this.placementAr = placementAr;
    }

    public EtatdeStockDate getTotalBanqueDevise() {
        return totalBanqueDevise;
    }

    public void setTotalBanqueDevise(EtatdeStockDate totalBanqueDevise) {
        this.totalBanqueDevise = totalBanqueDevise;
    }

    public ClassMAPTable[] getBanqueDevise() {
        return banqueDevise;
    }

    public void setBanqueDevise(ClassMAPTable[] banqueDevise) {
        this.banqueDevise = banqueDevise;
    }

    public EtatdeStockDate getTotalComptes() {
        return totalComptes;
    }

    public void setTotalComptes(EtatdeStockDate totalComptes) {
        this.totalComptes = totalComptes;
    }

    public ClassMAPTable[] getCaisseAr() {
        return caisseAr;
    }

    public void setCaisseAr(ClassMAPTable[] caisseAr) {
        this.caisseAr = caisseAr;
    }

    public ClassMAPTable[] getBanqueAr() {
        return banqueAr;
    }

    public void setBanqueAr(ClassMAPTable[] banqueAr) {
        this.banqueAr = banqueAr;
    }

    public EtatdeStockDate[] getEtatcaisse() {
        return etatcaisse;
    }

    public void setEtatcaisse(EtatdeStockDate[] etatcaisse) {
        this.etatcaisse = etatcaisse;
    }

    public double getTotalPlacement(ClassMAPTable[] situations) {
        double total = AdminGen.calculSommeDouble(situations, "montantStock");

        return total;
    }

    public SituationComptesData(String daty2, String daty1, String ingredients, String colonne, String ordre) throws Exception {
        int verif = 0;
        Connection c = null;

        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }

            etatcaisse = EtatdeStockDate.calculEtatCaisse(daty2, ingredients, null, c, colonne, ordre, daty1);
            caisseAr = getSituationCaisseAr(etatcaisse);
//            banqueAr = getSituationBanqueAr(etatcaisse);

//            totalComptes = getTotalSituationComptesAr(banqueAr, caisseAr);
            totalComptes = getTotalSituation(caisseAr);

            banqueDevise = getSituationBanqueDevise(etatcaisse);

            totalBanqueDevise = getTotalSituationBanqueDevise(banqueDevise);

            placementAr = getSituationPlacementAr(c, daty2, daty1);
            placementDevise = getSituationPlacementDevise(c, daty2, daty1);
            totalPlacementAr = getTotalPlacement(placementAr);
            totalPlacementDevise = getTotalPlacement(placementDevise);

            recapitulatifComptes = getRecapitulatifComptes(c, totalComptes.getReste(), totalBanqueDevise.getReste());
            recapitulatifPlacement = getRecapitulatifPlacement(c, totalPlacementAr, totalPlacementDevise);

            totalTresorerie = getTotalPlacement(recapitulatifComptes);
            totalPlacement = getTotalPlacement(recapitulatifPlacement);
            
            montantBP = getBonProvisoire(c);
            
            total = totalTresorerie + totalPlacement;
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    public double convertirDevise(Connection c, String iddevise, double montant) throws Exception {
        return getMontantDevise(c, iddevise) * montant;
    }

    public double getMontantDevise(Connection c, String iddevise) throws Exception {
        int verif = 0;
        double montant = 1;

        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }

            Coursdevise cours = new Coursdevise();
            cours.setNomTable("COURSDEVISE");
            Coursdevise[] tmp = (Coursdevise[]) CGenUtil.rechercher(cours, null, null, c, " and iddevise = '" + iddevise + "' order by daty desc");

            if (tmp != null && tmp.length > 0) {
                montant = tmp[0].getMontant();
            }
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
        
        return montant;
    }

    public double totalPlacementSpat(EtatdeStockDate[] recapitulatifPlacement) {
        return getTotal(recapitulatifPlacement);
    }

    public EtatdeStockDate[] getRecapitulatifPlacement(Connection c, double totalPlacementAr, double totalPlacementDevise) throws Exception {
        EtatdeStockDate[] recapPlacements = new EtatdeStockDate[2];

        recapPlacements[0] = new EtatdeStockDate();
        recapPlacements[0].setIngredients("Total placement en ariary");
        recapPlacements[0].setMontantStock(totalPlacementAr);
        
        totalPlacementDevise = convertirDevise(c, deviseEuro, totalPlacementDevise);
        
        recapPlacements[1] = new EtatdeStockDate();
        recapPlacements[1].setIngredients("Total placement en devise (convertit en Ariary)");
        recapPlacements[1].setMontantStock(totalPlacementDevise);

        return recapPlacements;
    }

    public EtatdeStockDate[] getRecapitulatifComptes(Connection c, double totalSituationComptesAr, double totalSituationBanqueDevise) throws Exception {
        EtatdeStockDate[] recapComptes = new EtatdeStockDate[2];

        recapComptes[0] = new EtatdeStockDate();
        recapComptes[0].setIngredients("Total comptes courants");
        recapComptes[0].setMontantStock(totalSituationComptesAr);

        totalSituationBanqueDevise = convertirDevise(c, deviseEuro, totalSituationBanqueDevise);
        
        recapComptes[1] = new EtatdeStockDate();
        recapComptes[1].setIngredients("Total compte banque en devise (convertit en Ariary)");
        recapComptes[1].setMontantStock(totalSituationBanqueDevise);

        return recapComptes;
    }

    public double getTotal(ClassMAPTable[] situations) {
        double total = AdminGen.calculSommeDouble(situations, "reste");

        return total;
    }

    public double getTotalPlacementDevise(EtatdeStockDate[] situationPlacementDevise) {
        return getTotal(situationPlacementDevise);
    }

    public double getTotalPlacementAr(EtatdeStockDate[] situationPlacementAr) {
        return getTotal(situationPlacementAr);
    }

    public EtatdeStockDate getTotalSituation(ClassMAPTable[] situations) throws Exception {
        double soldeI = AdminGen.calculSommeDouble(situations, "report");
        double entree = AdminGen.calculSommeDouble(situations, "entree");
        double sortie = AdminGen.calculSommeDouble(situations, "sortie");
        double soldeF = AdminGen.calculSommeDouble(situations, "reste");

        EtatdeStockDate situationTotal = new EtatdeStockDate(soldeI, entree, sortie, soldeF);

        return situationTotal;

    }

    public EtatdeStockDate getTotalSituationBanqueDevise(ClassMAPTable[] situationBanqueDevise) throws Exception {
        return getTotalSituation(situationBanqueDevise);
    }

    public EtatdeStockDate getTotalSituationComptesAr(ClassMAPTable[] situationBanqueAr, ClassMAPTable[] situationCaisseAr) throws Exception {
        EtatdeStockDate totalBanque = getTotalSituation(situationBanqueAr);
        EtatdeStockDate totalCaisse = getTotalSituation(situationCaisseAr);
        EtatdeStockDate totalComptes = null;

        double soldeI = totalBanque.getReport() + totalCaisse.getReport();
        double entree = totalBanque.getEntree() + totalCaisse.getEntree();
        double sortie = totalBanque.getSortie() + totalCaisse.getSortie();
        double soldeF = totalBanque.getReste() + totalCaisse.getReste();

        totalComptes = new EtatdeStockDate(soldeI, entree, sortie, soldeF);

        return totalComptes;
    }

    public ClassMAPTable[] getSituationCaisseAr(EtatdeStockDate[] etatcaisse) throws Exception {
        String[] atts = {"unite"};
        String[] vals = {deviseAr};

        return AdminGen.find(etatcaisse, atts, vals);
    }

    public EtatdeStockDate[] getSituationDevise(Connection c, String devise, String dateSup, String dateInf) throws Exception {
        int verif = 0;
        EtatdeStockDate[] situations = new EtatdeStockDate[0];

        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }

            EtatdeStockDate situation = new EtatdeStockDate();
            situation.setNomTable("AS_ETATSTOCKVIDE");
            String req = "select idCategorieIngredient,ingredients,iddevise as unite, nvl(sum(montant),0) as montantStock from (select  entite||'/'||banque as ingredients,banque as idCategorieIngredient, date_placement,iddevise, montant from placementlib p where date_placement<='" + dateInf + "' or date_placement<='" + dateSup + "'"
                    + "and date_echeance>='" + dateInf + "' or date_echeance>='" + dateSup + "'  and etat>=11 and id not in (select idplacement from journalcaisse)) where iddevise='" + devise + "' group by ingredients,idCategorieIngredient,iddevise";

            System.out.println("----------------REQ--------------" + req);
            situations = (EtatdeStockDate[]) CGenUtil.rechercher(situation, req, c);
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }

        return situations;
    }
    
    public double getBonProvisoire(Connection c) throws Exception{
        EtatCaisseBP[] ls = (EtatCaisseBP[]) CGenUtil.rechercher(new EtatCaisseBP(), null, null, c, "");
        return ls[0].getMontant();
    }

//    public SituationCaisse[] getSituationDevise(Connection c, String nomTable, String devise) throws Exception {
//        int verif = 0;
//        SituationCaisse[] situations = new SituationCaisse[0];
//
//        try {
//            if (c == null) {
//                c = new UtilDB().GetConn();
//                verif = 1;
//            }
//
//            SituationCaisse situation = new SituationCaisse();
//
//            if (nomTable != null) {
//                situation.setNomTable(nomTable);
//            }
//
//            if (devise != null) {
//                situations = (SituationCaisse[]) CGenUtil.rechercher(situation, null, null, c, " and iddevise = '" + devise + "'");
//            }
//        } catch (Exception e) {
//            throw e;
//        } finally {
//            if (c != null && verif == 1) {
//                c.close();
//            }
//        }
//
//        return situations;
//    }
    public EtatdeStockDate[] getSituationPlacement(Connection c, String devise, String dateSup, String dateInf) throws Exception {
        return getSituationDevise(c, devise, dateSup, dateInf);
    }

    public EtatdeStockDate[] getSituationPlacementAr(Connection c, String dateSup, String dateInf) throws Exception {
        return getSituationPlacement(c, deviseAr, dateSup, dateInf);
    }

    public EtatdeStockDate[] getSituationPlacementDevise(Connection c, String dateSup, String dateInf) throws Exception {
        return getSituationPlacement(c, deviseEuroLib, dateSup, dateInf);
    }

//    public SituationCaisse[] getSituationBanque(Connection c, String devise) throws Exception {
//        return getSituationDevise(c, "situationbanque", devise);
//    }
    public ClassMAPTable[] getSituationBanque(EtatdeStockDate[] etatcaisse, String devise) throws Exception {
        String[] atts = {"unite"};
        String[] vals = {devise};

        return AdminGen.find(etatcaisse, atts, vals);
    }

    public ClassMAPTable[] getSituationBanqueAr(EtatdeStockDate[] etatcaisse) throws Exception {
        return getSituationBanque(etatcaisse, deviseAr);
    }

    public ClassMAPTable[] getSituationBanqueDevise(EtatdeStockDate[] etatcaisse) throws Exception {
        return getSituationBanque(etatcaisse, deviseEuro);
    }

//    public SituationCaisse[] getSituationBanqueAr(Connection c) throws Exception {
//        return getSituationBanque(c, "Ar");
//    }
//    public SituationCaisse[] getSituationBanqueDevise(Connection c) throws Exception {
//        return getSituationBanque(c, "Euro");
//    }
}
