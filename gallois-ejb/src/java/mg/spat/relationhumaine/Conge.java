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
public class Conge extends ClassEtat {
    
    private String id,idPersonnel,disponibilite;
    private Date date_debut_conge,date_fin_conge;
    private int nombre;

    public Conge() {
         super.setNomTable("Conge");
    }

    public Conge(String id, String idPersonnel, String disponibilite, Date date_debut_conge, Date date_fin_conge, int nombre) throws Exception {
       super.setNomTable("Conge");
        this.setId(id);
        this.setIdPersonnel(idPersonnel);
        this.setDisponibilite(disponibilite);
        this.setDate_debut_conge(date_debut_conge);
        this.setDate_fin_conge(date_fin_conge);
        this.setNombre(nombre);
    }
     public Conge(String idPersonnel, String disponibilite, Date date_debut_conge, Date date_fin_conge, int nombre) throws Exception {
        super.setNomTable("Conge");
        this.setIdPersonnel(idPersonnel);
        this.setDisponibilite(disponibilite);
        this.setDate_debut_conge(date_debut_conge);
        this.setDate_fin_conge(date_fin_conge);
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

    public String getDisponibilite() {
        return disponibilite;
    }

    public void setDisponibilite(String disponibilite) {
        this.disponibilite = disponibilite;
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

    public void setDate_fin_conge(Date date_fin_conge) throws Exception {
        this.date_fin_conge = date_fin_conge;
    }

    public int getNombre() {
        return nombre;
    }

    public void setNombre(int nombre) throws Exception {
              
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if ( nombre < 0) {
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
         this.preparePk("CON", "getseq_conge");
        this.setId(makePK(c));
        
    }
    public void controler(Connection c) throws Exception{
        if(Utilitaire.compareDaty(this.getDate_debut_conge(),this.getDate_fin_conge() )==1){
            throw new Exception("La date de debut congé doit etre inférieure à la date fin");
        }
    }
}
