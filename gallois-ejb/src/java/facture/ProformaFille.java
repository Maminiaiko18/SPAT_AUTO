/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import java.sql.Connection;

/**
 *
 * @author Nouta
 */
public class ProformaFille extends FactureClientDetails{

    public ProformaFille() {
        super.setNomTable("proforma_fille");
    }
    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("CR","GETSEQ_PROFORMA_FILLE");
        setId(makePK(c));
    }
    
    
    
}
