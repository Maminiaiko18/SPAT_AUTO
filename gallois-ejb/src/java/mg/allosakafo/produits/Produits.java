/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.allosakafo.produits;

import bean.CGenUtil;
import bean.ClassMAPTable;
import java.sql.Connection;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author Joe
 */
public class Produits extends ClassMAPTable{
    private String cdg,ccg,cda,cca ;
    private String id, nom, designation, photo, typeproduit, calorie, pa, idIngredient,categorieingredient;
    private double prixl,poidsprecuit;

    public String getCategorieingredient() {
        return categorieingredient;
    }

    public void setCategorieingredient(String categorieingredient) {
        this.categorieingredient = categorieingredient;
    }
    
    public String getCdg() {
        return cdg;
    }

    public void setCdg(String cdg) throws Exception {
        if(this.getMode().compareTo("modif")==0){
            //if(cdg.length()!=7) throw new Exception("La longueur de ce compte doit etre egale a 7");
        }
        this.cdg = cdg;
    }

    public String getCcg() {
        return ccg;
    }

    public void setCcg(String ccg) throws Exception {
        if(this.getMode().compareTo("modif")==0){
            //if(ccg.length()!=7) throw new Exception("La longueur de ce compte doit etre egale a 7");
        }
        this.ccg = ccg;
    }

    public String getCda() {
        return cda;
    }

    public void setCda(String cda) throws Exception {
        if(this.getMode().compareTo("modif")==0){
           // if(cda.length()!=7) throw new Exception("La longueur de ce compte doit etre egale a 7");
        }
        this.cda = cda;
    }

    public String getCca() {
        return cca;
    }

    public void setCca(String cca) throws Exception {
        if(this.getMode().compareTo("modif")==0){
           // if(cca.length()!=7) throw new Exception("La longueur de ce compte doit etre egale a 7");
        }
        this.cca = cca;
    }

    
    
    public double getPoidsprecuit() {
        return poidsprecuit;
    }

    public void setPoidsprecuit(double poidsprecuit) {
        this.poidsprecuit = poidsprecuit;
    }

    public String getIdIngredient() {
        return idIngredient;
    }

    public void setIdIngredient(String idIngredient) {
        this.idIngredient = idIngredient;
    }
    private double poids;
    
    public String getValColLibelle(){
        return nom+";"+ccg+";"+pa;
    }
    
    public Produits() {
        this.setNomTable("as_produits");
    }
	public Produits(String nom, String designation, String photo, String typeproduit, String calorie, String pa, double poids) throws Exception{
        this.setNomTable("as_produits");
		this.setNom(nom);
		this.setDesignation(designation);
		this.setPhoto(photo);
		this.setTypeproduit(typeproduit);
		this.setCalorie(calorie);
		this.setPa(pa);
		this.setPoids(poids);
    }
    public void construirePK(Connection c) throws Exception {
        this.preparePk("APS", "getseqAS_PRODUITS");
        this.setId(makePK(c));
    }
    public String getTuppleID() {
        return id;
    }

    public String getAttributIDName() {
        return "id";
    }
    public String[] getListePhoto(){
        if(this.photo != null){
            return Utilitaire.split(this.photo, ";");
        }
        return null;
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

    public void setNom(String nom) throws Exception{
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (nom != null && nom.compareToIgnoreCase("") != 0) {
                this.nom = nom;
                return;
            } else {
                throw new Exception("Nom de produits invalide");
            }
        }
        this.nom = nom;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getTypeproduit() {
        return typeproduit;
    }

    public void setTypeproduit(String typeproduit) {
        this.typeproduit = typeproduit;
    }

    public String getCalorie() {
        return calorie;
    }

    public void setCalorie(String calorie) {
        this.calorie = calorie;
    }

    public String getPa() {
        return pa;
    }

    public void setPa(String pa) {
        this.pa = pa;
    }

    public double getPoids() {
        return poids;
    }

    public void setPoids(double poids) {
        this.poids = poids;
    }

    public double getPrixl() {
        return prixl;
    }

    public void setPrixl(double prixl) {
        this.prixl = prixl;
    }
    public void getProduitById(Connection c) throws Exception
    {
        boolean estOuvert=false;
        try
        {
            if(c==null)
            {
                c=new UtilDB().GetConn();
                estOuvert=true;
            }
            Produits[] lp=(Produits[])CGenUtil.rechercher(this ,null,null, c," and id='"+this.getId()+"'") ;
            if(lp.length==0) throw new Exception("Produit introuvable");
            this.setDesignation(lp[0].getDesignation());
            this.setNom(lp[0].getNom());
            this.setPhoto(lp[0].getPhoto());
            this.setTypeproduit(lp[0].getTypeproduit());
            this.setCalorie(this.getCalorie());
            this.setPoids(lp[0].getPoids());
            this.setPa(lp[0].getPa());
            this.setIdIngredient(lp[0].getIdIngredient());
            this.setPrixl(lp[0].getPrixl());
        }
        catch(Exception e)
        {
            e.printStackTrace();
            throw e;
        }
        finally
        {
            if(estOuvert==true&&c!=null)c.close();
        }
    }
}
