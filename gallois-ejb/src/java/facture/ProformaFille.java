/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.CGenUtil;
import java.sql.Connection;

/**
 *
 * @author Nouta
 */
public class ProformaFille extends FactureClientDetails{

    public ProformaFille() throws Exception{
        super.setNomTable("proforma_fille");
    }
    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("CR","GETSEQ_PROFORMA_FILLE");
        setId(makePK(c));
    }
    
    @Override
    public FactureClient findMere(Connection c) throws Exception {
        if(this.getMere() == null) {
            ProformaMere pm = new ProformaMere();
            pm.setId(this.getIdmere());
            pm.setEstDDPMICTSL(null);
            ProformaMere[] tmp = (ProformaMere[]) CGenUtil.rechercher(pm, null, null, c, "");
            
            if(tmp != null && tmp.length > 0) { 
                this.setMere(tmp[0]);
                return tmp[0];
            }
        }
        
        return this.getMere();
    }
    
    
}
