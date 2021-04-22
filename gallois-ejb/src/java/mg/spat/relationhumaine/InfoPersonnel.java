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
public class InfoPersonnel extends ClassMAPTable {

    private String situation_matrimoniale, nom_prenom_epoux, nom_prenom_pere, nom_prenom_mere, nom_prenom_enfant, id, nom, prenom, adresse, genre, numero_cin, telephone, mail, numero_matricule, type_contrat, categorie, poste, direction, anciennete_poste, idinfoprofessionnel, poste_occupe, societe, idrenseignement;
    private Date datenaissance, date_embauche, datenaissanceenfant;
    private int age, anciennete, annee_parcours_pro;
    private double duree;

    public InfoPersonnel() {
        super.setNomTable("infoPersonnelGlobal");
    }

    public InfoPersonnel(String id, String nom, String prenom, String adresse, String genre, String numero_cin, String telephone, String mail, String numero_matricule, String type_contrat, String categorie, String poste, String direction, String anciennete_poste, String idinfoprofessionnel, String idrenseignement, String situation_matrimoniale, String nom_prenom_epoux, String nom_prenom_pere, String nom_prenom_mere, String nom_prenom_enfant, Date datenaissance, Date date_embauche, Date datenaissanceenfant, int age, int anciennete, String poste_occupe, String societe, int annee_parcours_pro, double duree) throws Exception {
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
        this.setIdinfoprofessionnel(idinfoprofessionnel);
        this.setIdrenseignement(idrenseignement);
        this.setSituation_matrimoniale(situation_matrimoniale);
        this.setNom_prenom_epoux(nom_prenom_epoux);
        this.setNom_prenom_pere(nom_prenom_pere);
        this.setNom_prenom_mere(nom_prenom_mere);
        this.setNom_prenom_enfant(nom_prenom_enfant);
        this.setDatenaissance(datenaissance);
        this.setDate_embauche(date_embauche);
        this.setDatenaissanceenfant(datenaissanceenfant);
        this.setAge(age);
        this.setAnciennete(anciennete);
        this.setPoste_occupe(poste_occupe);
        this.setSociete(societe);
        this.setAnnee_parcours_pro(annee_parcours_pro);
        this.setDuree(duree);
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
           if(numero_matricule == null || numero_matricule.compareToIgnoreCase("") == 0){
                throw new Exception("numero matricule invalide");
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

    public String getIdinfoprofessionnel() {
        return idinfoprofessionnel;
    }

    public void setIdinfoprofessionnel(String idinfoprofessionnel) {
        this.idinfoprofessionnel = idinfoprofessionnel;
    }

    public String getIdrenseignement() {
        return idrenseignement;
    }

    public void setIdrenseignement(String idrenseignement) {
        this.idrenseignement = idrenseignement;
    }

    public String getSituation_matrimoniale() {
        return situation_matrimoniale;
    }

    public void setSituation_matrimoniale(String situation_matrimoniale) {
        this.situation_matrimoniale = situation_matrimoniale;
    }

    public String getNom_prenom_epoux() {
        return nom_prenom_epoux;
    }

    public void setNom_prenom_epoux(String nom_prenom_epoux) {
        this.nom_prenom_epoux = nom_prenom_epoux;
    }

    public String getNom_prenom_pere() {
        return nom_prenom_pere;
    }

    public void setNom_prenom_pere(String nom_prenom_pere) throws Exception {
        if(getMode().equals("modif"))
            if(nom_prenom_pere == null || nom_prenom_pere.trim().equals("")) throw new Exception("Nom du pere obligatoire.");
                this.nom_prenom_pere = nom_prenom_pere;
    }

    public String getNom_prenom_mere() {
        return nom_prenom_mere;
    }

    public void setNom_prenom_mere(String nom_prenom_mere) throws Exception {
        if(getMode().equals("modif"))
            if(nom_prenom_mere == null || nom_prenom_mere.trim().equals("")) throw new Exception("Nom de la mere obligatoire.");
                this.nom_prenom_mere = nom_prenom_mere;
    }

    public String getNom_prenom_enfant() {
        return nom_prenom_enfant;
    }

    public void setNom_prenom_enfant(String nom_prenom_enfant) {
        this.nom_prenom_enfant = nom_prenom_enfant;
    }

    public Date getDatenaissance() {
        return datenaissance;
    }

    public void setDatenaissance(Date datenaissance) {
        this.datenaissance = datenaissance;
    }

    public Date getDate_embauche() {
        return date_embauche;
    }

    public void setDate_embauche(Date date_embauche) {
        this.date_embauche = date_embauche;
    }

    public Date getDatenaissanceenfant() {
        return datenaissanceenfant;
    }

    public void setDatenaissanceenfant(Date datenaissanceenfant) {
        this.datenaissanceenfant = datenaissanceenfant;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (age < 0) {
                throw new Exception("Age invalide");
            }
        }
        this.age = age;
    }

    public int getAnciennete() {
        return anciennete;
    }

    public void setAnciennete(int anciennete) throws Exception {
        this.anciennete = anciennete;
    }

    public String getPoste_occupe() {
        return poste_occupe;
    }

    public void setPoste_occupe(String poste_occupe) {
        this.poste_occupe = poste_occupe;
    }

    public String getSociete() {
        return societe;
    }

    public void setSociete(String societe) {
        this.societe = societe;
    }

    public int getAnnee_parcours_pro() {
        return annee_parcours_pro;
    }

    public void setAnnee_parcours_pro(int annee_parcours_pro) {
        this.annee_parcours_pro = annee_parcours_pro;
    }

    public double getDuree() {
        return duree;
    }

    public void setDuree(double duree) {
        this.duree = duree;
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

}
