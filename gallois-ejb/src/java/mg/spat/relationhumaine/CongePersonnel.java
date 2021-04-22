/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.relationhumaine;
import bean.ClassMAPTable;
import java.sql.Date;
/**
 *
 * @author Asus
 */
public class CongePersonnel extends ClassMAPTable{
    
    private String id, matriculesalarie,nom,prenom,genre;
    private Date dateNaissance,date_debut,date_fin;
    private double nombre;

    public CongePersonnel() {
          super.setNomTable("analyse_conge_personnel");
    }

    public CongePersonnel(String id, String matriculesalarie, String nom, String prenom, String genre, Date dateNaissance, Date date_debut,Date date_fin, double nombre) {
        super.setNomTable("analyse_conge_personnel");
        this.setId(id);
        this.setMatriculesalarie(matriculesalarie);
        this.setNom(nom);
        this.setPrenom(prenom);
        this.setGenre(genre);
        this.setDateNaissance(dateNaissance);
        this.setDate_debut(date_debut);
        this.setDate_fin(date_fin);
        this.setNombre(nombre);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getMatriculesalarie() {
        return matriculesalarie;
    }

    public void setMatriculesalarie(String matriculesalarie) {
        this.matriculesalarie = matriculesalarie;
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

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public Date getDateNaissance() {
        return dateNaissance;
    }

    public void setDateNaissance(Date dateNaissance) {
        this.dateNaissance = dateNaissance;
    }

    public Date getDate_debut() {
        return date_debut;
    }

    public void setDate_debut(Date date_debut) {
        this.date_debut = date_debut;
    }

    public Date getDate_fin() {
        return date_fin;
    }

    public void setDate_fin(Date date_fin) {
        this.date_fin = date_fin;
    }

   
    
    public double getNombre() {
        return nombre;
    }

    public void setNombre(double nombre) {
        this.nombre = nombre;
    }
    
    

    @Override
    public String getTuppleID() {
      return this.id;
    }

    @Override
    public String getAttributIDName() {
      return "id";
    }
    
    
    
}
