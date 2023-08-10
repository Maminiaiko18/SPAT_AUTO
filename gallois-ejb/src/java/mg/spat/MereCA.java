/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.TypeObjet;
/**
 *
 * @author CHARLES Elsy
 */
public class MereCA extends TypeObjet {
    private String idgrandrubrique;
    private String idgrandrubriquelib;
    
    public MereCA (){
        setNomTable("MERECA");
    }

    public String getIdgrandrubiquelib() {
        return idgrandrubriquelib;
    }

    public void setIdgrandrubiquelib(String idgrandrubriquelib) {
        this.idgrandrubriquelib = idgrandrubriquelib;
    }

    public String getIdgrandrubrique() {
        return idgrandrubrique;
    }

    public void setIdgrandrubrique(String idgrandrubrique) {
        this.idgrandrubrique = idgrandrubrique;
    }
}
