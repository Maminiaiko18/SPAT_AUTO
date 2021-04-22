/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.relationhumaine;

import bean.ClassEtat;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.ConstanteEtat;
import utilitaire.Utilitaire;

/**
 *
 * @author Asus
 */
public class Permission extends ClassEtat {

    private String id, idPersonnel, objet;
    private Date date_debut_permission, date_fin_permission;
    private int nombre;

    public Permission() {
        super.setNomTable("Permission");
    }

    public Permission(String id, String idPersonnel, String objet, Date Date_debut_permission, Date date_fin_permission, int nombre) throws Exception {
        super.setNomTable("Permission");
        this.setId(id);
        this.setIdPersonnel(idPersonnel);
        this.setObjet(objet);
        this.setDate_debut_permission(Date_debut_permission);
        this.setDate_fin_permission(date_fin_permission);
        this.setNombre(nombre);
    }

    public Permission(String idPersonnel, String objet, Date Date_debut_permission, Date date_fin_permission, int nombre) throws Exception {
        super.setNomTable("Permission");
        this.setIdPersonnel(idPersonnel);
        this.setObjet(objet);
        this.setDate_debut_permission(Date_debut_permission);
        this.setDate_fin_permission(date_fin_permission);
        this.setNombre(nombre);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdPersonnel() {
        return idPersonnel;
    }

    public void setIdPersonnel(String idPersonnel) {
        this.idPersonnel = idPersonnel;
    }

    public String getObjet() {
        return objet;
    }

    public void setObjet(String objet) {
        this.objet = objet;
    }

    public Date getDate_debut_permission() {
        return date_debut_permission;
    }

    public void setDate_debut_permission(Date Date_debut_permission) {
        this.date_debut_permission = Date_debut_permission;
    }

    public Date getDate_fin_permission() {
        return date_fin_permission;
    }

    public void setDate_fin_permission(Date date_fin_permission) throws Exception {
        this.date_fin_permission = date_fin_permission;
    }

    public int getNombre() {
        return nombre;
    }

    public void setNombre(int nombre) throws Exception {

        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (nombre < 0) {
                throw new Exception("indice invalide");
            }
        }
        this.nombre = nombre;
    }

    @Override
    public String getTuppleID() {
        return this.id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public void construirePK(Connection c) throws Exception {
        this.preparePk("PER", "getseq_permission");
        this.setId(makePK(c));

    }

    public void controler(Connection c) throws Exception {
        if (Utilitaire.compareDaty(this.getDate_debut_permission(), this.getDate_fin_permission()) == 1) {
            throw new Exception("La date de debut permission doit etre inférieure à la date fin");
        }
    }
}
