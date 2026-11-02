package mg.port.api.model;

import java.util.List;

public class DaseCreateRequest {
    private String daty;
    private String codeetablissement;
    private String projet;
    private String designation;
    private String idcategorieachat;
    private String patrimoine;
    private List<Ligne> lignes;

    public String getDaty() {
        return daty;
    }

    public void setDaty(String daty) {
        this.daty = daty;
    }

    public String getCodeetablissement() {
        return codeetablissement;
    }

    public void setCodeetablissement(String codeetablissement) {
        this.codeetablissement = codeetablissement;
    }

    public String getProjet() {
        return projet;
    }

    public void setProjet(String projet) {
        this.projet = projet;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getIdcategorieachat() {
        return idcategorieachat;
    }

    public void setIdcategorieachat(String idcategorieachat) {
        this.idcategorieachat = idcategorieachat;
    }

    public String getPatrimoine() {
        return patrimoine;
    }

    public void setPatrimoine(String patrimoine) {
        this.patrimoine = patrimoine;
    }

    public List<Ligne> getLignes() {
        return lignes;
    }

    public void setLignes(List<Ligne> lignes) {
        this.lignes = lignes;
    }

    public static class Ligne {
        private String produit;
        private String designation;
        private String unite;
        private Double qte;
        private Double pu;
        private String remarque;

        public String getProduit() {
            return produit;
        }

        public void setProduit(String produit) {
            this.produit = produit;
        }

        public String getDesignation() {
            return designation;
        }

        public void setDesignation(String designation) {
            this.designation = designation;
        }

        public String getUnite() {
            return unite;
        }

        public void setUnite(String unite) {
            this.unite = unite;
        }

        public Double getQte() {
            return qte;
        }

        public void setQte(Double qte) {
            this.qte = qte;
        }

        public Double getPu() {
            return pu;
        }

        public void setPu(Double pu) {
            this.pu = pu;
        }

        public String getRemarque() {
            return remarque;
        }

        public void setRemarque(String remarque) {
            this.remarque = remarque;
        }
    }
}