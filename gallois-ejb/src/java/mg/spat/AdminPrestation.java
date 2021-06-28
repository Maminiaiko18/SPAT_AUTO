/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.CGenUtil;
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
    
    public OccupationMaterielNavalLibComplet[] getListePrestation() {
        return listePrestation;
    }

    public void setListePrestation(OccupationMaterielNavalLibComplet[] listePrestation) {
        this.listePrestation = listePrestation;
    }
}
