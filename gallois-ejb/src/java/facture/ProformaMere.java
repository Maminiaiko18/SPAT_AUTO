/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.CGenUtil;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.Constante;
import utilitaire.UtilDB;

/**
 *
 * @author Nouta
 */
public class ProformaMere extends FactureClient{
    private Date dateDepart,dateArrivee;
    private  String heureDepart,heureArrivee,bateau,provenance,provenancelib,destination,destinationlib,bateaulib;
    
    public ProformaMere() throws Exception{
        super.setNomTable("proforma_mere");
    }

    public String getBateaulib() {
        return bateaulib;
    }

    public void setBateaulib(String bateaulib) {
        this.bateaulib = bateaulib;
    }
    
    public String getProvenance() {
        return provenance;
    }

    public void setProvenance(String provenance) {
        this.provenance = provenance;
    }

    public String getProvenancelib() {
        return provenancelib;
    }

    public void setProvenancelib(String provenancelib) {
        this.provenancelib = provenancelib;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public String getDestinationlib() {
        return destinationlib;
    }

    public void setDestinationlib(String destinationlib) {
        this.destinationlib = destinationlib;
    }
    
    public Date getDateDepart() {
        return dateDepart;
    }

    public void setDateDepart(Date dateDepart) {
        this.dateDepart = dateDepart;
    }

    public Date getDateArrivee() {
        return dateArrivee;
    }

    public void setDateArrivee(Date dateArrivee) {
        this.dateArrivee = dateArrivee;
    }

    public String getHeureDepart() {
        return heureDepart;
    }

    public void setHeureDepart(String heureDepart) {
        this.heureDepart = heureDepart;
    }

    public String getHeureArrivee() {
        return heureArrivee;
    }

    public void setHeureArrivee(String heureArrivee) {
        this.heureArrivee = heureArrivee;
    }

    public String getBateau() {
        return bateau;
    }

    public void setBateau(String bateau) {
        this.bateau = bateau;
    }
    

    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("CR","GETSEQ_PROFORMA_MERE");
        setId(makePK(c));
    }

    
    public void initDetails(Connection c) throws Exception {
        int verif = 0;

        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                verif = 1;
            }

            if (this.getListeDetails() == null) {
                ProformaFille fcd = new ProformaFille();
                fcd.setNomTable("proforma_montanttc");
                this.setListeDetails((ProformaFille[]) CGenUtil.rechercher(fcd, null, null, c, " and idmere = '" + this.getId() + "' order by rang asc, datyactivite asc"));
                if (this.getListeDetails() == null) {
                    throw new Exception("Aucun details pour la proforma " + this.getId());
                }
            }

            this.setDevises(c);

            for (int i = 0; i < this.getListeDetails().length; i++) {
                double montantHT = this.getListeDetails()[i].getMontant(), montantTVA = this.getListeDetails()[i].getMontanttaxe();
                String devise = this.getListeDetails()[i].getDevise();
                
                if (devise != null && devise.equalsIgnoreCase(Constante.deviseAr)) {
                    montantHT = montantHT / this.getDeviseEuro();
                    montantTVA = montantTVA / this.getDeviseEuro();
                }

                this.getListeDetails()[i].setMontantHTEuro(this.getListeDetails()[i].getMontantAvecMajRed(montantHT));
                this.getListeDetails()[i].setMontantTVAEuro(this.getListeDetails()[i].getMontantAvecMajRed(montantTVA));
            }

            this.setCoeff(this.getDeviseEuro()/this.getDeviseDollar());

        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    
    @Override
    public FactureClientDetails getFirstFille() throws Exception {
        ProformaFille fd = null;
        ProformaFille[] listeDetails = (ProformaFille[]) this.getListeDetails();
        if (listeDetails != null && listeDetails.length > 0) {
            fd = new ProformaFille(listeDetails[0].getId(), listeDetails[0].getIdmere(), listeDetails[0].getQuantite(), listeDetails[0].getPu(), listeDetails[0].getTaux(), listeDetails[0].getCompte(), listeDetails[0].getIdproduit(), listeDetails[0].getProduit_lib(), listeDetails[0].getDevise(), listeDetails[0].getDesignation(), listeDetails[0].getIdProduitLib(), listeDetails[0].getIdactivite(), listeDetails[0].getCategorieFacturelib(), listeDetails[0].getCategorieClientlib(), listeDetails[0].getActivitelib(), listeDetails[0].getRubrique(), listeDetails[0].getMere(), listeDetails[0].getMontant(), listeDetails[0].getMontanttaux(), listeDetails[0].getMontantavoirsanstaux(), listeDetails[0].getMontantavoiravectaux(), listeDetails[0].getQtelivree(), listeDetails[0].getRestealivrer(), listeDetails[0].getDatefact(), listeDetails[0].getRubriquelib(), listeDetails[0].getIdprestation(), listeDetails[0].getClientlib(), listeDetails[0].getMois(), listeDetails[0].getAnnee(), listeDetails[0].getHeureDebut(), listeDetails[0].getHeureFin(), listeDetails[0].getMoislib(), listeDetails[0].getAnneelib(), listeDetails[0].getMontantHTEuro(), listeDetails[0].getMontantTVAEuro(), listeDetails[0].getMontanttaxe(), listeDetails[0].getMajoration(), listeDetails[0].getReduction(), listeDetails[0].getTva());
            fd.setRubrique(listeDetails[0].getRubrique());
        }
        fd.setMere(this);
        return fd; 
    }
    
//    public ProformaFille[] getListeDetails() {
//        return listeDetails;
//    }
//
//    public void setListeDetails(ProformaFille[] listeDetails) {
//        this.listeDetails = listeDetails;
//    }
//    public FactureClientDetails getFirstFille() throws Exception {
//        FactureClientDetails fd = null;
//        if (listeDetails != null && listeDetails.length > 0) {
//            fd = new FactureClientDetails(listeDetails[0].getId(), listeDetails[0].getIdmere(), listeDetails[0].getQuantite(), listeDetails[0].getPu(), listeDetails[0].getTaux(), listeDetails[0].getCompte(), listeDetails[0].getIdproduit(), listeDetails[0].getProduit_lib(), listeDetails[0].getDevise(), listeDetails[0].getDesignation(), listeDetails[0].getIdProduitLib(), listeDetails[0].getIdactivite(), listeDetails[0].getCategorieFacturelib(), listeDetails[0].getCategorieClientlib(), listeDetails[0].getActivitelib(), listeDetails[0].getRubrique(), listeDetails[0].getMere(), listeDetails[0].getMontant(), listeDetails[0].getMontanttaux(), listeDetails[0].getMontantavoirsanstaux(), listeDetails[0].getMontantavoiravectaux(), listeDetails[0].getQtelivree(), listeDetails[0].getRestealivrer(), listeDetails[0].getDatefact(), listeDetails[0].getRubriquelib(), listeDetails[0].getIdprestation(), listeDetails[0].getClientlib(), listeDetails[0].getMois(), listeDetails[0].getAnnee(), listeDetails[0].getHeureDebut(), listeDetails[0].getHeureFin(), listeDetails[0].getMoislib(), listeDetails[0].getAnneelib(), listeDetails[0].getMontantHTEuro(), listeDetails[0].getMontantTVAEuro(), listeDetails[0].getMontanttaxe(), listeDetails[0].getMajoration(), listeDetails[0].getReduction(), listeDetails[0].getTva());
//            fd.setRubrique(listeDetails[0].getRubrique());
//        }
//        fd.setMere(this);
//        return fd;
//    }
//    
}
