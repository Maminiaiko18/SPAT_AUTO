package historique;

import java.sql.Connection;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import utilitaire.Utilitaire;

public class MapHistorique extends bean.ClassMAPTable implements java.io.Serializable {

    private String idHistorique;
    private java.sql.Date dateHistorique;
    private String heure;
    private String objet;
    private String action;
    private String idUtilisateur;
    private String refObjet;

    
    
    public MapHistorique() {
        super.setNomTable("historique");
    }

    public MapHistorique(String refe, java.sql.Date date, String lera, String refOrd, String action, String user, String refObje) throws Exception {
        super.setNomTable("historique");
        this.setIdHistorique(refe);
        this.setDateHistorique(date);
        this.setHeure(lera);
        this.setObjet(refOrd);
        this.setAction(action);
        this.setIdUtilisateur(user);
        this.setRefObjet(refObje);
    }
    public MapHistorique(String obje, String action, String user, String refObje) throws Exception {
        this.setNomTable("historique");
        setNomProcedureSequence("getSeqHistorique");
        this.setLonguerClePrimaire(10);
        this.setIdHistorique(makePK());
        this.setDateHistorique(utilitaire.Utilitaire.dateDuJourSql());
        this.setHeure(utilitaire.Utilitaire.heureCouranteHMS() );
        this.setAction(action);
        this.setIdUtilisateur(user);
        this.setRefObjet(refObje);
        this.setObjet(objet);
       
    }
    
    public MapHistorique(String obje, String action, String user, String refObje, Connection c) throws Exception {
        this.setNomTable("historique");
        setNomProcedureSequence("getSeqHistorique");
        this.setLonguerClePrimaire(10);
        try {
            this.setIdHistorique(makePK(c));
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        this.setDateHistorique(utilitaire.Utilitaire.dateDuJourSql());
        this.setHeure(utilitaire.Utilitaire.heureCourante());
        this.setAction(action);
        this.setIdUtilisateur(user);
        this.setRefObjet(refObje);
        this.setObjet(obje);
       
    }

    public String getTuppleID() {
        return String.valueOf(getIdHistorique());
    }

    /**
     * Implementation de la methode qui doit donner le nom du champ de la cle
     * primaire (tjrs pour update)
     */
    public String getAttributIDName() {
        return "idHistorique";
    }

    

    public historique.MapUtilisateur getUtilisateurs() {
        return (MapUtilisateur) new historique.UtilisateurUtil().rechercher(1, this.getIdUtilisateur())[0];
    }

    public void setDateHistorique(java.sql.Date dateHistorique) {
        if (String.valueOf(dateHistorique).compareTo("") == 0 || dateHistorique == null) {
            this.dateHistorique = utilitaire.Utilitaire.dateDuJourSql();
        } else {
            this.dateHistorique = dateHistorique;
        }
    }

    public String getObjet() {
        return objet;
    }

   

    public MapUtilisateur getUtilisateur() {
        return (MapUtilisateur) new UtilisateurUtil().rechercher(1, String.valueOf(this.getIdUtilisateur()))[0];
    }

    public String getIdHistorique() {
        return idHistorique;
    }

    public void setIdHistorique(String idHistorique) {
        this.idHistorique = idHistorique;
    }

    public String getHeure() {
        
        return heure;
    }

    public void setHeure(String heure) throws Exception {
        System.out.println("heure avanty "+heure);
        Utilitaire.transformeHeure(heure);
        this.heure = heure;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getIdUtilisateur() {
        return idUtilisateur;
    }

    public void setIdUtilisateur(String idUtilisateur) {
        this.idUtilisateur = idUtilisateur;
    }

    public String getRefObjet() {
        return refObjet;
    }

    public void setRefObjet(String refObjet) {
        this.refObjet = refObjet;
    }

    public void setObjet(String objet) {
        this.objet = objet;
    }

    /**
     * @return the dateHistorique
     */
    public java.sql.Date getDateHistorique() {
        return dateHistorique;
    }
}
