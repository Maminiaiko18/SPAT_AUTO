/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ordremission;

import bean.ClassEtat;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.Utilitaire;

/**
 *
 * @author Valiah Karen
 */
public class RetourOM extends ClassEtat{
    private String id, idom, heurearrivee ,autres ;
    private Date datearrivee;
    private int nombres;
    private double prixunitaire , dureereelle ;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdom() {
        return idom;
    }

    public void setIdom(String idom) {
        this.idom = idom;
    }

    public String getHeurearrivee() {
        return heurearrivee;
    }

    public void setHeurearrivee(String heurearrivee) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            Utilitaire.testHeureValide(heurearrivee);
        }
        this.heurearrivee = heurearrivee;
    }

    public String getAutres() {
        return autres;
    }

    public void setAutres(String autres) {
        this.autres = autres;
    }

    public Date getDatearrivee() {
        return datearrivee;
    }

    public void setDatearrivee(Date datearrivee) {
        this.datearrivee = datearrivee;
    }

    public int getNombres() {
        return nombres;
    }

    public void setNombres(int nombres) {
        this.nombres = nombres;
    }

    public double getPrixunitaire() {
        return prixunitaire;
    }

    public void setPrixunitaire(double prixunitaire) {
        this.prixunitaire = prixunitaire;
    }

    public double getDureereelle() {
        return dureereelle;
    }

    public void setDureereelle(double dureereelle) {
        this.dureereelle = dureereelle;
    }

    
    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("ROM", "getseqretour_om");
        this.setId(makePK(c));
    }

    public RetourOM() {
        super.setNomTable("RETOUR_OM");
    }
    
    @Override
    public Object validerObject(String u, Connection c) throws Exception {
        try{
            OrdreMission om = new OrdreMission();
            OrdreMission ordremission = (OrdreMission)om.getById(this.getIdom(), "ordre_mission", c);
            double dureereelle = Utilitaire.getDiffJour(ordremission.getDatedepart(), this.getDatearrivee());
            int heure = Integer.parseInt(this.getHeurearrivee().substring(0, 2));
            if(heure < 12)
                dureereelle -= 0.5;
            this.setDureereelle(dureereelle);
            return super.validerObject(u, c);
        }
        catch(Exception e){
            throw e;
        }
    }
}
