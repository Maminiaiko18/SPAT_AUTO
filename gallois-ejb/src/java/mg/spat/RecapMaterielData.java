/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.CGenUtil;
import java.sql.Connection;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author MEVA
 */
public class RecapMaterielData {
    private ArrayList<HashMap<String,Object>> autres;
    public RecapMaterielData(Date date,Date date_f)throws Exception{
        System.out.println("Date=="+date+" and date_f="+date_f);
        Connection c = null;
        try{
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            autres = new ArrayList<HashMap<String,Object>>();
            int count=0;
        
            MaterielNaval[] liste=(MaterielNaval[])CGenUtil.rechercher(new MaterielNaval(), null, null, c, "");
            RecapMateriel[] ls = (RecapMateriel[]) CGenUtil.rechercher(new RecapMateriel(), null, null, c, " order by daty_prev desc, heuredebut_occup desc");
                for(int j=0;j<liste.length;j++){
                    autres.add(new HashMap<String,Object>());
                    autres.get(autres.size()-1).put("materiel",liste[j]);
                    for(int i=0;i<ls.length;i++){
                        if(ls[i].getIdmateriel_naval_occup()!=null && liste[j].getId().compareTo(ls[i].getIdmateriel_naval_occup())==0){
                            if(is(ls[i],date,date_f)){
                                if(((ArrayList)autres.get(autres.size()-1).get("Occupation"))==null){
                                    autres.get(autres.size()-1).put("Occupation",new ArrayList<Mouvement>());
                                }
                                ((ArrayList)autres.get(autres.size()-1).get("Occupation")).add(ls[i]);
                            }
                        }
                    }
                }
               
        }catch(Exception e){
            e.printStackTrace();
            if(c!=null) c.rollback();
            throw e;
        }finally{
            if(c!=null) c.close();
        }
    }
    
    public boolean is(RecapMateriel valeur,Date d,Date f){
        if((valeur.getDaty_occup()!=null 
            && Utilitaire.getDiffJour(d,valeur.getDaty_occup())>=0
            && Utilitaire.getDiffJour(f,valeur.getDaty_occup())<=0 )
            || ((valeur.getDaty_prev()!=null 
            && Utilitaire.getDiffJour(d,valeur.getDaty_prev())>=0
            && Utilitaire.getDiffJour(f,valeur.getDaty_prev())<=0))){
            return true;
        }
       else{
            return false;
        }
        
    }
    
    public ArrayList<HashMap<String,Object>> getAutres() {
        return autres;
    }

    public void setAutres(ArrayList<HashMap<String,Object>> autres) {
        this.autres = autres;
    }
}
