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
 * @author JESSI
 */
public class Bilan extends ClassMAPTable{
    private String id,rubrique,typeBilan;
    private double montant,total;

    public Bilan(String id, String rubrique, String typeBilan, double montant, double total)throws Exception {
        this.setNomTable("bilan");
        this.setId(id);
        this.setRubrique(rubrique);
        this.setTypeBilan(typeBilan);
        this.setMontant(montant);
        this.setTotal(total);
    }

    public Bilan() {
        this.setNomTable("bilan");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getRubrique() {
        return rubrique;
    }

    public void setRubrique(String rubrique) {
        this.rubrique = rubrique;
    }

    public String getTypeBilan() {
        return typeBilan;
    }

    public void setTypeBilan(String typeBilan) {
        this.typeBilan = typeBilan;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant)throws Exception {
         if (getMode().compareToIgnoreCase("modif") == 0) {
            if (montant < 0) {
                throw new Exception("montant invalide");
            }
        }
        this.montant = montant;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total)throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (total < 0) {
                throw new Exception("total invalide");
            }
        }
        this.total = total;
    }
    @Override
    public String getTuppleID() {
       return id;
    }

    @Override
    public String getAttributIDName() {
      return "id";
    }
    
      public void construirePK(Connection c) throws Exception {
        this.preparePk("BIL", "getseqbilan");
        this.setId(makePK(c));
    }
    
}
