/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassMAPTable;
import java.sql.Connection;
/**
 *
 * @author Notiavina
 */
public class DetailsBilletage extends ClassMAPTable{
    private String id, idmere, billet;
    private int nombre;
    private double montant;
    
    public DetailsBilletage(){
        super.setNomTable("detailsbilletage");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdmere() {
        return idmere;
    }

    public void setIdmere(String idmere) {
        this.idmere = idmere;
    }

    public String getBillet() {
        return billet;
    }

    public void setBillet(String billet) {
        this.billet = billet;
    }

    public int getNombre() {
        return nombre;
    }

    public void setNombre(int nombre)throws Exception{
        if(this.getMode().equals("modif") && nombre<0)
            throw new Exception("Nombre invalide");
        this.nombre = nombre;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }
    
    public void construirePK(Connection c) throws Exception {
        this.preparePk("DTS", "getseqdetailsbilletage");
        this.setId(makePK(c));
    }
    
    public String getTuppleID() {
        return id;
    }

    public String getAttributIDName() {
        return "id";
    }
}
