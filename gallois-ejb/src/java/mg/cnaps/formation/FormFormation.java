package mg.cnaps.formation;

import bean.ClassEtat;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.ConstanteEtat;
import utilitaire.Utilitaire;

public class FormFormation extends ClassEtat {

/*
STATUT_PRO,ID_DIRECTION,FONCTION,ID,FORM_DOMAINE,LOG_SERVICE,FORM_FORMATEUR,ID_CATEGORIE,ID_TYPE,ID_OF,DATE_DEBUT,DATE_FIN,
    LIEU,OBJETT,NIVEAU_REQUIS,ID_TYPE_COUT,COUT_OFFRE,ETABLISSEMENT,EXERCICE,IDUSER,HEURE_DEBUT,HEURE_FIN,DUREE_HDEBUT,DUREE_HFIN,
    ETAT,INTITULE,EFFECTIF,TYPE_DEMANDEUR,CATEGORIE_PRO    
    */    
    
//    id,form_domaine,log_service,form_formateur,id_categorie,id_type,id_of,date_debut,date_fin,lieu,objett,niveau_requis,
//    id_type_cout,cout_offre,etablissement,exercice,iduser,heure_debut,heure_fin,duree_hdebut,duree_hfin,etat,intitule,effectif,type_demandeur,
//    categorie_pro,statut_pro,id_direction,fonction
    
    private String id, form_domaine, log_service, form_formateur, id_categorie, id_type, id_of, form_demande,  intitule;
    private Date date_debut, date_fin;
    private String lieu;
    private double objett;
    private double niveau_requis, cout_offre;
    private String etablissement;
    private int exercice;
    private int effectif;
    private String type_demandeur;
    private String categorie_pro;
    private String statut_pro;
    private String heure_debut, heure_fin;
    private double duree_hdebut, duree_hfin;
    private String id_type_cout, id_direction;
    private String fonction ,idmatiere,annee_scolaire ;

    public String getIdmatiere() {
        return idmatiere;
    }

    public void setIdmatiere(String idmatiere) {
        this.idmatiere = idmatiere;
    }
    
    @Override
    public String getTuppleID() {
	return id;
    }

    @Override
    public String getAttributIDName() {
	return "id";
    }

    @Override
    public void construirePK(Connection c) throws Exception {
	this.preparePk("FFO", "GETSEQFORMFORMATION");
	this.setId(makePK(c));
    }

    public FormFormation() {
	super.setNomTable("form_formation");
    }

    public FormFormation(String id, String form_demande, String form_domaine, String log_service, String form_formateur, String id_categorie, String id_type, String id_of, Date date_debut, Date date_fin, String lieu, double objet, double niveau_requis, double cout_offre, String etablissement, int etat, int exercice) throws Exception {
	this.setId(id);
	this.setForm_domaine(form_domaine);
	this.setLog_service(log_service);
	this.setForm_formateur(form_formateur);
	this.setId_categorie(id_categorie);
	this.setId_type(id_type);
	this.setId_of(id_of);
	this.setDate_debut(date_debut);
	this.setDate_fin(date_fin);
	this.setLieu(lieu);
	this.setObjett(objet);
	this.setNiveau_requis(niveau_requis);
	this.setCout_offre(cout_offre);
	this.setEtablissement(etablissement);
	this.setEtat(etat);
	this.setExercice(exercice);
//	this.setForm_demande(form_demande);
	super.setNomTable("form_formation");
    }

    public FormFormation(String id, String form_demande, String form_domaine, String log_service, String form_formateur, String id_categorie, String id_type, String id_of, Date date_debut, Date date_fin, String lieu, double objet, double niveau_requis, double cout_offre, String etablissement, int etat, int exercice, int effectif, String type_demandeur, String categorie_pro, String statut_pro) throws Exception {
	this.setId(id);
	this.setForm_domaine(form_domaine);
	this.setLog_service(log_service);
	this.setForm_formateur(form_formateur);
	this.setId_categorie(id_categorie);
	this.setId_type(id_type);
	this.setId_of(id_of);
	this.setDate_debut(date_debut);
	this.setDate_fin(date_fin);
	this.setLieu(lieu);
	this.setObjett(objet);
	this.setNiveau_requis(niveau_requis);
	this.setCout_offre(cout_offre);
	this.setEtablissement(etablissement);
	this.setEtat(etat);
	this.setExercice(exercice);
//	this.setForm_demande(form_demande);
	this.setEffectif(effectif);
	this.setType_demandeur(type_demandeur);
	this.setCategorie_pro(categorie_pro);
	this.setStatut_pro(statut_pro);
	super.setNomTable("form_formation");
    }

    public FormFormation(String form_demande, String form_domaine, String log_service, String form_formateur, String id_categorie, String id_type, String id_of, Date date_debut, Date date_fin, String lieu, double objet, double niveau_requis, double cout_offre, String etablissement, int etat, int exercice) throws Exception {
	this.setForm_domaine(form_domaine);
	this.setLog_service(log_service);
	this.setForm_formateur(form_formateur);
	this.setId_categorie(id_categorie);
	this.setId_type(id_type);
	this.setId_of(id_of);
	this.setDate_debut(date_debut);
	this.setDate_fin(date_fin);
	this.setLieu(lieu);
	this.setObjett(objet);
	this.setNiveau_requis(niveau_requis);
	this.setCout_offre(cout_offre);
	this.setEtablissement(etablissement);
	this.setEtat(etat);
	this.setExercice(exercice);
//	this.setForm_demande(form_demande);
	super.setNomTable("form_formation");
    }

    public FormFormation(String form_demande, String form_domaine, String log_service, String form_formateur, String id_categorie, String id_type, String id_of, Date date_debut, Date date_fin, String lieu, double objet, double niveau_requis, double cout_offre, String etablissement, int etat, int exercice, int effectif, String type_demandeur, String categorie_pro, String statut_pro) throws Exception {
	this.setForm_domaine(form_domaine);
	this.setLog_service(log_service);
	this.setForm_formateur(form_formateur);
	this.setId_categorie(id_categorie);
	this.setId_type(id_type);
	this.setId_of(id_of);
	this.setDate_debut(date_debut);
	this.setDate_fin(date_fin);
	this.setLieu(lieu);
	this.setObjett(objet);
	this.setNiveau_requis(niveau_requis);
	this.setCout_offre(cout_offre);
	this.setEtablissement(etablissement);
	this.setEtat(etat);
	this.setExercice(exercice);
//	this.setForm_demande(form_demande);
	this.setEffectif(effectif);
	this.setType_demandeur(type_demandeur);
	this.setCategorie_pro(categorie_pro);
	this.setStatut_pro(statut_pro);
        
	super.setNomTable("form_formation");
    }

    public FormFormation(String id, String form_domaine, String log_service, String form_formateur, String id_categorie, String id_type, String id_of, String form_demande, String intitule, Date date_debut, Date date_fin, String lieu, double objett, double niveau_requis, double cout_offre, String etablissement, int exercice, int effectif, String type_demandeur, String categorie_pro, String statut_pro, String heure_debut, String heure_fin, double duree_hdebut, double duree_hfin, String id_type_cout, String id_direction, String fonction) {
        this.id = id;
        this.form_domaine = form_domaine;
        this.log_service = log_service;
        this.form_formateur = form_formateur;
        this.id_categorie = id_categorie;
        this.id_type = id_type;
        this.id_of = id_of;
//        this.form_demande = form_demande;
        this.intitule = intitule;
        this.date_debut = date_debut;
        this.date_fin = date_fin;
        this.lieu = lieu;
        this.objett = objett;
        this.niveau_requis = niveau_requis;
        this.cout_offre = cout_offre;
        this.etablissement = etablissement;
        this.exercice = exercice;
        this.effectif = effectif;
        this.type_demandeur = type_demandeur;
        this.categorie_pro = categorie_pro;
        this.statut_pro = statut_pro;
        this.heure_debut = heure_debut;
        this.heure_fin = heure_fin;
        this.duree_hdebut = duree_hdebut;
        this.duree_hfin = duree_hfin;
        this.id_type_cout = id_type_cout;
        this.id_direction = id_direction;
        this.fonction = fonction;
    }
    
//    public FormFormation(String id, String form_domaine,String log_service,String form_formateur,String id_categorie,String id_type,String id_of,Date date_debut,Date date_fin,String lieu,double objet,double niveau_requis,double cout_offre,String etablissement,int etat,int exercice)throws Exception {
//        this.setId(id);
//        this.setForm_domaine(form_domaine);
//        this.setLog_service(log_service);
//        this.setForm_formateur(form_formateur);
//        this.setId_categorie(id_categorie);
//        this.setId_type(id_type);
//        this.setId_of(id_of);
//        this.setDate_debut(date_debut);
//        this.setDate_fin(date_fin);
//        this.setLieu(lieu);
//        this.setObjett(objet);
//        this.setNiveau_requis(niveau_requis);
//        this.setCout_offre(cout_offre);
//        this.setEtablissement(etablissement);
//        this.setEtat(etat);
//        this.setExercice(exercice);
//        super.setNomTable("form_formation");
//    }

    public FormFormation(String form_domaine, String log_service, String form_formateur, String id_categorie, String id_type, String id_of, Date date_debut, Date date_fin, String lieu, double objet, double niveau_requis, double cout_offre, String etablissement, int etat, int exercice) throws Exception {
	this.setForm_domaine(form_domaine);
	this.setLog_service(log_service);
	this.setForm_formateur(form_formateur);
	this.setId_categorie(id_categorie);
	this.setId_type(id_type);
	this.setId_of(id_of);
	this.setDate_debut(date_debut);
	this.setDate_fin(date_fin);
	this.setLieu(lieu);
	this.setObjett(objet);
	this.setNiveau_requis(niveau_requis);
	this.setCout_offre(cout_offre);
	this.setEtablissement(etablissement);
	this.setEtat(etat);
	this.setExercice(exercice);
	super.setNomTable("form_formation");
    }

    public FormFormation(String id, String form_domaine, String log_service, String form_formateur, String id_categorie, String id_type, String id_of, Date date_debut, Date date_fin, String lieu, double objet, double niveau_requis, double cout_offre, String etablissement, int etat, int exercice, String heure_debut, String heure_fin, double duree_hdeb, double duree_hfin) throws Exception {
	this.setId(id);
	this.setForm_domaine(form_domaine);
	this.setLog_service(log_service);
	this.setForm_formateur(form_formateur);
	this.setId_categorie(id_categorie);
	this.setId_type(id_type);
	this.setId_of(id_of);
	this.setDate_debut(date_debut);
	this.setDate_fin(date_fin);
	this.setLieu(lieu);
	this.setObjett(objet);
	this.setNiveau_requis(niveau_requis);
	this.setCout_offre(cout_offre);
	this.setEtablissement(etablissement);
	this.setEtat(etat);
	this.setExercice(exercice);
	this.setHeure_debut(heure_debut);
	this.setHeure_fin(heure_fin);
	this.setDuree_hdebut(duree_hdeb);
	this.setDuree_hfin(duree_hfin);
	super.setNomTable("form_formation");
    }

    public FormFormation(String form_domaine, String log_service, String form_formateur, String id_categorie, String id_type, String id_of, Date date_debut, Date date_fin, String lieu, double objet, double niveau_requis, double cout_offre, String etablissement, int etat, int exercice, String heure_debut, String heure_fin, double duree_hdeb, double duree_hfin) throws Exception {
	this.setForm_domaine(form_domaine);
	this.setLog_service(log_service);
	this.setForm_formateur(form_formateur);
	this.setId_categorie(id_categorie);
	this.setId_type(id_type);
	this.setId_of(id_of);
	this.setDate_debut(date_debut);
	this.setDate_fin(date_fin);
	this.setLieu(lieu);
	this.setObjett(objet);
	this.setNiveau_requis(niveau_requis);
	this.setCout_offre(cout_offre);
	this.setEtablissement(etablissement);
	this.setEtat(etat);
	this.setExercice(exercice);
	this.setHeure_debut(heure_debut);
	this.setHeure_fin(heure_fin);
	this.setDuree_hdebut(duree_hdeb);
	this.setDuree_hfin(duree_hfin);
	super.setNomTable("form_formation");
    }

    public FormFormation(String form_domaine, String log_service, String form_formateur, String id_categorie, String id_type, String id_of, Date date_debut, Date date_fin, String lieu, double objet, double niveau_requis, String id_type_cout, double cout_offre, String etablissement, int etat, int exercice, String heure_debut, String heure_fin, double duree_hdeb, double duree_hfin, String fonction) throws Exception {
	this.setForm_domaine(form_domaine);
	this.setLog_service(log_service);
	this.setForm_formateur(form_formateur);
	this.setId_categorie(id_categorie);
	this.setId_type(id_type);
	this.setId_of(id_of);
	this.setDate_debut(date_debut);
	this.setDate_fin(date_fin);
	this.setLieu(lieu);
	this.setObjett(objet);
	this.setNiveau_requis(niveau_requis);
	this.setId_type_cout(id_type_cout);
	this.setCout_offre(cout_offre);
	this.setEtablissement(etablissement);
	this.setEtat(etat);
	this.setExercice(exercice);
	this.setHeure_debut(heure_debut);
	this.setHeure_fin(heure_fin);
	this.setDuree_hdebut(duree_hdeb);
	this.setDuree_hfin(duree_hfin);
        this.setFonction(fonction);
	super.setNomTable("form_formation");
    }

    public String getIntitule() {
	return intitule;
    }

    public void setIntitule(String intitule) throws Exception {
	this.intitule = intitule;
    }

    public String getForm_demande() {
	return form_demande;
    }

    public void setForm_demande(String form_demande) {
	this.form_demande = form_demande;
    }

    public void setId(String id) {
	this.id = id;
    }

    public String getId_type_cout() {
	return id_type_cout;
    }

    public void setId_type_cout(String id_type_cout) {
	this.id_type_cout = id_type_cout;
    }

    public void setForm_domaine(String form_domaine) {
	if (form_domaine == null) {
	    this.form_domaine = " ";
	} else {
	    this.form_domaine = form_domaine;
	}
    }

    public void setLog_service(String log_service) {
	this.log_service = log_service;
    }

    public void setForm_formateur(String form_formateur) throws Exception {
	this.form_formateur = form_formateur;
    }

    public void setId_categorie(String id_categorie) {
	this.id_categorie = id_categorie;
    }

    public void setId_type(String id_type) {
	this.id_type = id_type;
    }

    public void setId_of(String id_of) {
	this.id_of = id_of;
    }

    public Date getDate_fin() {
	return date_fin;
    }

    public void setDate_debut(Date date_debut) throws Exception {
	if (getMode().compareTo("modif") != 0) {
	    this.date_debut = date_debut;
	    return;
	}
	if(date_debut==null) throw new Exception("Date vide");
	this.date_debut = date_debut;
    }

    public Date getDate_debut() {
	return date_debut;
    }

    public void setDate_fin(Date date_fin) throws Exception {
	if (getMode().compareTo("modif") != 0) {
	    this.date_fin = date_fin;
	    return;
	}
	if(date_fin==null) throw new Exception("Date fin");
        if(getDate_debut().after(date_fin)) throw new Exception("Date invalide. Date fin doit �tre sup�rieur � Date d�but");
	this.date_fin = date_fin;

    }

    public void setLieu(String lieu) {
	this.lieu = lieu;
    }

    public void setObjett(double objet) {
	this.objett = objet;
    }

    public void setNiveau_requis(double niveau_requis) throws Exception {
	if (getMode().compareTo("modif") != 0) {
            this.niveau_requis = niveau_requis;
          
	    return;
	}
        
        
        
	if (niveau_requis < -7 || niveau_requis > 7) {
	    throw new Exception("Niveau requis invalide doit �tre entre -7 et 7");
	}
	this.niveau_requis = niveau_requis;
    }

    public void setCout_offre(double cout_offre) throws Exception {
	if (getMode().compareTo("modif") != 0) {
	    this.cout_offre = cout_offre;
	    return;
	}
	if (cout_offre < 0) {
	    throw new Exception("Co�t invalide car valeur n�gative");
	}
	this.cout_offre = cout_offre;
    }

    public void setEtablissement(String etablissement) throws Exception {
	/*if (etablissement == null || etablissement.compareToIgnoreCase("") == 0) {
	    throw new Exception("Champ etablissement a remplir");
	}*/
	this.etablissement = etablissement;
    }

    /*public void setEtat(double etat) {
        this.etat = etat;
    }*/
    public void setExercice(int exercice) throws Exception {
	if (getMode().compareTo("modif") != 0) {
	    this.exercice = exercice;
	    return;
	}
	if (exercice < 0) {
	    throw new Exception("Exercice invalide car <0");
	}
	this.exercice = exercice;
    }

    public String getId() {
	return id;
    }

    public String getForm_domaine() {
	return form_domaine;
    }

    public String getLog_service() {
	return log_service;
    }

    public String getForm_formateur() {
	return form_formateur;
    }

    public String getId_categorie() {
	return id_categorie;
    }

    public String getId_type() {
	return id_type;
    }

    public String getId_of() {
	return id_of;
    }

    public String getLieu() {
	return lieu;
    }

    public double getObjett() {
	return objett;
    }

    public double getNiveau_requis() {
	return niveau_requis;
    }

    public double getCout_offre() {
	return cout_offre;
    }

    public String getEtablissement() {
	return etablissement;
    }

    public int getExercice() {
	return exercice;
    }

    public String getHeure_debut() {
	return heure_debut;
    }

    public void setHeure_debut(String heure_debut) throws Exception {
	this.heure_debut = heure_debut;
    }

    public String getHeure_fin() {
	return heure_fin;
    }

    public void setHeure_fin(String heure_fin) throws Exception {
	this.heure_fin = heure_fin;
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
     * @return the effectif
     */
    public int getEffectif() {
	return effectif;
    }

    /**
     * @param effectif the effectif to set
     */
    public void setEffectif(int effectif) throws Exception {
	if (getMode().compareTo("modif") != 0) {
            this.effectif = effectif;
            return;
        }
        if(effectif<0) throw new Exception("Effectif ne peut �tre n�gatif");
    }

    /**
     * @return the type_demandeur
     */
    public String getType_demandeur() {
	return type_demandeur;
    }

    /**
     * @param type_demandeur the type_demandeur to set
     */
    public void setType_demandeur(String type_demandeur) {
	this.type_demandeur = type_demandeur;
    }

    /**
     * @return the categorie_pro
     */
    public String getCategorie_pro() {
	return categorie_pro;
    }

    /**
     * @param categorie_pro the categorie_pro to set
     */
    public void setCategorie_pro(String categorie_pro) {
	this.categorie_pro = categorie_pro;
    }

    /**
     * @return the statut_pro
     */
    public String getStatut_pro() {
	return statut_pro;
    }

    /**
     * @param statut_pro the statut_pro to set
     */
    public void setStatut_pro(String statut_pro) {
	this.statut_pro = statut_pro;
    }

    @Override
    public String getEtatText(int value) {
	if (value == ConstanteEtat.etatFormationRealise) {
	    return "R�ALIS�";
	}
        if (value == ConstanteEtat.getEtatCloture()) {
	    return "VIS� PAR LE CHEF DE SERVICE";
	}
        if (value == ConstanteEtat.getEtatValider()) {
	    return "ACCORD�";
	}
	return chaineEtat(value);
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
    
    
}
