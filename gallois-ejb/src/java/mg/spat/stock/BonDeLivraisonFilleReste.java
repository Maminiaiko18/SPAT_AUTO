/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.stock;

/**
 *
 * @author rasol
 */
public class BonDeLivraisonFilleReste extends BonDeLivraisonFille{
    private double pu, quantiteReste,tva,montantHT,montantTva,remise,taux ;

    public double getTaux() {
        return taux;
    }

    public void setTaux(double taux) {
        this.taux = taux;
    }

    public String getDevise() {
        return devise;
    }

    public void setDevise(String devise) {
        this.devise = devise;
    }
    private String nomtiers,idtiers;
    private String projet,projetlib, code_etablissement,code_etablissementlib;
    private String idbondecommandemere,devise;

    public String getIdbondecommandemere() {
        return idbondecommandemere;
    }

    public void setIdbondecommandemere(String idbondecommandemere) {
        this.idbondecommandemere = idbondecommandemere;
    }
    

    public BonDeLivraisonFilleReste() {
        this.setNomTable("BonDeLivraisonFilleReste");
    }

    public double getRemise() {
        return remise;
    }

    public void setRemise(double remise) {
        this.remise = remise;
    }
    
    public String getProjet() {
        return projet;
    }

    public void setProjet(String projet) {
        this.projet = projet;
    }

    public String getProjetlib() {
        return projetlib;
    }

    public void setProjetlib(String projetlib) {
        this.projetlib = projetlib;
    }

    public String getCode_etablissement() {
        return code_etablissement;
    }

    public void setCode_etablissement(String code_etablissement) {
        this.code_etablissement = code_etablissement;
    }

    public String getCode_etablissementlib() {
        return code_etablissementlib;
    }

    public void setCode_etablissementlib(String code_etablissementlib) {
        this.code_etablissementlib = code_etablissementlib;
    }

    public double getMontantHT() {
        return montantHT;
    }

    public void setMontantHT(double montantHT) {
        this.montantHT = montantHT;
    }

    public double getMontantTva() {
        return montantTva;
    }

    public void setMontantTva(double montantTva) {
        this.montantTva = montantTva;
    }

    public double getTva() {
        return tva;
    }

    public void setTva(double tva) {
        this.tva = tva;
    }


    public double getPu() {
        return pu;
    }

    public void setPu(double pu) {
        this.pu = pu;
    }

    public double getQuantiteReste() {
        return quantiteReste;
    }

    public void setQuantiteReste(double qteReste) {
        this.quantiteReste = qteReste;
    }

    public String getNomtiers() {
        return nomtiers;
    }

    public void setNomtiers(String nomtiers) {
        this.nomtiers = nomtiers;
    }

    public String getIdtiers() {
        return idtiers;
    }

    public void setIdtiers(String idtiers) {
        this.idtiers = idtiers;
    }

}
