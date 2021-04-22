/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package historique;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author rasol
 */
public class HistoriqueContrat extends ClassMAPTable{
    private String id, idcontrat;
    private Date daty;
    private double montant;

    public HistoriqueContrat() {
        this.setNomTable("historique_contrat");
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("HC", "GET_SEQ_HISTORIQUE_CONTRAT");
        this.setId(makePK(c));
    }

    public HistoriqueContrat(String idcontrat, Date daty, double montant) {
        this.setNomTable("historique_contrat");
        this.setIdcontrat(idcontrat);
        this.setDaty(daty);
        this.setMontant(montant);
    }
    
    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdcontrat() {
        return idcontrat;
    }

    public void setIdcontrat(String idcontrat) {
        this.idcontrat = idcontrat;
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
