/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassMAPTable;
import java.sql.Date;

/**
 *
 * @author john
 */
public class RecapTreso extends ClassMAPTable {
    private String libelle,numero_compte;
    private Date daty;
    private double montant;

    public String getNumero_compte() {
        return numero_compte;
    }

    public void setNumero_compte(String numero_compte) {
        this.numero_compte = numero_compte;
    }
    public RecapTreso(){
        super.setNomTable("recap_treso");
    }
    public String getTuppleID() {
        return "libelle";
    }

    public String getAttributIDName() {
        return "libelle";
    }

    public RecapTreso(String libelle, Date daty, double montant) {
        this.setLibelle(libelle);
        this.setDaty(daty);
        this.setMontant(montant);
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }
    
}
