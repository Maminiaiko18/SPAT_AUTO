package utilitaire;

import java.util.Hashtable;
import java.util.Hashtable;
import java.util.Vector;

/**
 * <p>
 * Title: Gestion des recettes </p>
 * <p>
 * Description: </p>
 * <p>
 * Copyright: Copyright (c) 2005</p>
 * <p>
 * Company: </p>
 *
 * @author unascribed
 * @version 1.0
 */
public class Config {

    static Hashtable listeMatiere = new Hashtable();

    static bean.TypeObjet[] listeOption;
    //static java.util.Hashtable listeMatiereOptionClasse=new Hashtable();
    static bean.TypeObjet[] listeSemestre;

    public Config(Hashtable liste) {
        setListeMatiere(liste);
    }

    void setListeMatiere(Hashtable liste) {
        listeMatiere = liste;
    }

    public static Hashtable getListeMatiere() {
        return listeMatiere;
    }

    public static void vider() {
        listeMatiere = null;
        listeOption = null;
    }

    public void setListeOption(bean.TypeObjet[] listeOption) {
        this.listeOption = listeOption;
    }

    public static bean.TypeObjet[] getListeOption() {
        return listeOption;
    }
    /* public void setListeMatiereOptionClasse(java.util.Hashtable listeMatiereOptionClasse) {
     this.listeMatiereOptionClasse = listeMatiereOptionClasse;
     }
     public java.util.Hashtable getListeMatiereOptionClasse() {
     return listeMatiereOptionClasse;
     }*/

    public void setListeSemestre(bean.TypeObjet[] listeSemestre) {
        this.listeSemestre = listeSemestre;
    }

    public bean.TypeObjet[] getListeSemestre() {
        return listeSemestre;
    }
}
