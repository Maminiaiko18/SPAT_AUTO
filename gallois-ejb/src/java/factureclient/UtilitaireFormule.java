/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package factureclient;

import bean.AdminGen;
import bean.CGenUtil;
import bean.ClassMAPTable;
import java.util.ArrayList;
import java.util.List;
import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import mg.cnaps.configuration.Configuration;
import mg.spat.exploitant.Activite;


/**
 *
 * @author tahina
 */
public class UtilitaireFormule {
    static ScriptEngine engine = new ScriptEngineManager().getEngineByName("JavaScript");
    public static List<String> getListeRubrique(String formule) throws Exception
    {
        List<String> retour = null;
        try {
            retour = new ArrayList<>();

            if (formule.contains("[") && formule.contains("]")) {
                String temp = "";
                boolean encours = false;
                for (int i = 0; i < formule.length(); i++) {
                    if (formule.charAt(i) == '[' || encours) {
                        if (formule.charAt(i + 1) == ']') {
                            retour.add(temp);
                            temp = new String("");
                            encours = false;
                        } else {
                            encours = true;
                            temp += formule.charAt(i + 1);
                        }
                    }
                }
            }
        } 
        catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return retour;
    }  
    public static String[] getListeRubriqueTab(String formule) throws Exception {
        String[] retour = null;
        try {
            List<String> rep = getListeRubrique(formule);
            retour = new String[rep.size()];
            rep.toArray(retour);
        } 
        catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return retour;
    }
    
    public static String remplacerRubriqueParChiffre(ClassMAPTable aCalc,String formule,ClassMAPTable[] lConfig) throws Exception
    {
        if(formule==null||formule.compareToIgnoreCase("")==0)return "";
        String retour=formule;
        String valeur="";
        try
        {
            String[] listeRub=getListeRubriqueTab(formule);
            
            for(String rub:listeRub)
            {
                valeur=rub;
                String[]sousRub=rub.split("::");
                
                if(sousRub.length>1) // Traitement Au cas ou info vient de Config
                {
                
                    if(sousRub[0].compareToIgnoreCase("Conf")==0||sousRub[0].compareToIgnoreCase("Configuration")==0)
                    {
                        String[] splitPointPoint=sousRub[1].split("\\.\\.");
                        String[] attrFiltre={"id"};
                        String[] attrValeur={splitPointPoint[0]};
                        Configuration conf=(Configuration)AdminGen.findUnique(lConfig, attrFiltre, attrValeur);
                        if(conf==null) throw new Exception("Configuration inexistante");
                        valeur=CGenUtil.getValeurFieldByMethod(conf,"valmin").toString();
                        if(splitPointPoint.length>1&&splitPointPoint[1].compareToIgnoreCase("valmax")==0) valeur=CGenUtil.getValeurFieldByMethod(conf,"valmax").toString();
                    }
                    
                }
                
                else // Traitement info vient de Activite*/
                {
                    
                    Object oval=CGenUtil.getValeurFieldByMethod(aCalc, rub);
                    if (oval!=null && oval instanceof Number){
                        valeur=oval.toString();
                    }
                    else if(oval!=null) {
                        valeur="'"+oval.toString()+"'";
                    }
                 }
                
                //String aRemp="\\["+rub+"\\]";
                //retour=retour.replaceAll(aRemp, valeur+"");
                retour=retour.replace("["+rub+"]", valeur);
                
            }
            
        }
        catch(NoSuchMethodException nm)
        {
            return valeur;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            return valeur;
        }
        return retour;
    }
    public static double calculerFormule(String formuleSansRub) throws Exception
    {
        //ScriptEngineManager mgr = new ScriptEngineManager();
        //ScriptEngine engine = mgr.getEngineByName("JavaScript");
        if(formuleSansRub==null || formuleSansRub.compareTo("")==0) return 0;
        return Double.parseDouble(engine.eval(formuleSansRub).toString());
    }
    public static String evaluerFormule(String formuleSansRub) throws Exception
    {
        //ScriptEngineManager mgr = new ScriptEngineManager();
        //ScriptEngine engine = mgr.getEngineByName("JavaScript");
        
        if(formuleSansRub==null || formuleSansRub.compareTo("")==0) return "";
        return (engine.eval(formuleSansRub).toString());
    }
    public static boolean evaluerCondition(String formuleSansRub) throws Exception
    {
        //ScriptEngineManager mgr = new ScriptEngineManager();
        //ScriptEngine engine = mgr.getEngineByName("JavaScript");
        return ((Boolean)engine.eval(formuleSansRub)).booleanValue();
    }
}
