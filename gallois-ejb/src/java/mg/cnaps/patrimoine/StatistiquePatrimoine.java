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

    public StatistiquePatrimoine() throws Exception {
        Connection c = new UtilDB().GetConn();
        try {
            RecapitulationPatrimoine recap = new RecapitulationPatrimoine();

            RecapitulationPatrimoine[] tab = (RecapitulationPatrimoine[]) CGenUtil.rechercher(recap, null, null, c, " and IDTYPEPATRIMOINE = '" + ConstantePatrimoine.magasinHangar + "'");
            magasinHangar = tab != null && tab.length > 0 ? tab[0] : recap;

            tab = (RecapitulationPatrimoine[]) CGenUtil.rechercher(recap, null, null, c, " and IDTYPEPATRIMOINE = '" + ConstantePatrimoine.materielNaval + "'");
            materielNaval = tab != null && tab.length > 0 ? tab[0] : recap;

            tab = (RecapitulationPatrimoine[]) CGenUtil.rechercher(recap, null, null, c, " and IDTYPEPATRIMOINE = '" + ConstantePatrimoine.logementEtBatiment + "'");
            logementEtBatiment = tab != null && tab.length > 0 ? tab[0] : recap;

            tab = (RecapitulationPatrimoine[]) CGenUtil.rechercher(recap, null, null, c, " and IDTYPEPATRIMOINE = '" + ConstantePatrimoine.terrain + "'");
            terrain = tab != null && tab.length > 0 ? tab[0] : recap;

            tab = (RecapitulationPatrimoine[]) CGenUtil.rechercher(recap, null, null, c, " and IDTYPEPATRIMOINE = '" + ConstantePatrimoine.patrimoineFoncier + "'");
            patrimoineFoncier = tab != null && tab.length > 0 ? tab[0] : recap;

            tab = (RecapitulationPatrimoine[]) CGenUtil.rechercher(recap, null, null, c, " and IDTYPEPATRIMOINE = '" + ConstantePatrimoine.materielRoulant + "'");
            materielRoulant = tab != null && tab.length > 0 ? tab[0] : recap;

            tab = (RecapitulationPatrimoine[]) CGenUtil.rechercher(recap, null, null, c, " and IDTYPEPATRIMOINE = '" + ConstantePatrimoine.quais + "'");
            quais = tab != null && tab.length > 0 ? tab[0] : recap;
            
            RecapitulationPatrimoine[] recapTab = {magasinHangar, materielNaval, logementEtBatiment, terrain, patrimoineFoncier, materielRoulant, quais};
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
}
