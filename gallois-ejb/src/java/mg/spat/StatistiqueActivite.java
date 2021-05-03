/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassEtat;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.Constante;

/**
 *
 * @author Asus
 */
public class StatistiqueActivite extends ClassEtat{
    
    private String id,idclient,rubrique;
    private Date daty;
    private double cumul;
    private String titre;
    private String idtypeActionConteneur;
    private double Plein20Pieds  ;
    private double Vide20Pieds  ;
    private double Plein40Pieds  ;
    private double Vide40Pieds  ;
    private String idnomsociete;
    private String idtypemanipulation;
    private String idtypemarchandise;
    private String idtypemesure;
    private int nombreunite ;
    private double poids ;
    private String typeSaisie;
    private String navire;

    public StatistiqueActivite() {
        super.setNomTable("statistique_activite");
    }

    @Override
    public ClassMAPTable createObject(String u, Connection c) throws Exception {
        if(getTypeSaisie().equalsIgnoreCase(Constante.typeconteneur)) setIdnomsociete(Constante.mictsl);
        
        return super.createObject(u, c); 
    }

    public String getNavire() {
        return navire;
    }

    public void setNavire(String navire) {
        this.navire = navire;
    }

    public String getTitre() {
        return titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public String getIdtypeActionConteneur() {
        return idtypeActionConteneur;
    }

    public void setIdtypeActionConteneur(String idtypeActionConteneur) {
        this.idtypeActionConteneur = idtypeActionConteneur;
    }

    public double getPlein20Pieds() {
        return Plein20Pieds;
    }

    public void setPlein20Pieds(double Plein20Pieds) {
        this.Plein20Pieds = Plein20Pieds;
    }

    public double getVide20Pieds() {
        return Vide20Pieds;
    }

    public void setVide20Pieds(double Vide20Pieds) {
        this.Vide20Pieds = Vide20Pieds;
    }

    public double getPlein40Pieds() {
        return Plein40Pieds;
    }

    public void setPlein40Pieds(double Plein40Pieds) {
        this.Plein40Pieds = Plein40Pieds;
    }

    public double getVide40Pieds() {
        return Vide40Pieds;
    }

    public void setVide40Pieds(double Vide40Pieds) {
        this.Vide40Pieds = Vide40Pieds;
    }

    public String getIdnomsociete() {
        return idnomsociete;
    }

    public void setIdnomsociete(String idnomsociete) {
        this.idnomsociete = idnomsociete;
    }

    public String getIdtypemanipulation() {
        return idtypemanipulation;
    }

    public void setIdtypemanipulation(String idtypemanipulation) {
        this.idtypemanipulation = idtypemanipulation;
    }

    public String getIdtypemarchandise() {
        return idtypemarchandise;
    }

    public void setIdtypemarchandise(String idtypemarchandise) {
        this.idtypemarchandise = idtypemarchandise;
    }

    public String getIdtypemesure() {
        return idtypemesure;
    }

    public void setIdtypemesure(String idtypemesure) {
        this.idtypemesure = idtypemesure;
    }

    public int getNombreunite() {
        return nombreunite;
    }

    public void setNombreunite(int nombreunite) {
        this.nombreunite = nombreunite;
    }

    public double getPoids() {
        return poids;
    }

    public void setPoids(double poids) {
        this.poids = poids;
    }

    public String getTypeSaisie() {
        return typeSaisie;
    }

    public void setTypeSaisie(String typeSaisie) {
        this.typeSaisie = typeSaisie;
    }
    
    

    public StatistiqueActivite(String id, String idclient, String rubrique, Date daty, double cumul) throws Exception {
         super.setNomTable("statistique_activite");
        this.setId(id);
        this.setIdclient(idclient);
        this.setRubrique(rubrique);
        this.setDaty(daty);
        this.setCumul(cumul);
    }
    public StatistiqueActivite(String idclient, String rubrique, Date daty, double cumul) throws Exception {
         super.setNomTable("statistique_activite");
        this.setIdclient(idclient);
        this.setRubrique(rubrique);
        this.setDaty(daty);
        this.setCumul(cumul);
    }
    
    

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdclient() {
        return idclient;
    }

    public void setIdclient(String idclient) {
        this.idclient = idclient;
    }

    public String getRubrique() {
        return rubrique;
    }

    public void setRubrique(String rubrique) {
        this.rubrique = rubrique;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public double getCumul() {
        return cumul;
    }

    public void setCumul(double cumul) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (cumul < 0) {
               throw new Exception("cumul invalide");
            } 
        }
         this.cumul = cumul;
       
       
       
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
         this.preparePk("STA", "getseq_statistique_activite");
        this.setId(makePK(c));
        
    }
    
}
