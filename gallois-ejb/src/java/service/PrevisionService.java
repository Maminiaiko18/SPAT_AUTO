/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package service;

import bean.CGenUtil;
import java.sql.Connection;
import java.sql.Date;
import mg.spat.OccupationMaterielNaval;
import mg.spat.Postedestinataire;
import mg.spat.Prevision;
import mg.spat.PrevisionMaterielNaval;
import mg.spat.PrevisionMaterielNavalLibComplet;
import mg.spat.PrevisionQuais;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author MEVA
 */
public class PrevisionService {
    
    public static Prevision getPrevisionById(String id,Connection c)throws Exception{
        int verif=0;
        try{
            if(c == null){
                c = new UtilDB().GetConn();
                verif = 1;
            }
            Prevision prv= new Prevision();
            prv.setId(id);
             Prevision[] liste=(Prevision[]) CGenUtil.rechercher(prv,null, null,c, "");
             return liste[0];
           
        }
        catch(Exception ex){
            throw ex;
        }
        finally{
            if(verif==1 && c!=null)c.close();
        }
    }
    public static int comparerHeure(String heure1,String heure2){
        String[] tabHeure1=heure1.split(":");
        String[] tabHeure2=heure2.split(":");
        int retour=0;
        int diff=((Integer.parseInt(tabHeure1[0])*60)+Integer.parseInt(tabHeure1[1]))-((Integer.parseInt(tabHeure2[0])*60)+Integer.parseInt(tabHeure2[1]));
        if(diff>0){
            retour=1;
        }if(diff<0){
            retour=-1;
        }
        return retour;
    }
    public static void testerPrevision(Prevision prev,Connection c) throws Exception{
        try{
            Postedestinataire pd=new Postedestinataire();
            Postedestinataire[] lpd=(Postedestinataire[]) CGenUtil.rechercher(pd, null, null, c, " and id='"+prev.getProvenance()+"'");
            PrevisionQuais pq = new PrevisionQuais();
            PrevisionQuais[] liste=(PrevisionQuais[]) CGenUtil.rechercher(pq, null, null, c, " and quai='"+lpd[0].getQuai()+"' and date_arrivee<=to_date('"+prev.getDate_arrivee()+"','YYYY-MM-dd') or date_depart>=to_date('"+prev.getDate_depart()+"','YYYY-MM-dd') ");
            for(PrevisionQuais prevq : liste){
                if(prevq.getDate_arrivee().before(prev.getDate_arrivee()) && prev.getDate_arrivee().before(prevq.getDate_depart())){
                    throw new Exception ("1===Prévision impossible pour ce navire à cette date et à cette heure");
                }else if(Utilitaire.compareDaty(prev.getDate_arrivee(),prevq.getDate_arrivee())==0 ){
                    if(comparerHeure(prevq.getHeure_arrivee(),prev.getHeure_arrivee())==1){
                        throw new Exception ("2===Prévision impossible pour ce navire à cette date et à cette heure");
                    }
                }else if(Utilitaire.compareDaty(prev.getDate_arrivee(),prevq.getDate_depart())==0 ){
                    if(comparerHeure(prevq.getHeure_depart(),prev.getHeure_arrivee())==1){
                        throw new Exception ("3===Prévision impossible pour ce navire à cette date et à cette heure");
                    }
                }else if(prev.getDate_depart().after(prevq.getDate_arrivee()) && prev.getDate_depart().before(prevq.getDate_depart())){
                    throw new Exception ("4===Prévision impossible pour ce navire à cette date et à cette heure");
                }/*else if(Utilitaire.compareDaty(prevq.getDate_arrivee(), prev.getDate_depart())==0){
                    if(comparerHeure(prevq.getHeure_arrivee(),prev.getHeure_depart())==-1){
                        throw new Exception ("5===Prévision impossible pour ce navire à cette date et à cette heure");
                    }
                }*/else if(Utilitaire.compareDaty(prevq.getDate_depart(), prev.getDate_depart())==0){
                    if(comparerHeure(prevq.getHeure_depart(),prev.getHeure_depart())==1){
                        throw new Exception ("6===Prévision impossible pour ce navire à cette date et à cette heure");
                    }
                }
            }
        }catch(Exception e){
            throw e;
        }
    }
    
    public static PrevisionMaterielNavalLibComplet getPrevisionMaterielNavalById(String id,Connection c)throws Exception{
        int verif=0;
        try{
            if(c == null){
                c = new UtilDB().GetConn();
                verif = 1;
            }
            PrevisionMaterielNavalLibComplet prv= new PrevisionMaterielNavalLibComplet();
            prv.setId(id);
             PrevisionMaterielNavalLibComplet[] liste=(PrevisionMaterielNavalLibComplet[]) CGenUtil.rechercher(prv,null, null,c, "");
             return liste[0];
           
        }
        catch(Exception ex){
            throw ex;
        }
        finally{
            if(verif==1 && c!=null)c.close();
        }
    }
    public static void testerPrevisionMaterielNaval(PrevisionMaterielNaval prev,Connection c) throws Exception{
        try{ 
            if(Utilitaire.compareDaty(prev.getDate_arrivee(),prev.getDate_depart())==1){
                throw new Exception ("La date d'arrivée doit être inférieur à la date départ");
            }else if(Utilitaire.compareDaty(prev.getDate_arrivee(),prev.getDate_depart())==0 && comparerHeure(prev.getHeure_arrivee(),prev.getHeure_depart())==1){                   
                throw new Exception ("2===Prévision impossible pour ce navire à cette date et à cette heure");
            }
        }catch(Exception e){
            throw e;
        }
    }
    public static void testerOccupationMaterielNaval(OccupationMaterielNaval prev,Connection c) throws Exception{
        try{ 
            if(comparerHeure(prev.getHeuredebut(),prev.getHeurefin())!=-1){
                throw new Exception ("1===Heure de fin inférieure à l'heure de début");
            }
        }catch(Exception e){
            throw e;
        }
    }
}
