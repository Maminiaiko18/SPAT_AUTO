/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bordereau;

import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author rasol
 */
public class BordereauFille extends ClassMAPTable{
    private String id, idbordereau, idop;

    public BordereauFille() {
        this.setNomTable("liaisonbordereau");
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

    public String getIdbordereau() {
        return idbordereau;
    }

    public void setIdbordereau(String idbordereau) {
        this.idbordereau = idbordereau;
    }

    public String getIdop() {
        return idop;
    }

    public void setIdop(String idop) {
        this.idop = idop;
    }
    @Override
    public void construirePK(Connection c) throws Exception{
        this.preparePk("BRD","get_seq_liaisonbordereau");
        this.setId(makePK(c));
    }
}
