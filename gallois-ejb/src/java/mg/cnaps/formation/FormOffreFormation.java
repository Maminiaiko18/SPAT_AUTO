
package mg.cnaps.formation;

import bean.ClassEtat;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.ConstanteEtat;
import utilitaire.Utilitaire;

public class FormOffreFormation extends ClassEtat{
    private String id,id_type,id_formateur,form_categorie,log_service;
    private Date date_debut, date_fin;
    private String lieu,remarque;
    private double niveau_requis,cout_offre;
    private String etablissement;
    private String id_type_cout;

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
       
        this.preparePk("FOF", "GETSEQFORMOFFREFORMATION");
        this.setId(makePK(c));
    }
    public FormOffreFormation() {
        super.setNomTable("form_offre_formation");
    }
    public FormOffreFormation(String id, String id_type,String id_formateur,String form_categorie,String log_service,Date date_debut,Date date_fin,String lieu,String remarque,double niveau_requis,double cout_offre,String etablissement) throws Exception{
        this.setId(id);
        this.setId_type(id_type);
        this.setId_formateur(id_formateur);
        this.setForm_categorie(form_categorie);
        this.setLog_service(log_service);
        this.setDate_debut(date_debut);
        this.setDate_fin(date_fin);
        this.setLieu(lieu);
        this.setRemarque(remarque);
        this.setNiveau_requis(niveau_requis);
        this.setCout_offre(cout_offre);
        this.setEtablissement(etablissement);
        super.setNomTable("form_offre_formation");
    }
    public FormOffreFormation(String id_type,String id_formateur,String form_categorie,String log_service,Date date_debut,Date date_fin,String lieu,String remarque,double niveau_requis,double cout_offre,String etablissement) throws Exception{
        this.setId_type(id_type);
        this.setId_formateur(id_formateur);
        this.setForm_categorie(form_categorie);
        this.setLog_service(log_service);
        this.setDate_debut(date_debut);
        this.setDate_fin(date_fin);
        this.setLieu(lieu);
        this.setRemarque(remarque);
        this.setNiveau_requis(niveau_requis);
        this.setCout_offre(cout_offre);
        this.setEtablissement(etablissement);
        super.setNomTable("form_offre_formation");
    }
    
    public FormOffreFormation(String id_type,String id_formateur,String form_categorie,String log_service,Date date_debut,Date date_fin,String lieu,String remarque,double niveau_requis,String id_type_cout, double cout_offre,String etablissement) throws Exception{
        this.setId_type(id_type);
        this.setId_formateur(id_formateur);
        this.setForm_categorie(form_categorie);
        this.setLog_service(log_service);
        this.setDate_debut(date_debut);
        this.setDate_fin(date_fin);
        this.setLieu(lieu);
        this.setRemarque(remarque);
        this.setNiveau_requis(niveau_requis);
        this.setId_type_cout(id_type_cout);
        this.setCout_offre(cout_offre);
        this.setEtablissement(etablissement);
        super.setNomTable("form_offre_formation");
    }
    public void setId(String id) {
        this.id = id;
    }

    public void setId_type(String id_type) {
        this.id_type = id_type;
    }

    public String getId_type_cout() {
        return id_type_cout;
    }

    public void setId_type_cout(String id_type_cout) {
        this.id_type_cout = id_type_cout;
    }

    public void setId_formateur(String id_formateur) {
        this.id_formateur = id_formateur;
    }

    public void setForm_categorie(String form_categorie) {
        this.form_categorie = form_categorie;
    }

    public void setLog_service(String log_service) {
        this.log_service = log_service;
    }

    public void setDate_debut(Date date_debut)throws Exception {
        if(getMode().compareTo("modif")!=0)
        {
            this.date_debut = date_debut;
            return;
        }
        if(date_debut == null) throw new Exception("Date de debut invalide car vide");
        int anneeEnCours=Utilitaire.getAneeEnCours();
        int anneeDate=Utilitaire.getAnnee(date_debut);
        int diffJourdate=Utilitaire.diffJourDaty(date_debut, Utilitaire.dateDuJourSql() );
        if(anneeEnCours-anneeDate>200) throw new Exception("Date de debut trop ancienne");  
        this.date_debut = date_debut;
    }

    public void setDate_fin(Date date_fin)throws Exception{
        if(getMode().compareTo("modif")!=0)
        {
            this.date_fin = date_fin;
            return;
        }
        if(date_fin == null)throw new Exception("Date de fin invalide car vide");
        int anneeEnCours=Utilitaire.getAneeEnCours();
        int anneeDate=Utilitaire.getAnnee(date_fin);
        int diffJourdate=Utilitaire.diffJourDaty(date_fin, Utilitaire.dateDuJourSql() );
        int diffJourdateForm=Utilitaire.diffJourDaty(getDate_debut(),date_fin );
        if(anneeEnCours-anneeDate>200) throw new Exception("Date de fin trop ancienne");
        if(diffJourdateForm>=2)throw new Exception("Date de fin inferieur à la date de début de formation");
        this.date_fin = date_fin;
    }

    public void setLieu(String lieu) {
        this.lieu = lieu;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public void setNiveau_requis(double niveau_requis)throws Exception {
        if(getMode().compareTo("modif")!=0)
        {
            this.niveau_requis = niveau_requis;
            return;
        }
        if(niveau_requis<-7 || niveau_requis>7) throw new Exception("Niveau requis invalide, la valeur doit etre compris entre -7 et 7");
        this.niveau_requis = niveau_requis;
    }

    public void setCout_offre(double cout_offre) throws Exception{
        if(getMode().compareTo("modif")!=0)
        {
            this.cout_offre = cout_offre;
            return;
        }
        if(cout_offre<0) throw new Exception("Cout invalide car valeur négative");
        this.cout_offre = cout_offre;
    }

    public void setEtablissement(String etablissement) {
        this.etablissement = etablissement;
    }

    public String getId() {
        return id;
    }

    public String getId_type() {
        return id_type;
    }

    public String getId_formateur() {
        return id_formateur;
    }

    public String getForm_categorie() {
        return form_categorie;
    }

    public String getLog_service() {
        return log_service;
    }

    public Date getDate_debut() {
        return date_debut;
    }

    public Date getDate_fin() {
        return date_fin;
    }

    public String getLieu() {
        return lieu;
    }

    public String getRemarque() {
        return remarque;
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
    @Override
    public String getEtatText(int value) {
	if (value == ConstanteFormation.OFFRE_ETAT_FORM_CREE) {
	    return "FORMATION DEJA CREE POUR CETTE OFFRE";
	}
	return chaineEtat(value);
    }
}
