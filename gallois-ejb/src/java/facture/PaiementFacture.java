/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.ClassMAPTable;

public class PaiementFacture extends ClassMAPTable{
    private String id;
    private String idMvt;
    private String idFact;
    private double montant;

    public PaiementFacture() {
        this.setNomTable("paiementFacture");
    }

    public PaiementFacture(String id, String idMvt, String idFact, double montant) {
        this.id = id;
        this.idMvt = idMvt;
        this.idFact = idFact;
        this.montant = montant;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdMvt() {
        return idMvt;
    }

    public void setIdMvt(String idMvt) {
        this.idMvt = idMvt;
    }

    public String getIdFact() {
        return idFact;
    }

    public void setIdFact(String idFact) {
        this.idFact = idFact;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }
    
    @Override
    public String getTuppleID() {return id;}

    @Override
    public String getAttributIDName() {return "id";}

    
}
