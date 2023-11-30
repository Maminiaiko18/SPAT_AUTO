/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.cnaps.patrimoine;

import bean.AdminGen;
import bean.CGenUtil;
import java.sql.Connection;
import recapitulation.RecapitulationPatrimoine;
import recapitulation.RecapitulationRH;
import utilitaire.UtilDB;

/**
 *
 * @author Sam25v14
 */
public class StatistiquePatrimoine {

    RecapitulationPatrimoine magasinHangar;
    RecapitulationPatrimoine materielNaval;
    RecapitulationPatrimoine logementEtBatiment;
    RecapitulationPatrimoine terrain;
    RecapitulationPatrimoine patrimoineFoncier;
    RecapitulationPatrimoine materielRoulant;
    RecapitulationPatrimoine quais;
    double total;
    RecapitulationPatrimoine batimentEtConstruction;
    RecapitulationPatrimoine materielsRoulants;
    RecapitulationPatrimoine matMobBureau;
    RecapitulationPatrimoine materielInfo;
    RecapitulationPatrimoine matMobHospitalier;
    RecapitulationPatrimoine autreMatEquipement;

    public StatistiquePatrimoine() throws Exception {
        Connection c = new UtilDB().GetConn();
        try {
            RecapitulationPatrimoine recap = new RecapitulationPatrimoine();

            RecapitulationPatrimoine[] tab = (RecapitulationPatrimoine[]) CGenUtil.rechercher(recap, null, null, c, " and IDTYPEPATRIMOINE = '" + ConstantePatrimoine.batimentEtConstruction + "'");
            batimentEtConstruction = tab != null && tab.length > 0 ? tab[0] : recap;

            tab = (RecapitulationPatrimoine[]) CGenUtil.rechercher(recap, null, null, c, " and IDTYPEPATRIMOINE = '" + ConstantePatrimoine.materielsRoulants + "'");
            materielsRoulants = tab != null && tab.length > 0 ? tab[0] : recap;

            tab = (RecapitulationPatrimoine[]) CGenUtil.rechercher(recap, null, null, c, " and IDTYPEPATRIMOINE = '" + ConstantePatrimoine.matMobBureau + "'");
            matMobBureau = tab != null && tab.length > 0 ? tab[0] : recap;

            tab = (RecapitulationPatrimoine[]) CGenUtil.rechercher(recap, null, null, c, " and IDTYPEPATRIMOINE = '" + ConstantePatrimoine.materielInfo + "'");
            materielInfo = tab != null && tab.length > 0 ? tab[0] : recap;

            tab = (RecapitulationPatrimoine[]) CGenUtil.rechercher(recap, null, null, c, " and IDTYPEPATRIMOINE = '" + ConstantePatrimoine.matMobHospitalier + "'");
            matMobHospitalier = tab != null && tab.length > 0 ? tab[0] : recap;

            tab = (RecapitulationPatrimoine[]) CGenUtil.rechercher(recap, null, null, c, " and IDTYPEPATRIMOINE = '" + ConstantePatrimoine.autreMatEquipement + "'");
            autreMatEquipement = tab != null && tab.length > 0 ? tab[0] : recap;
            
            RecapitulationPatrimoine[] recapTab = {batimentEtConstruction, materielsRoulants, matMobBureau, materielInfo, matMobHospitalier, autreMatEquipement};
            total = AdminGen.calculSommeDouble(recapTab, "nombre");
        } catch (Exception ex) {
            throw ex;
        } finally {
            c.close();
        }
    }

    public RecapitulationPatrimoine getMagasinHangar() {
        return magasinHangar;
    }

    public void setMagasinHangar(RecapitulationPatrimoine magasinHangar) {
        this.magasinHangar = magasinHangar;
    }

    public RecapitulationPatrimoine getMaterielNaval() {
        return materielNaval;
    }

    public void setMaterielNaval(RecapitulationPatrimoine materielNaval) {
        this.materielNaval = materielNaval;
    }

    public RecapitulationPatrimoine getLogementEtBatiment() {
        return logementEtBatiment;
    }

    public void setLogementEtBatiment(RecapitulationPatrimoine logementEtBatiment) {
        this.logementEtBatiment = logementEtBatiment;
    }

    public RecapitulationPatrimoine getTerrain() {
        return terrain;
    }

    public void setTerrain(RecapitulationPatrimoine terrain) {
        this.terrain = terrain;
    }

    public RecapitulationPatrimoine getPatrimoineFoncier() {
        return patrimoineFoncier;
    }

    public void setPatrimoineFoncier(RecapitulationPatrimoine patrimoineFoncier) {
        this.patrimoineFoncier = patrimoineFoncier;
    }

    public RecapitulationPatrimoine getMaterielRoulant() {
        return materielRoulant;
    }

    public void setMaterielRoulant(RecapitulationPatrimoine materielRoulant) {
        this.materielRoulant = materielRoulant;
    }

    public RecapitulationPatrimoine getQuais() {
        return quais;
    }

    public void setQuais(RecapitulationPatrimoine quais) {
        this.quais = quais;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public RecapitulationPatrimoine getBatimentEtConstruction() {
        return batimentEtConstruction;
    }

    public void setBatimentEtConstruction(RecapitulationPatrimoine batimentEtConstruction) {
        this.batimentEtConstruction = batimentEtConstruction;
    }

    public RecapitulationPatrimoine getMaterielsRoulants() {
        return materielsRoulants;
    }

    public void setMaterielsRoulants(RecapitulationPatrimoine materielsRoulants) {
        this.materielsRoulants = materielsRoulants;
    }

    public RecapitulationPatrimoine getMatMobBureau() {
        return matMobBureau;
    }

    public void setMatMobBureau(RecapitulationPatrimoine matMobBureau) {
        this.matMobBureau = matMobBureau;
    }

    public RecapitulationPatrimoine getMaterielInfo() {
        return materielInfo;
    }

    public void setMaterielInfo(RecapitulationPatrimoine materielInfo) {
        this.materielInfo = materielInfo;
    }

    public RecapitulationPatrimoine getMatMobHospitalier() {
        return matMobHospitalier;
    }

    public void setMatMobHospitalier(RecapitulationPatrimoine matMobHospitalier) {
        this.matMobHospitalier = matMobHospitalier;
    }

    public RecapitulationPatrimoine getAutreMatEquipement() {
        return autreMatEquipement;
    }

    public void setAutreMatEquipement(RecapitulationPatrimoine autreMatEquipement) {
        this.autreMatEquipement = autreMatEquipement;
    }
}
