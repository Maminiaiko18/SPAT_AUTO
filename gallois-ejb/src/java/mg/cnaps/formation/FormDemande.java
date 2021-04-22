/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.cnaps.formation;

import bean.ClassEtat;
import java.sql.Connection;
import java.sql.Date;
//import mg.cnaps.pointage.PointService;
import utilitaire.ConstanteEtat;
import utilitaire.Utilitaire;

/**
 *
 * @author Jetta
 */
public class FormDemande extends ClassEtat {

    private String id, id_etablissement, form_domaine, log_service, id_categorie, id_type, id_personnel, categorie_pro, statut_pro, type_demandeur;
    private Date date_debut, date_fin;
    private String lieu;
    private double objett;
    private int niveau_requis, effectif;
    private double cout_offre;
    private int etat;
    private String idmatiere;
    private int exercice;
    private String heure_debut, heure_fin;
    private double duree_hdebut, duree_hfin;
    private String id_type_cout, id_direction;
    private String fonction, annee_scolaire;

    public FormDemande(String id, String id_etablissement, String form_domaine, String log_service, String id_categorie, String id_type, String id_offre, Date date_debut, Date date_fin, String lieu, double objet, int niveau_requis, double cout_offre, int etat, String idmatiere, int exercice) throws Exception {
	this.setId(id);
	this.setId_etablissement(id_etablissement);
	this.setForm_domaine(form_domaine);
	this.setLog_service(log_service);
	this.setId_categorie(id_categorie);
	this.setId_type(id_type);
	this.setId_personnel(id_offre);
	this.setDate_debut(date_debut);
	this.setDate_fin(date_fin);
	this.setLieu(lieu);
	this.setObjett(objet);
	this.setNiveau_requis(niveau_requis);
	this.setCout_offre(cout_offre);
	this.setEtat(etat);
	this.setIdmatiere(idmatiere);
	this.setExercice(exercice);
	this.setNomTable("FORM_DEMANDE");
    }

    public FormDemande(String id_etablissement, String form_domaine, String log_service, String id_categorie, String id_type, String id_offre, Date date_debut, Date date_fin, String lieu, double objet, int niveau_requis, double cout_offre, int etat, String idmatiere, int exercice) throws Exception {

	this.setId_etablissement(id_etablissement);
	this.setForm_domaine(form_domaine);
	this.setLog_service(log_service);
	this.setId_categorie(id_categorie);
	this.setId_type(id_type);
	this.setId_personnel(id_offre);
	this.setDate_debut(date_debut);
	this.setDate_fin(date_fin);
	this.setLieu(lieu);
	this.setObjett(objet);
	this.setNiveau_requis(niveau_requis);
	this.setCout_offre(cout_offre);
	this.setEtat(etat);
	this.setIdmatiere(idmatiere);
	this.setExercice(exercice);
	this.setNomTable("FORM_DEMANDE");
    }

    public FormDemande(String id, String id_etablissement, String form_domaine, String log_service, String id_categorie, String id_type, String id_offre, Date date_debut, Date date_fin, String lieu, double objet, int niveau_requis, double cout_offre, int etat, String idmatiere, int exercice, String heure_debut, String heure_fin, double duree_hdeb, double duree_hfin) throws Exception {
	this.setId(id);
	this.setId_etablissement(id_etablissement);
	this.setForm_domaine(form_domaine);
	this.setLog_service(log_service);
	this.setId_categorie(id_categorie);
	this.setId_type(id_type);
	this.setId_personnel(id_offre);
	this.setDate_debut(date_debut);
	this.setDate_fin(date_fin);
	this.setLieu(lieu);
	this.setObjett(objet);
	this.setNiveau_requis(niveau_requis);
	this.setCout_offre(cout_offre);
	this.setEtat(etat);
	this.setIdmatiere(idmatiere);
	this.setExercice(exercice);
	this.setHeure_debut(heure_debut);
	this.setHeure_fin(heure_fin);
	this.setDuree_hdebut(duree_hdeb);
	this.setDuree_hfin(duree_hfin);
	this.setNomTable("FORM_DEMANDE");
    }

    public FormDemande(String id_etablissement, String form_domaine, String log_service, String id_categorie, String id_type, String id_offre, Date date_debut, Date date_fin, String lieu, double objet, int niveau_requis, double cout_offre, int etat, String idmatiere, int exercice, String heure_debut, String heure_fin, double duree_hdeb, double duree_hfin) throws Exception {
	this.setId_etablissement(id_etablissement);
	this.setForm_domaine(form_domaine);
	this.setLog_service(log_service);
	this.setId_categorie(id_categorie);
	this.setId_type(id_type);
	this.setId_personnel(id_offre);
	this.setDate_debut(date_debut);
	this.setDate_fin(date_fin);
	this.setLieu(lieu);
	this.setObjett(objet);
	this.setNiveau_requis(niveau_requis);
	this.setCout_offre(cout_offre);
	this.setEtat(etat);
	this.setIdmatiere(idmatiere);
	this.setExercice(exercice);
	this.setHeure_debut(heure_debut);
	this.setHeure_fin(heure_fin);
	this.setDuree_hdebut(duree_hdeb);
	this.setDuree_hfin(duree_hfin);
	this.setNomTable("FORM_DEMANDE");
    }

    public FormDemande(String id_etablissement, String form_domaine, String log_service, String id_categorie, String id_type, String id_offre, Date date_debut, Date date_fin, String lieu, double objet, int niveau_requis, String id_type_cout, double cout_offre, int etat, String idmatiere, int exercice, String heure_debut, String heure_fin, double duree_hdeb, double duree_hfin) throws Exception {
	this.setId_etablissement(id_etablissement);
	this.setForm_domaine(form_domaine);
	this.setLog_service(log_service);
	this.setId_categorie(id_categorie);
	this.setId_type(id_type);
	this.setId_personnel(id_offre);
	this.setDate_debut(date_debut);
	this.setDate_fin(date_fin);
	this.setLieu(lieu);
	this.setObjett(objet);
	this.setNiveau_requis(niveau_requis);
	this.setId_type_cout(id_type_cout);
	this.setCout_offre(cout_offre);
	this.setEtat(etat);
	this.setIdmatiere(idmatiere);
	this.setExercice(exercice);
	this.setHeure_debut(heure_debut);
	this.setHeure_fin(heure_fin);
	this.setDuree_hdebut(duree_hdeb);
	this.setDuree_hfin(duree_hfin);
	this.setNomTable("FORM_DEMANDE");
    }
    public FormDemande(String id_etablissement, String form_domaine, String log_service, String id_categorie, String id_type, String id_offre, Date date_debut, Date date_fin, String lieu, double objet, int niveau_requis, String id_type_cout, double cout_offre, int etat, String idmatiere, int exercice, String heure_debut, String heure_fin, double duree_hdeb, double duree_hfin, String fonction) throws Exception {
	this.setId_etablissement(id_etablissement);
	this.setForm_domaine(form_domaine);
	this.setLog_service(log_service);
	this.setId_categorie(id_categorie);
	this.setId_type(id_type);
	this.setId_personnel(id_offre);
	this.setDate_debut(date_debut);
	this.setDate_fin(date_fin);
	this.setLieu(lieu);
	this.setObjett(objet);
	this.setNiveau_requis(niveau_requis);
	this.setId_type_cout(id_type_cout);
	this.setCout_offre(cout_offre);
	this.setEtat(etat);
	this.setIdmatiere(idmatiere);
	this.setExercice(exercice);
	this.setHeure_debut(heure_debut);
	this.setHeure_fin(heure_fin);
	this.setDuree_hdebut(duree_hdeb);
	this.setDuree_hfin(duree_hfin);
        this.setFonction(fonction);
	this.setNomTable("FORM_DEMANDE");
    }
    

    public FormDemande() {
	this.setNomTable("FORM_DEMANDE");
    }

    public String getTuppleID() {
	return id;
    }

    public String getAttributIDName() {
	return "id";
    }

    public void construirePK(Connection c) throws Exception {
	this.preparePk("FMD", "getSeqFormDemande");
	this.setId(makePK(c));
    }

    public String getCategorie_pro() {
	return categorie_pro;
    }

    public void setCategorie_pro(String categorie_pro) {
	this.categorie_pro = categorie_pro;
    }

    public String getStatut_pro() {
	return statut_pro;
    }

    public void setStatut_pro(String statut_pro) {
	this.statut_pro = statut_pro;
    }

    public String getType_demandeur() {
	return type_demandeur;
    }

    public void setType_demandeur(String type_demandeur) {
	this.type_demandeur = type_demandeur;
    }

    public int getEffectif() {
	return effectif;
    }

    public void setEffectif(int effectif) throws Exception {
        try{
            if(getMode().compareTo("modif")!=0){
                this.effectif = effectif;
                return;
            }
            if(effectif < 0){
                throw new Exception("Effectif negatif non valide");
            }
            this.effectif = effectif;
        }catch(Exception e){
            throw e;
        }
    }

    public String getId_type_cout() {
	return id_type_cout;
    }

    public void setId_type_cout(String id_type_cout) {
	this.id_type_cout = id_type_cout;
    }

    public String getId() {
	return id;
    }

    public void setId(String id) {
	this.id = id;
    }

    public String getId_etablissement() {
	return id_etablissement;
    }

    public void setId_etablissement(String id_etablissement) {
	this.id_etablissement = id_etablissement;
    }

    public String getForm_domaine() {
	return form_domaine;
    }

    public void setForm_domaine(String form_domaine) {
	this.form_domaine = form_domaine;
    }

    public String getLog_service() {
	return log_service;
    }

    public void setLog_service(String log_service) throws Exception {
        if("modif".equals(getMode())){
            if(log_service==null||log_service.compareToIgnoreCase("")==0) {
                throw new Exception("Service Obligatoire");
            }
            this.log_service = log_service;
        }
	this.log_service = log_service;
    }

    public String getId_categorie() {
	return id_categorie;
    }

    public void setId_categorie(String id_categorie) {
	this.id_categorie = id_categorie;
    }

    public String getId_type() {
	return id_type;
    }

    public void setId_type(String id_type) {
	this.id_type = id_type;
    }

    public String getId_personnel() {
	return id_personnel;
    }

    public void setId_personnel(String id_personnel) {
	this.id_personnel = id_personnel;
    }

    public Date getDate_debut() {
	return date_debut;
    }

    public void setDate_debut(Date date_debut) throws Exception {
	if (getMode().compareTo("modif") != 0) {
	    this.date_debut = date_debut;
	    return;
	}
        if (date_debut == null) throw new Exception("Date de debut invalide car vide");
	this.date_debut = date_debut;
    }

    public Date getDate_fin() {
	return date_fin;
    }

    public void setDate_fin(Date date_fin) throws Exception {
	if (getMode().compareTo("modif") != 0) {
	    this.date_fin = date_fin;
	    return;
	}
	if(date_fin!=null && date_fin.before(getDate_debut())) throw new Exception("Date de fin invalide car est avant la date d�but");
	this.date_fin = date_fin;
    }

    public String getLieu() {
	return lieu;
    }

    public void setLieu(String lieu) {
	this.lieu = lieu;
    }

    public double getObjett() {
	return objett;
    }

    public void setObjett(double objet) {
	this.objett = objet;
    }

    public int getNiveau_requis() {
	return niveau_requis;
    }

    public void setNiveau_requis(int niveau_requis) throws Exception {
	if (getMode().compareTo("modif") != 0) {
	    this.niveau_requis = niveau_requis;
	    return;
	}
	if (niveau_requis < -7 || niveau_requis >7) {
	    throw new Exception("Niveau requis invalide doit �tre entre -7 et 7");
	}
	this.niveau_requis = niveau_requis;
    }

    public double getCout_offre() {
	return cout_offre;
    }

    public void setCout_offre(double cout_offre) throws Exception {
	if (getMode().compareTo("modif") != 0) {
	    this.cout_offre = cout_offre;
	    return;
	}
	if (cout_offre < 0) {
	    throw new Exception("Cout invalide car valeur n�gative");
	}
	this.cout_offre = cout_offre;
    }

    public int getEtat() {
	return etat;
    }

    public void setEtat(int etat) {
	this.etat = etat;
    }

    public String getIdmatiere() {
	return idmatiere;
    }

    public void setIdmatiere(String idmatiere) {
	this.idmatiere = idmatiere;
    }

    public int getExercice() {
	return exercice;
    }

    public void setExercice(int exercice) {
	this.exercice = exercice;
    }

    public String getHeure_debut() {
	return heure_debut;
    }

    public void setHeure_debut(String heure_debut) throws Exception{
        try{
            if(getMode().compareTo("modif")!=0){
                this.heure_debut = heure_debut;
                return;
            }            
//            PointService.validateTime(heure_debut);
            this.heure_debut = heure_debut;
        }catch(Exception e){
            throw e;
        }	
    }

    public String getHeure_fin() {
	return heure_fin;
    }

    public void setHeure_fin(String heure_fin) throws Exception {
        try{
            if(getMode().compareTo("modif")!=0){
                this.heure_fin = heure_fin;
                return;
            }
//            PointService.validateTime(heure_fin);
            this.heure_fin = heure_fin;
        }catch(Exception e){
            throw e;
        }
    }

    public double getDuree_hdebut() {
	return duree_hdebut;
    }

    public void setDuree_hdebut(double duree_hdebut) {
	this.duree_hdebut = duree_hdebut;
    }

    public double getDuree_hfin() {
	return duree_hfin;
    }

    public void setDuree_hfin(double duree_hfin) {
	this.duree_hfin = duree_hfin;
    }

    /**
     * @return the id_direction
     */
    public String getId_direction() {
	return id_direction;
    }

    /**
     * @param id_direction the id_direction to set
     */
    public void setId_direction(String id_direction) {
	this.id_direction = id_direction;
    }

    public String getFonction() {
        return fonction;
    }

    public void setFonction(String fonction) {
        this.fonction = fonction;
    }

    public String getAnnee_scolaire() {
        return annee_scolaire;
    }

    public void setAnnee_scolaire(String annee_scolaire) {
        this.annee_scolaire = annee_scolaire;
    }
    
    @Override
    public String getEtatText(int value) {
	if (value == ConstanteFormation.OFFRE_ETAT_FORM_CREE) {
	    return "FORMATION DEJA CREE POUR CETTE DEMANDE";
	}
	return chaineEtat(value);
    }
}
