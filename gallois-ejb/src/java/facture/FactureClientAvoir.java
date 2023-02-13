/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package facture;

import bean.ClassMAPTable;

/**
 *
 * @author Heriniaina
 */
public class FactureClientAvoir extends ClassMAPTable{
    String id;
    String idfc;
    String idavoir;
    double montant;

    public FactureClientAvoir(String id, String idfc, String idavoir, double montant) {
        this.id = id;
        this.idfc = idfc;
        this.idavoir = idavoir;
        this.montant = montant;
        this.setNomTable("FactureClientAvoir");
    }

    public FactureClientAvoir() {
        this.setNomTable("FactureClientAvoir");
    }

    
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdfc() {
        return idfc;
    }

    public void setIdfc(String idfc) {
        this.idfc = idfc;
    }

    public String getIdavoir() {
        return idavoir;
    }

    public void setIdavoir(String idavoir) {
        this.idavoir = idavoir;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }
    
    

    
    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
}
