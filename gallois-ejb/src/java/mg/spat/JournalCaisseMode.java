/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

/**
 *
 * @author mihary
 */
public class JournalCaisseMode  extends JournalCaisse{

    private String idmode,numcheque,valmode,type;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getIdmode() {
        return idmode;
    }

    public void setIdmode(String idmode) {
        this.idmode = idmode;
    }

    public String getNumcheque() {
        return numcheque;
    }

    public void setNumcheque(String numcheque) {
        this.numcheque = numcheque;
    }

    public String getValmode() {
        return valmode;
    }

    public void setValmode(String valmode) {
        this.valmode = valmode;
    }
    
    public JournalCaisseMode() {
        this.setNomTable("JOURNALCAISSE_BANQUE");
    }
    
}
