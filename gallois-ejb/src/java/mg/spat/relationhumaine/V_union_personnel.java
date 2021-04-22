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
 * @author pro
 */
public class V_union_personnel extends ClassMAPTable{
    private String id;
    private String matriculeSalarie;
    private String nom;
    private String prenom;
    private String civilite;
    private Date dateNaissance; 
    private String telephone; 
    private String email; 

    public V_union_personnel() {
        super.setNomTable("v_union_personnel");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    
    public String getMatriculeSalarie() {
        return matriculeSalarie;
    }

    public void setMatriculeSalarie(String matriculeSalarie) {
        this.matriculeSalarie = matriculeSalarie;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getCivilite() {
        return civilite;
    }

    public void setCivilite(String civilite) {
        this.civilite = civilite;
    }

    public Date getDateNaissance() {
        return dateNaissance;
    }

    public void setDateNaissance(Date dateNaissance) {
        this.dateNaissance = dateNaissance;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
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
    public String getValColLibelle(){
        return this.getNom()+" "+this.getPrenom();
    }
}
