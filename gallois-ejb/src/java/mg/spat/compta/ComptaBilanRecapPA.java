/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.compta;

import bean.CGenUtil;
import java.sql.Connection;
import java.util.ArrayList;
import utilitaire.UtilDB;

/**
 *
 * @author MEVA
 */
public class ComptaBilanRecapPA {
    private ComptaBilan[] listePassif;
    private ComptaBilan[] listeActif;
    private double mtPassif;
    private double mtActif;
    private double resultat;

    public ComptaBilanRecapPA() {
    }

    public ComptaBilan[] getListePassif() {
        return listePassif;
    }

    public void setListePassif(ComptaBilan[] listePassif) {
        this.listePassif = listePassif;
    }

    public ComptaBilan[] getListeActif() {
        return listeActif;
    }

    public void setListeActif(ComptaBilan[] listeActif) {
        this.listeActif = listeActif;
    }

    public ComptaBilanRecapPA(ComptaBilan[] listePassif, ComptaBilan[] listeActif) {
        this.setListePassif(listePassif);
        this.setListeActif(listeActif);
        double mttP = 0;
        double mttA = 0;
        for(int i=0; i<listePassif.length; i++){
            mttP += listePassif[i].getEc_montant();
        }
        this.setMtPassif(mttP);
        for(int i=0; i<listeActif.length; i++){
            mttA += listeActif[i].getEc_montant();
        }
        this.setMtActif(mttA);
        this.resultat = this.mtActif - this.mtPassif;
        this.setMtPassif(this.getMtPassif() + this.resultat);
    }

    public double getMtPassif() {
        return mtPassif;
    }

    public void setMtPassif(double mtPassif) {
        this.mtPassif = mtPassif;
    }

    public double getMtActif() {
        return mtActif;
    }

    public void setMtActif(double mtActif) {
        this.mtActif = mtActif;
    }

    public double getResultat() {
        return resultat;
    }

    public void setResultat(double resultat) {
        this.resultat = resultat;
    }
    
    
    
    public static String[] getNumCompte(String reference,Connection c)throws Exception{
        int verif=0;
        String[] retour = null;
        try{
            if(c==null){
                c=new UtilDB().GetConn();
                verif=1;
            }
            CompteRubrique compta = new CompteRubrique();
            compta.setReference(reference);
            CompteRubrique[] lscompta=(CompteRubrique[])CGenUtil.rechercher(compta, null, null, c, "");
            if(lscompta.length>0){
                retour=new String[lscompta.length];
                for(int i=0;i<lscompta.length;i++){
                    retour[i] = lscompta[i].getCompte();
                }
            }
            return retour;
        }
        catch(Exception ex){
            throw ex;
        }
        finally{
            if(c!=null && verif==1){
                c.close();
            }
        }
    }
}
