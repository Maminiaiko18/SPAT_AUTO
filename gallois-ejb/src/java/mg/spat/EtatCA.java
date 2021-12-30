/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.AdminGen;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 *
 * @author Asus
 */
public class EtatCA {

    CA totalGeneral;
    HashMap<String, CA[]> listeParRubrique;
    HashMap<String, CA> sommePartiel;
    int nbFactComptant;
    int nbFactCredit;
    double pourcAvoir;
    double pourComptant;
    double pourcCredit;
    int mois;
    int annee;

    public CA getTotalGeneral() {
        return totalGeneral;
    }

    public void setTotalGeneral(CA totalGeneral) {
        this.totalGeneral = totalGeneral;
    }

    public HashMap<String, CA[]> getListeParRubrique() {
        return listeParRubrique;
    }

    public void setListeParRubrique(HashMap<String, CA[]> listeParRubrique) {
        this.listeParRubrique = listeParRubrique;
    }

    public HashMap<String, CA> getSommePartiel() {
        return sommePartiel;
    }

    public void setSommePartiel(HashMap<String, CA> sommePartiel) {
        this.sommePartiel = sommePartiel;
    }

    public int getNbFactComptant() {
        return nbFactComptant;
    }

    public void setNbFactComptant(int nbFactComptant) {
        this.nbFactComptant = nbFactComptant;
    }

    public int getNbFactCredit() {
        return nbFactCredit;
    }

    public void setNbFactCredit(int nbFactCredit) {
        this.nbFactCredit = nbFactCredit;
    }

    public double getPourcAvoir() {
        return pourcAvoir;
    }

    public void setPourcAvoir(double pourcAvoir) {
        this.pourcAvoir = pourcAvoir;
    }

    public double getPourComptant() {
        return pourComptant;
    }

    public void setPourComptant(double pourComptant) {
        this.pourComptant = pourComptant;
    }

    public double getPourcCredit() {
        return pourcCredit;
    }

    public void setPourcCredit(double pourcCredit) {
        this.pourcCredit = pourcCredit;
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

    public EtatCA() {
    }

    public EtatCA(CA[] tout, int mois, int annee, boolean estGroupeAncien) {

    }

    public EtatCA(String mois, String annee, boolean estGroupeAncien) {

    }

    public void calculCATotal(CA[] tout) {
        String[] cols = new String[]{"anciencumul", "regul", "regulEETP", "avoirEETP", "comptant", "credit", "taux"};
        double[] total = AdminGen.calculSommeDouble(tout, cols);

        if (total.length > 0) {
            totalGeneral = new CA(null, "TOTAL GENERAL", total[0], total[1], total[2], total[3], total[4], total[5], 0);
            totalGeneral.setTaux(total[6]);

            pourcAvoir = (totalGeneral.getAvoirEETP() / totalGeneral.getTotal()) * 100;
            pourComptant = (totalGeneral.getComptant() / totalGeneral.getTotal()) * 100;
            pourcCredit = (totalGeneral.getCredit() / totalGeneral.getTotal()) * 100;
        }
    }

    public String[] addCAByCompteMere(String compteMere, CA[] tout) {
        List<CA> caList = new ArrayList<CA>();
        List<String> compteMereAlreadyExist = new ArrayList<String>();
        for(int i=0; i<tout.length; i++) {
            if(compteMere.equalsIgnoreCase(tout[i].getCompteMere())) {
                tout[i].setTaux(tout[i].getTotal() / totalGeneral.getTotal() * 100);
                caList.add(tout[i]);
            }
        }
        listeParRubrique.put(compteMere, caList.toArray(new CA[caList.size()]));
        compteMereAlreadyExist.add(compteMere);
        return compteMereAlreadyExist.toArray(new String[compteMereAlreadyExist.size()]);
    }

    public Boolean checkCompteMereAlreadyExist(String compteMere, String[] compteMereAlreadyExist) {
        if(compteMereAlreadyExist != null) {
            for(int i=0; i<compteMereAlreadyExist.length; i++) {
                if(compteMere.equalsIgnoreCase(compteMereAlreadyExist[i])) {
                    return true;
                }
            }
        }
        return false;
    }

    public void calculerTauxEtHashMap(CA[] tout) {
        String[] compteMereAlreadyExist = null;
        for(int i=0; i<tout.length; i++) {
            if(!this.checkCompteMereAlreadyExist(tout[i].getCompteMere(), compteMereAlreadyExist)) {
                compteMereAlreadyExist = this.addCAByCompteMere(tout[i].getCompteMere(), tout);
            } 
        }   
    }
    
     public void calculerHashMapPartiel(){
        for(String cle : listeParRubrique.keySet()){
            String[] cols = new String[]{"anciencumul", "regul", "regulEETP", "avoirEETP", "comptant", "credit", "taux"};
            double[] total = AdminGen.calculSommeDouble(listeParRubrique.get(cle), cols);
            CA ca = new CA(null, cle, total[0], total[1], total[2], total[3], total[4], total[5], 0);
            ca.setTaux(total[6]);
            this.sommePartiel.put(cle, ca);
        }
    }
}
