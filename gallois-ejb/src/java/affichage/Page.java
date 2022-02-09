package affichage;

import bean.CGenUtil;
import java.lang.reflect.Field;
import bean.ClassMAPTable;
import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;

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
public class Page {

    Formulaire formu;
    private TableauRecherche tableau;
    private TableauRecherche tableauRecap;
    private String lien;
    private TableauRecherche tableauRegroup;
    private bean.ClassMAPTable base;
    private bean.ClassMAPTable[] baseTableau;
    private String titre;
    private user.UserEJB utilisateur;
    private String html;
    private javax.servlet.http.HttpServletRequest req;
    private boolean testRecap = false;
    private int nombreLigne = 0;
    private String pathPage;
    private String[] tabIndexe;

    
    public String[] getTabIndexe() {
        return tabIndexe;
    }

    public void setTabIndexe(String[] tabIndexe) {
        this.tabIndexe = tabIndexe;
    }
    
    public int getNombreLigne() {
        return nombreLigne;
    } 
    public String getPathPage() {
        return pathPage;
    }

    public void setPathPage(String pathPage) {
        this.pathPage = pathPage;
    }

    public void setNombreLigne(int nombreLigne) {
        if (nombreLigne <= 0) {
            this.nombreLigne = 10;
        }
        this.nombreLigne = nombreLigne;
    } 

    public Page() {
    }

    public Page(ClassMAPTable p, HttpServletRequest r) {
        setBase(p);
        setReq(r);
    }
    
    public Page(ClassMAPTable p, HttpServletRequest r, int nombreligne) {
        setBase(p);
        setReq(r);
        setNombreLigne(nombreligne);
    }

    public void makeHtml() {

    }

    public Formulaire getFormu() {
        return formu;
    }

    public void setFormu(Formulaire formu) {
        this.formu = formu;
    }

    public void setTableau(TableauRecherche tableau) {
        this.tableau = tableau;
    }

    public TableauRecherche getTableau() {
        return tableau;
    }

    public void setBase(bean.ClassMAPTable base) {
        this.base = base;
    }
    
    public void setBaseTableau(bean.ClassMAPTable[] baseT) {
        this.baseTableau = baseT;
    }
    
    public bean.ClassMAPTable[] getBaseTableau() {
        return baseTableau;
    }


    public bean.ClassMAPTable getBase() {
        return base;
    }

    public void setLien(String lien) {
        this.lien = lien;
    }

    public String getLien() {
        return lien;
    }

    public TableauRecherche getTableauRecap() {
        return tableauRecap;
    }

    public void setTableauRecap(TableauRecherche tableauRecap) {
        this.testRecap = true;
        this.tableauRecap = tableauRecap;
    }

    public void setTableauRegroup(TableauRecherche tableauRegroup) {
        this.tableauRegroup = tableauRegroup;
    }

    public TableauRecherche getTableauRegroup() {
        return tableauRegroup;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public String getTitre() {
        return titre;
    }

    public void setUtilisateur(user.UserEJB utilisateur) {
        this.utilisateur = utilisateur;
    }

    public boolean getTestRecap() {
        return testRecap;
    }

    public user.UserEJB getUtilisateur() {
        return utilisateur;
    }

    public void setHtml(String html) {
        this.html = html;
    }

    public String getHtml() {
        if (html == null || html.compareToIgnoreCase("") == 0) {
            makeHtml();
        }
        return html;
    }

    public void setReq(javax.servlet.http.HttpServletRequest req) {
        this.req = req;
        if(this.getReq()!=null) {
            this.setPathPage(this.getReq().getParameter("but"));
        }
    }

    public javax.servlet.http.HttpServletRequest getReq() {
        return req;
    }

    public String getParamSansNull(String nomP) {
        String temp = getReq().getParameter(utilitaire.Utilitaire.remplacerUnderscore(nomP));
        if ((temp != null) && temp.compareToIgnoreCase("") != 0) {
            temp = temp.replace("'", "\'");
            return temp;
        }
        return "";
    }
        public String getParamSansNull(String nomP, HashMap<String, String> valeurs) {
        String temp = valeurs.get(utilitaire.Utilitaire.remplacerUnderscore(nomP));
        if ((temp != null) && temp.compareToIgnoreCase("") != 0) {
            return temp;
        }
        return "";
    }

    public void getValeurFormulaire() throws Exception {
        Champ[] c = formu.getListeChamp();  
        for (int i = 0; i < c.length; i++) {
            String valeurRecup = getParamSansNull(c[i].getNom());

            c[i].setValeur(valeurRecup);
        }
        Champ[] f = formu.getChampGroupe();
        if (f != null) {
            for (int j = 0; j < f.length; j++) {
                f[j].setValeur(getParamSansNull(f[j].getNom()));
            }
        }
        Champ[] af = formu.getChampTableauAff();
        if (af != null) {
            for (int j = 0; j < af.length; j++) {
                af[j].setValeur(getParamSansNull(af[j].getNom()));
            }
        }
    }

    public ClassMAPTable getObjectAvecValeur() throws Exception {
        //Field[]tempChamp=getBase().getFieldList();
        Field[] tempChamp = bean.ListeColonneTable.getFieldListeHeritage(getBase());
        for (int i = 0; i < tempChamp.length; i++) {
            Field f = tempChamp[i];
            String valeur = getParamSansNull(f.getName());
            if (f.getType().getName().compareToIgnoreCase("java.lang.String") == 0) {
                bean.CGenUtil.setValChamp(getBase(), f, valeur);
            }
            if (f.getType().getName().compareToIgnoreCase("java.sql.Date") == 0) {
                //System.out.println("La date en sortie = "+utilitaire.Utilitaire.string_date("dd/MM/yyyy",valeur));
                bean.CGenUtil.setValChamp(getBase(), f, utilitaire.Utilitaire.string_date("dd/MM/yyyy", valeur));
            }
            if (f.getType().getName().compareToIgnoreCase("double") == 0) {
                bean.CGenUtil.setValChamp(getBase(), f, new Double(utilitaire.Utilitaire.stringToDouble(valeur)));
            }
            if (f.getType().getName().compareToIgnoreCase("int") == 0) {
                if (valeur != null && valeur.compareToIgnoreCase("") != 0) {
                    bean.CGenUtil.setValChamp(getBase(), f, new Integer(valeur));
                }
            }
            if (f.getType().getName().compareToIgnoreCase("float") == 0) {
                bean.CGenUtil.setValChamp(getBase(), f, new Float(utilitaire.Utilitaire.stringToFloat(valeur)));
            }
        }
        if(getBase().getEstHistorise()){
            getBase().setMemo(getParamSansNull("memo"));
        }
        return getBase();
    }
    public ClassMAPTable getObjectAvecValeur(HashMap<String, String> listeValeur) throws Exception {
        try {
            Field[] tempChamp = bean.ListeColonneTable.getFieldListeHeritage(getBase());
            for (int i = 0; i < tempChamp.length; i++) {
                Field f = tempChamp[i];
                String valeur = getParamSansNull(f.getName(), listeValeur);
                if (f.getType().getName().compareToIgnoreCase("java.lang.String") == 0) {
                    bean.CGenUtil.setValChamp(getBase(), f, valeur);
                }
                if (f.getType().getName().compareToIgnoreCase("java.sql.Date") == 0) {
                    bean.CGenUtil.setValChamp(getBase(), f, utilitaire.Utilitaire.string_date("dd/MM/yyyy", valeur));
                }
                if (f.getType().getName().compareToIgnoreCase("double") == 0) {
                    bean.CGenUtil.setValChamp(getBase(), f, new Double(utilitaire.Utilitaire.stringToDouble(valeur)));
                }
                if (f.getType().getName().compareToIgnoreCase("int") == 0) {
                    if (valeur != null && valeur.compareToIgnoreCase("") != 0) {
                        bean.CGenUtil.setValChamp(getBase(), f, new Integer(valeur));
                    }
                }
                if (f.getType().getName().compareToIgnoreCase("float") == 0) {
                    bean.CGenUtil.setValChamp(getBase(), f, new Float(utilitaire.Utilitaire.stringToFloat(valeur)));
                }
            }
            return getBase();
        } catch (NumberFormatException n) {
            throw new Exception("format de nombre invalide");
        } catch (Exception e) {
            throw e;
        }
    }
    
    public ClassMAPTable[] getObjectAvecValeurTableau() throws Exception {
        //Field[]tempChamp=getBase().getFieldList();
        int nombreLigne = getNombreLigne();
        ClassMAPTable[] liste = new ClassMAPTable[nombreLigne];
        try {
            Field[] tempChamp = bean.ListeColonneTable.getFieldListeHeritage(getBase());
            int x=0;
            for (int iLigne = 0; iLigne < nombreLigne; iLigne++) {
                ClassMAPTable ex = (ClassMAPTable)Class.forName(getBase().getClassName()).newInstance();
                for (int i = 0; i < tempChamp.length; i++) {
                    Field f = tempChamp[i];
                    String nomChamp = f.getName()+"_"+iLigne;
                    String valeur = getParamSansNull(nomChamp);
                    if(i==1 && (valeur==null || valeur.compareTo("")==0)){break;}
                    if (f.getType().getName().compareToIgnoreCase("java.lang.String") == 0) {
                        bean.CGenUtil.setValChamp(ex, f, valeur);
                    }
                    if (f.getType().getName().compareToIgnoreCase("java.sql.Date") == 0) {
                        //System.out.println("La date en sortie = "+utilitaire.Utilitaire.string_date("dd/MM/yyyy",valeur));
                        bean.CGenUtil.setValChamp(ex, f, utilitaire.Utilitaire.string_date("dd/MM/yyyy", valeur));
                    }
                    if (f.getType().getName().compareToIgnoreCase("double") == 0) {
                        bean.CGenUtil.setValChamp(ex, f, new Double(utilitaire.Utilitaire.stringToDouble(valeur)));
                    }
                    if (f.getType().getName().compareToIgnoreCase("int") == 0) {
                        if (valeur == null || valeur.compareToIgnoreCase("") == 0) {
                            bean.CGenUtil.setValChamp(ex, f, new Integer(0));
                        } else {
                            bean.CGenUtil.setValChamp(ex, f, new Integer(valeur));
                        }
                    }
                    if (f.getType().getName().compareToIgnoreCase("float") == 0) {
                        bean.CGenUtil.setValChamp(ex, f, new Float(utilitaire.Utilitaire.stringToFloat(valeur)));
                    }
                    if(i==1) x++;
                }
                liste[iLigne]  = ex;
            }
            ClassMAPTable[] ret = new ClassMAPTable[x]; 
            for(int j = 0; j<x ; j++){
                ret[j] = liste[j];
            }
            return ret;
        } catch (NumberFormatException n) {
            throw new Exception("format de nombre invalide");
        } catch (Exception e) {
            //System.out.println("ERREUUURRR = "+e.getMessage());
            throw e;
        }
    }
    public void getValeurFormulaireMultiple() throws Exception {
        Champ[] c = formu.getListeChamp();
        for (int i = 0; i < c.length; i++) {
            String valeurRecup = getParamSansNullMultiple(c[i].getNom());
            c[i].setValeur(valeurRecup);
        }
        Champ[] f = formu.getChampGroupe();
        if (f != null) {
            for (int j = 0; j < f.length; j++) {
                f[j].setValeur(getParamSansNullMultiple(f[j].getNom()));
            }
        }
        Champ[] af = formu.getChampTableauAff();
        if (af != null) {
            for (int j = 0; j < af.length; j++) {
                af[j].setValeur(getParamSansNullMultiple(af[j].getNom()));
            }
        }
    }

    public String getParamSansNullMultiple(String nomP) {
        String[] listetemp = getReq().getParameterValues(utilitaire.Utilitaire.remplacerUnderscore(nomP));
        String temp = "";
        if (listetemp != null) {
            temp = listetemp[0];
            for (int i = 1; i < listetemp.length; i++) {
                if (listetemp[i].compareToIgnoreCase("") != 0) {
                    temp = temp + "','" + listetemp[i];
                }
            }
        }
        if (nomP.compareTo("colonne") == 0 || nomP.compareTo("ordre") == 0) {
            temp = getReq().getParameter(utilitaire.Utilitaire.remplacerUnderscore(nomP));
        }
        if ((temp != null) && temp.compareToIgnoreCase("") != 0) {
            return temp;
        }
        return "";
    }
    public static String getContenuServlet(String valeurFiltre,String nomTable,String nomClasse,String nomColoneFiltre,String nomColvaleur,String nomColAffiche) throws Exception
    {
        ClassMAPTable filtre=(ClassMAPTable)Class.forName(nomClasse).newInstance();
        filtre.setNomTable(nomTable);
        String rekety="select * from "+nomTable+" where "+nomColoneFiltre+"='"+valeurFiltre+"'";
        ClassMAPTable listee[]=(ClassMAPTable[])CGenUtil.rechercher(filtre , rekety);
        String valeur="[";
        for(int i=0;i<listee.length;i++)
        {
            ClassMAPTable to=listee[i];
            String valeurId=(String)CGenUtil.getValeurFieldByMethod(to, nomColvaleur);
            Object val=CGenUtil.getValeurFieldByMethod(to, nomColAffiche);
            String valeurAffiche=val.toString();
            valeur+="{\"id\":\"" + valeurId+"\",\"valeur\":\"" + valeurAffiche+"\"}";
            if(i<listee.length-1)valeur+=",";
        }
        valeur+="]";
        return("{\"valeure\":" + valeur +"}");
    }
    public static String getContenuServlet(String valeurFiltre,String nomTable,String nomClasse,String nomColoneFiltre,String nomColvaleur,String nomColAffiche,String nomOrderby, String sensOrderBy,boolean liste) throws Exception
    {
        ClassMAPTable filtre=(ClassMAPTable)Class.forName(nomClasse).newInstance();
        filtre.setNomTable(nomTable);
        String rekety="select * from "+nomTable+" where "+nomColoneFiltre+"='"+valeurFiltre+"' order by "+nomOrderby+" "+sensOrderBy;
        ClassMAPTable listee[]=(ClassMAPTable[])CGenUtil.rechercher(filtre , rekety);
        int taille=listee.length;
        if(!liste)taille=1;
        String valeur="[";
        for(int i=0;i<taille;i++)
        {
            ClassMAPTable to=listee[i];
            String valeurId=(String)CGenUtil.getValeurFieldByMethod(to, nomColvaleur);
            String valeurAffiche=CGenUtil.getValeurFieldByMethod(to, nomColAffiche).toString();
            valeur+="{\"id\":\"" + valeurId+"\",\"valeur\":\"" + valeurAffiche+"\"}";
            if(i<taille-1)valeur+=",";
        }
        valeur+="]";
        return("{\"valeure\":" + valeur +"}");
    }
    public ClassMAPTable[] getObjectAvecValeurTableauUpdate() throws Exception {
        //Field[]tempChamp=getBase().getFieldList();
        int nombreLigne = getNombreLigne();
        String[] tabIndexe = getTabIndexe();
        if(tabIndexe == null)
            throw new Exception("Vous devez cocher");
        ClassMAPTable[] liste = new ClassMAPTable[tabIndexe.length];
        try {
            Field[] tempChamp = bean.ListeColonneTable.getFieldListeHeritage(getBase());
            int x=0;
            for (int iLigne = 0; iLigne < nombreLigne; iLigne++) {
                ClassMAPTable ex = (ClassMAPTable)Class.forName(getBase().getClassName()).newInstance();
                for(int indice=0; indice<tabIndexe.length; indice++){
                    String ligne = ""+iLigne;
                    if(ligne.equals(tabIndexe[indice])){
                        for (int i = 0; i < tempChamp.length; i++) {
                            Field f = tempChamp[i];
                            String nomChamp = f.getName()+"_"+iLigne;
                            String valeur = getParamSansNull(nomChamp);
                            if(valeur != null && valeur.compareTo("")!= 0){
                                if(i==1 && (valeur==null || valeur.compareTo("")==0)){break;}
                                if (f.getType().getName().compareToIgnoreCase("java.lang.String") == 0) {
                                    bean.CGenUtil.setValChamp(ex, f, valeur);
                                }
                                if (f.getType().getName().compareToIgnoreCase("java.sql.Date") == 0) {
                                    //System.out.println("La date en sortie = "+utilitaire.Utilitaire.string_date("dd/MM/yyyy",valeur));
                                    bean.CGenUtil.setValChamp(ex, f, utilitaire.Utilitaire.string_date("dd/MM/yyyy", valeur));
                                }
                                if (f.getType().getName().compareToIgnoreCase("double") == 0) {
                                    bean.CGenUtil.setValChamp(ex, f, new Double(utilitaire.Utilitaire.stringToDouble(valeur)));
                                }
                                if (f.getType().getName().compareToIgnoreCase("int") == 0) {
                                    if (valeur == null || valeur.compareToIgnoreCase("") == 0) {
                                        bean.CGenUtil.setValChamp(ex, f, new Integer(0));
                                    } else {
                                        bean.CGenUtil.setValChamp(ex, f, new Integer(valeur));
                                    }
                                }
                                if (f.getType().getName().compareToIgnoreCase("float") == 0) {
                                    bean.CGenUtil.setValChamp(ex, f, new Float(utilitaire.Utilitaire.stringToFloat(valeur)));
                                }
                                if(i==1) x++;
                            }
                        }
                        liste[indice]  = ex;
                    }
                }
            }
             ClassMAPTable[] ret = new ClassMAPTable[liste.length]; 
            for(int j = 0; j<liste.length ; j++){
                ret[j] = liste[j];
            }
            return ret;
        } catch (NumberFormatException n) {
            throw new Exception("format de nombre invalide");
        } catch (Exception e) {
            //System.out.println("ERREUUURRR = "+e.getMessage());
            throw e;
        }
    }

    public Page(ClassMAPTable p, HttpServletRequest r, int nombreligne, String[] tabIndexe) {
        setBase(p);
        setReq(r);
        setNombreLigne(nombreligne);
        setTabIndexe(tabIndexe);
    }
}
