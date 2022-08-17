/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassMAPTable;

/**
 *
 * @author Jacques
 */
public class MvtIntraCaisseFille extends ClassMAPTable{
    private String id;
    private String idmere,reference,remarque;
    public MvtIntraCaisseFille(){
        setNomTable("mvtintracaisse_fille");
    }
    @Override
    public String getTuppleID() {
        return id; 
    }

    @Override
    public String getAttributIDName() {
        return "id";  
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdmere() {
        return idmere;
    }

    public void setIdmere(String idmere) {
        this.idmere = idmere;
    }

    public String getReference() {
        return reference;
    }

    public void setReference(String reference) {
        this.reference = reference;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }
    
    
}
