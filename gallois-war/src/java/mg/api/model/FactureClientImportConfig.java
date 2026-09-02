package mg.port.api.model;

import java.math.BigDecimal;

public class FactureClientImportConfig {

    private String cheminExcel;
    private FactureConfig facture;
    private DetailConfig detail;

    public String getCheminExcel() {
        return cheminExcel;
    }

    public void setCheminExcel(String cheminExcel) {
        this.cheminExcel = cheminExcel;
    }

    public FactureConfig getFacture() {
        return facture;
    }

    public void setFacture(FactureConfig facture) {
        this.facture = facture;
    }

    public DetailConfig getDetail() {
        return detail;
    }

    public void setDetail(DetailConfig detail) {
        this.detail = detail;
    }

    public static class FactureConfig {

        private String tiers;
        private String daty;
        private String designation;
        private String type;
        private BigDecimal tva;
        private String remarque;
        private String iduser;
        private String dateEcheance;
        private String dateDepart;
        private String dateArrivee;
        private Integer etat;
        private String devisemere;
        private String typeengagement;
        private Integer exercice;
        private Integer estauto;
        private Integer estancienne;
        private Integer estproformaescale;
        private Integer estSup2021;
        private String idcategorie;

        public String getTiers() {
            return tiers;
        }

        public void setTiers(String tiers) {
            this.tiers = tiers;
        }

        public String getDaty() {
            return daty;
        }

        public void setDaty(String daty) {
            this.daty = daty;
        }

        public String getDesignation() {
            return designation;
        }

        public void setDesignation(String designation) {
            this.designation = designation;
        }

        public String getType() {
            return type;
        }

        public void setType(String type) {
            this.type = type;
        }

        public BigDecimal getTva() {
            return tva;
        }

        public void setTva(BigDecimal tva) {
            this.tva = tva;
        }

        public String getRemarque() {
            return remarque;
        }

        public void setRemarque(String remarque) {
            this.remarque = remarque;
        }

        public String getIduser() {
            return iduser;
        }

        public void setIduser(String iduser) {
            this.iduser = iduser;
        }

        public String getDateEcheance() {
            return dateEcheance;
        }

        public void setDateEcheance(String dateEcheance) {
            this.dateEcheance = dateEcheance;
        }

        public String getDateDepart() {
            return dateDepart;
        }

        public void setDateDepart(String dateDepart) {
            this.dateDepart = dateDepart;
        }

        public String getDateArrivee() {
            return dateArrivee;
        }

        public void setDateArrivee(String dateArrivee) {
            this.dateArrivee = dateArrivee;
        }

        public Integer getEtat() {
            return etat;
        }

        public void setEtat(Integer etat) {
            this.etat = etat;
        }

        public String getDevisemere() {
            return devisemere;
        }

        public void setDevisemere(String devisemere) {
            this.devisemere = devisemere;
        }

        public String getTypeengagement() {
            return typeengagement;
        }

        public void setTypeengagement(String typeengagement) {
            this.typeengagement = typeengagement;
        }

        public Integer getExercice() {
            return exercice;
        }

        public void setExercice(Integer exercice) {
            this.exercice = exercice;
        }

        public Integer getEstauto() {
            return estauto;
        }

        public void setEstauto(Integer estauto) {
            this.estauto = estauto;
        }

        public Integer getEstancienne() {
            return estancienne;
        }

        public void setEstancienne(Integer estancienne) {
            this.estancienne = estancienne;
        }

        public Integer getEstproformaescale() {
            return estproformaescale;
        }

        public void setEstproformaescale(Integer estproformaescale) {
            this.estproformaescale = estproformaescale;
        }

        public Integer getEstSup2021() {
            return estSup2021;
        }

        public void setEstSup2021(Integer estSup2021) {
            this.estSup2021 = estSup2021;
        }

        public String getIdcategorie() {
            return idcategorie;
        }

        public void setIdcategorie(String idcategorie) {
            this.idcategorie = idcategorie;
        }
    }

    public static class DetailConfig {

        private String devise;
        private BigDecimal taux;
        private BigDecimal tva;
        private String datefact;
        private Integer mois;
        private Integer annee;
        private String daty;
        private String rubrique;
        private String compte;
        private BigDecimal duree;
        private Integer estproformaescale;

        public String getDevise() {
            return devise;
        }

        public void setDevise(String devise) {
            this.devise = devise;
        }

        public BigDecimal getTaux() {
            return taux;
        }

        public void setTaux(BigDecimal taux) {
            this.taux = taux;
        }

        public BigDecimal getTva() {
            return tva;
        }

        public void setTva(BigDecimal tva) {
            this.tva = tva;
        }

        public String getDatefact() {
            return datefact;
        }

        public void setDatefact(String datefact) {
            this.datefact = datefact;
        }

        public Integer getMois() {
            return mois;
        }

        public void setMois(Integer mois) {
            this.mois = mois;
        }

        public Integer getAnnee() {
            return annee;
        }

        public void setAnnee(Integer annee) {
            this.annee = annee;
        }

        public String getDaty() {
            return daty;
        }

        public void setDaty(String daty) {
            this.daty = daty;
        }

        public String getRubrique() {
            return rubrique;
        }

        public void setRubrique(String rubrique) {
            this.rubrique = rubrique;
        }

        public String getCompte() {
            return compte;
        }

        public void setCompte(String compte) {
            this.compte = compte;
        }

        public BigDecimal getDuree() {
            return duree;
        }

        public void setDuree(BigDecimal duree) {
            this.duree = duree;
        }

        public Integer getEstproformaescale() {
            return estproformaescale;
        }

        public void setEstproformaescale(Integer estproformaescale) {
            this.estproformaescale = estproformaescale;
        }
    }
}