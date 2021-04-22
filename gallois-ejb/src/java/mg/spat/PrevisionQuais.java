/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

/**
 *
 * @author MEVA
 */
public class PrevisionQuais extends Prevision{
    private String quai,idposte;

    public PrevisionQuais() {
        this.setNomTable("previsionquais");
    }

    
    
    public String getIdposte() {
        return idposte;
    }

    public void setIdposte(String idposte) {
        this.idposte = idposte;
    }

    
    
    public String getQuai() {
        return quai;
    }

    public void setQuai(String quai) {
        this.quai = quai;
    }
    
}
