/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.cnaps.formation;
import java.sql.Connection;

import bean.ClassMAPTable;

/**
 *
 * @author Jetta
 */
public class FormFormateur extends ClassMAPTable {

    private String id, nom, desce, remarque, id_etablissement;

    private int niveau, experience;

	
	
	@Override
    public void construirePK(Connection c) throws Exception {       
        this.preparePk("FFO", "GETSEQFORMFORMATEUR");
        this.setId(makePK(c));
    }
  
	
	
	
    public String getId_etablissement() {
        return id_etablissement;
    }

    public void setId_etablissement(String id_etablissement) {
        this.id_etablissement = id_etablissement;
    }

    public FormFormateur(String id, String nom, String desce, String remarque, String id_etablissement, int niveau, int expericence)throws Exception {
        this.setId(id);
        this.setNom(nom);
        this.setDesce(desce);
        this.setRemarque(remarque);
        this.setNiveau(niveau);
        this.setExperience(expericence);
        this.setId_etablissement(id_etablissement);
        this.setNomTable("FORM_FORMATEUR");
    }

    public FormFormateur(String nom, String desce, String remarque, String id_etablissement, int niveau, int expericence)throws Exception {

        this.setNom(nom);
        this.setDesce(desce);
        this.setRemarque(remarque);
        this.setNiveau(niveau);
        this.setExperience(expericence);
        this.setId_etablissement(id_etablissement);
        this.setNomTable("FORM_FORMATEUR");
    }

    public FormFormateur() {
        this.setNomTable("FORM_FORMATEUR");
    }

    public String getTuppleID() {
        return id;
    }

    public String getAttributIDName() {
        return "id";
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) throws Exception {
        if (getMode().compareTo("modif") != 0) {
            this.nom = nom;
            return;
        }
        if(nom=="") throw new Exception("Champ nom manquant");
        this.nom = nom;
    }

    public String getDesce() {
        return desce;
    }

    public void setDesce(String desce) {
        this.desce = desce;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public int getNiveau() {
        return niveau;
    }

    public void setNiveau(int niveau) throws Exception{
        if(getMode().compareTo("modif")!=0)
        {
            this.niveau = niveau;
            return;
        }
        if(niveau<0 || niveau>10) throw new Exception("Niveau invalide car doit être entre 0 et 10");
        this.niveau = niveau;
    }

    public int getExperience() {
        return experience;
    }

    public void setExperience(int expericence) throws Exception{
        this.experience = expericence;
    }
    public String getValColLibelle(){
        return nom;
    }
    

}
