/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.ClassMAPTable;

/**
 *
 * @author Nouta
 */
public class ChiffreAffaire extends ClassMAPTable{
    private String idrubrique,rubriquelib,categorie,categorielib,designation,type,typelib,code_prest;
    private double montant;
    private int mois,annee;
    private String montantstring, creditstring; 

    public ChiffreAffaire() {
        super.setNomTable("rubrique_activite_CA");
    }

    public ChiffreAffaire(String idrubrique, String rubriquelib, String categorie, String categorielib, String designation, String type, String typelib, String code_prest, double montant, int mois, int annee) {
        this.idrubrique = idrubrique;
        this.rubriquelib = rubriquelib;
        this.categorie = categorie;
        this.categorielib = categorielib;
        this.designation = designation;
        this.type = type;
        this.typelib = typelib;
        this.code_prest = code_prest;
        this.montant = montant;
        this.mois = mois;
        this.annee = annee;
    }

    public String getMontantstring() {
        return montantstring;
    }

    public void setMontantstring(String montantstring) {
        this.montantstring = montantstring;
    }

    public String getCreditstring() {
        return creditstring;
    }

    public void setCreditstring(String creditString) {
        this.creditstring = creditString;
    }
    
    

    
    public String getIdrubrique() {
        return idrubrique;
    }

    public void setIdrubrique(String idrubrique) {
        this.idrubrique = idrubrique;
    }

    public String getRubriquelib() {
        return rubriquelib;
    }

    public void setRubriquelib(String rubriquelib) {
        this.rubriquelib = rubriquelib;
    }

    public String getCategorie() {
        return categorie;
    }

    public void setCategorie(String categorie) {
        this.categorie = categorie;
    }

    public String getCategorielib() {
        return categorielib;
    }

    public void setCategorielib(String categorielib) {
        this.categorielib = categorielib;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTypelib() {
        return typelib;
    }

    public void setTypelib(String typelib) {
        this.typelib = typelib;
    }

    public String getCode_prest() {
        return code_prest;
    }

    public void setCode_prest(String code_prest) {
        this.code_prest = code_prest;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
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
    
    
    

    @Override
    public String getTuppleID() {
        return idrubrique; 
    }

    @Override
    public String getAttributIDName() {
        return "idrubrique";
    }
    
}
