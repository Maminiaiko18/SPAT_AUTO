/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.ClassMAPTable;
import bean.TypeObjet;
import java.sql.Connection;

/**
 *
 * @author Asus
 */
public class Caisse extends TypeObjet{
    
    private String numero;

    public Caisse() {
        super.setNomTable("Caisse");
    }
    
    

    public Caisse(String id, String val, String desce, String numero) {
        super.setNomTable("Caisse");
        this.setId(id);
        this.setVal(val);
        this.setDesce(desce);
        this.setNumero(numero);
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }
    
    

    @Override
    public String getTuppleID() {
    return id;
    }

    @Override
    public String getAttributIDName() {
    return "id";
    }
    
     public void construirePK(Connection c) throws Exception {
        this.preparePk("CAI", "getseqcaisse");
        this.setId(makePK(c));

    }
}
