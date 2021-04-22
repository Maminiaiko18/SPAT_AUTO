/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.relationhumaine;

import bean.ClassMAPTable;
import java.sql.Connection;
import service.SpatService;

/**
 *
 * @author Asus
 */
public class Diplome extends ClassMAPTable {

    private String id, idPersonnel, titre, options, etablissement;

    private int annee_diplome;

    public Diplome() {
        super.setNomTable("Diplome");
    }

    public Diplome(String id, String idPersonnel, String titre, String options, String etablissement, int annee_diplome) throws Exception {
        super.setNomTable("Diplome");
        this.setId(id);
        this.setIdPersonnel(idPersonnel);
        this.setTitre(titre);
        this.setOptions(options);
        this.setEtablissement(etablissement);
        this.setAnnee_diplome(annee_diplome);
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

    public int getAnnee_diplome() {
        return annee_diplome;
    }

    public void setAnnee_diplome(int annee_diplome) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            if (annee_diplome < 0) {
               throw new Exception("annee_diplome invalide");
            } 
        }
        this.annee_diplome=annee_diplome;
    }

    public void controler(Connection c) throws Exception {
        try {
            //SpatService.testDoublonDiplome(this,c);
        } catch (Exception e) {
            throw e;
        }
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
        this.preparePk("DPL", "getseq_diplome");
        this.setId(makePK(c));

    }

}
