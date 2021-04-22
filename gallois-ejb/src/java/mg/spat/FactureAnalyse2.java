/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import factureclient.FactureClient;

/**
 *
 * @author Daniel
 */
public class FactureAnalyse2 extends FactureClient {
    private String antenne, service;
    
    public FactureAnalyse2() {
        this.setNomTable("VIEW_FACTURECLIENT_2");
    }

    public String getAntenne() {
        return antenne;
    }

    public void setAntenne(String antenne) {
        this.antenne = antenne;
    }

    public String getService() {
        return service;
    }

    public void setService(String service) {
        this.service = service;
    }
}
