/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package affichage;

import bean.ClassMAPTable;
import java.lang.reflect.Field;
import java.sql.Connection;
import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;
import user.UserEJB;
/**
 *
 * @author Joe
 */
public class PageInsertMultiple  extends Page {
     Formulaire formufle;
    private int nombreLigne = 0;
    private ClassMAPTable fille;
    private String[] tabIndice;
    
    public PageInsertMultiple(ClassMAPTable bse, ClassMAPTable fle, HttpServletRequest req, int nbLine, UserEJB u) throws Exception {
        setBase(bse);
        setFille(fle);
        setReq(req);
        setUtilisateur(u);
        setNombreLigne(nbLine);
        makeFormulaire();
        formufle.setEstFille(true);
        
    }

    public PageInsertMultiple(ClassMAPTable bse, ClassMAPTable fle, HttpServletRequest req, int nbLine) throws Exception {
        setBase(bse);
        setFille(fle);
        setReq(req);
        setNombreLigne(nbLine);
    }
    
    public PageInsertMultiple(ClassMAPTable bse, ClassMAPTable fle, HttpServletRequest req, int nbLine, String[] tabIndice) throws Exception {
        setBase(bse);
        setFille(fle);
        setReq(req);
        setNombreLigne(nbLine);
        setTabIndice(tabIndice);
    }

    public void preparerDataFormu() throws Exception {
        Connection c = null;
        try {
            c = new utilitaire.UtilDB().GetConn();
            formu.getAllData(c);
            formufle.getAllDataFille(c);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw (ex);
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }
    
    public void makeFormulaire() throws Exception {
        formu = new Formulaire();
        formufle = new Formulaire();
        affichage.Champ[] tbse = null;
        affichage.Champ[] tfle = null;
        
        bean.Champ[] champbse = bean.ListeColonneTable.getFromListe(getBase(), null);
        bean.Champ[] champfle = bean.ListeColonneTable.getFromListe(getFille(), null);
        
        tbse = new Champ[champbse.length - 1];
        tfle = new Champ[(champfle.length)*getNombreLigne()];
        
        int nbElement = 0;
        for (int i = 0; i < tbse.length + 1; i++) {
            if (champbse[i].getNomColonne().compareToIgnoreCase(getBase().getAttributIDName()) != 0) {
                if (champbse[i].getTypeJava().compareToIgnoreCase("double") == 0 || champbse[i].getTypeJava().compareToIgnoreCase("int") == 0 || champbse[i].getTypeJava().compareToIgnoreCase("float") == 0) {
                    tbse[nbElement] = new ChampCalcul(champbse[i].getNomColonne());
                } else if (champbse[i].getTypeJava().compareToIgnoreCase("java.sql.Date") == 0) {
                    tbse[nbElement] = new ChampDate(champbse[i].getNomColonne());
                } else {
                    System.out.println("");
                    tbse[nbElement] = new Champ(champbse[i].getNomColonne());
                    tbse[nbElement].setLibelle(champbse[i].getNomColonne());
                    tbse[nbElement].setValeur("");
                }
                nbElement++;
            }
        }
        formu.setListeChamp(tbse);
        
        int nbElementfle = 0;
        for(int ligne=0; ligne<getNombreLigne() ; ligne++){
            for (int i = 0; i < champfle.length; i++) {
                //System.out.println("*********************"+i);
                //if (champfle[i].getNomColonne().compareToIgnoreCase(getFille().getAttributIDName()) != 0) {
                    if (champfle[i].getTypeJava().compareToIgnoreCase("double") == 0 || champfle[i].getTypeJava().compareToIgnoreCase("int") == 0 || champfle[i].getTypeJava().compareToIgnoreCase("float") == 0) {
                        tfle[nbElementfle] = new ChampCalcul(champfle[i].getNomColonne()+"_"+ligne);
                    } else if (champfle[i].getTypeJava().compareToIgnoreCase("java.sql.Date") == 0) {
                        tfle[nbElementfle] = new ChampDate(champfle[i].getNomColonne()+"_"+ligne);
                    } else {
                        tfle[nbElementfle] = new Champ(champfle[i].getNomColonne()+"_"+ligne);
                        tfle[nbElementfle].setLibelle(champfle[i].getNomColonne()+"_"+ligne);
                        tfle[nbElementfle].setValeur("");
                    }
                    nbElementfle++;
                //}
            }
        }
        formufle.setListeChamp(tfle);
        formufle.setObjet(getFille());
        formufle.setNbLigne(getNombreLigne());
        
    }
    
    public ClassMAPTable getObjectAvecValeur() throws Exception {
        //Field[]tempChamp=getBase().getFieldList();
        try {
            Field[] tempChamp = bean.ListeColonneTable.getFieldListeHeritage(getBase());
            for (int i = 0; i < tempChamp.length; i++) {
                Field f = tempChamp[i];
                String valeur = getParamSansNull(f.getName());
                getBase().setMode("modif");
                if (f.getType().getName().compareToIgnoreCase("java.lang.String") == 0&&f.getName().compareToIgnoreCase("liaisonMere")!=0&&f.getName().compareToIgnoreCase("liaisonFille")!=0) {
                    //System.out.println("base---------------"+getBase());
                    //System.out.println("f---------------"+f);
                    //System.out.println("valeur---------------"+valeur);
                    bean.CGenUtil.setValChamp(getBase(), f, valeur);
                }
                if (f.getType().getName().compareToIgnoreCase("java.sql.Date") == 0) {
                    bean.CGenUtil.setValChamp(getBase(), f, utilitaire.Utilitaire.string_date("dd/MM/yyyy", valeur));
                }
                if (f.getType().getName().compareToIgnoreCase("double") == 0) {
                    bean.CGenUtil.setValChamp(getBase(), f, new Double(utilitaire.Utilitaire.stringToDouble(valeur)));
                }
                if (f.getType().getName().compareToIgnoreCase("int") == 0) {
                    if (valeur == null || valeur.compareToIgnoreCase("") == 0) {
                        bean.CGenUtil.setValChamp(getBase(), f, new Integer(0));
                    } else {
                        bean.CGenUtil.setValChamp(getBase(), f, new Integer(valeur));
                    }
                }
                if (f.getType().getName().compareToIgnoreCase("float") == 0) {
                    bean.CGenUtil.setValChamp(getBase(), f, new Float(utilitaire.Utilitaire.stringToFloat(valeur)));
                }
            }
            return getBase();
        } catch (NumberFormatException n) {
            n.printStackTrace();
            throw new Exception("format de nombre invalide");
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
    
    /*public ClassMAPTable getObjectAvecValeur() throws Exception {
        
        try {
            Field[] tempChamp = bean.ListeColonneTable.getFieldListeHeritage(getBase());
            for (int i = 0; i < tempChamp.length; i++) {
                Field f = tempChamp[i];
                String valeur = getParamSansNull(f.getName());
                getBase().setMode("modif");
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
                    if (valeur == null || valeur.compareToIgnoreCase("") == 0) {
                        bean.CGenUtil.setValChamp(getBase(), f, new Integer(0));
                    } else {
                        bean.CGenUtil.setValChamp(getBase(), f, new Integer(valeur));
                    }
                }
                if (f.getType().getName().compareToIgnoreCase("float") == 0) {
                    bean.CGenUtil.setValChamp(getBase(), f, new Float(utilitaire.Utilitaire.stringToFloat(valeur)));
                }
            }
            return getBase();
        } catch (NumberFormatException n) {
            n.printStackTrace();
            throw new Exception("format de nombre invalide");
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }*/
    
    public ClassMAPTable[] getObjectFilleAvecValeur() throws Exception {
        int nombreLigne = getNombreLigne();
        String[] tIndice = getTabIndice();
        if(tIndice == null)
            throw new Exception("Vous devez cocher");
        ClassMAPTable[] liste = new ClassMAPTable[tIndice.length];
        try {
            Field[] tempChamp = bean.ListeColonneTable.getFieldListeHeritage(getFille());
            int x=0;
            ClassMAPTable ex=null;
            for (int iLigne = 0; iLigne < nombreLigne; iLigne++) {
                ex =  (ClassMAPTable)Class.forName(getFille().getClassName()).newInstance();
                for(int indice=0; indice<tIndice.length; indice++){
                    String ligne = ""+iLigne;
                    if(ligne.equals(tIndice[indice])){
                        for (int i = 0; i < tempChamp.length; i++) {
                            Field f = tempChamp[i];
                            String nomChamp = f.getName()+"_"+iLigne;
                            String valeur = getParamSansNull(nomChamp);
                            /*if(i==1 && (valeur==null || valeur.compareTo("")==0 || valeur.compareTo(" ")==0)){
                                ex=null;
                                break;
                            }*/
                            if (f.getType().getName().compareToIgnoreCase("java.lang.String") == 0&&f.getName().compareToIgnoreCase("liaisonMere")!=0&&f.getName().compareToIgnoreCase("liaisonFille")!=0) {
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
                            if(i==0) x++;
                        }
                        liste[indice]  = ex;
                    }
                }
            }
            //ClassMAPTable[] ret = new ClassMAPTable[x]; 
            ClassMAPTable[] ret = (ClassMAPTable[]) java.lang.reflect.Array.newInstance(ex.getClass().newInstance().getClass(), liste.length);
            int countOk = 0; 
            for(int j = 0; j<tIndice.length; j++){
                if (liste[j] != null){
                    ret[countOk] = liste[j];
                    countOk ++;
                }
            }
            return ret;
        } catch (NumberFormatException n) {
            n.printStackTrace();
            throw new Exception("format de nombre invalide");
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
    
    public ClassMAPTable getObjectAvecValeur(HashMap<String, String> listeValeur) throws Exception {
        try {
            Field[] tempChamp = bean.ListeColonneTable.getFieldListeHeritage(getBase());
            for (int i = 0; i < tempChamp.length; i++) {
                Field f = tempChamp[i];
                String valeur = getParamSansNull(f.getName(), listeValeur);
                getBase().setMode("insert");
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
                    if (valeur == null || valeur.compareToIgnoreCase("") == 0) {
                        bean.CGenUtil.setValChamp(getBase(), f, new Integer(0));
                    } else {
                        bean.CGenUtil.setValChamp(getBase(), f, new Integer(valeur));
                    }
                }
                if (f.getType().getName().compareToIgnoreCase("float") == 0) {
                    bean.CGenUtil.setValChamp(getBase(), f, new Float(utilitaire.Utilitaire.stringToFloat(valeur)));
                }
            }
            return getBase();
        } catch (NumberFormatException n) {
            n.printStackTrace();
            throw new Exception("format de nombre invalide");
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
    
    public ClassMAPTable getObjectFilleAvecValeur(HashMap<String, String> listeValeur) throws Exception {
        try {
            Field[] tempChamp = bean.ListeColonneTable.getFieldListeHeritage(getFille());
            for (int i = 0; i < tempChamp.length; i++) {
                Field f = tempChamp[i];
                String valeur = getParamSansNull(f.getName(), listeValeur);
                getFille().setMode("insert");
                if (f.getType().getName().compareToIgnoreCase("java.lang.String") == 0&&f.getName().compareToIgnoreCase("liaisonMere")!=0&&f.getName().compareToIgnoreCase("liaisonFille")!=0) {
                    bean.CGenUtil.setValChamp(getFille(), f, valeur);
                }
                if (f.getType().getName().compareToIgnoreCase("java.sql.Date") == 0) {
                    bean.CGenUtil.setValChamp(getFille(), f, utilitaire.Utilitaire.string_date("dd/MM/yyyy", valeur));
                }
                if (f.getType().getName().compareToIgnoreCase("double") == 0) {
                    bean.CGenUtil.setValChamp(getFille(), f, new Double(utilitaire.Utilitaire.stringToDouble(valeur)));
                }
                if (f.getType().getName().compareToIgnoreCase("int") == 0) {
                    if (valeur == null || valeur.compareToIgnoreCase("") == 0) {
                        bean.CGenUtil.setValChamp(getFille(), f, new Integer(0));
                    } else {
                        bean.CGenUtil.setValChamp(getFille(), f, new Integer(valeur));
                    }
                }
                if (f.getType().getName().compareToIgnoreCase("float") == 0) {
                    bean.CGenUtil.setValChamp(getFille(), f, new Float(utilitaire.Utilitaire.stringToFloat(valeur)));
                }
            }
            return getFille();
        } catch (NumberFormatException n) {
            n.printStackTrace();
            throw new Exception("format de nombre invalide");
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
    
    public void makeHtml() {

    }
    
    public int getNombreLigne() {
        return nombreLigne;
    }

    public void setNombreLigne(int nombreLigne) {
        this.nombreLigne = nombreLigne;
    }

    public ClassMAPTable getFille() {
        return fille;
    }

    public void setFille(ClassMAPTable fille) {
        this.fille = fille;
    }

    public Formulaire getFormufle() {
        return formufle;
    }

    public void setFormufle(Formulaire formufle) {
        this.formufle = formufle;
    }

    public String[] getTabIndice() {
        return tabIndice;
    }

    public void setTabIndice(String[] tabIndice) {
        this.tabIndice = tabIndice;
    }
    
    public PageInsertMultiple(ClassMAPTable fle, HttpServletRequest req, int nbLine, UserEJB u) throws Exception {
        setFille(fle);
        setReq(req);
        setUtilisateur(u);
        setNombreLigne(nbLine);
        makeFormulaireFille();
    }
    
    public void makeFormulaireFille() throws Exception {
        formu = new Formulaire();
        formufle = new Formulaire();
        affichage.Champ[] tfle = null;
        
        bean.Champ[] champfle = bean.ListeColonneTable.getFromListe(getFille(), null);
        
        tfle = new Champ[champfle.length - 1];
        
        int nbElementfle = 0;
        for (int i = 0; i < tfle.length + 1; i++) {
            if (champfle[i].getNomColonne().compareToIgnoreCase(getFille().getAttributIDName()) != 0) {
                if (champfle[i].getTypeJava().compareToIgnoreCase("double") == 0 || champfle[i].getTypeJava().compareToIgnoreCase("int") == 0 || champfle[i].getTypeJava().compareToIgnoreCase("float") == 0) {
                    tfle[nbElementfle] = new ChampCalcul(champfle[i].getNomColonne());
                } else if (champfle[i].getTypeJava().compareToIgnoreCase("java.sql.Date") == 0) {
                    tfle[nbElementfle] = new ChampDate(champfle[i].getNomColonne());
                } else {
                    tfle[nbElementfle] = new Champ(champfle[i].getNomColonne());
                    tfle[nbElementfle].setLibelle(champfle[i].getNomColonne());
                    tfle[nbElementfle].setValeur("");
                }
                nbElementfle++;
            }
        }
        formufle.setListeChamp(tfle);
        formufle.setNbLigne(getNombreLigne());
    }
    
    public void preparerDataFormuFille() throws Exception {
        Connection c = null;
        try {
            c = new utilitaire.UtilDB().GetConn();
            formufle.getAllData(c);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw (ex);
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }
    
    public PageInsertMultiple(ClassMAPTable fle, HttpServletRequest req, int nbLine, String[] tabIndice) throws Exception {
        setFille(fle);
        setReq(req);
        setNombreLigne(nbLine);
        setTabIndice(tabIndice);
    }
}
