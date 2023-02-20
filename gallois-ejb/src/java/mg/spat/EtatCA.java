/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.AdminGen;
import bean.CGenUtil;
import java.sql.Connection;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import utilitaire.UtilDB;

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

    public EtatCA() {
    }

    public HashMap<String, CA> getetatcagen (int mois, int annee,CA[] cas){
        //ArrayList<CA> ca = new ArrayList<CA>();
        HashMap<String, CA> cahmap=new HashMap<String, CA>();
        
        int taillecas = cas.length;

        for(int i = 0;i< taillecas;i++){
            //System.out.println("numero du compte "+cas[i].getCompte());
            if ((cas[i].getMois()<mois && cas[i].getAnnee()== annee)||(cas[i].getMois()==mois&&cas[i].getAnnee()==annee&&(cas[i].getMoisFact()<cas[i].getMois()||cas[i].getAnneeFact()<cas[i].getAnnee()))){
              //  System.out.println("Niditra IFFF");

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
                    }
                    temp.setComptant(0);
                    temp.setCredit(0);
                    temp.setAvoir(0);
                    cahmap.put(cas[i].getCompte(),temp);
                }
                
            }
            
            else if (cas[i].getMois()==mois && cas[i].getAnnee()== annee&&cas[i].getMoisFact()==cas[i].getMois()&&cas[i].getAnneeFact()==annee){
                //System.out.println("NIditra Else IFFF");
                if(cahmap.get(cas[i].getCompte())!=null){
                    CA temp = cahmap.get(cas[i].getCompte());
                    temp.setAvoirEETP(temp.getAvoirEETP()+cas[i].getAvoir());
                    temp.setComptant(temp.getComptant()+cas[i].getComptant());
                    temp.setCredit(temp.getCredit()+cas[i].getCredit());
                    cahmap.put(cas[i].getCompte(),temp);
                }
                if(cahmap.get(cas[i].getCompte())==null){
                    CA temp = cas[i];
                    temp.setAvoirEETP(cas[i].getAvoir());
                    cahmap.put(cas[i].getCompte(),temp);
                }
               
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
    
    public EtatCA(String mois, String annee, boolean estGroupeAncien) {
        
    }

    public void calculCATotal(CA[] tout) {
        String[] cols = new String[]{"anciencumul", "regul", "regulEETP", "avoirEETP", "comptant", "credit", "nbComptant", "nbCredit"};
        double[] total = AdminGen.calculSommeDouble(tout, cols);

        if (total!=null&&total.length > 0) {
            totalGeneral = new CA(null, "TOTAL GENERAL", total[0], total[1], total[2], total[3], total[4], total[5], 0);
            totalGeneral.setNbComptant((int)total[6]);
            totalGeneral.setNbCredit((int)total[7]);
            
            pourcAvoir = (totalGeneral.getAvoirEETP() / totalGeneral.getTotal()) * 100;
            pourComptant = (totalGeneral.getComptant() / totalGeneral.getTotal()) * 100;
            pourcCredit = (totalGeneral.getCredit() / totalGeneral.getTotal()) * 100;
        }
        
    }

    public String[] addCAByCompteMere(String compteMere, CA[] tout) {
        List<CA> caList = new ArrayList<CA>();
        List<String> compteMereAlreadyExist = new ArrayList<String>();
        for(int i=0; i<tout.length; i++) {
            if(compteMere.equalsIgnoreCase(tout[i].getCompteMerelib())) {
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
        this.listeParRubrique = new HashMap<String, CA[]>();
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
            String[] cols = new String[]{"anciencumul", "regul", "regulEETP", "avoirEETP", "comptant", "credit", "taux"};
            double[] total = AdminGen.calculSommeDouble(listeParRubrique.get(cle), cols);
            CA ca = new CA(null, cle, total[0], total[1], total[2], total[3], total[4], total[5], 0);
            ca.setTaux(total[6]);
            totalTaux += ca.getTaux();
            this.sommePartiel.put(cle, ca);
        }
        
        totalGeneral.setTaux(totalTaux);
    }
     
    public CA[] getCACpl(int mois, int annee) throws Exception{
        Connection c = null;
        try{
            c = new UtilDB().GetConn();
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
            if(c != null) c.close();
        }
    } 
    public int getNbFactureTotal()
    {
        return this.getNbFactComptant()+this.getNbFactCredit();
    }
}
