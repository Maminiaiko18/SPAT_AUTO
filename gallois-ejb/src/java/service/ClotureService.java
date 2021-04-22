/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package service;

import bean.CGenUtil;
import historique.MapHistorique;
import historique.MapUtilisateurServiceDirection;
import java.sql.Connection;
import java.sql.Date;
import mg.spat.Billetage;
import mg.spat.Cloture;
import mg.spat.JournalCaisse;
import mg.spat.SoldeCaisse;
import user.UserEJB;

/**
 *
 * @author MEVA
 */
public class ClotureService {

    public static double getSoldeFarany(Date daty, String caisse, Connection c) throws Exception {
        double solde=0;
        try {
            
            SoldeCaisse[] lsoldeTaloha = (SoldeCaisse[]) CGenUtil.rechercher(new SoldeCaisse(), null, null, c, "and dateEffet=to_date('" + daty + "','YYYY-MM-DD') and caisse='" + caisse + "'");
            if (lsoldeTaloha.length>0) {
                solde=lsoldeTaloha[0].getSolde();
            }
            Cloture[] clo=(Cloture[]) CGenUtil.rechercher(new Cloture(), null, null, c, " and daty<to_date('"+ daty +"','YYYY-MM-DD') and caisse='"+caisse+"' order by daty desc");
            if(clo.length>0){
                solde+=clo[0].getSolde();
            }
            return solde;
        } catch (Exception e) {
            throw e;
        }
    }

    public static void testDateCloture(Date daty,String caisse, Connection c) throws Exception {
        try {
            Cloture[] liste = (Cloture[]) CGenUtil.rechercher(new Cloture(), null, null, c, " and daty=to_date('"+ daty +"','YYYY-MM-DD') and caisse='"+caisse+"'");
            if(liste.length>0) throw new Exception("Cette caisse a déjà été cloturée à cette date");
        } catch (Exception e) {
            throw e;
        }
    }
    
    public static void ouvrirCloture(String caisse,String daty,Connection c,MapUtilisateurServiceDirection u) throws Exception{
        try{
            Cloture[] liste=(Cloture[]) CGenUtil.rechercher(new Cloture(), null, null, c, " and daty=to_date('"+ daty +"','YYYY-MM-DD') and caisse='"+caisse+"'");
            if(liste.length==0) throw new Exception("Caisse inexistante pour cette date");
            liste[0].deleteToTable(c);
            
            MapHistorique h = new MapHistorique(new Cloture().getClassName()+liste[0].getId(),"delete",u.getTuppleID(),String.valueOf(liste[0].getSolde()),c);           
            h.insertToTable(c);
        }catch(Exception e){
            throw e;
        }
    }
   
    public static void modifSequentiel(double debit, double credit,Date daty,String caisse,Connection c) throws Exception{       
        try{
            Cloture[] liste=(Cloture[]) CGenUtil.rechercher(new Cloture(), null, null, c, " and daty>to_date('"+ daty +"','YYYY-MM-DD') and caisse='"+caisse+"'");
            if(liste.length>0){
                for(int i=0;i<liste.length;i++){
                    liste[i].setSolde(liste[i].getSolde()+debit);
                    liste[i].setSolde(liste[i].getSolde()-credit);
                    liste[i].updateToTable(c);
                }
            }
        }catch(Exception e){
            throw e;
        }
    }
    public static double getMontantBilletage(Date daty, String caisse, Connection c) throws Exception {
        double montant=0;
        try {
            Billetage[] listeB=(Billetage[]) CGenUtil.rechercher(new Billetage(),null,null,c,"and daty=to_date('" + daty + "','YYYY-MM-DD') and caisse='" + caisse + "'");
            //if(listeB.length==0) throw new Exception("Pas d'enregistrement de billet pour cette caisse à cette date");
            if(listeB.length>0){
                montant=listeB[0].getMontant();
            }
            return montant;
        } catch (Exception e) {
            throw e;
        }
    }

}
