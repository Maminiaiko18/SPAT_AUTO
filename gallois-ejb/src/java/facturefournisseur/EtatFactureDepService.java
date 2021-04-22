/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facturefournisseur;

/**
 *
 * @author mihary
 */
public class EtatFactureDepService extends EtatFactureMontantDaty{

    private String departement,service,direction;

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

    public String getDirection() {
        return direction;
    }

    public void setDirection(String direction) {
        this.direction = direction;
    }
    
    public EtatFactureDepService() {
        this.setNomTable("ETATFACTUREMONTANTDATY_LIB");
    }
    
}
