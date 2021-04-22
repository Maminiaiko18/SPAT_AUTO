package mg.cnaps.formation;

import bean.ClassMAPTable;
import java.sql.Date;

public class AnalyseDemandeFormation extends ClassMAPTable{
    private String id, etablissement, domaine, service, categorie, formation_type, lieu, objet;
    private java.sql.Date date_debut, date_fin;
    private double cout;
    private int niveau_requis, exercice;

    /**CONSTRUCTOR**/
    public AnalyseDemandeFormation() {
        setNomTable("analyse_demande_formation");
    }
    
    /**GETTERS & SETTERS**/
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getEtablissement() {
        return etablissement;
    }

    public void setEtablissement(String etablissement) {
        this.etablissement = etablissement;
    }

    public String getDomaine() {
        return domaine;
    }

    public void setDomaine(String domaine) {
        this.domaine = domaine;
    }

    public String getService() {
        return service;
    }

    public void setService(String service) {
        this.service = service;
    }

    public String getCategorie() {
        return categorie;
    }

    public void setCategorie(String categorie) {
        this.categorie = categorie;
    }

    public String getFormation_type() {
        return formation_type;
    }

    public void setFormation_type(String formation_type) {
        this.formation_type = formation_type;
    }

    public String getLieu() {
        return lieu;
    }

    public void setLieu(String lieu) {
        this.lieu = lieu;
    }

    public String getObjet() {
        return objet;
    }

    public void setObjet(String objet) {
        this.objet = objet;
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

    public double getCout() {
        return cout;
    }

    public void setCout(double cout) {
        this.cout = cout;
    }

    public int getNiveau_requis() {
        return niveau_requis;
    }

    public void setNiveau_requis(int niveau_requis) {
        this.niveau_requis = niveau_requis;
    }

    public int getExercice() {
        return exercice;
    }

    public void setExercice(int exercice) {
        this.exercice = exercice;
    }
    
    /**FUNCTIONS**/
    @Override
    public String getTuppleID() {
        return "";
    }

    @Override
    public String getAttributIDName() {
        return "";
    }
}
