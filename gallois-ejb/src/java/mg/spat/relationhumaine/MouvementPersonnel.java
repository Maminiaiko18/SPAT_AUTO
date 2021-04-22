/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.relationhumaine;

/**
 *
 * @author MEVA
 */
public class MouvementPersonnel {

    public MouvementPersonnel(String motif, int mois_anterieur, int mois_encours, int cumul) throws Exception {
        this.setMotif(motif);
        this.setMois_anterieur(mois_anterieur);
        this.setMois_encours(mois_encours);
        this.setCumul(cumul);
    }
    private String motif;
    private int mois_anterieur, mois_encours,cumul,prevision;

    public MouvementPersonnel() {
    }

    public String getMotif() {
        return motif;
    }

    public void setMotif(String motif) {
        this.motif = motif;
    }

    public int getMois_anterieur() {
        return mois_anterieur;
    }

    public void setMois_anterieur(int mois_anterieur) throws Exception{
        if(mois_anterieur<0) throw new Exception("Nombre mois anterieur invalide");
        this.mois_anterieur = mois_anterieur;
    }

    public int getMois_encours() {
        return mois_encours;
    }

    public void setMois_encours(int mois_encours) throws Exception {
        if(mois_encours<0) throw new Exception("Nombre mois en cours invalide");
        this.mois_encours = mois_encours;
    }

    public int getCumul() {
        return cumul;
    }

    public void setCumul(int cumul) {
        this.cumul = cumul;
    }

    public int getPrevision() {
        return prevision;
    }

    public void setPrevision(int prevision) {
        this.prevision = prevision;
    }
    
}
