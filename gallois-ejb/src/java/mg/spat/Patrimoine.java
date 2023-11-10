package mg.spat;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.Utilitaire;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author Asus
 */
public class Patrimoine extends ClassMAPTable {

    private String id, idObjet, idTypePatrimoine, remarque, etat, libelle, description, occupant, utilisation, devise;
    private Date date_change;
    private double cours_change, superficie;
    private String valtypepatrimoine;
    private Date date_debut_contrat;
    private Date date_fin_contrat;

    public Date getDate_debut_contrat() {
        return date_debut_contrat;
    }

    public void setDate_debut_contrat(Date date_debut_contrat) {
        this.date_debut_contrat = date_debut_contrat;
    }

    public Date getDate_fin_contrat() {
        return date_fin_contrat;
    }

    public void setDate_fin_contrat(Date date_fin_contrat) {
        this.date_fin_contrat = date_fin_contrat;
    }
    
    @Override
    public String getValColLibelle() {
        return this.getLibelle();
    }

    public String getValtypepatrimoine() {
        return valtypepatrimoine;
    }

    public void setValtypepatrimoine(String valtypepatrimoine) {
        this.valtypepatrimoine = valtypepatrimoine;
    }

    public double getSuperficie() {
        return superficie;
    }

    public void setSuperficie(double superficie) {
        this.superficie = superficie;
    }

    public String getDevise() {
        return devise;
    }

    public void setDevise(String devise) {
        this.devise = devise;
    }

    public Date getDate_change() {
        return date_change;
    }

    public void setDate_change(Date date_change) {
        this.date_change = date_change;
    }

    public double getCours_change() {
        return cours_change;
    }

    public void setCours_change(double cours_change) throws Exception {
        if (cours_change < 0) {
            throw new Exception("Cours de change invalide");
        }
        this.cours_change = cours_change;
    }

    public String getUtilisation() {
        return utilisation;
    }

    public void setUtilisation(String utilisation) {
        this.utilisation = utilisation;
    }
    private double montant;
    private Date debut_contrat, fin_contrat;

    public Patrimoine() {
        this.setNomTable("patrimoine");
    }

    public Patrimoine(String id, String idObjet, String idTypePatrimoine, String remarque, String etat) {
        this.setNomTable("patrimoine");
        this.setId(id);
        this.setIdObjet(idObjet);
        this.setIdTypePatrimoine(idTypePatrimoine);
        this.setRemarque(remarque);
        this.setEtat(etat);
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getOccupant() {
        return occupant;
    }

    public void setOccupant(String occupant) throws Exception {
        /*if(this.getMode().compareTo("modif")==0){
            if(occupant.equalsIgnoreCase("")) throw new Exception("Occupant ne doit pas etre vide");
        }*/

        this.occupant = occupant;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) throws Exception {
        if (this.getMode().compareTo("modif") == 0) {
            if (montant < 0) {
                throw new Exception("Montant invalide");
            }
        }
        this.montant = montant;
    }

    public Date getDebut_contrat() {
        return debut_contrat;
    }

    public void setDebut_contrat(Date debut_contrat) {
        this.debut_contrat = debut_contrat;
    }

    public Date getFin_contrat() {
        return fin_contrat;
    }

    public void setFin_contrat(Date fin_contrat) throws Exception {
//        if(this.getMode().compareTo("modif")==0){
//            if(this.getDebut_contrat()!=null && Utilitaire.compareDaty(fin_contrat, this.getDebut_contrat())==-1)
//                throw new Exception("La date de début doit être supérieure à la date de fin");
//        }
        this.fin_contrat = fin_contrat;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdObjet() {
        return idObjet;
    }

    public void setIdObjet(String idObjet) {
        this.idObjet = idObjet;
    }

    public String getIdTypePatrimoine() {
        return idTypePatrimoine;
    }

    public void setIdTypePatrimoine(String idTypePatrimoine) {
        this.idTypePatrimoine = idTypePatrimoine;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public String getEtat() {
        return etat;
    }

    public void setEtat(String etat) {
        this.etat = etat;
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public void construirePK(Connection c) throws Exception {
        this.preparePk("PAT", "getseq_patrimoine");
        this.setId(makePK(c));
    }

}
