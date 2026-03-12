/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.AdminGen;
import bean.CGenUtil;
import fin.Coursdevise;
import java.sql.Connection;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author Asus
 */
public class EtatCA {

    CA totalGeneral;
    HashMap<String, CA[]> listeParRubrique;
    HashMap<String, CA> sommePartiel;
    int nbFactComptant;
    int nbFactCredit;
    double pourcAvoir;
    double pourComptant;
    double pourcCredit;
    int mois;
    int annee;
    CA[] CAtout;
    String idgrandrubrique;

    public CA getTotalGeneral() {
        return totalGeneral;
    }

    public void setTotalGeneral(CA totalGeneral) {
        this.totalGeneral = totalGeneral;
    }

    public HashMap<String, CA[]> getListeParRubrique() {
        return listeParRubrique;
    }

    public void setListeParRubrique(HashMap<String, CA[]> listeParRubrique) {
        this.listeParRubrique = listeParRubrique;
    }

    public HashMap<String, CA> getSommePartiel() {
        return sommePartiel;
    }

    public void setSommePartiel(HashMap<String, CA> sommePartiel) {
        this.sommePartiel = sommePartiel;
    }

    public int getNbFactComptant() {
        return nbFactComptant;
    }

    public void setNbFactComptant(int nbFactComptant) {
        this.nbFactComptant = nbFactComptant;
    }

    public int getNbFactCredit() {
        return nbFactCredit;
    }

    public void setNbFactCredit(int nbFactCredit) {
        this.nbFactCredit = nbFactCredit;
    }

    public double getPourcAvoir() {
        return pourcAvoir;
    }

    public void setPourcAvoir(double pourcAvoir) {
        this.pourcAvoir = pourcAvoir;
    }

    public double getPourComptant() {
        return pourComptant;
    }

    public void setPourComptant(double pourComptant) {
        this.pourComptant = pourComptant;
    }

    public double getPourcCredit() {
        return pourcCredit;
    }

    public void setPourcCredit(double pourcCredit) {
        this.pourcCredit = pourcCredit;
    }

    public int getMois() {
        return mois;
    }

    public void setMois(int mois) {
        this.mois = mois;
    }

    public int getAnnee() {
        return annee;
    }

    public void setAnnee(int annee) {
        this.annee = annee;
    }

    public CA[] getCAtout() {
        return CAtout;
    }

    public void setCAtout(CA[] CAtout) {
        this.CAtout = CAtout;
    }

    public String getIdgrandrubrique() {
        return idgrandrubrique;
    }

    public void setIdgrandrubrique(String idgrandrubrique) {
        this.idgrandrubrique = idgrandrubrique;
    }

    public EtatCA() {
    }

    public HashMap<String, CA> getetatcagen (int mois, int annee,CA[] cas){
        //ArrayList<CA> ca = new ArrayList<CA>();
        HashMap<String, CA> cahmap=new LinkedHashMap<String, CA>();
        
        int taillecas = cas.length;

        for(int i = 0;i< taillecas;i++){
            if ( ((cas[i].getMois()<mois && cas[i].getAnnee()== annee)||(cas[i].getMois()==mois&&cas[i].getAnnee()==annee&&(cas[i].getMoisFact()<cas[i].getMois()&&cas[i].getAnneeFact()<=cas[i].getAnnee())))&& cas[i].getCheckReport()==0 ){
                if(cahmap.get(cas[i].getCompte())!=null){
                    CA temp = cahmap.get(cas[i].getCompte());
                    if(cas[i].getMois()<mois)
                    {
                        temp.setAnciencumul(temp.getAnciencumul()+cas[i].getMontant()-cas[i].getAvoir());
                        //temp.setRegulEETP(temp.getRegulEETP()+cas[i].getAvoir());
                    }
                    else
                    {
                        temp.setAnciencumul(temp.getAnciencumul()+cas[i].getMontant());
                        temp.setRegulEETP(temp.getRegulEETP()+cas[i].getAvoir());
                        temp.setRegulEETPINT(temp.getRegulEETPINT()+cas[i].getAvoirinterne());
                        temp.setRegulEETPEXT(temp.getRegulEETPEXT()+cas[i].getAvoirexterne());
                    }
                    //temp.setComptant(0);
                    //temp.setCredit(0);
                    //temp.setAvoir(0);
                    cahmap.put(cas[i].getCompte(),temp);
                }
                if(cahmap.get(cas[i].getCompte())==null){
                    CA temp = cas[i];
                    if(cas[i].getMois()<mois)
                    {
                        temp.setAnciencumul(cas[i].getMontant()-cas[i].getAvoir());
                        //temp.setRegulEETP(cas[i].getAvoir());
                    }
                    else
                    {
                        temp.setAnciencumul(cas[i].getMontant());
                        temp.setRegulEETP(cas[i].getAvoir());
                        temp.setRegulEETPINT(cas[i].getAvoirinterne());
                        temp.setRegulEETPEXT(cas[i].getAvoirexterne());
                    }
                    temp.setComptant(0);
                    temp.setCredit(0);
                    temp.setAvoir(0);
                    cahmap.put(cas[i].getCompte(),temp);
                }
            }
            
            else if ( ((cas[i].getMois()<mois && cas[i].getAnnee()== annee)||(cas[i].getMois()==mois&&cas[i].getAnnee()==annee&&(cas[i].getMoisFact()<cas[i].getMois()||cas[i].getAnneeFact()<=cas[i].getAnnee())))&&cas[i].getCheckReport()==1 ){
                if(cahmap.get(cas[i].getCompte())!=null){
                    CA temp = cahmap.get(cas[i].getCompte());
                    if(cas[i].getMois()==mois)
                    {
                        //temp.setAnciencumul(temp.getAnciencumul()+cas[i].getMontant());
                        //temp.setRegulEETP(temp.getRegulEETP()+cas[i].getAvoir());
                        temp.setReportAvoir(temp.getReportAvoir()+cas[i].getAvoir());
                    }
                    //temp.setComptant(0);
                    //temp.setCredit(0);
                    //temp.setAvoir(0);
                    cahmap.put(cas[i].getCompte(),temp);
                }
                if(cahmap.get(cas[i].getCompte())==null){
                    CA temp = cas[i];
                    if(cas[i].getMois()==mois)
                    {
                        temp.setReportAvoir(cas[i].getAvoir());
                    }
                    temp.setRegulEETP(0);
                    temp.setAnciencumul(0);
                    temp.setComptant(0);
                    temp.setCredit(0);
                    temp.setAvoir(0);
                    cahmap.put(cas[i].getCompte(),temp);
                }
                
            }
            
            else if (cas[i].getMois()==mois && cas[i].getAnnee()== annee&&cas[i].getMoisFact()==cas[i].getMois()&&cas[i].getAnneeFact()==annee){
                if(cahmap.get(cas[i].getCompte())!=null){
                    CA temp = cahmap.get(cas[i].getCompte());
                    temp.setAvoirEETP(temp.getAvoirEETP()+cas[i].getAvoir());
                    temp.setAvoirEETPINT(temp.getAvoirEETPINT()+cas[i].getAvoirinterne());
                    temp.setAvoirEETPEXT(temp.getAvoirEETPEXT()+cas[i].getAvoirexterne());
                    temp.setComptant(temp.getComptant()+cas[i].getComptant());
                    temp.setCredit(temp.getCredit()+cas[i].getCredit());
                    cahmap.put(cas[i].getCompte(),temp);
                }
                if(cahmap.get(cas[i].getCompte())==null){
                    CA temp = cas[i];
                    temp.setAvoirEETPINT(cas[i].getAvoirinterne());
                    temp.setAvoirEETPEXT(cas[i].getAvoirexterne());
                    temp.setAvoirEETP(cas[i].getAvoir());
                    cahmap.put(cas[i].getCompte(),temp);
                }
               
            }
            
        }
        return cahmap;
        
    }

    public HashMap<String, CA> getetatcagen (CA[] cas){
        //ArrayList<CA> ca = new ArrayList<CA>();
        HashMap<String, CA> cahmap=new LinkedHashMap<String, CA>();

        int taillecas = cas.length;


        for(int i = 0;i< taillecas;i++){
            if(cahmap.get(cas[i].getCompte())!=null){
                CA temp = cahmap.get(cas[i].getCompte());
                temp.setAvoirEETP(temp.getAvoirEETP()+cas[i].getAvoir());
                temp.setAvoirEETPINT(temp.getAvoirEETPINT()+cas[i].getAvoirinterne());
                temp.setAvoirEETPEXT(temp.getAvoirEETPEXT()+cas[i].getAvoirexterne());
                temp.setComptant(temp.getComptant()+cas[i].getComptant());
                temp.setCredit(temp.getCredit()+cas[i].getCredit());
                cahmap.put(cas[i].getCompte(),temp);
            }
            if(cahmap.get(cas[i].getCompte())==null){
                CA temp = cas[i];
                temp.setAvoirEETPINT(cas[i].getAvoirinterne());
                temp.setAvoirEETPEXT(cas[i].getAvoirexterne());
                temp.setAvoirEETP(cas[i].getAvoir());
                cahmap.put(cas[i].getCompte(),temp);
            }

        }
        return cahmap;

    }
        
    public EtatCA(int mois, int annee, boolean estGroupeAncien) throws Exception {
        CA[] tout = getCACpl(mois, annee);
        this.calculCATotal(tout);
        this.calculerTauxEtHashMap(tout);
        this.calculerHashMapPartiel();
    }
        
    public EtatCA(int mois, int annee, String idGrandrubrique, boolean estGroupeAncien) throws Exception {
        CA[] tout = getCACpl(mois, idGrandrubrique, annee);
        this.setCAtout(tout);
        this.calculCATotal(tout);
        this.calculerTauxEtHashMap(tout);
        this.calculerHashMapPartiel();
    }

    public EtatCA(String datedebut, String datefin, String idGrandrubrique, boolean estGroupeAncien) throws Exception {
        CA[] tout = getCACpl(datedebut, idGrandrubrique, datefin);
        this.setCAtout(tout);
        this.calculCATotal(tout);
        this.calculerTauxEtHashMap(tout);
        this.calculerHashMapPartiel();
    }
        
    public EtatCA(int mois, int annee, String idGrandrubrique, boolean estGroupeAncien, Connection c) throws Exception {
        CA[] tout = getCACpl(mois, idGrandrubrique, annee, c);
        this.calculCATotal(tout);
        this.calculerTauxEtHashMap(tout);
        this.calculerHashMapPartiel();
    }
    
    public EtatCA(int mois, int annee, boolean estGroupeAncien,String devise) throws Exception {
        CA[] tout = getCACpl(mois, annee, devise);
        this.calculCATotal(tout);
        this.calculerTauxEtHashMap(tout);
        this.calculerHashMapPartiel();
    }
    
    public EtatCA(String mois, String annee, boolean estGroupeAncien) {
        
    }

    public void calculCATotal(CA[] tout) {
        if(tout != null && tout.length > 0){
         //   String[] cols = new String[]{"anciencumul", "regul", "regulEETP", "avoirEETP", "comptant", "credit", "nbComptant", "nbCredit"};
            String[] cols = new String[]{"anciencumul", "regul", "regulEETP","regulEETPINT","regulEETPEXT", "avoirEETP","avoirEETPINT","avoirEETPEXT", "comptant", "credit", "nbComptant", "nbCredit"};
            
            double[] total = AdminGen.calculSommeDouble(tout, cols);

            if (total!=null&&total.length > 0) {
               // totalGeneral = new CA(null, "TOTAL", total[0], total[1], total[2], total[3], total[4], total[5], 0);
                totalGeneral = new CA(null, "TOTAL GENERAL", total[0], total[1], total[2], total[3], total[4], total[5],total[6],total[7],total[8],total[9], 0);
                totalGeneral.setNbComptant((int)total[6]);
                totalGeneral.setNbCredit((int)total[7]);

                pourcAvoir = (totalGeneral.getTotal() == 0) ? 0 : (totalGeneral.getAvoirEETP() / totalGeneral.getTotal()) * 100;
                pourComptant = (totalGeneral.getTotal() == 0) ? 0 : (totalGeneral.getComptant() / totalGeneral.getTotal()) * 100;
                pourcCredit = (totalGeneral.getTotal() == 0) ? 0 : (totalGeneral.getCredit() / totalGeneral.getTotal()) * 100;
            }
        }
    }

    public String[] addCAByCompteMere(String compteMere, CA[] tout) {
        List<CA> caList = new ArrayList<CA>();
        List<String> compteMereAlreadyExist = new ArrayList<String>();
        for(int i=0; i<tout.length; i++) {
            if(compteMere.equalsIgnoreCase(tout[i].getCompteMerelib())) {
                if(totalGeneral.getTotal() == 0)
                    tout[i].setTaux(0);
                else
                    tout[i].setTaux(tout[i].getTotal() / totalGeneral.getTotal() * 100);
                caList.add(tout[i]);
            }
        }
        listeParRubrique.put(compteMere, caList.toArray(new CA[caList.size()]));
        compteMereAlreadyExist.add(compteMere);
        return compteMereAlreadyExist.toArray(new String[compteMereAlreadyExist.size()]);
    }

    public Boolean checkCompteMereAlreadyExist(String compteMere, String[] compteMereAlreadyExist) {
        if(compteMereAlreadyExist != null) {
            for(int i=0; i<compteMereAlreadyExist.length; i++) {
                if(compteMere.equalsIgnoreCase(compteMereAlreadyExist[i])) {
                    return true;
                }
            }
        }
        return false;
    }

    public void calculerTauxEtHashMap(CA[] tout) {
        if(totalGeneral==null)return;
        String[] compteMereAlreadyExist = null;
        this.listeParRubrique = new LinkedHashMap<String, CA[]>();
        totalGeneral.setTaux(0);
        for(int i=0; i<tout.length; i++) {
            if(!this.checkCompteMereAlreadyExist(tout[i].getCompteMerelib(), compteMereAlreadyExist)) {
                compteMereAlreadyExist = this.addCAByCompteMere(tout[i].getCompteMerelib(), tout);
            } 
        }   
    }
    
     public void calculerHashMapPartiel(){
         if (listeParRubrique==null) return;
         sommePartiel = new HashMap<String, CA>();
         double totalTaux = 0;
        for(String cle : listeParRubrique.keySet()){
          //  String[] cols = new String[]{"anciencumul", "regul", "regulEETP", "avoirEETP", "comptant", "credit", "taux"};
            String[] cols = new String[]{"anciencumul", "regul", "regulEETP","regulEETPINT","regulEETPEXT", "avoirEETP","avoirEETPINT","avoirEETPEXT", "comptant", "credit", "taux"};
           
            double[] total = AdminGen.calculSommeDouble(listeParRubrique.get(cle), cols);
        //    CA ca = new CA(null, cle, total[0], total[1], total[2], total[3], total[4], total[5],0);
            CA ca =  new CA(null, cle, total[0], total[1], total[2], total[3], total[4], total[5],total[6],total[7],total[8],total[9],0);
                
            ca.setTaux(total[6]);
            totalTaux += ca.getTaux();
            this.sommePartiel.put(cle, ca);
        }
        
        totalGeneral.setTaux(totalTaux);
    }
     
    public CA[] getCACpl(int mois, int annee, Connection c, boolean b) throws Exception{
        boolean ouvert = false;
        try{
            if(c == null) {
                c = new UtilDB().GetConn();
                ouvert = true;
            }
            CA base = new CA();
            base.setNomTable("CompteCAFactAvoir_grp");
            CA[] result = (CA[]) CGenUtil.rechercher(base, null, null, c, " and annee="+annee+ " and mois<="+mois+" order by mois asc, compte asc");
            String[] listeCompte=AdminGen.getDistinct(result, "compte");
            HashMap<String, CA> mapCA = getetatcagen(mois, annee, result);
            base.setNomTable("factureClientMAGroupe");
            CA[] resultNombre = (CA[]) CGenUtil.rechercher(base, null, null, c, " and mois="+mois+" and annee="+annee);
            if(resultNombre.length>0)
            {
                this.setNbFactComptant(resultNombre[0].getNbComptant());
                this.setNbFactCredit(resultNombre[0].getNbCredit());
            }
            
            CA[] tabCA = new CA[mapCA.size()];
            int i = 0;
            if(tabCA==null||tabCA.length==0)return null;
            /*for(Map.Entry map:mapCA.entrySet())
            {
                System.out.println("Anaty MAP "+map.getKey());
            }*/
            for(String key: listeCompte){
                //System.out.println("i= "+i+" cleee  "+key);
                tabCA[i] = mapCA.get(key);
                i++;
            }
            return tabCA;
        } catch(Exception ex){
            throw ex;
        } finally{
            if(c != null && ouvert) c.close();
        }
    }
     
    public CA[] getCACpl(int mois, int annee) throws Exception{
        try{
            return this.getCACpl(mois, annee, null, false);
        } catch(Exception ex){
            throw ex;
        }
    }
     
    public CA[] getCACpl(int mois, String idGrandRubrique, int annee, Connection c) throws Exception{
        boolean ouvert = false;
        try{
            if(c == null) {
                c = new UtilDB().GetConn();
                ouvert = true;
            }
            CA base = new CA();
            base.setNomTable("CompteCAFactAvoir_grp");
            String requete = "SELECT\n" +
"	RANGMERECA AS RANGMERECA,\n" +
"	nvl(c.RANGCOMPTECA,j.rangcompteca) as RANGCOMPTECA,\n" +
"	nvl(c.RUBRIQUE,'-') AS rubrique,\n" +
"	nvl(c.RUBRIQUELIB,'-') AS rubriquelib,\n" +
"	nvl(c.COMPTE,j.VAL) AS compte ,\n" +
"	nvl(c.LIBELLE,j.LIBELLE ) AS LIBELLE ,\n" +
"	nvl(c.COMPTEMERE,j.comptemere) AS comptemere,\n" +
"	nvl(c.COMPTEMERELIB,j.comptemerelib) AS comptemerelib,\n" +
"	nvl(c.MERE,j.DESCE) AS mere,\n" +
"	nvl(c.MOIS," + mois + ") AS mois,\n" +
"	nvl(c.ANNEE," + annee + ") AS annee,\n" +
"	nvl(c.MOISFACT,0) AS moisfact,\n" +
"	nvl(c.ANNEEFACT,0) AS anneefact,\n" +
"	nvl(c.NBCREDIT,0) AS nbcredit,\n" +
"	nvl(c.NBCOMPTANT,0) AS nbcomptant,\n" +
"	nvl(c.CREDIT,0) AS credit,\n" +
"	nvl(c.COMPTANT,0) AS comptant,\n" +
"	nvl(c.MONTANT,0) AS montant,\n" +
"	nvl(c.AVOIR,0) AS avoir,\n" +
"	nvl(c.AVOIRinterne,0) AS avoirinterne,\n" +
"	nvl(c.AVOIRexterne,0) AS avoirexterne,\n" +
"	nvl(c.IDGRANDRUBRIQUE,j.IDGRANDRUBRIQUE) AS IDGRANDRUBRIQUE, c.CHECKREPORT  FROM\n" +
"	JOINTURECA j,\n" +
"(\n" +
"select * from CompteCAFactAvoir_grp where 1<2  and annee = " + annee + " and mois <= " + mois + " and idgrandrubrique = '" + idGrandRubrique + "' order by mois asc, compte ASC)c \n" +
"WHERE \n" +
"	j.val = c.COMPTE(+)\n" +
"	AND j.desce = c.MERE(+)\n" +
"	AND j.idgrandrubrique = c.IDGRANDRUBRIQUE (+)\n" +
"    AND j.IDGRANDRUBRIQUE = '" + idGrandRubrique + "' order by RANGMERECA,RANGCOMPTECA";
            System.out.println("Requete pour CA : "+requete);
            CA[] result = (CA[]) CGenUtil.rechercher(base, requete, c);
            String[] listeCompte=AdminGen.getDistinct(result, "compte");
            HashMap<String, CA> mapCA = getetatcagen(mois, annee, result);
            base.setNomTable("factureClientMAGroupe");
            CA[] resultNombre = (CA[]) CGenUtil.rechercher(base, null, null, c, " and mois="+mois+" and annee="+annee);
            if(resultNombre.length>0)
            {
                this.setNbFactComptant(resultNombre[0].getNbComptant());
                this.setNbFactCredit(resultNombre[0].getNbCredit());
            }
            
            CA[] tabCA = new CA[mapCA.size()];
            int i = 0;
            if(tabCA.length == 0)return null;
            /*for(Map.Entry map:mapCA.entrySet())
            {
                System.out.println("Anaty MAP "+map.getKey());
            }*/
            for(String key: listeCompte){
                tabCA[i] = mapCA.get(key);
                i++;
            }
            return tabCA;
        } catch(Exception ex){
            throw ex;
        } finally{
            if(c != null && ouvert) c.close();
        }
    }

    public CA[] getCACpl(String dateDebut, String idGrandRubrique, String dateFin, Connection c) throws Exception{

//        dateFin = String.valueOf(Date.valueOf(Utilitaire.stringToDateJ("DD/MM/YYYY", Utilitaire.stringToDate("DD/MM/YYYY", dateFin))));
//        dateDebut = String.valueOf(Date.valueOf(Utilitaire.stringToDateJ("DD/MM/YYYY", (Date) Utilitaire.stringToDate("DD/MM/YYYY", dateDebut))));

        SimpleDateFormat sdf = null;
        System.out.println( "dateDebut : "+dateDebut+" dateFin : "+dateFin);

        String pattern = "YYYY-MM-dd";
        if (dateDebut != null && dateDebut.length() >= 3 && dateDebut.charAt(2) == '/') {
            System.out.println("Le 3eme caractère est /");
            pattern = "dd/MM/yyyy";
        }

//        java.util.Date utilDateDebut = sdf.parse(dateDebut);
//        java.util.Date utilDateFin = sdf.parse(dateFin);
//
//        java.sql.Date sqlDateDebut = new java.sql.Date(utilDateDebut.getTime());
//        java.sql.Date sqlDateFin = new java.sql.Date(utilDateFin.getTime());

//        System.out.println("DATE DEBUT : "+sqlDateDebut+" DATE FIN : "+sqlDateFin);
        boolean ouvert = false;
        try{
            if(c == null) {
                c = new UtilDB().GetConn();
                ouvert = true;
            }
            CA base = new CA();
            base.setNomTable("CompteCAFactAvoir_grp");
//            String requete = "SELECT\n" +
//                    "	RANGMERECA AS RANGMERECA,\n" +
//                    "	nvl(c.RANGCOMPTECA,j.rangcompteca) as RANGCOMPTECA,\n" +
//                    "	nvl(c.RUBRIQUE,'-') AS rubrique,\n" +
//                    "	nvl(c.RUBRIQUELIB,'-') AS rubriquelib,\n" +
//                    "	nvl(c.COMPTE,j.VAL) AS compte ,\n" +
//                    "	nvl(c.LIBELLE,j.LIBELLE ) AS LIBELLE ,\n" +
//                    "	nvl(c.COMPTEMERE,j.comptemere) AS comptemere,\n" +
//                    "	nvl(c.COMPTEMERELIB,j.comptemerelib) AS comptemerelib,\n" +
//                    "	nvl(c.MERE,j.DESCE) AS mere,\n" +
//                    "	nvl(c.MOIS," + mois + ") AS mois,\n" +
//                    "	nvl(c.ANNEE," + annee + ") AS annee,\n" +
//                    "	nvl(c.MOISFACT,0) AS moisfact,\n" +
//                    "	nvl(c.ANNEEFACT,0) AS anneefact,\n" +
//                    "	nvl(c.NBCREDIT,0) AS nbcredit,\n" +
//                    "	nvl(c.NBCOMPTANT,0) AS nbcomptant,\n" +
//                    "	nvl(c.CREDIT,0) AS credit,\n" +
//                    "	nvl(c.COMPTANT,0) AS comptant,\n" +
//                    "	nvl(c.MONTANT,0) AS montant,\n" +
//                    "	nvl(c.AVOIR,0) AS avoir,\n" +
//                    "	nvl(c.AVOIRinterne,0) AS avoirinterne,\n" +
//                    "	nvl(c.AVOIRexterne,0) AS avoirexterne,\n" +
//                    "	nvl(c.IDGRANDRUBRIQUE,j.IDGRANDRUBRIQUE) AS IDGRANDRUBRIQUE, c.CHECKREPORT  FROM\n" +
//                    "	JOINTURECA j,\n" +
//                    "(\n" +
//                    "select * from CompteCAFactAvoir_grp where 1<2  and annee = " + annee + " and mois <= " + mois + " and idgrandrubrique = '" + idGrandRubrique + "' order by mois asc, compte ASC)c \n" +
//                    "WHERE \n" +
//                    "	j.val = c.COMPTE(+)\n" +
//                    "	AND j.desce = c.MERE(+)\n" +
//                    "	AND j.idgrandrubrique = c.IDGRANDRUBRIQUE (+)\n" +
//                    "    AND j.IDGRANDRUBRIQUE = '" + idGrandRubrique + "' order by RANGMERECA,RANGCOMPTECA";

            System.out.println("DATE DEBUT : "+dateDebut+" DATE FIN : "+dateFin);

            String requete = "SELECT RANGMERECA                                AS RANGMERECA,\n" +
                    "        nvl(c.RANGCOMPTECA, j.rangcompteca)       as RANGCOMPTECA,\n" +
                    "        nvl(c.RUBRIQUE, '-')                      AS rubrique,\n" +
                    "        nvl(c.RUBRIQUELIB, '-')                   AS rubriquelib,\n" +
                    "        nvl(c.COMPTE, j.VAL)                      AS compte,\n" +
                    "        nvl(c.LIBELLE, j.LIBELLE)                 AS LIBELLE,\n" +
                    "        nvl(c.COMPTEMERE, j.comptemere)           AS comptemere,\n" +
                    "        nvl(c.COMPTEMERELIB, j.comptemerelib)     AS comptemerelib,\n" +
                    "        nvl(c.MERE, j.DESCE)                      AS mere,\n" +
                    "        nvl(c.MOIS, 0)                            AS mois,\n" +
                    "        nvl(c.ANNEE, 0)                        AS annee,\n" +
                    "        nvl(c.MOISFACT, 0)                        AS moisfact,\n" +
                    "        nvl(c.ANNEEFACT, 0)                       AS anneefact,\n" +
                    "        nvl(SUM(c.NBCREDIT), 0)                        AS nbcredit,\n" +
                    "        nvl(SUM(c.NBCOMPTANT), 0)                      AS nbcomptant,\n" +
                    "        nvl(SUM(c.CREDIT), 0)                          AS credit,\n" +
                    "        nvl(SUM(c.COMPTANT), 0)                        AS comptant,\n" +
                    "        nvl(SUM(c.MONTANT), 0)                         AS montant,\n" +
                    "        nvl(SUM(c.AVOIR), 0)                           AS avoir,\n" +
                    "        nvl(SUM(c.AVOIRinterne), 0)                    AS avoirinterne,\n" +
                    "        nvl(SUM(c.AVOIRexterne), 0)                    AS avoirexterne,\n" +
                    "        nvl(c.IDGRANDRUBRIQUE, j.IDGRANDRUBRIQUE) AS IDGRANDRUBRIQUE,\n" +
                    "        c.CHECKREPORT\n" +
                    "FROM JOINTURECA j,\n" +
                    "      (select *\n" +
                    "       from COMPTECAFACTAVOIR_GRP_DATY\n" +
                    "       where 1 < 2\n" +
                    "         and DATY >= to_date('"+dateDebut+"', '"+pattern+"')\n" +
                    "         and DATY <= to_date('"+dateFin+"', '"+pattern+"')\n" +
                    "         and idgrandrubrique = '"+idGrandRubrique+"'\n" +
                    "       order by mois asc, compte ASC) c\n" +
                    "  WHERE j.val = c.COMPTE(+)\n" +
                    "   AND j.desce = c.MERE(+)\n" +
                    "   AND j.idgrandrubrique = c.IDGRANDRUBRIQUE (+)\n" +
                    "   AND j.IDGRANDRUBRIQUE = '"+idGrandRubrique+"'\n" +
                    "group by RANGMERECA, c.RANGCOMPTECA, j.rangcompteca, c.RUBRIQUE, c.RUBRIQUELIB, c.COMPTE, j.VAL, c.LIBELLE, j.LIBELLE, c.COMPTEMERE, j.comptemere, c.COMPTEMERELIB, j.comptemerelib, c.MERE, j.DESCE, c.MOIS, c.ANNEE, c.MOISFACT, c.ANNEEFACT, c.IDGRANDRUBRIQUE, j.IDGRANDRUBRIQUE, c.CHECKREPORT\n" +
                    "order by RANGMERECA, RANGCOMPTECA";
            System.out.println("Requete pour CA : "+requete);
            CA[] result = (CA[]) CGenUtil.rechercher(base, requete, c);
            System.out.println("Resultat CA : "+result.length);
            String[] listeCompte=AdminGen.getDistinct(result, "compte");
            HashMap<String, CA> mapCA = getetatcagen(result);
            base.setNomTable("factureClientMAGroupe");
            String req2 = "select sum(nbreacredit) as nbCredit, sum(aucomptant) as nbComptant\n" +
                    " from factureclientMA where DATY >= to_date('"+dateDebut+"', '"+pattern+"') and DATY <= to_date('"+dateFin+"', '"+pattern+"')";
            CA[] resultNombre = (CA[]) CGenUtil.rechercher(base, req2, c);
            if(resultNombre.length>0)
            {
                this.setNbFactComptant(resultNombre[0].getNbComptant());
                this.setNbFactCredit(resultNombre[0].getNbCredit());
            }

            CA[] tabCA = new CA[mapCA.size()];
            System.out.println("Resultat CA : "+tabCA.length);
            int i = 0;
            if(tabCA==null||tabCA.length==0)return null;
            /*for(Map.Entry map:mapCA.entrySet())
            {
                System.out.println("Anaty MAP "+map.getKey());
            }*/
            for(String key: listeCompte){
                tabCA[i] = mapCA.get(key);
                i++;
            }
            return tabCA;
        } catch(Exception ex){
            throw ex;
        } finally{
            if(c != null && ouvert) c.close();
        }
    }
    
    public CA[] getCACpl(int mois, String idGrandRubrique, int annee) throws Exception{
        try{
            return this.getCACpl(mois, idGrandRubrique, annee, null);
        }
        catch(Exception e){
            throw e;
        }
    }

    public CA[] getCACpl(String datedebut, String idGrandRubrique, String datefin) throws Exception{
        try{
            return this.getCACpl(datedebut, idGrandRubrique, datefin, null);
        }
        catch(Exception e){
            throw e;
        }
    }
    
    public Coursdevise getCoursDevise(String devise, Connection c)throws Exception{
        if(devise!=null && devise.isEmpty()==false){
            String awhere = " and iddevise = '%s' and daty <= '%s' order by daty desc";
            Coursdevise[] coursc = (Coursdevise[]) CGenUtil.rechercher(new Coursdevise(), null, null, c, String.format(awhere, devise, Utilitaire.dateDuJour()));
            if(coursc.length>0)return coursc[0];
        }
        return null;
    }
    
    public CA[] getCACpl(int mois, int annee,String devise) throws Exception{
        Connection c = null;
        try{
            c = new UtilDB().GetConn();
            CA base = new CA();
            base.setNomTable("CompteCAFactAvoir_grp");
            CA[] result = (CA[]) CGenUtil.rechercher(base, null, null, c, " and annee="+annee+ " and mois<="+mois+" order by mois asc, compte asc");
            Coursdevise coursDevise=this.getCoursDevise(devise, c);
            for(int i=0;i<result.length;i++){
                result[i].convertirDevise(coursDevise);
            }
            String[] listeCompte=AdminGen.getDistinct(result, "compte");
            HashMap<String, CA> mapCA = getetatcagen(mois, annee, result);
            base.setNomTable("factureClientMAGroupe");
            CA[] resultNombre = (CA[]) CGenUtil.rechercher(base, null, null, c, " and mois="+mois+" and annee="+annee);
            if(resultNombre.length>0)
            {
                this.setNbFactComptant(resultNombre[0].getNbComptant());
                this.setNbFactCredit(resultNombre[ 0].getNbCredit());
            }
            
            CA[] tabCA = new CA[mapCA.size()];
            int i = 0;
            if(tabCA==null||tabCA.length==0)return null;
            for(String key: listeCompte){
                tabCA[i] = mapCA.get(key);
                i++;
            }
            return tabCA;
        } catch(Exception ex){
            throw ex;
        } finally{
            if(c != null) c.close();
        }
    }
    public int getNbFactureTotal()
    {
        return this.getNbFactComptant()+this.getNbFactCredit();
    }
}
