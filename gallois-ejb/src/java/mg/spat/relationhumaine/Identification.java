/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.relationhumaine;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author Asus
 */
public class Identification extends ClassMAPTable{
    private String id,nom,prenom,adresse,genre,numero_cin,telephone,
            mail,numero_matricule,type_contrat,categorie,poste,
            direction,anciennete_poste;
    private Date datenaissance,date_embauche;
    private int age,anciennete;

    public Identification() {
        super.setNomTable("identification");
    }

    public Identification(String id, String nom, String prenom, String adresse, String genre, String numero_cin, String telephone, String mail, String numero_matricule, String type_contrat, String categorie, String poste, String direction, String anciennete_poste, Date datenaissance, Date date_embauche, int age, int anciennete) throws Exception {
        super.setNomTable("identification");
        this.setId(id);
        this.setNom(nom);
        this.setPrenom(prenom);
        this.setAdresse(adresse);
        this.setGenre(genre);
        this.setNumero_cin(numero_cin);
        this.setTelephone(telephone);
        this.setMail(mail);
        this.setNumero_matricule(numero_matricule);
        this.setType_contrat(type_contrat);
        this.setCategorie(categorie);
        this.setPoste(poste);
        this.setDirection(direction);
        this.setAnciennete_poste(anciennete_poste);
        this.setDatenaissance(datenaissance);
        this.setDate_embauche(date_embauche);
        this.setAge(age);
        this.setAnciennete(anciennete);
    }
    public Identification(String nom, String prenom, String adresse, String genre, String numero_cin, String telephone, String mail, String numero_matricule, String type_contrat, String categorie, String poste, String direction, String anciennete_poste, Date datenaissance, Date date_embauche, int age, int anciennete) throws Exception {
        super.setNomTable("identification");
        this.setNom(nom);
        this.setPrenom(prenom);
        this.setAdresse(adresse);
        this.setGenre(genre);
        this.setNumero_cin(numero_cin);
        this.setTelephone(telephone);
        this.setMail(mail);
        this.setNumero_matricule(numero_matricule);
        this.setType_contrat(type_contrat);
        this.setCategorie(categorie);
        this.setPoste(poste);
        this.setDirection(direction);
        this.setAnciennete_poste(anciennete_poste);
        this.setDatenaissance(datenaissance);
        this.setDate_embauche(date_embauche);
        this.setAge(age);
        this.setAnciennete(anciennete);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) throws Exception {
        if(nom == null || nom.trim().equals("")) throw new Exception("Nom obligatoire.");
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) throws Exception {
        if(getMode().equals("modif") && (prenom == null || prenom.trim().equals(""))) throw new Exception("Prenom obligatoire.");
        this.prenom = prenom;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) throws Exception {
        if(getMode().equals("modif") && (adresse== null || adresse.trim().equals(""))) throw new Exception("Adresse obligatoire.");
        this.adresse = adresse;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) throws Exception {
        if(getMode().equals("modif") && (genre == null || genre.trim().equals(""))) throw new Exception("Genre obligatoire.");
        this.genre = genre;
    }

    public String getNumero_cin() {
        return numero_cin;
    }

    public void setNumero_cin(String numero_cin) throws Exception {
         if (getMode().compareToIgnoreCase("modif") == 0) {
            if(numero_cin == null || numero_cin.compareToIgnoreCase("") == 0){
            throw new Exception("numero cin obligatoire");
            } 
            else {
                if(numero_cin.length()!=12){
                    throw new Exception("Le nombre de caractères pour numero_cin doit être égale à 12");
                }
           }
         }
        
        this.numero_cin = numero_cin;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) throws Exception {
        if(getMode().equals("modif"))
            if(telephone == null || telephone.trim().equals("")) throw new Exception("Telephone obligatoire.");
                this.telephone = telephone;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public String getNumero_matricule() {
        return numero_matricule;
    }

    public void setNumero_matricule(String numero_matricule) throws Exception {
         if (getMode().compareToIgnoreCase("modif") == 0) {
            if (numero_matricule.length()!=7) {
               throw new Exception("Numero Matricule invalide. (Ne doit contenir que 7 caracteres!)");
            } 
        }
        this.numero_matricule = numero_matricule;
    }

    public String getType_contrat() {
        return type_contrat;
    }

    public void setType_contrat(String type_contrat) throws Exception {
        if(getMode().equals("modif"))
            if(type_contrat == null || type_contrat.trim().equals("")) throw new Exception("Type de contrat obligatoire.");
                this.type_contrat = type_contrat;
    }

    public String getCategorie() {
        return categorie;
    }

    public void setCategorie(String categorie) {
        this.categorie = categorie;
    }

    public String getPoste() {
        return poste;
    }

    public void setPoste(String poste) {
        this.poste = poste;
    }

    public String getDirection() {
        return direction;
    }

    public void setDirection(String direction) {
        this.direction = direction;
    }

    public String getAnciennete_poste() {
        return anciennete_poste;
    }

    public void setAnciennete_poste(String anciennete_poste) {
        this.anciennete_poste = anciennete_poste;
    }

    public Date getDatenaissance() {
        return datenaissance;
    }

    public void setDatenaissance(Date datenaissance) throws Exception {
        if (getMode().equals("modif") && datenaissance == null) {
            throw new Exception("Date de naissance obligatoire");
        }
        this.datenaissance = datenaissance;
    }

    public Date getDate_embauche() {
        return date_embauche;
    }

    public void setDate_embauche(Date date_embauche) {
        this.date_embauche = date_embauche;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (age < 0) {
               throw new Exception("age invalide");
            } 
        }
        
        this.age = age;
    }

    public int getAnciennete() {
        return anciennete;
    }

    public void setAnciennete(int anciennete) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (anciennete < 0) {
               throw new Exception("age invalide");
            } 
        }
        this.anciennete = anciennete;
    }

    @Override
    public String getTuppleID() {
     return this.id;
    }

    @Override
    public String getAttributIDName() {
          return "id";
    }
     public void construirePK(Connection c) throws Exception {
         this.preparePk("IDE", "getseq_identification"); 
        this.setId(makePK(c));
        
    }
    
    
}
