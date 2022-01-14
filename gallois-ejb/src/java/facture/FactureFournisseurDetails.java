/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.CGenUtil;
import bean.ClassMere;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.ConstanteEtat;
import utilitaire.Utilitaire;

/**
 *
 * @author rijan
 */
public class FactureFournisseurDetails extends FactureClientDetails{
    
   
    
    public FactureFournisseurDetails() throws Exception{ 
        this.setNomTable("facture_fournisseur_fille");
        this.setNomClasseMere("facture.FactureFournisseur");
        this.setLiaisonMere("idmere");
    }

    public FactureFournisseurDetails(String id, String idmere, String designation, String compte, String idproduit, String devise, String idactivite, String rubrique, String heureDebut, String heureFin, double quantite, double pu, double taux, double tva, double reduction, double majoration, double test, Date datefact, int mois, int annee) throws Exception{
        this.setNomTable("facture_fournisseur_fille");
        this.setId(id);
        this.setIdmere(idmere);
        this.setDesignation(designation);
        this.setCompte(compte);
        this.setIdproduit(idproduit);
        this.setDevise(devise);
        this.setIdactivite(idactivite);
        this.setRubrique(rubrique);
        this.setHeureDebut(heureDebut);
        this.setHeureFin(heureFin);
        this.setQuantite(quantite);
        this.setPu(pu);
        this.setTaux(taux);
        this.setTva(tva);
        this.setReduction(reduction);
        this.setMajoration(majoration);
        
        this.setDatefact(datefact);
        this.setMois(mois);
        this.setAnnee(annee);
    }
    
    
    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("FFD", "get_seq_factFournFille");
        this.setId(makePK(c));
    }

    public FactureFournisseur findMere(Connection c) throws Exception {
        if(this.getMere() == null) {
            FactureFournisseur fc = new FactureFournisseur();
            fc.setNomTable("facture_Fournisseur_Mere");
            fc.setId(this.getIdmere());
            fc.setEstDDPMICTSL(null);
            FactureFournisseur[] tmp = (FactureFournisseur[]) CGenUtil.rechercher(fc, null, null, c, "");
            
            if(tmp != null && tmp.length > 0) { 
                this.setMere(tmp[0]);
                return tmp[0];
            }
        }
        
        return this.getMere();
    }
    @Override
    public FactureFournisseur getMere() {
        return (FactureFournisseur) super.getMere();
    }

    public void controlerUpdate(Connection c) throws Exception {
        FactureClient m=findMere(c);
        if(m.getEtat()>=ConstanteEtat.getEtatValider()) throw new Exception("Objet mere deja valide");
    }
    
     @Override
    public String getValColLibelle() {
        return getLibDesignation()+";"+getLibDesignation()+";"+getDevise();
    }
    String idBLF;

    public String getIdBLF() {
        return idBLF;
    }

    public void setIdBLF(String idBLF) {
        this.idBLF = idBLF;
    }

    public FactureFournisseurDetails(String idmere, double quantite, double pu, String compte, String designation, double duree) throws Exception {
        setNomTable("facture_fournisseur_fille");
        this.setNomClasseMere("facture.FactureFournisseur");
        this.setLiaisonMere("idmere");
        this.setIdmere(idmere);
        this.setQuantite(quantite);
        this.setPu(pu);
        this.setCompte(compte);
        this.setDesignation(designation);
        this.setDuree(duree);
    }
}