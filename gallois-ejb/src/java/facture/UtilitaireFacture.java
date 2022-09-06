/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.CGenUtil;
import java.sql.Connection;
import java.sql.Date;
import java.util.HashMap;
import java.util.Map;
import utilitaire.Utilitaire;

public class UtilitaireFacture {

    public static String genererSequence(Connection c, String nomtable, int longueur, String date, String code, String typecateg) throws Exception {
        //String daty = Utilitaire.datetostring(date);

        String sequence = "1";

        NumeroFacture num = new NumeroFacture();
        num.setNomTable(nomtable);
        
        String awhere = " and mois = %s and annee = %s and code like '%s' and typecateg like '%s'";
        String mois = Utilitaire.genererMois(date), annee = Utilitaire.getAnnee(date);
        awhere = String.format(awhere, mois, annee, code, typecateg);

        NumeroFacture[] nums = (NumeroFacture[]) CGenUtil.rechercher(num, null, null, c, awhere);

        if (nums != null && nums.length > 0) {
            sequence = "" + nums[0].getNumerosuivant();
        }

        return Utilitaire.completerInt(longueur, sequence);
    }

    public static String genererSequence(Connection c, String nomtable, int longueur, String date) throws Exception {
        //String daty = Utilitaire.datetostring(date);

        String sequence = "1";

        NumeroFacture num = new NumeroFacture();
        num.setNomTable(nomtable);

        String awhere = " and annee = %s";
        String annee = Utilitaire.getAnnee(date);
        awhere = String.format(awhere, annee);

        NumeroFacture[] nums = (NumeroFacture[]) CGenUtil.rechercher(num, null, null, c, awhere);

        if (nums != null && nums.length > 0) {
            sequence = "" + nums[0].getNumerosuivant();
        }

        return Utilitaire.completerInt(longueur, sequence);
    }

    public static String genererSequence(Connection c, String nomtable, int longueur, String date,String awhere) throws Exception {
        //String daty = Utilitaire.datetostring(date);

        String sequence = "1";

        NumeroFacture num = new NumeroFacture();
        num.setNomTable(nomtable);

        NumeroFacture[] nums = (NumeroFacture[]) CGenUtil.rechercher(num, null, null, c, awhere);

        if (nums != null && nums.length > 0) {
            sequence = "" + nums[0].getNumerosuivant();
        }

        return Utilitaire.completerInt(longueur, sequence);
    }
    
    public static String remplacerCharacteres(String texte) {
        Map<String, String> interpretations = new HashMap<String, String>();
        interpretations.put("&#8217;", "'");
        
        for(String charactere: interpretations.keySet()) {
            texte = texte.replaceAll(charactere, interpretations.get(charactere));
        }
        
        return texte;
    }
}
