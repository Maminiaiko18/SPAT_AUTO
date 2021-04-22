/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

/**
 *
 * @author Sanda
 */
public class PrevisionMaterielNavalLibComplet extends PrevisionMaterielNaval{
   private String denomination,valcommandant,valnatureoperation;
    
    public PrevisionMaterielNavalLibComplet(){
        super.setNomTable("PREVISION_MAT_NAVAL_LIBcomplet");
    }

    public String getDenomination() {
        return denomination;
    }

    public void setDenomination(String denomination) {
        this.denomination = denomination;
    }

    public String getValcommandant() {
        return valcommandant;
    }

    public void setValcommandant(String valcommandant) {
        this.valcommandant = valcommandant;
    }

    public String getValnatureoperation() {
        return valnatureoperation;
    }

    public void setValnatureoperation(String valnatureoperation) {
        this.valnatureoperation = valnatureoperation;
    }
    
}
