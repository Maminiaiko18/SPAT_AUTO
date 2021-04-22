/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.stock;

/**
 *
 * @author andya
 */
public class BonDeCommandeLibelle extends BonDeCommande{
    String fournisseurlibelle,projetlibelle,code_etablibelle;

    public BonDeCommandeLibelle() {
        this.setNomTable("AS_BONDECOMMANDE_LIBCOMPLET");
    }

    
    public String getFournisseurlibelle() {
        return fournisseurlibelle;
    }

    public void setFournisseurlibelle(String fournisseurlibelle) {
        this.fournisseurlibelle = fournisseurlibelle;
    }

    public String getProjetlibelle() {
        return projetlibelle;
    }

    public void setProjetlibelle(String projetlibelle) {
        this.projetlibelle = projetlibelle;
    }

    public String getCode_etablibelle() {
        return code_etablibelle;
    }

    public void setCode_etablibelle(String code_etablibelle) {
        this.code_etablibelle = code_etablibelle;
    }
}
