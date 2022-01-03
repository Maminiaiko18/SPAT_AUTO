/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fin;

import java.sql.Date;
import utilitaire.Utilitaire;

/**
 *
 * @author Asus
 */
public class CoursdevisePDF {
    String daty;
    String iddevise;
    String montant;

    public CoursdevisePDF(Date daty, String iddevise, double montant) {
        this.setDaty(Utilitaire.datetostring(daty));
        this.setIddevise(iddevise);
        this.setMontant(Utilitaire.formaterAr(montant));
    }

    public CoursdevisePDF() {
    }

    public String getDaty() {
        return daty;
    }

    public void setDaty(String daty) {
        this.daty = daty;
    }

    public String getIddevise() {
        return iddevise;
    }

    public void setIddevise(String iddevise) {
        this.iddevise = iddevise;
    }

    public String getMontant() {
        return montant;
    }

    public void setMontant(String montant) {
        this.montant = montant;
    }
    
}
