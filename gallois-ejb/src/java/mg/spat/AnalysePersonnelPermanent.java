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
 * @author Asus
 */
public class AnalysePersonnelPermanent extends ClassMAPTable{
    
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

    public AnalysePersonnelPermanent() {
          super.setNomTable("ANALYSE_PERSONNEL_PERMANENT");
    }

    public AnalysePersonnelPermanent(int sa_compteurnumero, String nom, String prenom, String sexe, String syndicat, String cadre, String rue1, String commune, Date datenaissance, String matriculesalarie, String telephone, int modedepaiement, String email, String emploioccupe, String qualification, String niveau, String indice, String categorie, int numsalarie, double valeurcumul, double nombre, String type) {
         super.setNomTable("ANALYSE_PERSONNEL_PERMANENT");
        this.sa_compteurnumero = sa_compteurnumero;
        this.nom = nom;
        this.prenom = prenom;
        this.sexe = sexe;
        this.syndicat = syndicat;
        this.cadre = cadre;
        this.rue1 = rue1;
        this.commune = commune;
        this.datenaissance = datenaissance;
        this.matriculesalarie = matriculesalarie;
        this.telephone = telephone;
        this.modedepaiement = modedepaiement;
        this.email = email;
        this.emploioccupe = emploioccupe;
        this.qualification = qualification;
        this.niveau = niveau;
        this.indice = indice;
        this.categorie = categorie;
        this.numsalarie = numsalarie;
        this.valeurcumul = valeurcumul;
        this.nombre = nombre;
        this.type = type;
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

    public int getModedepaiement() {
        return modedepaiement;
    }

    public void setModedepaiement(int modedepaiement) {
        this.modedepaiement = modedepaiement;
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

    public String getCategorie() {
        return categorie;
    }

    public void setCategorie(String categorie) {
        this.categorie = categorie;
    }

    public int getNumsalarie() {
        return numsalarie;
    }

    public void setNumsalarie(int numsalarie) throws Exception {
         if (getMode().compareToIgnoreCase("modif") == 0) {
            if (numsalarie < 0) {
                throw new Exception("numsalarie invalide");
            }
        }
        this.numsalarie = numsalarie;
    }

    public double getValeurcumul() {
        return valeurcumul;
    }

    public void setValeurcumul(double valeurcumul) throws Exception {
        
          if (getMode().compareToIgnoreCase("modif") == 0) {
            if (valeurcumul < 0) {
                throw new Exception("valeurcumul invalide");
            }
        }
        this.valeurcumul = valeurcumul;
    }

    public double getNombre() {
        return nombre;
    }

    public void setNombre(double nombre) throws Exception {
         if (getMode().compareToIgnoreCase("modif") == 0) {
            if (nombre < 0) {
                throw new Exception("nombre invalide");
            }
        }
        this.nombre = nombre;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
    
    

    @Override
    public String getTuppleID() {
     return ""+sa_compteurnumero; }

    @Override
    public String getAttributIDName() {
        return "sa_compteurnumero";
    }
    
}
