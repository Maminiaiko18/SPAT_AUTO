/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ded;

/**
 *
 * @author Sam25v14
 */
public class OrdonnerPayementBP extends OrdonnerPayement {
    private String idbon;

    public OrdonnerPayementBP() {
        this.setNomTable("ORDONNERPAYEMENT_BP");
    }

    public String getIdbon() {
        return idbon;
    }

    public void setIdbon(String idbon) {
        this.idbon = idbon;
    }
}
