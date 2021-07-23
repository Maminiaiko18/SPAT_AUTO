/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.ClassFille;

/**
 *
 * @author itokiana
 */
public class FactureClientDetailsGrouper  extends ClassFille {
    private String idRubrique;
    private String idmere;
    private String designationRubrique;
    private double quantite;
    private double pu;
    private double montant;
    
    public FactureClientDetailsGrouper(){
        this.setNomTable("facture_client_fille_gp");
    }
    public String getIdRubrique() {
        return idRubrique;
    }

    public void setIdRubrique(String idRubrique) {
        this.idRubrique = idRubrique;
    }

    public String getIdmere() {
        return idmere;
    }

    public void setIdmere(String idmere) {
        this.idmere = idmere;
    }

    public String getDesignationRubrique() {
        return designationRubrique;
    }

    public void setDesignationRubrique(String designationRubrique) {
        this.designationRubrique = designationRubrique;
    }

    public double getQuantite() {
        return quantite;
    }

    public void setQuantite(double quantite) {
        this.quantite = quantite;
    }


    public double getPu() {
        return pu;
    }

    public void setPu(double pu) {
        this.pu = pu;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    @Override
    public String getTuppleID() {
        return this.getIdRubrique();
    }

    @Override
    public String getAttributIDName() {
        return "idRubrique";
    }
    
    

}
