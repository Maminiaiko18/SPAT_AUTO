/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.allosakafo.fin;

/**
 *
 * @author tahina
 */
public class OrdreDePaiementLettre extends OrdreDePaiement {
    public OrdreDePaiementLettre()
    {
        this.setNomTable("ordonnerPayementLettre");
    }
    
    public String getEtatL() {
        return etatL;
    }

    public void setEtatL(String etatLettre) {
        this.etatL = etatLettre;
    }

    public String getTiers() {
        return tiers;
    }

    public void setTiers(String tiers) {
        this.tiers = tiers;
    }
    String etatL;
    String tiers;
    
}
