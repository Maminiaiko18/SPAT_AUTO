/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package service;

import bean.CGenUtil;
import java.sql.Connection;
import java.sql.Date;
import java.util.ArrayList;
import mg.spat.Billetage;
import mg.spat.Cloture;
import mg.spat.CloturerBilletage;
import mg.spat.JournalCaisse;

/**
 *
 * @author MEVA
 */
public class BilletageService {
    public static void testDateCloture(Date daty,String caisse, Connection c) throws Exception {
        try {
            CloturerBilletage[] liste = (CloturerBilletage[]) CGenUtil.rechercher(new CloturerBilletage(), null, null, c, " and daty=to_date('"+ daty +"','YYYY-MM-DD') and caisse='"+caisse+"'");
            if(liste.length>0) throw new Exception("Cette caisse a déjà été cloturée à cette date");
        } catch (Exception e) {
            throw e;
        }
    }
    
    public static ArrayList<Object> testConformite(JournalCaisse[] liste, Billetage billetage){
        boolean test=false;
        ArrayList<Object> valiny=new ArrayList<Object>();
        try{
            double val=0;
            for(int i=0;i<liste.length;i++){
                val+=(liste[i].getDebit()-liste[i].getCredit());
            }
            if(val==billetage.getMontant()) test=true;
            valiny.add(test);
            valiny.add(billetage.getMontant());
            valiny.add(val);
            return valiny;
        }catch(Exception e){
            throw e;
        }
    }
    
}
