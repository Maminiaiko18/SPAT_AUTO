/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author Nouta
 */
public class ProformaMere extends FactureClient{
    private Date dateDepart,dateArrivee;
    private  String heureDepart,heureArrivee,bateau;
    public ProformaMere() {
        super.setNomTable("proforma_mere");
    }

    public Date getDateDepart() {
        return dateDepart;
    }

    public void setDateDepart(Date dateDepart) {
        this.dateDepart = dateDepart;
    }

    public Date getDateArrivee() {
        return dateArrivee;
    }

    public void setDateArrivee(Date dateArrivee) {
        this.dateArrivee = dateArrivee;
    }

    public String getHeureDepart() {
        return heureDepart;
    }

    public void setHeureDepart(String heureDepart) {
        this.heureDepart = heureDepart;
    }

    public String getHeureArrivee() {
        return heureArrivee;
    }

    public void setHeureArrivee(String heureArrivee) {
        this.heureArrivee = heureArrivee;
    }

    public String getBateau() {
        return bateau;
    }

    public void setBateau(String bateau) {
        this.bateau = bateau;
    }
    

    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("CR","GETSEQ_PROFORMA_MERE");
        setId(makePK(c));
    }

    
    
}
