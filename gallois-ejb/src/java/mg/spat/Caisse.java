/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.CGenUtil;
import bean.ClassMAPTable;
import bean.TypeObjet;
import service.ClotureService;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

import java.sql.Connection;
import java.sql.SQLException;

/**
 *
 * @author Asus
 */
public class Caisse extends TypeObjet{
    
    private String numero;
    private int rangsitcptcrt,placesitcptcrt;


    public Caisse() {
        super.setNomTable("Caisse");
    }

    public Caisse(String id, String val, String desce, String numero) {
        super.setNomTable("Caisse");
        this.setId(id);
        this.setVal(val);
        this.setDesce(desce);
        this.setNumero(numero);
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public int getRangsitcptcrt() {
        return rangsitcptcrt;
    }

    public void setRangsitcptcrt(int rangsitcptcrt) {
        this.rangsitcptcrt = rangsitcptcrt;
    }

    public int getPlacesitcptcrt() {
        return placesitcptcrt;
    }

    public void setPlacesitcptcrt(int placesitcptcrt) {
        this.placesitcptcrt = placesitcptcrt;
    }
    
    

    @Override
    public String getTuppleID() {
    return id;
    }

    @Override
    public String getAttributIDName() {
    return "id";
    }
    
     public void construirePK(Connection c) throws Exception {
        this.preparePk("CAI", "getseqcaisse");
        this.setId(makePK(c));

    }

    public void cloturerCaisse(String u,String date, String remarque) throws Exception{
        int verif = 0;
        Connection c = null;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            Cloture[] liste = (Cloture[]) CGenUtil.rechercher(new Cloture(), null, null, c, " and daty >=to_date('"+ Utilitaire.stringDate(date) +"','YYYY-MM-DD') and caisse='"+this.getId()+"'");
            if(liste.length >0 ) throw new Exception("Caisse "+ this.getId() +" déjà cloture a ce date");
            Cloture clo = new Cloture();
            clo.setDaty(Utilitaire.stringDate(date));
            clo.setCaisse(this.getId());
            clo.setRemarque(remarque);
            double mtt = ClotureService.getSoldeFarany(clo.getDaty(), clo.getCaisse(),c );
            clo.setSolde(mtt);
            clo.createObject(u, c);
        } catch (Exception e) {
            if (c != null && verif == 1) {
                c.rollback();
            }
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    public boolean isBanque(Connection c) throws Exception {
        Caisse caisse = new Caisse();
        caisse.setId(this.getId());
        caisse.setNomTable(this.getNomTable());
        caisse =  (Caisse) caisse.getById(caisse.getId(), caisse.getNomTable(), c);
        if(caisse.getDesce().compareToIgnoreCase("banque")==0) return true;
        return false;
    }
}
