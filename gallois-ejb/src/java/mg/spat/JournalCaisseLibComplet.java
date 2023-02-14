/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

/**
 *
 * @author nyamp
 */
public class JournalCaisseLibComplet extends JournalCaisse{
    private String tierslib,valcaisse, descecaisse, valtypecheque,descetypecheque,idfact,etatlib,typelib;
    private double montant;

    public String getTypelib() {
        return typelib;
    }

    public void setTypelib(String typelib) {
        this.typelib = typelib;
    }

    
    public String getIdfact() {
        return idfact;
    }

    public void setIdfact(String idfact) {
        this.idfact = idfact;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }
    
    public String getTierslib() {
        return tierslib;
    }

    public void setTierslib(String tierslib) {
        this.tierslib = tierslib;
    }
    
    public JournalCaisseLibComplet(){
        this.setNomTable("JOURNALCAISSELIBCOMPLET");
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

    public String getValtypecheque() {
        return valtypecheque;
    }

    public void setValtypecheque(String valtypecheque) {
        this.valtypecheque = valtypecheque;
    }

    public String getDescetypecheque() {
        return descetypecheque;
    }

    public void setDescetypecheque(String descetypecheque) {
        this.descetypecheque = descetypecheque;
    }

    public String getEtatlib() {
        return etatlib;
    }

    public void setEtatlib(String etatlib) {
        this.etatlib = etatlib;
    }
    
}
