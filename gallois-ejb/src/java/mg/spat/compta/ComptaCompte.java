/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.compta;

import bean.AdminGen;
import bean.ClassMAPTable;
import java.sql.Connection;
import utilitaire.Utilitaire;

/**
 *
 * @author MEVA
 */
public class ComptaCompte extends ClassMAPTable {

    private String id, compte, libelle, typeCompte, classe,analytique_obli;
    private double debit_n, credit_n, debit_n_1, credit_n_1, debit_n_2, credit_n_2,debit_m_1 ,  credit_m_1 ,  debit_m_2  ,  credit_m_2 ,  debit_m_3  ,  credit_m_3  ,  debit_m_4  ,  credit_m_4 ,  debit_m_5  ,  credit_m_5  ,  debit_m_6  ,  credit_m_6 ,  debit_m_7  ,  credit_m_7  ,  debit_m_8  ,  credit_m_8 ,  debit_m_9   ,  credit_m_9  ,  debit_m_10 ,  credit_m_10 ,  debit_m_11 ,  credit_m_11 ,  debit_m_12  ,  credit_m_12 ;
    private String idjournal; //ajout pour modification vue
    public String getAnalytique_obli() {
        return analytique_obli;
    }

    public void setAnalytique_obli(String analytique_obli) throws Exception {
        if(getMode()=="modif"){
            if(analytique_obli.compareToIgnoreCase("0")==0||analytique_obli.compareToIgnoreCase("1")==0)this.analytique_obli = analytique_obli;
            else throw new Exception("Valeur non autorisé pour la compte analitique obligatoire!");
        }
        this.analytique_obli = analytique_obli;
    }

    public ComptaCompte(String id, String compte, String libelle, String typeCompte, String classe) throws Exception {
        super.setNomTable("compta_compte");
        this.setId(id);
        this.setCompte(compte);
        this.setLibelle(libelle);
        this.setTypeCompte(typeCompte);
        this.setClasse(classe);
    }

    public String getValColLibelle(){
        return libelle;
    }
    
    public double getDebit_n() {
        return debit_n;
    }

    public void setDebit_n(double debit_n) {
        this.debit_n = debit_n;
    }

    public double getCredit_n() {
        return credit_n;
    }

    public void setCredit_n(double credit_n) {
        this.credit_n = credit_n;
    }

    public double getDebit_n_1() {
        return debit_n_1;
    }

    public void setDebit_n_1(double debit_n_1) {
        this.debit_n_1 = debit_n_1;
    }

    public double getCredit_n_1() {
        return credit_n_1;
    }

    public void setCredit_n_1(double credit_n_1) {
        this.credit_n_1 = credit_n_1;
    }

    public double getDebit_n_2() {
        return debit_n_2;
    }

    public void setDebit_n_2(double debit_n_2) {
        this.debit_n_2 = debit_n_2;
    }

    public double getCredit_n_2() {
        return credit_n_2;
    }

    public void setCredit_n_2(double credit_n_2) {
        this.credit_n_2 = credit_n_2;
    }

    public double getDebit_m_1() {
        return debit_m_1;
    }

    public void setDebit_m_1(double debit_m_1) {
        this.debit_m_1 = debit_m_1;
    }

    public double getCredit_m_1() {
        return credit_m_1;
    }

    public void setCredit_m_1(double credit_m_1) {
        this.credit_m_1 = credit_m_1;
    }

    public double getDebit_m_2() {
        return debit_m_2;
    }

    public void setDebit_m_2(double debit_m_2) {
        this.debit_m_2 = debit_m_2;
    }

    public double getCredit_m_2() {
        return credit_m_2;
    }

    public void setCredit_m_2(double credit_m_2) {
        this.credit_m_2 = credit_m_2;
    }

    public double getDebit_m_3() {
        return debit_m_3;
    }

    public void setDebit_m_3(double debit_m_3) {
        this.debit_m_3 = debit_m_3;
    }

    public double getCredit_m_3() {
        return credit_m_3;
    }

    public void setCredit_m_3(double credit_m_3) {
        this.credit_m_3 = credit_m_3;
    }

    public double getDebit_m_4() {
        return debit_m_4;
    }

    public void setDebit_m_4(double debit_m_4) {
        this.debit_m_4 = debit_m_4;
    }

    public double getCredit_m_4() {
        return credit_m_4;
    }

    public void setCredit_m_4(double credit_m_4) {
        this.credit_m_4 = credit_m_4;
    }

    public double getDebit_m_5() {
        return debit_m_5;
    }

    public void setDebit_m_5(double debit_m_5) {
        this.debit_m_5 = debit_m_5;
    }

    public double getCredit_m_5() {
        return credit_m_5;
    }

    public void setCredit_m_5(double credit_m_5) {
        this.credit_m_5 = credit_m_5;
    }

    public double getDebit_m_6() {
        return debit_m_6;
    }

    public void setDebit_m_6(double debit_m_6) {
        this.debit_m_6 = debit_m_6;
    }

    public double getCredit_m_6() {
        return credit_m_6;
    }

    public void setCredit_m_6(double credit_m_6) {
        this.credit_m_6 = credit_m_6;
    }

    public double getDebit_m_7() {
        return debit_m_7;
    }

    public void setDebit_m_7(double debit_m_7) {
        this.debit_m_7 = debit_m_7;
    }

    public double getCredit_m_7() {
        return credit_m_7;
    }

    public void setCredit_m_7(double credit_m_7) {
        this.credit_m_7 = credit_m_7;
    }

    public double getDebit_m_8() {
        return debit_m_8;
    }

    public void setDebit_m_8(double debit_m_8) {
        this.debit_m_8 = debit_m_8;
    }

    public double getCredit_m_8() {
        return credit_m_8;
    }

    public void setCredit_m_8(double credit_m_8) {
        this.credit_m_8 = credit_m_8;
    }

    public double getDebit_m_9() {
        return debit_m_9;
    }

    public void setDebit_m_9(double debit_m_9) {
        this.debit_m_9 = debit_m_9;
    }

    public double getCredit_m_9() {
        return credit_m_9;
    }

    public void setCredit_m_9(double credit_m_9) {
        this.credit_m_9 = credit_m_9;
    }

    public double getDebit_m_10() {
        return debit_m_10;
    }

    public void setDebit_m_10(double debit_m_10) {
        this.debit_m_10 = debit_m_10;
    }

    public double getCredit_m_10() {
        return credit_m_10;
    }

    public void setCredit_m_10(double credit_m_10) {
        this.credit_m_10 = credit_m_10;
    }

    public double getDebit_m_11() {
        return debit_m_11;
    }

    public void setDebit_m_11(double debit_m_11) {
        this.debit_m_11 = debit_m_11;
    }

    public double getCredit_m_11() {
        return credit_m_11;
    }

    public void setCredit_m_11(double credit_m_11) {
        this.credit_m_11 = credit_m_11;
    }

    public double getDebit_m_12() {
        return debit_m_12;
    }

    public void setDebit_m_12(double debit_m_12) {
        this.debit_m_12 = debit_m_12;
    }

    public double getCredit_m_12() {
        return credit_m_12;
    }

    public void setCredit_m_12(double credit_m_12) {
        this.credit_m_12 = credit_m_12;
    }

    public ComptaCompte(String compte, String libelle, String typeCompte, String classe) throws Exception {
        super.setNomTable("compta_compte");

        this.setCompte(compte);
        this.setLibelle(libelle);
        this.setTypeCompte(typeCompte);
        this.setClasse(classe);
    }
    
    public ComptaCompte() {
        super.setNomTable("compta_compte");

    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("COC", "GETSEQCOMPTACOMPTE");
        this.setId(makePK(c));
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    
    public String getCompte() {
        return Utilitaire.champNull(compte);
    }

    public void setCompte(String compte) throws Exception{
		if(getMode().compareTo("modif")!=0)
        {
            this.compte = compte;
            return;
        }
        //if(compte=="") throw new Exception("Champ Compte manquant");
        this.compte = compte;
    }

    public String getLibelle() {
        return Utilitaire.champNull(libelle);
    }

    public void setLibelle(String libelle) throws Exception {
		if(getMode().compareTo("modif")!=0)
        {
            this.libelle = libelle;
            return;
        }
        if(libelle=="") throw new Exception("Champ libelle manquant");
        this.libelle = libelle;
    }

    public String getTypeCompte() {
        return Utilitaire.champNull(typeCompte);
    }

    public void setTypeCompte(String typeCompte) throws Exception {
        if(getMode().compareTo("modif")!=0)
        {
            this.typeCompte = typeCompte;
            return;
        }
        if(typeCompte=="") throw new Exception("Champ Type Compte manquant");
        this.typeCompte = typeCompte;
    }

    public String getClasse() {
        return Utilitaire.champNull(classe);
    }

    public void setClasse(String classe) throws Exception {
        if(getMode().compareTo("modif")!=0)
        {
            this.classe = classe;
            return;
        }
        if(classe=="") throw new Exception("Champ Classe manquant");
        this.classe = classe;
    }
    public double[] getSoldeCumule(int mois, String compte, String daty1, String daty2, ReportSolde[] report_liste) throws Exception{
        try{
            double[] ret = {0,0}; //debit, credit
            String[] attributET = {"compte"};
            String[] valET = {compte};
            ReportSolde[] reportliste = (ReportSolde[])AdminGen.findAvecOrder(report_liste, attributET, valET);
            double debit = 0, credit = 0;
            if(reportliste!=null && reportliste.length>0){
                for(int i =0; i<reportliste.length;i++){
                    debit = debit + reportliste[i].getDebit();
                    credit = credit + reportliste[i].getCredit();
                }
            }
            double solde = debit - credit;
            if(solde>0) {
                ret[0] = solde;
                ret[1] = 0;
            }
            else{
                ret[0] = 0;
                ret[1] = solde * (-1);
            }
            return ret;
        }
        catch(Exception e){
            throw e;
        }
    }
    public String getCompteReflechi(String compte){
        String temp = "";
        if(compte.startsWith("6")){
            temp ="90"+compte.substring(0, 2)+compte.substring(4, 5)+"00";      
        }
        return temp;
    }
    
    public double[] getSoldeCumule(int mois, ComptaCompte[] cc, String compte) throws Exception{
        try{
            double[] ret = {0,0}; //debit, credit
            String[] attributET = {"compte"};
            String[] valET = {compte};
            ComptaCompte[] lc = (ComptaCompte[])AdminGen.findAvecOrder(cc, attributET, valET);
            if(mois == 1){
                if(lc!=null && lc.length>0){
                    ret[0] = lc[0].getDebit_n_1();
                    ret[1] = lc[0].getCredit_n_1();
                }
                return ret;
            }
            else{
                if(lc!=null  && lc.length>0){
                    double debit = 0, credit = 0;
                    for(int i=1; i<=mois ; i++){
                        Double  debittemp = (Double)lc[0].getClass().getMethod("getDebit_m_"+i, null).invoke(lc[0]);
                        debit =  debit + debittemp.doubleValue();
                        Double  credittemp = (Double)lc[0].getClass().getMethod("getCredit_m_"+i, null).invoke(lc[0]);
                        credit = credit + credittemp.doubleValue();
                    }
                    double solde = debit - credit;
                    if(solde>0) {
                        ret[0] = solde;
                        ret[1] = 0;
                    }
                    else{
                        ret[0] = 0;
                        ret[1] = solde * (-1);
                    }
                    return ret;
                }
                else{
                    return ret;
                }
            }
        }
        catch(Exception e){
            throw e;
        }
    }

    public String getIdjournal() {
        return idjournal;
    }

    public void setIdjournal(String idjournal) {
        this.idjournal = idjournal;
    }
    
    
}
