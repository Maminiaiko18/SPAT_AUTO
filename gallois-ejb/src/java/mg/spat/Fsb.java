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
 * @author Nouta
 */
public class Fsb extends ClassMAPTable {
    private String codeetb,codeprojet,numfacture;
    private int annee;
    private Date daty;

    public Fsb() {
        super.setNomTable("ficheSuiviBudgetVide");
    }
    
    public String getCodeetb() {
        return codeetb;
    }

    public void setCodeetb(String codeetb) {
        this.codeetb = codeetb;
    }

    public String getCodeprojet() {
        return codeprojet;
    }

    public void setCodeprojet(String codeprojet) {
        this.codeprojet = codeprojet;
    }

    public String getNumfacture() {
        return numfacture;
    }

    public void setNumfacture(String numfacture) {
        this.numfacture = numfacture;
    }

    public int getAnnee() {
        return annee;
    }

    public void setAnnee(int annee) {
        this.annee = annee;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    @Override
    public String getTuppleID() {
        return codeetb;    
    }

    @Override
    public String getAttributIDName() {
        return "codeetb";
    }

   
    
    
}
