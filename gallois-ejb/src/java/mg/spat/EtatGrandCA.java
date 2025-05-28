/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.AdminGen;
import bean.CGenUtil;
import bean.TypeObjet;
import java.sql.Connection;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import utilitaire.UtilDB;

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
        Connection c = null;
        try{
            c = new UtilDB().GetConn();
            List<CA> CAtout = new java.util.ArrayList<>();
            GrandRubriqueLib grandrubrique = new GrandRubriqueLib();
            grandrubrique.setNomTable("GRANDRUBRIQUE");
            GrandRubriqueLib[] grandrubriques = (GrandRubriqueLib[])CGenUtil.rechercher(grandrubrique, null, null, c, " order by rang");
            int t = grandrubriques.length;
            listeCA = new LinkedHashMap<>();
            for(int i = 0; i < t; i++){
                EtatCA etatca = new EtatCA(mois, annee, grandrubriques[i].getId(), estGroupeAncien);
                etatca.setIdgrandrubrique(grandrubriques[i].getId());
                CA[] tout = etatca.getCAtout();
                if(tout != null){
                    CAtout.addAll(Arrays.asList(tout));
                    listeCA.put(grandrubriques[i].getVal(), etatca);
                }
            }
           
            tout = CAtout.toArray(new CA[CAtout.size()]);
            this.calculerTotalGeneral(mois, annee, c);   
            double tauxTotal = 0;
            double total = 0;
            
            //calcul taux par grande rubrique
            for(int i = 0; i < t; i++){
                EtatCA tmp = listeCA.get(grandrubriques[i].getVal());
                double tauxTmp = tmp.getTotalGeneral().getTotal() / totalgeneralgrandrubrique.getTotal() * 100;
                tmp.getTotalGeneral().setTaux(tauxTmp);
                listeCA.replace(grandrubriques[i].getVal(), tmp);
                tauxTotal += tauxTmp;
                total += tmp.getTotalGeneral().getTotal();
            }
            totalgeneralgrandrubrique.setTaux(tauxTotal);
        }
        catch(Exception e){
            throw e;
        }
        finally{
            if(c != null)c.close();
        }
    }
    
    public void calculerTotalGeneral(int mois, int annee, Connection c) throws Exception {
        try{
            String[] cols = new String[]{"anciencumul", "regul", "regulEETP","regulEETPINT","regulEETPEXT", "avoirEETP","avoirEETPINT","avoirEETPEXT", "comptant", "credit", "nbComptant", "nbCredit"};
            double[] total = AdminGen.calculSommeDouble(tout, cols);

            if (total!=null&&total.length > 0) {
                totalgeneralgrandrubrique = new CA(null, "TOTAL GENERAL", total[0], total[1], total[2], total[3], total[4], total[5],total[6],total[7],total[8],total[9], 0);
                totalgeneralgrandrubrique.setNbComptant((int)total[10]);
                totalgeneralgrandrubrique.setNbCredit((int)total[11]);
                double totalG = 0;
                if(totalgeneralgrandrubrique.getTotal() > 0){
                    totalG = totalgeneralgrandrubrique.getTotal();
                }

                pourcAvoir = (totalgeneralgrandrubrique.getTotal() == 0) ? 0 : (totalgeneralgrandrubrique.getAvoirEETP() / totalgeneralgrandrubrique.getTotal()) * 100;
                pourComptant = (totalgeneralgrandrubrique.getTotal() == 0) ? 0 : (totalgeneralgrandrubrique.getComptant() / totalgeneralgrandrubrique.getTotal()) * 100;
                pourcCredit = (totalgeneralgrandrubrique.getTotal() == 0) ? 0 : (totalgeneralgrandrubrique.getCredit() / totalgeneralgrandrubrique.getTotal()) * 100;
            }
            
            CA base = new CA();
            base.setNomTable("factureClientMAGroupe");
            CA[] resultNombre = (CA[]) CGenUtil.rechercher(base, null, null, c, " and mois="+mois+" and annee="+annee);
            if(resultNombre.length>0)
            {
                totalgeneralgrandrubrique.setNbComptant(resultNombre[0].getNbComptant());
                totalgeneralgrandrubrique.setNbCredit(resultNombre[0].getNbCredit());
                totalgeneralgrandrubrique.setNbFactureTotal(resultNombre[0].getNbComptant()+resultNombre[0].getNbCredit());
            }
        }
        catch(Exception e){
            throw e;
        }
    }
}
