/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package avancement;

/**
 *
 * @author nyamp
 */
public class AvancementContratLibcomplet extends AvancementContrat{
    private String idcontratlib;

    public String getIdcontratlib() {
        return idcontratlib;
    }

    public void setIdcontratlib(String idcontratlib) {
        this.idcontratlib = idcontratlib;
    }
    
    public AvancementContratLibcomplet(){
        setNomTable("avancement_contratlibcomplet");
    }
}
