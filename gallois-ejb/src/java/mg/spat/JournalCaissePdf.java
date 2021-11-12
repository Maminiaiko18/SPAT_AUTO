/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import java.util.ArrayList;


public class JournalCaissePdf {
    private String numpiece, client, motif; 
    private ArrayList<JournalCaisse> jcaisse;
   
    
    
    public String getNumpiece() {
        return numpiece;
    }

    public void setNumpiece(String numpiece) {
        this.numpiece = numpiece;
    }

    public String getClient() {
        return client;
    }

    public void setClient(String client) {
        this.client = client;
    }

    public String getMotif() {
        return motif;
    }

    public void setMotif(String motif) {
        this.motif = motif;
    }

    public ArrayList<JournalCaisse> getJcaisse() {
        return jcaisse;
    }

    public void setJcaisse(ArrayList<JournalCaisse> jcaisse) {
        this.jcaisse = jcaisse;
    }

    
    
}
