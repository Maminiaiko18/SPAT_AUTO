/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.relationhumaine;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author Asus
 */
public class InfoCongePermission extends ClassMAPTable {

    private String id, idPersonnel, disponibilite, objet, idPermission;

    private Date date_debut_conge, date_fin_conge, date_debut_permission, date_fin_permission;
    private int nombre, nombrepermission;

    public InfoCongePermission() {
        super.setNomTable("InfoCongePermission");

    }

    public InfoCongePermission(String id, String disponibilite, String idPermission, String objet, Date date_debut_conge, Date date_fin_conge, Date date_deut_permission, Date date_fin_permission, int nombre, int nombrepermission) throws Exception {
        super.setNomTable("InfoCongePermission");
        this.setId(id);
        this.setIdPermission(idPermission);
        this.setDisponibilite(disponibilite);
        this.setObjet(objet);
        this.setDate_debut_conge(date_debut_conge);
        this.setDate_fin_conge(date_fin_conge);
        this.setDate_debut_permission(date_deut_permission);
        this.setDate_fin_permission(date_fin_permission);
        this.setNombre(nombre);
        this.setNombrepermission(nombrepermission);
    }

    public String getIdPermission() {
        return idPermission;
    }

    public void setIdPermission(String idPermisssion) {
        this.idPermission = idPermisssion;
    }

    public String getIdPersonnel() {
        return idPersonnel;
    }

    public void setIdPersonnel(String idPersonnel) {
        this.idPersonnel = idPersonnel;
    }

    public Date getDate_debut_permission() {
        return date_debut_permission;
    }

    public void setDate_debut_permission(Date date_debut_permission) {
        this.date_debut_permission = date_debut_permission;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDisponibilite() {
        return disponibilite;
    }

    public void setDisponibilite(String disponibilite) {
        this.disponibilite = disponibilite;
    }

    public String getObjet() {
        return objet;
    }

    public void setObjet(String objet) {
        this.objet = objet;
    }

    public Date getDate_debut_conge() {
        return date_debut_conge;
    }

    public void setDate_debut_conge(Date date_debut_conge) {
        this.date_debut_conge = date_debut_conge;
    }

    public Date getDate_fin_conge() {
        return date_fin_conge;
    }

    public void setDate_fin_conge(Date date_fin_conge) {
        this.date_fin_conge = date_fin_conge;
    }

    public Date getDate_deut_permission() {
        return date_debut_permission;
    }

    public void setDate_deut_permission(Date date_deut_permission) {
        this.date_debut_permission = date_deut_permission;
    }

    public Date getDate_fin_permission() {
        return date_fin_permission;
    }

    public void setDate_fin_permission(Date date_fin_permission) {
        this.date_fin_permission = date_fin_permission;
    }

    public int getNombre() {

        return nombre;
    }

    public void setNombre(int nombre) throws Exception {

        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (nombre < 0) {
                throw new Exception("nombre invalide");

            }
        }
        this.nombre = nombre;
    }

    public int getNombrepermission() {
        return nombrepermission;
    }

    public void setNombrepermission(int nombrepermission) throws Exception {

        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (nombrepermission < 0) {
                throw new Exception("nombre invalide");

            }
        }
        this.nombrepermission = nombrepermission;
    }

    @Override
    public String getTuppleID() {
        return this.id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

}
