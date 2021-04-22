/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.amadia.stock;

import bean.ClassMAPTable;
import java.util.List;

/**
 *
 * @author mihary
 */
public class RecapitulatifComptesSubReport {
    List<EtatdeStockDate> recapitulatifComptes;
    List<EtatdeStockDate> recapitulatifPlacement;
    List<EtatdeStockDate> situationCompteCourant;
    List<EtatdeStockDate> situationCompteBanqueDevise;
    List<EtatdeStockDate> placementAr;
    List<EtatdeStockDate> placementDevise;

    public RecapitulatifComptesSubReport(List<EtatdeStockDate> recapComptes, List<EtatdeStockDate> recapPlacement,
            List<EtatdeStockDate> situationCompteCour,List<EtatdeStockDate> situationBanque,
            List<EtatdeStockDate> placementA,List<EtatdeStockDate> placementD
    ) {
        this.recapitulatifComptes = recapComptes;
        this.recapitulatifPlacement = recapPlacement;
        this.situationCompteCourant = situationCompteCour;
        this.situationCompteBanqueDevise = situationBanque;
        this.placementAr = placementA;
        this.placementDevise = placementD;
    }

    public List<EtatdeStockDate> getPlacementDevise() {
        return placementDevise;
    }

    public void setPlacementDevise(List<EtatdeStockDate> placementDevise) {
        this.placementDevise = placementDevise;
    }

    public List<EtatdeStockDate> getPlacementAr() {
        return placementAr;
    }

    public void setPlacementAr(List<EtatdeStockDate> placementAr) {
        this.placementAr = placementAr;
    }

    public List<EtatdeStockDate> getSituationCompteBanqueDevise() {
        return situationCompteBanqueDevise;
    }

    public void setSituationCompteBanqueDevise(List<EtatdeStockDate> situationCompteBanqueDevise) {
        this.situationCompteBanqueDevise = situationCompteBanqueDevise;
    }

    public List<EtatdeStockDate> getSituationCompteCourant() {
        return situationCompteCourant;
    }

    public void setSituationCompteCourant(List<EtatdeStockDate> situationCompteCourant) {
        this.situationCompteCourant = situationCompteCourant;
    }

    public List<EtatdeStockDate> getRecapitulatifComptes() {
        return recapitulatifComptes;
    }

    public void setRecapitulatifComptes(List<EtatdeStockDate> recapitulatifComptes) {
        this.recapitulatifComptes = recapitulatifComptes;
    }

    public List<EtatdeStockDate> getRecapitulatifPlacement() {
        return recapitulatifPlacement;
    }

    public void setRecapitulatifPlacement(List<EtatdeStockDate> recapitulatifPlacement) {
        this.recapitulatifPlacement = recapitulatifPlacement;
    }
    
}
