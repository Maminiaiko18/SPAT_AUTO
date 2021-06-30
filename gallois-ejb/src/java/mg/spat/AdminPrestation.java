/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.CGenUtil;
import facture.FactureClient;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import mg.spat.exploitant.Activite;
import mg.spat.exploitant.AdminActivite;
import utilitaire.Utilitaire;

/**
 *
 * @author
 */
public class AdminPrestation {
    
    private OccupationMaterielNavalLibComplet[] listePrestation;
    private Prevision prevision;
    
    
    public AdminPrestation(){
    }
    
    public void findPrestations(String[] ids) throws Exception{
        OccupationMaterielNavalLibComplet o = new OccupationMaterielNavalLibComplet();
        o.setNomTable("occupationmaterielnavallibcpl");
        OccupationMaterielNavalLibComplet[] ls = (OccupationMaterielNavalLibComplet[]) CGenUtil.rechercher(o, null, null, " and id in ("+Utilitaire.tabToString(ids, "'", ",")+")");
        if(ls.length > 0){
            setListePrestation(ls);
        }
    }
    
    public void initPrevision(String idPrevision) throws Exception{
        Prevision p = new Prevision();
        Prevision[] ls = (Prevision[]) CGenUtil.rechercher(p, null, null, " and id='"+idPrevision+"'");
        if(ls.length > 0){
            this.prevision = ls[0];
        }
    }
    
    public ArrayList<Activite> genererActivite(String u, Connection c) throws Exception {
        ArrayList<Activite> reps = new ArrayList();
        for(int i=0; listePrestation!=null && i<listePrestation.length; i++){
            Activite act = listePrestation[i].genererActivite( u, c);
            act.validerObject(u, c);
            reps.add(act);
        }
        Activite actDroitePort = this.prevision.genererDroitDePort(u, c);
        actDroitePort.validerObject(u, c);
        reps.add(actDroitePort);
        
        Activite actRedevanceCommunale = this.prevision.genererRedevanceCommunale(u, c);
        actRedevanceCommunale.validerObject(u, c);
        reps.add(actRedevanceCommunale);
        return reps;
    }
    public String[] getIdsActivite(List<Activite> listeActivite){
        String[] retour=null;
        if(listeActivite!=null){
            retour=new String[listeActivite.size()];
            for(int i=0;i<listeActivite.size();i++){
                retour[i]=listeActivite.get(i).getId();
            }
        }
        return retour;
    }
    public FactureClient facturer(String user) throws Exception {
        Connection c = null;
        FactureClient fc=null;
        try {
            c = (new utilitaire.UtilDB()).GetConn();
            c.setAutoCommit(false);
            
            AdminActivite adminAct = new AdminActivite();
            java.util.List<Activite> activites = this.genererActivite(user, c);
            adminAct.findactivite(getIdsActivite(activites));
            //adminAct.setListeActivites(activites.toArray(new Activite[activites.size()]));
            
            fc=adminAct.facturer(user, c);
            
            c.commit();
        } catch (Exception e) {
            if(c != null) c.rollback();
            throw e;
        }
        finally {
            if(c != null) c.close();
        }
        return fc;
    }
            
            
    public OccupationMaterielNavalLibComplet[] getListePrestation() {
        return listePrestation;
    }

    public void setListePrestation(OccupationMaterielNavalLibComplet[] listePrestation) {
        this.listePrestation = listePrestation;
    }

    public Prevision getPrevision() {
        return prevision;
    }

    public void setPrevision(Prevision prevision) {
        this.prevision = prevision;
    }
    
}
