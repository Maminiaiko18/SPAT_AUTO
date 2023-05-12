/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.ClassMAPTable;

public class OpFacture extends ClassMAPTable{
    private String id;
    private String idOp;
    private String idFacture;

    public OpFacture(){
        this.setNomTable("opfacture");
    }

    @Override
    public String getTuppleID() {return id;}

    @Override
    public String getAttributIDName() {return "id";}
    
}
