/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassMAPTable;
import java.sql.Date;

/**
 *
 * @author pro
 */
public class AnalysePersonnel extends ClassMAPTable{
    
    private int sa_compteurnumero;
    private String nom;
    private String prenom;
    private String sexe;
    private String syndicat;
    private String cadre;
    private String rue1;
    private String commune;
    private Date datenaissance;
    private String matriculesalarie;
    private String telephone;
    private int modedepaiement;
    private String email;
    private String emploioccupe;
    private String qualification;
    private String niveau;
    private String indice;
    private String categorie;
    private int numsalarie;
    private double valeurcumul;
    private double nombre; 
    private String type;
    private double effectif;

    public double getNombre() {
        return nombre;
    }

    public void setNombre(double nombre) {
        this.nombre = nombre;
    }

    public String getSexe() {
        return sexe;
    }

    public void setSexe(String sexe) {
        this.sexe = sexe;
    }

    public String getSyndicat() {
        return syndicat;
    }

    public void setSyndicat(String syndicat) {
        this.syndicat = syndicat;
    }

    public String getCadre() {
        return cadre;
    }

    public void setCadre(String cadre) {
        this.cadre = cadre;
    }

    public String getCategorie() {
        return categorie;
    }

    public void setCategorie(String categorie) {
        this.categorie = categorie;
    }

    public AnalysePersonnel() {
        super.setNomTable("analyse_personnelmat");
    }
    
    public int getSa_compteurnumero() {
        return sa_compteurnumero;
    }

    public void setSa_compteurnumero(int sa_compteurnumero) {
        this.sa_compteurnumero = sa_compteurnumero;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getRue1() {
        return rue1;
    }

    public void setRue1(String rue1) {
        this.rue1 = rue1;
    }

    public String getCommune() {
        return commune;
    }

    public void setCommune(String commune) {
        this.commune = commune;
    }

    public Date getDatenaissance() {
        return datenaissance;
    }

    public void setDatenaissance(Date datenaissance) {
        this.datenaissance = datenaissance;
    }

    public String getMatriculesalarie() {
        return matriculesalarie;
    }

    public void setMatriculesalarie(String matriculesalarie) {
        this.matriculesalarie = matriculesalarie;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getEmploioccupe() {
        return emploioccupe;
    }

    public void setEmploioccupe(String emploioccupe) {
        this.emploioccupe = emploioccupe;
    }

    public String getQualification() {
        return qualification;
    }

    public void setQualification(String qualification) {
        this.qualification = qualification;
    }

    public String getNiveau() {
        return niveau;
    }

    public void setNiveau(String niveau) {
        this.niveau = niveau;
    }

    public String getIndice() {
        return indice;
    }

    public void setIndice(String indice) {
        this.indice = indice;
    }

    public int getModedepaiement() {
        return modedepaiement;
    }

    public void setModedepaiement(int modedepaiement) {
        this.modedepaiement = modedepaiement;
    }

    public int getNumsalarie() {
        return numsalarie;
    }

    public void setNumsalarie(int numsalarie) {
        this.numsalarie = numsalarie;
    }

    public double getValeurcumul() {
        return valeurcumul;
    }

    public void setValeurcumul(double valeurcumul) {
        this.valeurcumul = valeurcumul;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
    
    @Override
    public String getTuppleID() {
        return ""+sa_compteurnumero;
    }

    @Override
    public String getAttributIDName() {
        return "sa_compteurnumero";
    }

    public double getEffectif() {
        return effectif;
    }

    public void setEffectif(double effectif) {
        this.effectif = effectif;
    }
   
}
