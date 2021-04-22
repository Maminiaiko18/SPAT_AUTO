/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.compta;


import bean.CGenUtil;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;
import bean.CGenUtil;
import static utilitaire.Utilitaire.dateDuJourSql;

/**
 *
 * @author MEVA
 */
public class ComptaBilan extends ClassMAPTable{
    private String idrubrique, rubrique, reference;
    private double ec_montant;

 
    
    
    public ComptaBilan() {
        super.setNomTable("comptabilanactif");
    }

    

    public String getRubrique() {
        return rubrique;
    }

    public void setRubrique(String rubrique) {
        this.rubrique = rubrique;
    }

    public String getIdrubrique() {
        return idrubrique;
    }

    public void setIdrubrique(String idrubrique) {
        this.idrubrique = idrubrique;
    }

    public double getEc_montant() {
        return ec_montant;
    }

    public void setEc_montant(double ec_montant) {
        this.ec_montant = ec_montant;
    }

    public String getReference() {
        return reference;
    }

    public void setReference(String reference) {
        this.reference = reference;
    }
    
    @Override
    public String getTuppleID() {
        return this.rubrique;
    }

    @Override
    public String getAttributIDName() {
        return "rubrique";
    }
    
    public static DetailsRubrique[] getSolde(String reference, String nomtable, String type, String debut, String fin,String cpt_rubrique)throws Exception{
        Connection c = null;
        try{
            c = new UtilDB().GetConn();
            
            String[] numCompte = ComptaBilanRecapPA.getNumCompte(reference, c);
            
            Date date1 = Utilitaire.dateDuJourSql();
            Date date2 = Utilitaire.dateDuJourSql();
            System.out.println("DEBUT : "+debut+", FIN : "+fin);
            if(debut != null && !debut.isEmpty())
                date1 = Utilitaire.stringDate(debut);
            if(fin != null && !fin.isEmpty())
                date2 = Utilitaire.stringDate(fin);
            System.out.println("DEBUT d : "+date1+", FIN d : "+date2);
            
            DetailsRubrique[] detailsrubrique = ComptaBilan.getSolde(numCompte, nomtable, type, date1, date2,cpt_rubrique, c);
            
            return detailsrubrique;
        }catch(Exception e){
            e.printStackTrace();
            throw e;
        }finally{
            if(c != null) c.close();
        }
    }
    
    public static DetailsRubrique[] getSolde(String[] numCompte, String nomtable, String type, Date debut, Date fin,String cpt_rubrique, Connection c)throws Exception{
        int verif = 0;
        try{
            if(c == null){
                c = new UtilDB().GetConn();
                verif = 1;
            }
            String cpt_rubriqueWhere="";
            if(cpt_rubrique!=null && cpt_rubrique.length()>0){
                cpt_rubriqueWhere= " and cpt_rubrique like '%"+cpt_rubrique+"%'";
            }
            
            String ids = Utilitaire.tabToString(numCompte, "'", ",");
            String requete = "select rubrique, cpt_rubrique, sum(ec_montant) as ec_montant , LIBELLE_CPT_RUBRIQUE from comptabilan where cpt_rubrique in ("+ids+") and ec_date>=to_date('"+debut+"','YYYY-MM-DD') and ec_date<=to_date('"+fin+"','YYYY-MM-DD') and type='"+type+"' "+cpt_rubriqueWhere+" group by cpt_rubrique, rubrique,LIBELLE_CPT_RUBRIQUE";
            
            System.out.println("requette  ----   "+requete);
            
            
            DetailsRubrique rubrique = new DetailsRubrique();
            //rubrique.setNomTable(nomtable);
            DetailsRubrique[] retour = (DetailsRubrique[]) CGenUtil.rechercher(rubrique, requete, c);
            
            return retour;
        }catch(Exception e){
            e.printStackTrace();
            throw e;
        }finally{
            if(c != null && verif == 1) c.close();
        }
    }
}
