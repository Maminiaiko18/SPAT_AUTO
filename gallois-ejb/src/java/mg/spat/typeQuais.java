/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author Asus
 */
public class typeQuais extends ClassMAPTable{
    
    private String id,val,desce,typequais;

    public typeQuais() {
         super.setNomTable("typequais");
    }

    public typeQuais(String id, String val, String desce, String typequais) {
        this.id = id;
        this.val = val;
        this.desce = desce;
        this.typequais = typequais;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getVal() {
        return val;
    }

    public void setVal(String val) {
        this.val = val;
    }

    public String getDesce() {
        return desce;
    }

    public void setDesce(String desce) {
        this.desce = desce;
    }

    public String getTypequais() {
        return typequais;
    }

    public void setTypequais(String typequais) {
        this.typequais = typequais;
    }
    
    
    
    @Override
    public String getTuppleID() {
     return this.id;
    }

    @Override
    public String getAttributIDName() {
    return "id";
    }
    public void construirePK(Connection c) throws Exception {
         this.preparePk("TPQ", "getseqqquais");
        this.setId(makePK(c));
        
    }
    
}
