/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture.tr;

import bean.ClassEtat;
import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author Rado
 */
public class Escompte extends Traite {
    String id, idTraite;
    double frais;
    Date daty;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public String getIdTraite() {
        return idTraite;
    }

    public void setIdTraite(String idTraite) {
        this.idTraite = idTraite;
    }

    public double getFrais() {
        return frais;
    }

    public void setFrais(double frais) {
        this.frais = frais;
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public Escompte() {
        this.setNomTable("escompte");
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("ES", "getseqescompte");
        this.setId(makePK(c));
    }

}
