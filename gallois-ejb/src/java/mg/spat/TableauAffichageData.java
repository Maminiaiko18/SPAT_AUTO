/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.CGenUtil;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import utilitaire.UtilDB;

/**
 *
 * @author MEVA
 */
public class TableauAffichageData {
    private MouvementLibComplet[] listeOccupation;
    private PrevisionLibComplet[] listePrevision;

    public TableauAffichageData() {
    }
    public void getRecapAffichage(Connection c,Date debut,Date fin) throws Exception{
        boolean estOuvert=false;
        try{
            if(c==null){
                c=new UtilDB().GetConn();
                estOuvert=true;
            }
            MouvementLibComplet complet = new MouvementLibComplet();
            complet.setNomTable("mouvementLibCompletTA");
//            System.out.println(" and datearrivee>=to_date('"+debut+"','yyyy-mm-dd') and datearrivee<=to_date('"+fin+"','yyyy-mm-dd') and date_depart is null order by datearrivee desc,heure desc");
//            listeOccupation=(MouvementLibComplet[])CGenUtil.rechercher(complet, null, null,c, "and etat=11 and datearrivee>=to_date('"+debut+"','yyyy-mm-dd') and datearrivee<=to_date('"+fin+"','yyyy-mm-dd') and date_depart is null order by datearrivee desc,heure desc");
            listeOccupation=(MouvementLibComplet[])CGenUtil.rechercher(complet, null, null,c, "and etat=11 and date_depart is null order by datearrivee desc,heure desc");
            listePrevision=(PrevisionLibComplet[])CGenUtil.rechercher(new PrevisionLibComplet(), null, null,c, "and etat=11 and date_arrivee>=to_date('"+debut+"','yyyy-mm-dd') and date_arrivee<=to_date('"+fin+"','yyyy-mm-dd') order by date_arrivee desc,heure_arrivee desc");
        }catch(Exception e){
            throw e;
        }finally{
            if(estOuvert)c.close();
        }
    }
    

    public MouvementLibComplet[] getListeOccupation() {
        return listeOccupation;
    }

    public PrevisionLibComplet[] getListePrevision() {
        return listePrevision;
    }
    
}
