/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.allosakafo.fin;

import bean.CGenUtil;
import bean.ClassEtat;
import java.sql.Connection;
import java.sql.Date;
import ded.OrdonnerPayement;
import mg.spat.JournalCaisse;
import service.ClotureService;
//import mg.amadia.compta.ComptaEcriture;
//import mg.cnaps.compta.ComptaEcriture;
//import mg.cnaps.compta.ComptaSousEcriture;
//import mg.cnaps.compta.Lettrage;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import user.*;
import utilitaire.Constante;
import utilitaire.Utilitaire;
//import mg.amadia.facture.Caisse;
//import mg.amadia.sig.SigPersonnes;

/**
 *
 * @author Joe
 */
public class MvtCaisse extends JournalCaisse {
    
    public static JournalCaisse getMvtCaisse(String idordre, Connection c) throws Exception  {
        boolean in = false;
        try {
            if(c == null){
                c = new UtilDB().GetConn();
                in = !in;
            }
            JournalCaisse[] mvtCaisse = (JournalCaisse[])CGenUtil.rechercher(new JournalCaisse(), null, null, c, " and idordre = '"+idordre+"' and etat = "+ConstanteEtat.getEtatValider());
            if(mvtCaisse.length >= 1){
                return mvtCaisse[0];
            }
        } catch (Exception e) {
            throw e;
        } finally{
            if(in && c!=null )c.close();
        }
        return null;
    }
    
    
//    public OrdonnerPayement getOP(Connection c) throws Exception {
//        OrdonnerPayement crtOrd = new OrdonnerPayement();
//        crtOrd.setId(this.getIdordre());
//        OrdonnerPayement ret[] = (OrdonnerPayement[]) CGenUtil.rechercher(crtOrd, null, null, c, "");
//        if (ret.length == 0) {
//            return null;
//        }
//        return ret[0];
//    }

   

    @Override
    public void viser(UserEJBBean user, Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            if (this.getEtat() >= ConstanteEtat.getEtatValider()) {
                throw new Exception("mouvement caissse deja valide");
            }

        } catch (Exception e) {
            if (c != null && verif == 1) {
                c.rollback();
            }
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

}
