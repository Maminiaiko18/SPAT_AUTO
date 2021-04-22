/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

/**
 *
 * @author pro
 */
public class BonProvisoireRetourRegule extends BonProvisoire{
    
    private double regule;
    private double retour;

    public BonProvisoireRetourRegule() {
        super.setNomTable("BON_PROVISOIRE_REGULE_RETOUR");
    }
    
    public double getRegule() {
        return regule;
    }

    public void setRegule(double regule) {
        this.regule = regule;
    }

    public double getRetour() {
        return retour;
    }

    public void setRetour(double retour) {
        this.retour = retour;
    }
   
}
