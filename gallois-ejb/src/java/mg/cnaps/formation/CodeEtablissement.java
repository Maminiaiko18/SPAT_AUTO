/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.cnaps.formation;

import bean.TypeObjet;
import java.sql.Connection;

/**
 *
 * @author rasol
 */
public class CodeEtablissement extends TypeObjet{
    private String departement, service;

    public CodeEtablissement() {
        this.setNomTable("codeetablissement");
    }

    public String getDepartement() {
        return departement;
    }

    public void setDepartement(String departement) {
        this.departement = departement;
    }

    public String getService() {
        return service;
    }

    public void setService(String service) {
        this.service = service;
    }
    
    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("CET", "get_seq_codeetabliss");
        this.setId(makePK(c));
    }
}
