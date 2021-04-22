/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.relationhumaine;

import bean.ClassMAPTable;
import java.sql.Date;

/**
 *
 * @author MEVA
 */
public class MouvementEffectif extends ClassMAPTable{
    private String idhisto,matricule,motif;
    private int matricule_interne;
    private Date debut_fct;

    public MouvementEffectif() {
        super.setNomTable("mvt_effectif");
    }

    public String getIdhisto() {
        return idhisto;
    }

    public void setIdhisto(String idhisto) {
        this.idhisto = idhisto;
    }

    public String getMatricule() {
        return matricule;
    }

    public void setMatricule(String matricule) {
        this.matricule = matricule;
    }

    public String getMotif() {
        return motif;
    }

    public void setMotif(String motif) {
        this.motif = motif;
    }

    public int getMatricule_interne() {
        return matricule_interne;
    }

    public void setMatricule_interne(int matricule_interne) {
        this.matricule_interne = matricule_interne;
    }

    public Date getDebut_fct() {
        return debut_fct;
    }

    public void setDebut_fct(Date debut_fct) {
        this.debut_fct = debut_fct;
    }
    
    
    @Override
    public String getTuppleID() {
        return this.idhisto;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
}
