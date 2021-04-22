/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package affichage;

import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author tahina
 */
public class PageRechercheUpdate extends PageRecherche {
    Formulaire formuLigne;
    String id;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Formulaire getFormuLigne() {
        return formuLigne;
    }

    public void setFormuLigne(Formulaire formuLigne) {
        this.formuLigne = formuLigne;
    }
    
    public  void creerFormuLigne(String[]tabAffiche)throws Exception
    {
        formuLigne=new Formulaire();
        formuLigne.setObjet(getBase());
        formuLigne.makeChampFormuLigne(tabAffiche);
    }
    
    public PageRechercheUpdate(bean.ClassMAPTable o, HttpServletRequest req, String[] vrt, String[] listInterval, int nbRange, String[] tabAff,String ids) throws Exception {
        super(o,req,vrt,listInterval,nbRange,tabAff);
        creerFormuLigne(tabAff);
        setId(ids);
    }
    public void creerObjetPage(String libEnteteDefaut[], String[] colSom) throws Exception
    {
        super.creerObjetPage(libEnteteDefaut, colSom);
        this.getTableau().setIds(getId());
        getTableau().setFormu(getFormuLigne());
        
    }
}
