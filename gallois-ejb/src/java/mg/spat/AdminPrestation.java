/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.CGenUtil;
import java.sql.Connection;
import java.util.ArrayList;
import mg.spat.exploitant.Activite;
import mg.spat.exploitant.AdminActivite;
import utilitaire.Utilitaire;

/**
 *
 * @author
 */
public class AdminPrestation {
    
    private OccupationMaterielNavalLibComplet[] listePrestation;
    
    
    public AdminPrestation(){
    }
    
    public void findPrestations(String[] ids) throws Exception{
        OccupationMaterielNavalLibComplet o = new OccupationMaterielNavalLibComplet();
        OccupationMaterielNavalLibComplet[] ls = (OccupationMaterielNavalLibComplet[]) CGenUtil.rechercher(o, null, null, " and id in ("+Utilitaire.tabToString(ids, "'", ",")+")");
        if(ls.length > 0){
            setListePrestation(ls);
        }
    }
    
    public ArrayList<Activite> genererActivite(Connection c) throws Exception {
        ArrayList<Activite> reps = new ArrayList();
            for(int i=0; listePrestation!=null && i<listePrestation.length; i++){
                reps.add(OccupationMaterielNaval.genererActivite(listePrestation[i], c));
            }
        return reps;
    }
    
    public void facturer(String user) throws Exception {
        Connection c = null;
        
        try {
            c = (new utilitaire.UtilDB()).GetConn();
            c.setAutoCommit(false);
            
            AdminActivite adminAct = new AdminActivite();
            java.util.List<Activite> activites = this.genererActivite(c);
            adminAct.setListeActivites(activites.toArray(new Activite[activites.size()]));
            
            adminAct.facturer(user, c);
            
            c.commit();
        } catch (Exception e) {
            if(c != null) c.rollback();
            throw e;
        }
        finally {
            if(c != null) c.close();
        }
    }
            
            
    public OccupationMaterielNavalLibComplet[] getListePrestation() {
        return listePrestation;
    }

    public void setListePrestation(OccupationMaterielNavalLibComplet[] listePrestation) {
        this.listePrestation = listePrestation;
    }
}
