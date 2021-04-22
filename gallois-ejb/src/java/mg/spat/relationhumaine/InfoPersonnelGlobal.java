/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.relationhumaine;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.Utilitaire;

/**
 *
 * @author Antsa
 */
public class InfoPersonnelGlobal extends ClassMAPTable {

    private String id, nom, prenom, adresse, genre, numero_cin, telephone, mail, numero_matricule, type_contrat, categorie, poste, direction, anciennete_poste, situation_matrimoniale, nom_prenom_epoux, nom_prenom_pere, nom_prenom_mere, palier, logement, vehicule, autre_avantage, mode_paiement, numero_virement, numero_cnaps;
    private Date datenaissance, date_embauche;
    private int age, anciennete, indice;
    private double salaire_base, indemnite_fonction, indemnite_conge_paye, indemnite_deplacement, indemnite_risque;

    public InfoPersonnelGlobal() {
        super.setNomTable("infopersonnelglobal");
    }

    public InfoPersonnelGlobal(String id, String nom, String prenom, String adresse, String genre, String numero_cin, String telephone, String mail, String numero_matricule, String type_contrat, String categorie, String poste, String direction, String anciennete_poste, String situation_matrimoniale, String nom_prenom_epoux, String nom_prenom_pere, String nom_prenom_mere, String palier, String logement, String vehicule, String autre_avantage, String mode_paiement, String numero_virement, String numero_cnaps, Date datenaissance, Date date_embauche, int age, int anciennete, int indice, double salaire_base, double indemnite_fonction, double indemnite_conge_paye, double indemnite_deplacement, double indemnite_risque) throws Exception {
        super.setNomTable("infopersonnelglobal");

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
        this.setSituation_matrimoniale(situation_matrimoniale);
        this.setNom_prenom_epoux(nom_prenom_epoux);
        this.setNom_prenom_pere(nom_prenom_pere);
        this.setNom_prenom_mere(nom_prenom_mere);
        this.setPalier(palier);
        this.setLogement(logement);
        this.setVehicule(vehicule);
        this.setAutre_avantage(autre_avantage);
        this.setMode_paiement(mode_paiement);
        this.setNumero_virement(numero_virement);
        this.setNumero_cnaps(numero_cnaps);
        this.setDatenaissance(datenaissance);
        this.setDate_embauche(date_embauche);
        this.setAge(age);
        this.setAnciennete(anciennete);
        this.setIndice(indice);
        this.setSalaire_base(salaire_base);
        this.setIndemnite_fonction(indemnite_fonction);
        this.setIndemnite_conge_paye(indemnite_conge_paye);
        this.setIndemnite_deplacement(indemnite_deplacement);
        this.setIndemnite_risque(indemnite_risque);
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
        this.nom_prenom_pere = nom_prenom_pere;
    }

    public String getNom_prenom_mere() {
        return nom_prenom_mere;
    }

    public void setNom_prenom_mere(String nom_prenom_mere) throws Exception {
        this.nom_prenom_mere = nom_prenom_mere;
    }

    public String getPalier() {
        return palier;
    }

    public void setPalier(String palier) {
        this.palier = palier;
    }

    public String getLogement() {
        return logement;
    }

    public void setLogement(String logement) {
        this.logement = logement;
    }

    public String getVehicule() {
        return vehicule;
    }

    public void setVehicule(String vehicule) {
        this.vehicule = vehicule;
    }

    public String getAutre_avantage() {
        return autre_avantage;
    }

    public void setAutre_avantage(String autre_avantage) {
        this.autre_avantage = autre_avantage;
    }

    public String getMode_paiement() {
        return mode_paiement;
    }

    public void setMode_paiement(String mode_paiement) {
        this.mode_paiement = mode_paiement;
    }

    public String getNumero_virement() {
        return numero_virement;
    }

    public void setNumero_virement(String numero_virement) {
        this.numero_virement = numero_virement;
    }

    public String getNumero_cnaps() {
        return numero_cnaps;
    }

    public void setNumero_cnaps(String numero_cnaps) {
        this.numero_cnaps = numero_cnaps;
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
        this.anciennete = anciennete;
    }

    public int getIndice() {
        return indice;
    }

    public void setIndice(int indice) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (indice < 0) {
                throw new Exception("indice invalide");
            }
        }
        this.indice = indice;
    }

    public double getSalaire_base() {

        return salaire_base;
    }

    public void setSalaire_base(double salaire_base) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (salaire_base < 0) {
                throw new Exception("salaire_base invalide");
            }
        }
        this.salaire_base = salaire_base;
    }

    public double getIndemnite_fonction() {
        return indemnite_fonction;
    }

    public void setIndemnite_fonction(double indemnite_fonction) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (indemnite_fonction < 0) {
                throw new Exception("indemnite_fonction invalide");
            }
        }
        this.indemnite_fonction = indemnite_fonction;
    }

    public double getIndemnite_conge_paye() {
        return indemnite_conge_paye;
    }

    public void setIndemnite_conge_paye(double indemnite_conge_paye) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (indemnite_conge_paye < 0) {
                throw new Exception("indemnite_conge_paye invalide");
            }
        }
        this.indemnite_conge_paye = indemnite_conge_paye;
    }

    public double getIndemnite_deplacement() {
        return indemnite_deplacement;
    }

    public void setIndemnite_deplacement(double indemnite_deplacement) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (indemnite_deplacement < 0) {
                throw new Exception("indemnite_deplacement invalide");
            }
        }
        this.indemnite_deplacement = indemnite_deplacement;
    }

    public double getIndemnite_risque() {
        return indemnite_risque;
    }

    public void setIndemnite_risque(double indemnite_risque) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (indemnite_risque < 0) {
                throw new Exception("indemnite_fonction invalide");
            }
        }
        this.indemnite_risque = indemnite_risque;
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
        this.preparePk("IPG", "getseq_infopersonnelglobal");
        this.setId(makePK(c));
    }
}
