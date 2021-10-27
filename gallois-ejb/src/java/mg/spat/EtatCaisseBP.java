/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassMAPTable;

public class EtatCaisseBP extends ClassMAPTable{
    private double montant;
    private String idCategorie;
    
    public EtatCaisseBP(){
        this.setNomTable("ETATCAISSEBP");
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public String getIdCategorie() {
        return idCategorie;
    }

    public void setIdCategorie(String idCategorie) {
        this.idCategorie = idCategorie;
    }
    
    

    @Override
    public String getTuppleID() {
       return this.idCategorie;
    }

    @Override
    public String getAttributIDName() {
        return "idcategorie";
    }
    
}
