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
    private String idgrandrubiquelib;
    
    public MereCA (){
        setNomTable("MERECA");
    }

    public String getIdgrandrubiquelib() {
        return idgrandrubiquelib;
    }

    public void setIdgrandrubiquelib(String idgrandrubiquelib) {
        this.idgrandrubiquelib = idgrandrubiquelib;
    }

    public String getIdgrandrubrique() {
        return idgrandrubrique;
    }

    public void setIdgrandrubrique(String idgrandrubrique) {
        this.idgrandrubrique = idgrandrubrique;
    }
}
