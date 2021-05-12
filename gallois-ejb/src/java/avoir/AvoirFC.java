/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package avoir;


import bean.ClassEtat;
import java.sql.Connection;
import java.sql.Date;


/**
 *
 * @author
 */
public class AvoirFC extends ClassEtat {
    
    private String id;
    private Date daty;
    private String idfacture;


    
    
    public AvoirFC() {
        setNomTable("AvoirFC");
    }
    
    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("AVRFC", "get_seqAvoirFC");
        setId(makePK(c));
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
    
    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }
    
    public String getIdfacture() {
        return idfacture;
    }

    public void setIdfacture(String idfacture) {
        this.idfacture = idfacture;
    }
}
