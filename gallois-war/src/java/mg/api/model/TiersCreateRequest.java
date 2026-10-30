package mg.port.api.model;

public class TiersCreateRequest {

    private String nom;
    private String description;
    private String nif;
    private String stat;
    private String contact;
    private String responsable;
    private String adresse;
    private String type;
    private String compteAuxFournisseur;
    private String compteAuxClient;
    private String cin;
    private String cp;
    private Boolean verificationJustificatifs;

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getNif() {
        return nif;
    }

    public void setNif(String nif) {
        this.nif = nif;
    }

    public String getStat() {
        return stat;
    }

    public void setStat(String stat) {
        this.stat = stat;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getResponsable() {
        return responsable;
    }

    public void setResponsable(String responsable) {
        this.responsable = responsable;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getCompteAuxFournisseur() {
        return compteAuxFournisseur;
    }

    public void setCompteAuxFournisseur(String compteAuxFournisseur) {
        this.compteAuxFournisseur = compteAuxFournisseur;
    }

    public String getCompteAuxClient() {
        return compteAuxClient;
    }

    public void setCompteAuxClient(String compteAuxClient) {
        this.compteAuxClient = compteAuxClient;
    }

    public String getCin() {
        return cin;
    }

    public void setCin(String cin) {
        this.cin = cin;
    }

    public String getCp() {
        return cp;
    }

    public void setCp(String cp) {
        this.cp = cp;
    }

    public Boolean getVerificationJustificatifs() {
        return verificationJustificatifs;
    }

    public void setVerificationJustificatifs(Boolean verificationJustificatifs) {
        this.verificationJustificatifs = verificationJustificatifs;
    }
}
