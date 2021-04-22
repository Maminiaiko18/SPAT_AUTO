/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

/**
 *
 * @author HP
 */
public class RecapOccupationQuais extends RecapMouvementQuais {
    private String id,val,desce,typequais;
    
    public RecapOccupationQuais() {
        super.setNomTable("recapitulationquais");
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
}
