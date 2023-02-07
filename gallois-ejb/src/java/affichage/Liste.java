package affichage;

import bean.CGenUtil;
import java.sql.Connection;
import bean.ClassMAPTable;
import java.lang.reflect.Field;
import java.lang.reflect.Method;

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
public class Liste extends Champ {

    private String colAffiche;
    private String colValeur;
    
    private bean.ClassMAPTable singleton;
    private Object[] valeurBrute;
    private String[] colValeurBrute;
    //private String defaultSelected;
    private String apresW = "";

    public Liste() {
    }

    public Liste(String nom) {
	super(nom);
    }

    public Liste(bean.ClassMAPTable[] f) {
	setBase(f);
    }

    public Liste(String nom, Object[] f, String defaut) {
	super(nom);
	setValeurBrute(f);
	setDefaultSelected(defaut);
    }

    public Liste(String nom, ClassMAPTable f) {
	super(nom);
	setSingleton(f);
    }

    public Liste(String nom, Object[] f) {
	super(nom);
	setValeurBrute(f);
    }

    public Liste(String nom, String lib, Object[] f) {
	super(nom);
	this.setLibelle(lib);
	this.setValeurBrute(f);
    }

    public Liste(String nom, bean.ClassMAPTable f, String colAff) {
	super(nom);
	setSingleton(f);
	setColAffiche(colAff);
    }

    public Liste(String nom, bean.ClassMAPTable f, String colAff, String colV) throws Exception {
       
	super(nom);
	setSingleton(f);
	setColAffiche(colAff);
	setColValeur(colV);
        //findData(null);
    }

    public Liste(String nom, Object[] f, String[] valeur) {
	super(nom);
	setValeurBrute(f);
	setColValeurBrute(valeur);
    }

    public void makeListeMois() {
	String affiche[] = {"Janvier", "F\u00e9vrier", "Mars", "Avril", "Mai", "Juin", "Juillet", "Aout", "Septembre", "Octobre", "Novembre", "D\u00e9cembre"};
	String valeur[] = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"};
	setValeurBrute(affiche);
	setColValeurBrute(valeur);
    }

    public void makeListeOuiNon() {
	String affiche[] = {"NON", "OUI"};
	String valeur[] = {"0", "1"};
	setValeurBrute(affiche);
	setColValeurBrute(valeur);
    }
    
    public void makeListeOuiNon2() {
	String affiche[] = {"NON", "OUI", "AVOIR"};
	String valeur[] = {"0", "1", "2"};
	setValeurBrute(affiche);
	setColValeurBrute(valeur);
    }
    
    public void makeListeChamp() {
	String affiche[] = {"SOLDE", "CUMUL"};
	String valeur[] = {"SOLDE", "CUMUL"};
	setValeurBrute(affiche);
	setColValeurBrute(valeur);
    }
    
    public void makeListeDbCr() {
	String affiche[] = {"DB", "CR"};
	String valeur[] = {"DB", "CR"};
	setValeurBrute(affiche);
	setColValeurBrute(valeur);
    }

    public Liste(String nom, bean.ClassMAPTable[] f, String colAff, String colV) {
	super(nom);
	setBase(f);
	setColAffiche(colAff);
	setColValeur(colV);
    }

    public Liste(String nom, bean.ClassMAPTable f, String colAff, String colV, Connection c) throws Exception {
	super(nom);
	setSingleton(f);
	setColAffiche(colAff);
	setColValeur(colV);
	findData(c);
    }

    public void findData(Connection c) throws Exception {
	//if(getValeurBrute()==null||getValeurBrute().length==0)
	if (getSingleton() != null) {
	    String aW = " order by " + getColAffiche() + " ASC";
	    //System.out.println("la comande = "+getApresW()+aW);
	    bean.ClassMAPTable[] ret = (bean.ClassMAPTable[]) (CGenUtil.rechercher(getSingleton(), null, null, c, getApresW() + aW));
	    setBase(ret);
	}
    }

    //public Liste(
    public String makeHtmlValeur(String temp) throws Exception {
	for (int i = 0; i < getValeurBrute().length; i++) {
	    String champValeur = "";
	    if (getColValeurBrute() == null) {
		champValeur = valeurBrute[i].toString();
	    } else {
		champValeur = getColValeurBrute()[i];
	    }
	    String champAffiche = getValeurBrute()[i].toString();
	    String selected = "";
	    if (champValeur.compareToIgnoreCase(getValeur()) == 0) {
		selected = "selected";
	    } else if ((getValeur() == null || getValeur().compareToIgnoreCase("") == 0) && (getDefaultSelected() != null && getDefaultSelected().compareToIgnoreCase("") != 0)) {
		if (champValeur.compareToIgnoreCase(getDefaultSelected()) == 0) {
		    selected = "selected";
		}
	    }
	    temp += "<option value='" + champValeur + "' " + selected + ">" + champAffiche + "</option>";
	}
	return temp;
    }

    public void makeHtml() throws Exception {
	String temp = "";
	temp = "<select name=" + getNom() + " class=" + getCss() + " id=" + getNom() + ">";
	//if(this.getBase()==null||this.getBase().length==0)
	{
	    if (valeurBrute != null && valeurBrute.length > 0) {
		temp = makeHtmlValeur(temp);
	    }
	}
	
	if (this.getBase() != null && this.getBase().length > 0) {
	    temp += "<option value=" + ConstanteAffichage.asterisque + ">Tous</option>";

	    for (int i = 0; i < this.getBase().length; i++) {
		String champValeur = String.valueOf(CGenUtil.getValeurFieldByMethod((getBase()[i]), getColValeur()));
		String champAffiche = String.valueOf(CGenUtil.getValeurFieldByMethod((getBase()[i]), getColAffiche()));
		String selected = "";
		if ((getValeur() == null || getValeur().compareToIgnoreCase("") == 0) && getDefaultSelected() != null) {
		    if (champValeur.compareToIgnoreCase(getDefaultSelected()) == 0) {
			selected = "selected";
		    }
		} else if (champValeur.compareToIgnoreCase(getValeur()) == 0) {
		    selected = "selected";
		}
		temp += "<option value='" + champValeur + "' " + selected + ">" + champAffiche + "</option>";
	    }
	}
	temp += "</select>";
	setHtml(temp);
    }

    public void makeHtmlInsert() throws Exception {
	String temp = "";
	temp = "<select name=" + getNom() + " class=" + getCss() + " id=" + getNom() + " " + getAutre() + " >";
	//if(this.getBase()==null||this.getBase().length==0)
	{
	    if (valeurBrute != null && valeurBrute.length > 0) {
		temp = makeHtmlValeur(temp);
	    }
	}
	//else
//        System.out.println("__________________"+this.getBase().length);
        //System.out.println("nom de champ "+this.getNom()+" valeur : "+ this.getValeur());
	if (this.getBase() != null && this.getBase().length > 0) {

	    for (int i = 0; i < this.getBase().length; i++) {
		String champValeur = String.valueOf(CGenUtil.getValeurFieldByMethod((getBase()[i]), getColValeur()));
		String champAffiche = String.valueOf(CGenUtil.getValeurFieldByMethod((getBase()[i]), getColAffiche()));
		String selected = "";

		if ((getValeur() == null || getValeur().compareToIgnoreCase("") == 0) && getDefaultSelected() != null) {
		    if (champValeur.compareToIgnoreCase(getDefaultSelected()) == 0) {
			selected = "selected";
		    }
		} else if (champValeur.compareToIgnoreCase(getValeur()) == 0) {
		    selected = "selected";
		}
		temp += "<option value='" + champValeur + "' " + selected + ">" + champAffiche + "</option>";
	    }
	}
	temp += "</select>";
	setHtmlInsert(temp);
    }

    public void ajouterValeur(String[] valeur, String[] affiche) {
	setColValeurBrute(valeur);
	setValeurBrute(affiche);
    }

    

    public void setColAffiche(String colAffiche) {
	this.colAffiche = colAffiche;
    }

    public String getColAffiche() throws Exception {
	if (colAffiche == null) {
	    if (getSingleton() != null) {
		return getSingleton().getFieldList()[1].getName();
	    }
	    return getColValeur();
	}
	return colAffiche;
    }

    public void setColValeur(String colValeur) {
	this.colValeur = colValeur;
    }

    public String getColValeur() {
	if (colValeur == null) {
	    if (getBase() != null && getBase().length > 0) {
		return getBase()[0].getAttributIDName();
	    }
	}
	return colValeur;
    }

    public void setSingleton(bean.ClassMAPTable singleton) {
	this.singleton = singleton;
    }

    public bean.ClassMAPTable getSingleton() {
	return singleton;
    }

    public void setValeurBrute(Object[] valeurBrute) {
	this.valeurBrute = valeurBrute;
    }

    public Object[] getValeurBrute() {
	return valeurBrute;
    }

    public void setColValeurBrute(String[] colValeurBrute) {
	this.colValeurBrute = colValeurBrute;
    }

    public String[] getColValeurBrute() {
	return colValeurBrute;
    }

    public void setDefaultSelected(String defaultSelected) {
	setDefaut(defaultSelected);
	//this.defaultSelected = ;
    }

    public String getDefaultSelected() {
	return getDefaut();
    }

    public void setApresW(String apresW) {
	this.apresW = apresW;
    }

    public String getApresW() {
	return apresW;
    }

    public void makeListeStatut() {
	String affiche[] = {"ENC", "EFA", "ECD", "STG"};
	String valeur[] = {"ENC", "EFA", "ECD", "STG"};
	setValeurBrute(affiche);
	setColValeurBrute(valeur);
    }

    public void makeListeTypeInterneExterne() {
	String affiche[] = {"Interne", "Externe"};
	String valeur[] = {"interne", "externe"};
	setValeurBrute(affiche);
	setColValeurBrute(valeur);
    }

    public void makeListeString(String[] aaffiche, String[] value) {
	String affiche[] = aaffiche;
	String valeur[] = value;
	setValeurBrute(affiche);
	setColValeurBrute(valeur);
    }

    public void makeListeTypeDeplacementArrive() {
	String affiche[] = {"Final", "Intermediaire", "Retour"};
	String valeur[] = {"Final", "Intermediaire", "Retour"};
	setValeurBrute(affiche);
	setColValeurBrute(valeur);
    }

    public void makeListeTypeRoute() {
	String affiche[] = {"Ville", "Route"};
	String valeur[] = {"0", "1"};
	setValeurBrute(affiche);
	setColValeurBrute(valeur);
    }

    public void makeListeEnquete() {
	String affiche[] = {"Pris en charge", "Rejeter"};
	String valeur[] = {"0", "1"};
	setValeurBrute(affiche);
	setColValeurBrute(valeur);
    }

    public void makeListeFromArray(String afficher, String val, ClassMAPTable[] array) throws Exception {
	try {
	    Method valeurAffiche = array[0].getClass().getMethod("get" + utilitaire.Utilitaire.convertDebutMajuscule(afficher), null);
	    Method valeurVal = array[0].getClass().getMethod("get" + utilitaire.Utilitaire.convertDebutMajuscule(val), null);
	    String[] affiche = new String[array.length];
	    String[] valeur = new String[array.length];
	    for (int i = 0; i < array.length; i++) {
		affiche[i] = (String) valeurAffiche.invoke(array[i], null);
		valeur[i] = (String) valeurVal.invoke(array[i], null);
	    }
	    setValeurBrute(affiche);
	    setColValeurBrute(valeur);
	} catch (Exception e) {
	    e.printStackTrace();
	    throw new Exception("method get" + utilitaire.Utilitaire.convertDebutMajuscule(afficher) + " get" + utilitaire.Utilitaire.convertDebutMajuscule(val) + " introuvable");
	}
    }
    public void setDeroulanteDependante(Liste autre,String nomColonneFiltreAutre,String event) throws Exception
    {
        String evenement="onblur";
        if(event!=null&&event.compareToIgnoreCase("")!=0)evenement=event;
        //dependante(valeurFiltre,champDependant,nomTable,nomClasse,nomColoneFiltre,nomColvaleur,nomColAffiche)
        this.setAutre(" "+this.getAutre()+" "+evenement+"=\"dependante(this.value,'"+autre.getNom()+"','"+autre.getSingleton().getNomTable()+"'"
                + ",'"+autre.getSingleton().getClass().getName()+"','"+nomColonneFiltreAutre+"','"+getColValeur()+"','"+getColAffiche()+"')\"");
    }
    
    public void setDeroulanteDependante(Formulaire formu,String autre,String nomColonneFiltreAutre,String event) throws Exception
    {
        Liste c=(Liste)formu.getChamp(autre);
        this.setDeroulanteDependante(c, nomColonneFiltreAutre, event);
    }
    public void setDeroulanteDependanteAvecTiret(Liste autre,String nomColonneFiltreAutre,String event,boolean esttiret) throws Exception
    {
        String evenement="onblur";
        if(event!=null&&event.compareToIgnoreCase("")!=0)evenement=event;
        this.setAutre(getAutre()+" "+evenement+"=\"dependantewithtiret(this.value,'"+autre.getNom()+"','"+autre.getSingleton().getNomTable()+"'"
                + ",'"+autre.getSingleton().getClass().getName()+"','"+nomColonneFiltreAutre+"','"+autre.getColValeur()+"','"+autre.getColAffiche()+"','"+esttiret+"')\"");
    }
    
    public void makeHtmlInsertTableau(int indice) throws Exception {
        String temp = "";
	temp = "<select name=" + getNom() + " class=" + getCss() + " id=" + getNom() +" " + getAutre() + " >";
	{
	    if (valeurBrute != null && valeurBrute.length > 0) {
		temp = makeHtmlValeur(temp);
	    }
	}
	if (this.getBase() != null && this.getBase().length > 0) {

	    for (int i = 0; i < this.getBase().length; i++) {
		String champValeur = String.valueOf(CGenUtil.getValeurFieldByMethod((getBase()[i]), getColValeur()));
		String champAffiche = String.valueOf(CGenUtil.getValeurFieldByMethod((getBase()[i]), getColAffiche()));
		String selected = "";

		if ((getValeur() == null || getValeur().compareToIgnoreCase("") == 0) && getDefaultSelected() != null) {
		    if (champValeur.compareToIgnoreCase(getDefaultSelected()) == 0) {
			selected = "selected";
		    }
		} else if (champValeur.compareToIgnoreCase(getValeur()) == 0) {
		    selected = "selected";
		}
		temp += "<option value='" + champValeur + "' " + selected + ">" + champAffiche + "</option>";
	    }
	}
	temp += "</select>";
        setHtmlTableauInsert(temp);
    }
    
    public String makeHtmlTabInsert(int indice) throws Exception {
        String temp = "";
	temp = "<select name=" + getNom() + "_"+indice+" class=" + getCss() + " id=" + getNom() +"_"+indice+" " + getAutre() + " >";
	{
	    if (valeurBrute != null && valeurBrute.length > 0) {
		temp = makeHtmlValeur(temp);
	    }
	}
//        System.out.println("avant miditra base");
	if (this.getBase() != null && this.getBase().length > 0) {
//            System.out.println("tafiditra base");
	    for (int i = 0; i < this.getBase().length; i++) {
//                System.out.println("commando -- "+i);
		String champValeur = String.valueOf(CGenUtil.getValeurFieldByMethod((getBase()[i]), getColValeur()));
//                System.out.println("champValeur = " + champValeur);
		String champAffiche = String.valueOf(CGenUtil.getValeurFieldByMethod((getBase()[i]), getColAffiche()));
		String selected = "";

		if ((getValeur() == null || getValeur().compareToIgnoreCase("") == 0) && getDefaultSelected() != null) {
//                    System.out.println(" -- 1 -- ");
		    if (champValeur.compareToIgnoreCase(getDefaultSelected()) == 0) {
//                        System.out.println(" -- 2 -- ");
			selected = "selected";
		    }
		} else if (champValeur.compareToIgnoreCase(getValeur()) == 0) {
//                    System.out.println(" -- 3 -- ");
		    selected = "selected";
		}
		temp += "<option value='" + champValeur + "' " + selected + ">" + champAffiche + "</option>";
	    }
	}
	temp += "</select>";
        setHtmlTableauInsert(temp);
        return temp;
    }
    
    public String makeHtmlTabInsert(int indice,String valeur) throws Exception {
        String temp = "";
        setValeur(valeur);
	temp = "<select name=" + getNom() + "_"+indice+" class=" + getCss() + " id=" + getNom() +"_"+indice+" " + getAutre() + " >";
	{
	    if (valeurBrute != null && valeurBrute.length > 0) {
		temp = makeHtmlValeur(temp);
	    }
	}
//        System.out.println("avant miditra base");
	if (this.getBase() != null && this.getBase().length > 0) {
//            System.out.println("tafiditra base");
	    for (int i = 0; i < this.getBase().length; i++) {
//                System.out.println("commando -- "+i);
		String champValeur = String.valueOf(CGenUtil.getValeurFieldByMethod((getBase()[i]), getColValeur()));
//                System.out.println("champValeur = " + champValeur);
		String champAffiche = String.valueOf(CGenUtil.getValeurFieldByMethod((getBase()[i]), getColAffiche()));
		String selected = "";

		if ((getValeur() == null || getValeur().compareToIgnoreCase("") == 0) && getDefaultSelected() != null) {
//                    System.out.println(" -- 1 -- ");
		    if (champValeur.compareToIgnoreCase(getDefaultSelected()) == 0) {
//                        System.out.println(" -- 2 -- ");
			selected = "selected";
		    }
		} else if (champValeur.compareToIgnoreCase(getValeur()) == 0) {
//                    System.out.println(" -- 3 -- ");
		    selected = "selected";
		}
		temp += "<option value='" + champValeur + "' " + selected + ">" + champAffiche + "</option>";
	    }
	}
	temp += "</select>";
        setHtmlTableauInsert(temp);
        return temp;
    }
    
    public String getHtmlTableauInsert(int i, String valeur) throws Exception {
        //htmlTableauInsert = null;
        return makeHtmlTabInsert(i,valeur);
    }
}
