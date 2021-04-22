package affichage;

import bean.CGenUtil;
import bean.ClassMAPTable;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import user.UserEJB;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

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
public class Champ {

    private String nom;
    private String defaut = "";
    private String css = "form-control";
    private String type = ConstanteAffichage.typeTextBox;
    private String libelle;
    private String pageAppel;
    private String cssLibelle = "left";
    private String html;
    private int taille;
    private String valeur;
    private String typeData = ConstanteAffichage.typeTexte;
    private java.lang.reflect.Field attribut;
    private int estIntervalle = 0;
    private String autre;
    private String libelleAffiche;
    private String htmlInsert;
    private boolean visible = true;
    private boolean photo = false;
    private String htmlTableauInsert;
    private String htmlTableau;
    private String champReturn;
    private String apresLienPageappel = "";
    private String urlFiche = "";
    private boolean autoComplete = false;
    private String valeur_ac;
    private String[] colFiltre;
    private String[] valFiltre;
    
    private String ac_affiche;
    private String ac_valeur;
    private String ac_nomTable;
    private String ac_aWhere;
    private boolean autocomplete = false;
    private Ac_object[] tab_ac;
    private bean.ClassMAPTable[] base;
    private bean.ClassMAPTable mine;
    
    Formulaire formulaire;
    private String valeurLibelle;

    public Formulaire getFormulaire() {
        return formulaire;
    }

    public void setFormulaire(Formulaire formulaire) {
        this.formulaire = formulaire;
    }

    public ClassMAPTable getMine() {
        return mine;
    }

    public void setMine(ClassMAPTable mine) {
        this.mine = mine;
    }
    
    
    public bean.ClassMAPTable[] getBase() {
	return base;
    }

    public void setBase(bean.ClassMAPTable[] base) {
	this.base = base;
    }

    public boolean isAutocomplete() {
        return autocomplete;
    }

    public void setAutocomplete(boolean autocomplete) {
        this.autocomplete = autocomplete;
    }
    
    public String getAc_affiche() {
        return ac_affiche;
    }

    public void setAc_affiche(String ac_affiche) {
        this.ac_affiche = ac_affiche;
    }

    public String getAc_valeur() {
        return ac_valeur;
    }

    public void setAc_valeur(String ac_valeur) {
        this.ac_valeur = ac_valeur;
    }

    public String getAc_nomTable() {
        return ac_nomTable;
    }

    public void setAc_nomTable(String ac_nomTable) {
        this.ac_nomTable = ac_nomTable;
    }
    
    public Ac_object[] getTab_ac() {
        return tab_ac;
    }

    public void setTab_ac(Ac_object[] tab_ac) {
        this.tab_ac = tab_ac;
        transformToStringAc();
    }

    public String getAc_aWhere() {
        return ac_aWhere;
    }

    public void setAc_aWhere(String ac_aWhere) {
        this.ac_aWhere = ac_aWhere;
    }

    
    PageConsulteLien lien;

    /*public String getLien() {
     return lien;
     }

     public void setLien(String lien) {
     this.lien = lien;
     }*/

    public String[] getColFiltre() {
        return colFiltre;
    }

    public void setColFiltre(String[] colFiltre) {
        this.colFiltre = colFiltre;
    }

    public String[] getValFiltre() {
        return valFiltre;
    }

    public void setValFiltre(String[] valFiltre) {
        this.valFiltre = valFiltre;
    }
    
     public void setPageAppelAvecFiltre(String pageAppel, String champReturnn,String[] col,String[] val) {
        this.pageAppel = pageAppel;
        this.champReturn = champReturnn;
        this.setColFiltre(col);
        this.setValFiltre(val);
    }
    
    
    public String getValeur_ac() {
        return valeur_ac;
    }
     public void setValeur_ac(String valeur_ac) {
        this.valeur_ac = valeur_ac;
    }
    public String getUrlFiche() {
        return urlFiche;
    }

    public void setUrlFiche(String urlFiche) {
        this.urlFiche = urlFiche;
    }

    public String getApresLienPageappel() {
        return apresLienPageappel;
    }

    public void setApresLienPageappel(String apresLienPageappel) {
        this.apresLienPageappel = apresLienPageappel;
    }

    public PageConsulteLien getLien() {
        return lien;
    }

    public void setLien(PageConsulteLien lien) {
        this.lien = lien;
    }

    public void setLien(String lien, String queryString) {
        setLien(new PageConsulteLien(lien, queryString));
    }

    public boolean isPhoto() {
        return photo;
    }

    public void setPhoto(boolean photo) {
        this.photo = photo;
    }

    public Champ() {
    }

    public Champ(String nom) {
        setNom(nom);
    }

    public String toString() {
        return getNom();
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public void setDefaut(String defaut) {
        this.defaut = defaut;
    }
    
    public static void setDefaut(Champ[] tChamp, String defaut) {
        for(Champ c : tChamp)
            c.setDefaut(defaut);
    }

    public String getDefaut() {
        return defaut;
    }

    public void setCss(String css) {
        this.css = css;
    }
    
    public static void setCss(Champ[] tChamp, String css) {
        for(Champ c : tChamp)
            c.setCss(css);
    }

    public String getCss() {
        return css;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getType() {
        return type;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

    public String getLibelle() {
        if (libelle == null || libelle.compareToIgnoreCase("") == 0) {
            return nom;
        }
        return libelle;
    }

    public void setPageAppel(String pageAppel) {
        this.pageAppel = pageAppel;
        this.champReturn = this.getNom() + ";" + this.getNom() + "libelle";
    }
    
    public static void setPageAppel(Champ[] tChamp, String pageAppel, String champReturn) throws Exception {
        for(Champ c : tChamp){
            c.pageAppel = pageAppel;
            c.champReturn = champReturn;
        }
    }
    
    public static void setAutocomplete(Champ[] tChamp, String affiche, String valeur, String nomTable, String aWhere) throws Exception {
        for(Champ c : tChamp){
            c.ac_affiche = affiche;
            c.ac_valeur = valeur;
            c.ac_nomTable = nomTable;
            c.autocomplete = true;
            c.ac_aWhere = aWhere;
        }
    }

    public String getChampReturn() {
        return champReturn;
    }

    public void setChampReturn(String champReturn) {
        this.champReturn = champReturn;
    }

    public void setPageAppel(String pageAppel, String champReturnn) {
        this.pageAppel = pageAppel;
        this.champReturn = champReturnn;
    }
    
    

    public String getPageAppel() {
        return pageAppel;
    }

    public void setCssLibelle(String cssLibelle) {
        this.cssLibelle = cssLibelle;
    }

    public String getCssLibelle() {
        return cssLibelle;
    }

    public void setHtml(String html) {
        this.html = html;
    }

    public void setHtmlTableau(String htmlTableau) {
        this.htmlTableau = htmlTableau;
    }

    public String getHtml() throws Exception {
        if (html == null || html.compareToIgnoreCase("") == 0) {
            this.makeHtml();
        }
        return html;
    }

    public String getHtmlTableau(int i) throws Exception {
        this.makeHtmlTableau(i);
        return htmlTableau;
    }

    public void makeHtml() throws Exception {
        String temp = "";
        if(getVisible()==false)
        {
            temp = "<input name='" + getNom() + "' type='hidden' class=" + getCss() + "  id=" + getNom() + " value='" + getValeur() + "' " + getAutre() + ">";
        }
        else if (type.compareTo(ConstanteAffichage.textarea) == 0) {
            //temp = "<textarea name='" + getNom() + "' row='3' class='" + getCss() + "' id='" + getNom() + "' maxlength='" + getTaille() + "'>" + getValeur() + "</textarea>";
            temp = "<textarea name='" + getNom() + "' class='" + getCss() + "' id='" + getNom() + "' style='resize: none;'>" + getValeur() + "</textarea>";
        } // ==== nampiana 
        else if (typeData.compareTo(ConstanteAffichage.typeDaty) == 0) {
            temp = "<input name=" + getNom() + " type=" + getType() + " class='" + getCss() + " datepicker'  id=" + getNom() + " value='" + getValeur() + "' " + getAutre() + ">";

        } // ==== nampiana 
        else if (!this.isPhoto()) 
        {
            temp = "<input name=" + getNom() + " type=" + getType() + " class=" + getCss() + "  id=" + getNom() + " value='" + getValeur() + "' " + getAutre() + ">";
            if (!this.isAutoComplete()) {
                temp += "<input type=hidden value='' name=" + getNom() + "auto>";
            }
        } else {
            temp = "<input name=" + getNom() + " type=\"file\" class=" + getCss() + " id=" + getNom() + " " + getAutre() + ">";
            if (!getValeur().isEmpty()) {
                temp += "<input type=\"hidden\" value=\"" + getValeur() + "\" name=\"" + getNom() + "2" + "\">";
            }
        }
        setHtml(temp);
    }

    public void makeHtmlTableau(int i) throws Exception {
        String temp = "";
        //System.out.println("i="+i);
        if(getVisible()==false)
        {
            temp = "<input name='" + getNom() + "' type='hidden' class=" + getCss() + "  id=" + getNom() + " value='" + getValeur() + "' " + getAutre() + ">";
        }
        else if (type.compareTo(ConstanteAffichage.textarea) == 0) {
            //temp = "<textarea name='" + getNom() + "' row='3' class='" + getCss() + "' id='" + getNom() + "' maxlength='" + getTaille() + "'>" + getValeur() + "</textarea>";
            temp = "<textarea name='" + getNom() + "' class='" + getCss() + "' id='" + getNom() + "' style='resize: none;'>" + getValeur() + "</textarea>";
        } 
        else if (!this.isPhoto()) {
            //System.out.println("***************"+getValeur());
            temp = "<input name='" + getNom() + "' type=" + getType() + " class=" + getCss() + "  id=" + getNom() + " value='" + getValeur() + "' " + getAutre() + ">";

        } else {
            //System.out.println("getValeur() insert ===  " + getValeur());
            temp = "<input name='" + getNom() + "' type=\"file\" class=" + getCss() + " id=" + getNom() + " " + getAutre() + ">";
            if (!getValeur().isEmpty()) {

                temp += "<input type=\"hidden\" value=\"" + getValeur() + "\" name=\"" + getNom() + "2" + "_" + i + "\">";
            }
        }
        setHtmlTableau(temp);
    }

    public void makeHtmlInsert() throws Exception {
    }

    public void setTaille(int taille) {
        this.taille = taille;
    }
    
    public static void setTaille(Champ[] tChamp, int taille) {
        for(Champ c : tChamp)
            c.setTaille(taille);
    }

    public int getTaille() {
        return taille;
    }

    public void setValeur(String valeur) {
        this.valeur = valeur;
    }
    
    public static void setValeur(Champ[] tChamp, String valeur) {
        for(Champ c : tChamp)
            c.setValeur(valeur);
    }

    public String getValeur() {
        if (valeur == null || valeur.compareToIgnoreCase("null") == 0 || valeur.compareToIgnoreCase("") == 0) {
            if (getDefaut() == null || getDefaut().compareToIgnoreCase("null") == 0) {
                return "";
            }
            return getDefaut();
        }
        return valeur;
    }

    
    public String getValeurLibelle() {
        if (valeurLibelle == null || valeurLibelle.compareToIgnoreCase("null") == 0 || valeurLibelle.compareToIgnoreCase("") == 0) {
            if (getDefaut() == null || getDefaut().compareToIgnoreCase("null") == 0) {
                return "";
            }
            return getDefaut();
        }
        String valeur = valeurLibelle;
        if(valeur!=null && valeur.contains("'")){
            valeur = valeur.replaceAll("'", "&apos;");
        }
        return valeur;
    }
    
    public void setValeurLibelle(String valeurLibelle) {
        this.valeurLibelle = valeurLibelle;
    }
    
    public void setTypeData(String typeData) {
        this.typeData = typeData;
    }
    
    public static void setTypeData(Champ[] tChamp, String typeData) {
        for(Champ c : tChamp)
            c.setTypeData(typeData);
    }

    public String getTypeData() {
        return typeData;
    }

    public void setAttribut(java.lang.reflect.Field attribut) {
        this.attribut = attribut;
    }

    public java.lang.reflect.Field getAttribut() {
        return attribut;
    }

    public void setEstIntervalle(int estIntervalle) {
        this.estIntervalle = estIntervalle;
    }

    public int getEstIntervalle() {
        return estIntervalle;
    }
    public void findDataAutoComplete(Connection c) throws Exception
    {
        if (isAutocomplete()) 
        {
            //System.out.println("mandalo autocomplete = " );
            Ac_object[] ac_objt = null;
            ResultSet dr = null;
            Statement st = null;
            try {
                String req = "select " + getAc_affiche() + ", " + getAc_valeur() + " from " + getAc_nomTable() +" where 1<2 "+getAc_aWhere();
                st = c.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                dr = st.executeQuery(req);
                List<Ac_object> liste = new ArrayList<>();
                while (dr.next()) {
                    Ac_object aco=new Ac_object(dr.getObject(getAc_valeur()), dr.getObject(getAc_affiche()));
                    liste.add(aco);
                }
                if (liste.size() > 0) {
                    ac_objt = new Ac_object[liste.size()];
                    for (int k = 0; k < liste.size(); k++) {
                        ac_objt[k] = liste.get(k);
                    }
                    setTab_ac(ac_objt);
                }
            } catch (SQLException e) {
                throw e;
            } finally {
                if (st != null) {
                    st.close();
                }
                if (dr != null) {
                    dr.close();
                }
            }
        }
    }
    public void findData(Connection c) throws Exception {
        
    }

    public void setAutre(String autre) {
        this.autre = autre;
    }
    
    public static void setAutre(Champ[] tChamp, String autre) {
        for(Champ c : tChamp)
            c.setAutre(autre);
    }

    public String getAutre() {
        if (autre == null) {
            return "";
        }
        return autre;
    }

    public void setLibelleAffiche(String libelleAffiche) {
        this.libelleAffiche = libelleAffiche;
    }

    public String getLibelleAffiche() {
        if (libelleAffiche == null || libelleAffiche.compareToIgnoreCase("") == 0) {
            return getLibelle();
        }
        return libelleAffiche;
    }

    public void setHtmlInsert(String htmlInsert) {
        this.htmlInsert = htmlInsert;
    }

    public String getHtmlInsert() throws Exception {
        if (htmlInsert == null || htmlInsert.compareToIgnoreCase("") == 0) {
            makeHtmlInsert();
        }
        if (htmlInsert == null || htmlInsert.compareToIgnoreCase("") == 0) {
            htmlInsert = getHtml();
        }
        return htmlInsert;
    }

    public String getInputHidden() throws Exception {
        makeInputPopup();
        return htmlInsert;
    }

    public String getInputHiddenAutoComplete() throws Exception {
        String temp = "";
        temp = "<input name=" + getNom() + "libelle" + " type=" + getType() + " class=" + getCss() + "  id=" + getNom() + "libelle" + " value='" + getValeur() + "' " + getAutre() + ">";
        temp += "<input type='hidden' value='" + getValeur() + "' name='" + getNom() + "' id='" + getNom() + "'>";
        return temp;
    }

   
    public void makeInputPopup() throws Exception {
        String temp = "";
        String[] val = getNom().split("_");
        if(val.length > 1 && Utilitaire.checkNumber(val[1])){
            temp = "<input name=" + val[0] + "libelle_" + val[1] + " type=" + getType() + " class=" + getCss() + "  id=" + val[0] + "libelle_" + val[1] + " value='" + getValeurLibelle() + "' " + getAutre() + ">";
            temp += "<input type='hidden' value='" + getValeur() + "' name='" + getNom() + "' id='" + getNom() + "'>";
        }else{
            temp = "<input name=" + getNom() + "libelle" + " type=" + getType() + " class=" + getCss() + "  id=" + getNom() + "libelle" + " value='" + getValeurLibelle() + "' " + getAutre() + ">";
            temp += "<input type='hidden' value='" + getValeur() + "' name='" + getNom() + "' id='" + getNom() + "'>";
        }
        setHtml(temp);
        setHtmlInsert(temp);
    }

    public void setHtmlTableauInsert(String htmlTableauInsert) {
        this.htmlTableauInsert = htmlTableauInsert;
    }

    /*public String getHtmlTableauInsert(int i) throws Exception {
        htmlTableauInsert = getHtmlTableau(i);
        return htmlTableauInsert;
    }*/
    
    public String getHtmlTableauInsert(int i) throws Exception {
        htmlTableauInsert = null;
        makeHtmlInsertTableau(i);
        if (htmlTableauInsert == null || htmlTableauInsert.compareToIgnoreCase("") == 0) {
            htmlTableauInsert = getHtmlTableau(i);
        }
        return htmlTableauInsert;
        //htmlTableauInsert = getHtmlTableau(i);
        //return htmlTableauInsert;
    }

    public void setVisible(boolean visible) {
        this.visible = visible;
    }
    
    public static void setVisible(Champ[] tChamp, boolean visible) {
        for(Champ c : tChamp)
            c.setVisible(visible);
    }

    public boolean getVisible() {
        return visible;
    }

    public void setAutocomplete(String affiche, String valeur, ClassMAPTable classMapTable, UserEJB u,Connection c) throws Exception {
        int indice =0;
        try {
            if(c==null){
                c = new UtilDB().GetConn();
                indice = 1;
            }
            this.autoComplete = true;
            Object[] liste = CGenUtil.rechercher(classMapTable, null, null,c, "");
            Class<?> clazz = Class.forName(classMapTable.getClassName());
            StringBuilder sbA = new StringBuilder();
            sbA = new StringBuilder();
            sbA.append("get")
                    .append(affiche.substring(0, 1).toUpperCase())
                    .append(affiche.substring(1));
            String getterAffiche = sbA.toString();
            StringBuilder sbV = new StringBuilder();
            sbV = new StringBuilder();
            sbV.append("get")
                    .append(valeur.substring(0, 1).toUpperCase())
                    .append(valeur.substring(1));
            String getterValeur = sbV.toString();
            String jsons = "[{";
            for (int i = 0; i < liste.length; i++) {
                Method getter = clazz.getMethod(getterAffiche);
                Method getter2 = clazz.getMethod(getterValeur);
                jsons += "value : '" + getter.invoke(liste[i]) + "',";
                jsons += "label:'" + getter.invoke(liste[i]) + "',";
                jsons += "id:'" + getter2.invoke(liste[i]) + "'";
                if (i < liste.length - 1) {
                    jsons += "},{ ";
                }
            }
            jsons += "}]";
            u.getMapAutoComplete().put(this.getNom(), jsons);
            System.out.println(jsons);
            System.out.println(isAutoComplete());
            if(indice==1) c.commit();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
        }finally{
            if(indice == 1 && c!=null)c.close();
        }

    }

    public boolean isAutoComplete() {
        return autoComplete;
    }

    public void setAutoComplete(boolean autoComplete) {
        this.autoComplete = autoComplete;
    }
    public String getChampReturn(int indexe) throws Exception {
        String champ = "";
        String[] tchampReturn = Utilitaire.split(champReturn, ";");
        for(int i=0; i<tchampReturn.length; i++){
            String[] champRet = tchampReturn[i].split("_");
            if(champRet.length > 1 && Utilitaire.checkNumber(champRet[1])){
                champ += tchampReturn[i];
            }else{
                champ += tchampReturn[i]+"_"+indexe;
            }
            if(i != tchampReturn.length-1)
                champ += ";";
        }
        return champ;
    }
    
    public void makeHtmlInsertTableau(int indice) throws Exception {
    }
    
    public String getHtmlTableauInsert(int i, String valeur) throws Exception {
        htmlTableauInsert = null;
        makeHtmlInsertTableau(i, valeur);
        if (htmlTableauInsert == null || htmlTableauInsert.compareToIgnoreCase("") == 0) {
            htmlTableauInsert = getHtmlTableau(i, valeur);
        }
        return htmlTableauInsert;
    }
    
    public void makeHtmlInsertTableau(int indice, String valeur) throws Exception {
    }
    
    public String getHtmlTableau(int i, String valeur) throws Exception {
        this.makeHtmlTableau(i, valeur);
        return htmlTableau;
    }
    
    public void makeHtmlTableau(int i, String valeur) throws Exception {
        String temp = "";
        setValeur(valeur);
        if (type.compareTo(ConstanteAffichage.textarea) == 0) {
            temp = "<textarea name='" + getNom() + "_" + i + "' class='" + getCss() + "' id='" + getNom() + "_" + i + "' style='resize: none;'>" + getValeur() + "</textarea>";
        } else if (typeData.compareTo(ConstanteAffichage.typeDaty) == 0) {
            temp = "<input name=" + getNom() + "_" + i + " type=" + getType() + " class='" + getCss() + " datepicker'  id=" + getNom() + "_" + i + " value='" + getValeur() + "' " + getAutre() + ">";

        } else if (!this.isPhoto()) {
            temp = "<input name=" + getNom() + "_" + i + " type=" + getType() + " class=" + getCss() + "  id=" + getNom() + "_" + i + " value='" + getValeur() + "' " + getAutre() + ">";

        } else {
            temp = "<input name=" + getNom() + "_" + i + " type=\"file\" class=" + getCss() + " id=" + getNom() + "_" + i + " " + getAutre() + ">";
            if (!getValeur().isEmpty()) {
                temp += "<input type=\"hidden\" value=\"" + getValeur() + "\" name=\"" + getNom() + "_" + i + "2" + "\">";
            }
        }
        setHtmlTableau(temp);
    }
    public void setPageAppelIndice(String pageAppel, int i) {
        this.pageAppel = pageAppel;
        String[] tGetNom = this.getNom().split("_");
        if(tGetNom.length > 0)
            this.champReturn = this.getNom() + ";" + tGetNom[0]+"libelle_"+ tGetNom[1];
    }
    
    public void setAutocomplete(String affiche, String valeur, String nomTable, String aWhere) throws Exception {
        this.ac_affiche = affiche;
        this.ac_valeur = valeur;
        this.ac_nomTable = nomTable;
        this.autocomplete = true;
        this.ac_aWhere = aWhere;
    }
    
    public void transformToStringAc() {
        String jsons = "";
        if (getTab_ac() != null && getTab_ac().length > 0) {
            jsons += "[";
            for (int i = 0; i < getTab_ac().length; i++) {
                if(getTab_ac()[i].getAffiche() != null){
                    jsons += "\"" + getTab_ac()[i].getAffiche().toString().replace("'", " ").replace("\"", " ") + " :: " + getTab_ac()[i].getValeur().toString().replace("'", " ").replace("\"", " ") + "\"";

    //jsons += "\"" + getTab_ac()[i].getAffiche().toString().replace("'", " ") + "\"";
                    if (i < getTab_ac().length - 1) {
                        jsons += ", ";
                    }
                }
            }
            jsons += "]";
            //System.out.println("JSONNNN "+jsons);
            this.setValeur_ac(jsons);

        }
    }
    
    public static void setPageAppel(Champ[] tChamp, String pageAppel, String champReturn, boolean isautocomplete) throws Exception {
        for(Champ c : tChamp){
            //c.autocomplete = isautocomplete;
            c.pageAppel = pageAppel;
            c.champReturn = champReturn;
        }
    }
}
