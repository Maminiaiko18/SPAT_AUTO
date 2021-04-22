/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

/**
 *
 * @author JESSI
 */
public class BonProvisoireComplet extends BonProvisoire{
    private String valcaisse,descecaisse,beneficiairelib;

    public BonProvisoireComplet() {
        this.setNomTable("bon_provisoire_libcomplet");
    }

    public String getValcaisse() {
        return valcaisse;
    }

    public void setValcaisse(String valcaisse) {
        this.valcaisse = valcaisse;
    }

    public String getDescecaisse() {
        return descecaisse;
    }

    public void setDescecaisse(String descecaisse) {
        this.descecaisse = descecaisse;
    }

    public String getBeneficiairelib() {
        return beneficiairelib;
    }

    public void setBeneficiairelib(String beneficiairelib) {
        this.beneficiairelib = beneficiairelib;
    }
    
    
}
