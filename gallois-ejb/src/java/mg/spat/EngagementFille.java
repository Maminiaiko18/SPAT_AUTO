/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author Nouta
 */
public class EngagementFille extends ClassMAPTable{
    private String id,idmere,designation;
    private double montant;

    public EngagementFille() {
        super.setNomTable("engagement_fille");
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdmere() {
        return idmere;
    }

    public void setIdmere(String idmere) {
        this.idmere = idmere;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) throws Exception {
        if(designation == null || designation.trim().isEmpty())
        {
            throw new Exception("Désignation obligatoire");
        }
        this.designation = designation;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) throws Exception {
        if(montant < 0)
        {
            throw new Exception("montant négatif");
        }
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
    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("CR","GETSEQENGAGEMENT_FILLE");
        setId(makePK(c));
    }
    
}
