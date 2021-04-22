/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.CGenUtil;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author MEVA
 */
public class DetailsPatrimoine extends ClassMAPTable{

    private String id, idPatrimoine, natureObjet;
    private double surfaceOccupe,surfaceDisponible;
    private String utilisateur , remarque;
    private Date date_debut_contrat , date_fin_contrat;

    public DetailsPatrimoine() {
        this.setNomTable("details_patrimoine");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdPatrimoine() {
        return idPatrimoine;
    }

    public void setIdPatrimoine(String IdPatrimoine){
        this.idPatrimoine = IdPatrimoine;
    }

    public String getNatureObjet() {
        return natureObjet;
    }

    public void setNatureObjet(String natureObjet) {
        this.natureObjet = natureObjet;
    }

    public double getSurfaceOccupe() {
        return surfaceOccupe;
    }

    public void setSurfaceOccupe(double surfaceOccupe) throws Exception {
        if(this.getMode().compareTo("modif")==0){
            if(surfaceOccupe<0) throw new Exception(" surface occupée invalide");
        }
        this.surfaceOccupe = surfaceOccupe;
    }

    public double getSurfaceDisponible() {
        return surfaceDisponible;
    }

    public void setSurfaceDisponible(double surfaceDisponible) throws Exception {
        if(this.getMode().compareTo("modif")==0){
            if(surfaceDisponible<0) throw new Exception(" surface disponible invalide");
        }
        this.surfaceDisponible = surfaceDisponible;
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
        this.preparePk("DP", "getseqdetailspatrimoine");
        this.setId(makePK(c));
    }

    public String getUtilisateur() {
        return utilisateur;
    }

    public void setUtilisateur(String utilisateur) {
        this.utilisateur = utilisateur;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

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
    public void controler(Connection c) throws Exception{
        Patrimoine mere = new Patrimoine();
        mere.setId(this.getIdPatrimoine());
        Patrimoine[] patrimoine = (Patrimoine[]) CGenUtil.rechercher(mere, null, null, c, "");
        if(patrimoine == null || patrimoine.length ==0) throw new Exception ("Patrimoine obligatoire");
        double superficieMere = patrimoine[0].getSuperficie();
        DetailsPatrimoine details = new DetailsPatrimoine();
        details.setIdPatrimoine(this.getIdPatrimoine());
        DetailsPatrimoine[] liste = (DetailsPatrimoine[]) CGenUtil.rechercher(details, null, null, c, "");
        double superficieFille = 0;
        for(DetailsPatrimoine d : liste){
            superficieFille += d.getSurfaceOccupe();
        }
        double restante = superficieMere - superficieFille;
        if(this.getSurfaceOccupe() > restante) throw new Exception("supreficie invalide superficie restante : "+restante);
    }
}
