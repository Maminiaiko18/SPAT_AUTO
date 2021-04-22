/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilitaire;

import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author Jetta
 */
public class Menudynamique extends ClassMAPTable {

    String id, libelle, icone, href, id_pere;
    private int rang, niveau;

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
        super.setNomTable("MENUDYNAMIQUE");
        this.preparePk("MEN", "getSeqMenudynamique");
        this.setId(makePK(c));
    }

    public Menudynamique(String id, String libelle, String icone, String href, String id_pere, int rang, int niveau) {
        super.setNomTable("MENUDYNAMIQUE");
        this.setId(id);
        this.setLibelle(libelle);
        this.setIcone(icone);
        this.setHref(href);
        this.setId_pere(id_pere);
        this.setRang(rang);
        this.setNiveau(niveau);
    }

    public Menudynamique(String libelle, String icone, String href, String id_pere, int rang, int niveau) {
        super.setNomTable("MENUDYNAMIQUE");
        this.setLibelle(libelle);
        this.setIcone(icone);
        this.setHref(href);
        this.setId_pere(id_pere);
        this.setRang(rang);
        this.setNiveau(niveau);
    }

    public Menudynamique() {
        super.setNomTable("MENUDYNAMIQUE");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

    public String getIcone() {
        return icone;
    }

    public void setIcone(String icone) {
        this.icone = icone;
    }

    public String getHref() {
        return href;
    }

    public void setHref(String href) {
        this.href = href;
    }

    public String getId_pere() {
        return id_pere;
    }

    public void setId_pere(String id_pere) {
        this.id_pere = id_pere;
    }

    public int getRang() {
        return rang;
    }

    public void setRang(int rang) {
        this.rang = rang;
    }

    public int getNiveau() {
        return niveau;
    }

    public void setNiveau(int niveau) {
        this.niveau = niveau;
    }
}
