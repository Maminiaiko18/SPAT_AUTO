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
 * @author Asus
 */
public class InfoProfessionnel extends ClassMAPTable {

    private String id, idpersonnel, poste_occupe, societe, iddiplome, titre, options, etablissement, idrenseignement, libelle, type, observation;
    private int annee_parcours_pro, annee_diplome;
    private double duree;
    private Date daty;

    public InfoProfessionnel() {
        super.setNomTable("infoProfessionnelGlobal");
    }

    public InfoProfessionnel(String id, String idpersonnel, String poste_occupe, String societe, String iddiplome, String titre, String options, String etablissement, String idrenseignement, String libelle, String type, String observation, int annee_parcours_pro, int annee_diplome, double duree, Date daty) throws Exception {
        super.setNomTable("infoProfessionnelGlobal");
        this.setId(id);
        this.setIdpersonnel(idpersonnel);
        this.setPoste_occupe(poste_occupe);
        this.setSociete(societe);
        this.setIddiplome(iddiplome);
        this.setTitre(titre);
        this.setOptions(options);
        this.setEtablissement(etablissement);
        this.setIdrenseignement(idrenseignement);
        this.setLibelle(libelle);
        this.setType(type);
        this.setObservation(observation);
        this.setAnnee_parcours_pro(annee_parcours_pro);
        this.setAnnee_diplome(annee_diplome);
        this.setDuree(duree);
        this.setDaty(daty);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdpersonnel() {
        return idpersonnel;
    }

    public void setIdpersonnel(String idpersonnel) {
        this.idpersonnel = idpersonnel;
    }

    public String getPoste_occupe() {
        return poste_occupe;
    }

    public void setPoste_occupe(String poste_occupe) {
        this.poste_occupe = poste_occupe;
    }

    public String getSociete() {
        return societe;
    }

    public void setSociete(String societe) {
        this.societe = societe;
    }

    public String getIddiplome() {
        return iddiplome;
    }

    public void setIddiplome(String iddiplome) {
        this.iddiplome = iddiplome;
    }

    public String getTitre() {
        return titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public String getOptions() {
        return options;
    }

    public void setOptions(String options) {
        this.options = options;
    }

    public String getEtablissement() {
        return etablissement;
    }

    public void setEtablissement(String etablissement) {
        this.etablissement = etablissement;
    }

    public String getIdrenseignement() {
        return idrenseignement;
    }

    public void setIdrenseignement(String idrenseignement) {
        this.idrenseignement = idrenseignement;
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getObservation() {
        return observation;
    }

    public void setObservation(String observation) {
        this.observation = observation;
    }

    public int getAnnee_parcours_pro() {
        return annee_parcours_pro;
    }

    public void setAnnee_parcours_pro(int annee_parcours_pro) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (annee_parcours_pro < 0) {
                throw new Exception("annee_parcours_pro invalide");
            }
        }
        this.annee_parcours_pro = annee_parcours_pro;
    }

    public int getAnnee_diplome() {
        return annee_diplome;
    }

    public void setAnnee_diplome(int annee_diplome) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (annee_diplome < 0) {
                throw new Exception("annee_diplome invalide");
            }
        }
        this.annee_diplome = annee_diplome;
    }

    public double getDuree() {
        return duree;
    }

    public void setDuree(double duree) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (duree < 0) {
                throw new Exception("annee_parcours_pro invalide");
            }
        }
        this.duree = duree;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
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
