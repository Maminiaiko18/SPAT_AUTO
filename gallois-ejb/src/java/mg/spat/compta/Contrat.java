/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.compta;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.Utilitaire;

/**
 *
 * @author Asus
 */
public class Contrat extends ClassMAPTable{
    
    private String id,idTiers,objet,devise,unite,typedroitport,typeduree;
    private Date date_signature,debut_contrat,fin_contrat;
    private double duree,droit_entree,redevance_fixe,redevance_variable,droit_port,redevance_domaniale,redevance_locative,pipeline;

    public Contrat() {
           super.setNomTable("contrat");
    }
    
    

    public Contrat(String id, String idTiers, String objet, String devise, String unite, Date date_signature, Date debut_contrat, Date fin_contrat, double duree, double droit_entree, double redevance_fixe, double redevance_variable, double droit_port) throws Exception {
        super.setNomTable("contrat");
        this.setId(id);
        this.setIdTiers(idTiers);
        this.setObjet(objet);
        this.setDevise(devise);
        this.setUnite(unite);
        this.setDate_signature(date_signature);
        this.setDebut_contrat(debut_contrat);
        this.setFin_contrat(fin_contrat);
        this.setDuree(duree);
        this.setDroit_entree(droit_entree);
        this.setRedevance_fixe(redevance_fixe);
        this.setRedevance_variable(redevance_variable);
        this.setDroit_port(droit_port);
    }
    public Contrat( String idTiers, String objet, String devise, String unite, Date date_signature, Date debut_contrat, Date fin_contrat, double duree, double droit_entree, double redevance_fixe, double redevance_variable, double droit_port) throws Exception {
        super.setNomTable("contrat");
   
        this.setIdTiers(idTiers);
        this.setObjet(objet);
        this.setDevise(devise);
        this.setUnite(unite);
        this.setDate_signature(date_signature);
        this.setDebut_contrat(debut_contrat);
        this.setFin_contrat(fin_contrat);
        this.setDuree(duree);
        this.setDroit_entree(droit_entree);
        this.setRedevance_fixe(redevance_fixe);
        this.setRedevance_variable(redevance_variable);
        this.setDroit_port(droit_port);
    }

    public String getTypedroitport() {
        return typedroitport;
    }

    public void setTypedroitport(String typedroitport) {
        this.typedroitport = typedroitport;
    }

    public String getTypeduree() {
        return typeduree;
    }

    public void setTypeduree(String typeduree) {
        this.typeduree = typeduree;
    }

    public double getRedevance_domaniale() {
        return redevance_domaniale;
    }

    public void setRedevance_domaniale(double redevance_domaniale) {
        this.redevance_domaniale = redevance_domaniale;
    }

    public double getRedevance_locative() {
        return redevance_locative;
    }

    public void setRedevance_locative(double redevence_locative) {
        this.redevance_locative = redevence_locative;
    }

    public double getPipeline() {
        return pipeline;
    }

    public void setPipeline(double pipeline) {
        this.pipeline = pipeline;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdTiers() {
        return idTiers;
    }

    public void setIdTiers(String idTiers) {
        this.idTiers = idTiers;
    }

    public String getObjet() {
        return objet;
    }

    public void setObjet(String objet) {
        this.objet = objet;
    }

    public String getDevise() {
        return devise;
    }

    public void setDevise(String devise) {
        this.devise = devise;
    }

    public String getUnite() {
        return unite;
    }

    public void setUnite(String unite) {
        this.unite = unite;
    }

    public Date getDate_signature() {
        return date_signature;
    }

    public void setDate_signature(Date date_signature) {
        this.date_signature = date_signature;
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
        
         if(this.getMode().compareTo("modif")==0){
            if(this.getDebut_contrat()!=null && Utilitaire.compareDaty(fin_contrat, this.getDebut_contrat())!=1)
                throw new Exception("La date de fin doit être supérieure à la date de debut");
        }
        
        this.fin_contrat = fin_contrat;
    }

    public double getDuree() {
        return duree;
    }

    public void setDuree(double duree) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {

            if ( duree < 0) {

                throw new Exception("duree invalide");
            }
        }
        this.duree = duree;
    }

    public double getDroit_entree() {
        return droit_entree;
    }

    public void setDroit_entree(double droit_entree) throws Exception {
        
         if (getMode().compareToIgnoreCase("modif") == 0) {

            if ( droit_entree < 0) {

                throw new Exception("droit_entree invalide");
            }
        }
        this.droit_entree = droit_entree;
    }

    public double getRedevance_fixe() {
        return redevance_fixe;
    }

    public void setRedevance_fixe(double redevance_fixe) throws Exception {
         if (getMode().compareToIgnoreCase("modif") == 0) {

            if ( redevance_fixe < 0) {

                throw new Exception("redevance_fixe invalide");
            }
        }
        this.redevance_fixe = redevance_fixe;
    }

    public double getRedevance_variable() {
        return redevance_variable;
    }

    public void setRedevance_variable(double redevance_variable) throws Exception {
         if (getMode().compareToIgnoreCase("modif") == 0) {

            if ( redevance_variable < 0) {

                throw new Exception("redevance_variable invalide");
            }
        }
        this.redevance_variable = redevance_variable;
    }

    public double getDroit_port() {
        return droit_port;
    }

    public void setDroit_port(double droit_port) throws Exception {
          if (getMode().compareToIgnoreCase("modif") == 0) {

            if ( droit_port < 0) {

                throw new Exception("droit_port invalide");
            }
        }
        this.droit_port = droit_port;
    }
    
    
    
    @Override
    public String getTuppleID() {
     return this.id;}

    @Override
    public String getAttributIDName() {
         return "id";
    }
    
    public void construirePK(Connection c) throws Exception {
         this.preparePk("CTR", "getseq_contrat");
        this.setId(makePK(c));
        
    }
    
}
