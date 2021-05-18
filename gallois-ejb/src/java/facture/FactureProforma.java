/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import java.sql.Connection;

/**
 *
 * @author je sais pas
 */
public class FactureProforma extends FactureClient{
    
    public FactureProforma(){
        super.setNomTable("FactureProforma");
    }
    
    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("FCP", "get_seqfacture_prof_fille");
        setId(makePK(c));
    }
}
