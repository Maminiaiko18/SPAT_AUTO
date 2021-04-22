/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;

import utilitaire.Utilitaire;

/**
 *
 * @author Ravaka
 */
public abstract class ClassUser extends ClassMAPTable{
    private String iduser;
    private String direction;
    String service;

    public String getDirection() {
        return direction;
    }

    public void setDirection(String direction) {
        this.direction = direction;
    }

    public String getService() {
        return service;
    }

    public void setService(String service) {
        this.service = service;
    }

    public String getIduser() {
        return iduser;
    }

    public void setIduser(String iduser) {
        if(getMode().compareTo("modif")==0 && iduser!=null && iduser.contains("/")){
            String[] g = Utilitaire.split(iduser, "/");
            String t = g[0];
            this.iduser= g[0];
            return;
        }
        this.iduser = iduser;
    }    
}
