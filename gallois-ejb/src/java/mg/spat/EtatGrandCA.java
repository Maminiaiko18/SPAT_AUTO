/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.AdminGen;
import bean.CGenUtil;
import bean.TypeObjet;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

/**
 *
 * @author Itokiana
 */
public class EtatGrandCA {
    
    HashMap<String, EtatCA> listeCA;
    CA totalgeneralgrandrubrique;
    int nbFactComptant;
    int nbFactCredit;
    double pourcAvoir;
    double pourComptant;
    double pourcCredit;
    int mois;
    int annee;
    CA[] tout;
    EtatCA[] etatCAtout;

    public HashMap<String, EtatCA> getListeCA() {
        return listeCA;
    }

    public void setListeCA(HashMap<String, EtatCA> listeCA) {
        this.listeCA = listeCA;
    }

    public CA getTotalgeneralgrandrubrique() {
        return totalgeneralgrandrubrique;
    }

    public void setTotalgeneralgrandrubrique(CA totalgeneralgrandrubrique) {
        this.totalgeneralgrandrubrique = totalgeneralgrandrubrique;
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

    public CA[] getTout() {
        return tout;
    }

    public void setTout(CA[] tout) {
        this.tout = tout;
    }

    public EtatCA[] getEtatCAtout() {
        return etatCAtout;
    }

    public void setEtatCAtout(EtatCA[] etatCAtout) {
        this.etatCAtout = etatCAtout;
    }

    public EtatGrandCA(int mois, int annee, boolean estGroupeAncien) throws Exception {
        
        try{
            List<CA> CAtout = new java.util.ArrayList<>();
            TypeObjet grandrubrique = new TypeObjet();
            grandrubrique.setNomTable("GRANDRUBRIQUE");
            TypeObjet[] grandrubriques = (TypeObjet[])CGenUtil.rechercher(grandrubrique, null, null, null, "");
            
            int t = grandrubriques.length;
            listeCA = new HashMap<>();
            for(int i = 0; i < t; i++){
                EtatCA etatca = new EtatCA(mois, annee, grandrubriques[i].getId(), estGroupeAncien);
                CA[] tout = etatca.getCACpl(mois, annee);
                CAtout.addAll(Arrays.asList(tout));
                listeCA.put(grandrubriques[i].getVal(), etatca);
            }
            
            tout = CAtout.toArray(new CA[CAtout.size()]);
            this.calculerTotalGeneral();

        }
        catch(Exception e){
            throw e;
        }
        
    }
    
    public void calculerTotalGeneral() throws Exception {
        
        try{
            String[] cols = new String[]{"anciencumul", "regul", "regulEETP", "avoirEETP", "comptant", "credit", "nbComptant", "nbCredit"};
            double[] total = AdminGen.calculSommeDouble(tout, cols);

            if (total!=null&&total.length > 0) {
                totalgeneralgrandrubrique = new CA(null, "TOTAL GENERAL", total[0], total[1], total[2], total[3], total[4], total[5], 0);
                totalgeneralgrandrubrique.setNbComptant((int)total[6]);
                totalgeneralgrandrubrique.setNbCredit((int)total[7]);

                pourcAvoir = (totalgeneralgrandrubrique.getAvoirEETP() / totalgeneralgrandrubrique.getTotal()) * 100;
                pourComptant = (totalgeneralgrandrubrique.getComptant() / totalgeneralgrandrubrique.getTotal()) * 100;
                pourcCredit = (totalgeneralgrandrubrique.getCredit() / totalgeneralgrandrubrique.getTotal()) * 100;
            }
        }
        catch(Exception e){
            throw e;
        }
    }
}
