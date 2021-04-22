package mg.amadia.facture;

import java.util.ArrayList;

public class FactureClientReport {

    private String client, daty, id, medecin, numFacture, adresse;
    private ArrayList<DetailsFactureSubReport> listeDetails;    
    double montantTotal;

    public double getMontantTotal() {
        return montantTotal;
    }

    public void setMontantTotal(double montantTotal) {
        this.montantTotal = montantTotal;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public String getClient() {
        return client;
    }

    public void setClient(String client) {
        this.client = client;
    }

    public String getDaty() {
        return daty;
    }

    public void setDaty(String daty) {
        this.daty = daty;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getMedecin() {
        return medecin;
    }

    public void setMedecin(String medecin) {
        this.medecin = medecin;
    }


    public String getNumFacture() {
        return numFacture;
    }

    public void setNumFacture(String numFacture) {
        this.numFacture = numFacture;
    }

    public ArrayList<DetailsFactureSubReport> getListeDetails() {
        return listeDetails;
    }

    public void setListeDetails(ArrayList<DetailsFactureSubReport> listeDetails) {
        this.listeDetails = listeDetails;
    }
    
    
}
