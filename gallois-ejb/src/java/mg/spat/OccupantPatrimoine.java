/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.Utilitaire;

/**
 *
 * @author Antsa
 */
public class OccupantPatrimoine extends ClassMAPTable {

    private String id, idpatrimoine, idoccupant;
    private Date debutcontrat,fincontrat;
    private double montant;
    private String iddevise;
    private double courschange;
    private Date datechange;

    public OccupantPatrimoine(String iddevise, String idoccupant, String idpatrimoine, String id, double montant, double courschange, Date fincontrat, Date datechange, Date debutcontrat) throws Exception {
        this.setNomTable("occupantpatrimoine");
        this.setIddevise(iddevise);
        this.setIdoccupant(idoccupant);
        this.setIdpatrimoine(idpatrimoine);
        this.setId(id);
        this.setMontant(montant);
        this.setCourschange(courschange);
        this.setFincontrat(fincontrat);
        this.setDatechange(datechange);
        this.setDebutcontrat(debutcontrat);
    }

    public OccupantPatrimoine() {
        this.setNomTable("occupantpatrimoine");
    }

    public String getIddevise() {
        return iddevise;
    }

    public void setIddevise(String iddevise) {
        this.iddevise = iddevise;
    }

    public String getIdoccupant() {
        return idoccupant;
    }

    public void setIdoccupant(String idoccupant) throws Exception {
        if(this.getMode().compareTo("modif")==0){
            if(idoccupant.equalsIgnoreCase("")) throw new Exception("Occupant obligatoire");
        }
        this.idoccupant = idoccupant;
    }

    public String getIdpatrimoine() {
        return idpatrimoine;
    }

    public void setIdpatrimoine(String idpatrimoine) throws Exception {
        if(this.getMode().compareTo("modif")==0){
            if(idpatrimoine.equalsIgnoreCase("")) throw new Exception("Patrimoine obligatoire");
        }
        this.idpatrimoine = idpatrimoine;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) throws Exception {
        if(this.getMode().compareTo("modif")==0){
            if(montant<0) throw new Exception("Montant invalide");
        }
        this.montant = montant;
    }

    public double getCourschange() {
        return courschange;
    }

    public void setCourschange(double courschange) throws Exception {
        if(this.getMode().compareTo("modif")==0){
            if(courschange<0) throw new Exception("Cours de change invalide");
        }
        this.courschange = courschange;
    }

    public Date getFincontrat() {
        return fincontrat;
    }

    public void setFincontrat(Date fincontrat) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (Utilitaire.compareDaty(fincontrat, this.debutcontrat) == -1) {
                throw new Exception("La date de fin de contrat doit être inférieure à la date de début");
            } 
        }
        this.fincontrat = fincontrat;
    }

    public Date getDatechange() {
        return datechange;
    }

    public void setDatechange(Date datechange) {
        this.datechange = datechange;
    }

    public Date getDebutcontrat() {
        return debutcontrat;
    }

    public void setDebutcontrat(Date debutcontrat) {
        this.debutcontrat = debutcontrat;
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
        this.preparePk("OCUPAT", "getseqoccupantpatrimoine");
        this.setId(makePK(c));
    }

}
