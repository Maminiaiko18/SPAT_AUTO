/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package datas;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import bean.CGenUtil;
import java.sql.Connection;
import mg.spat.Mouvement;
import mg.spat.Prevision;
import mg.spat.Quais;
import mg.spat.RecapOccupationQuais;
import mg.spat.RecapQuai;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author HP
 */
public class RecapQuaisDatas {

    private ArrayList<HashMap<String, Object>> autres;

    public RecapQuaisDatas(Date date, Date date_f, String type) throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            autres = new ArrayList<HashMap<String, Object>>();
            
            Quais quaisMG = new Quais();
            quaisMG.setNomTable("QUAIS_MG");
            Quais[] liste = (Quais[]) CGenUtil.rechercher(quaisMG, null, null, c, "");
            RecapQuai[] ls = (RecapQuai[]) CGenUtil.rechercher(new RecapQuai(), null, null, c, " and etat >= " + ConstanteEtat.getEtatValider() + " order by DATE_ARRIVEE_OCCUP asc");
//            int total = 0;
            
            for (int j = 0; j < liste.length; j++) {
                autres.add(new HashMap<String, Object>());
                autres.get(autres.size() - 1).put("quais", liste[j]);
//                System.out.println("quais -----> " + liste[j].getId());
                for (int i = 0; i < ls.length; i++) {
                    if (ls[i].getIdquai() != null && liste[j].getId().compareTo(ls[i].getIdquai()) == 0) {
                        if (is(ls[i], date, date_f, type)) {
                            if (((ArrayList) autres.get(autres.size() - 1).get("Occupation")) == null) {
                                autres.get(autres.size() - 1).put("Occupation", new ArrayList<Mouvement>());
                            }
                            ((ArrayList) autres.get(autres.size() - 1).get("Occupation")).add(ls[i]);
                        }
                    }
                }

//                if (autres.get(autres.size() - 1).get("Occupation") != null) {
//                    System.out.println("occup " + ((ArrayList) autres.get(autres.size() - 1).get("Occupation")).size());
//                    total += ((ArrayList) autres.get(autres.size() - 1).get("Occupation")).size();
//                }
            }
            
//            System.out.println("total " + total);

        } catch (Exception e) {
            e.printStackTrace();
            if (c != null) {
                c.rollback();
            }
            throw e;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public boolean is(RecapQuai valeur, Date d, Date f, String type_q) {
        if ((valeur.getDate_arrivee_occup() != null && Utilitaire.getDiffJour(d, valeur.getDate_arrivee_occup()) >= 0
                && Utilitaire.getDiffJour(f, valeur.getDate_arrivee_occup()) <= 0
                && (valeur.getIdTypeQuais().compareTo(type_q) == 0 || type_q.isEmpty()))
                || (valeur.getDate_arrivee_prev() != null
                && Utilitaire.getDiffJour(d, valeur.getDate_arrivee_prev()) >= 0
                && Utilitaire.getDiffJour(f, valeur.getDate_arrivee_prev()) <= 0
                && (valeur.getIdTypeQuais().compareTo(type_q) == 0 || type_q.isEmpty()))) {
            return true;
        }

        return false;
    }

    public ArrayList<HashMap<String, Object>> getAutres() {
        return autres;
    }

    public void setAutres(ArrayList<HashMap<String, Object>> autres) {
        this.autres = autres;
    }
}
