/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.CGenUtil;
import java.sql.Connection;
import utilitaire.UtilDB;
/**
 *
 * @author je sais pas
 */
public class FactureProforma extends FactureClient{
    
    private FactureProformaDetails[] filles;
    
    public FactureProforma(){
        super.setNomTable("facture_prof_mere");
    }
    
    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("FCP", "get_seqfacture_prof_fille");
        setId(makePK(c));
    }
    
    public void initialiserFilles (Connection c, String nomtablefille) throws Exception {
        boolean ouvert = false;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                ouvert = true;
            }
            FactureProformaDetails factureProformaDetails = new FactureProformaDetails();
            factureProformaDetails.setNomTable(nomtablefille);
            FactureProformaDetails[] fille = (FactureProformaDetails[]) CGenUtil.rechercher(factureProformaDetails, null, null, c, " and idmere = '" + this.getId() + "'");
            
            if (fille != null && fille.length > 0) {
                this.setFilles(fille);
            }
            
            
            
        } catch (Exception ex) {
            if (c != null && ouvert) {
                c.rollback();
            }
            throw ex;
        } finally {
            if (c != null && ouvert) {
                c.close();
            }
        }
    }
    
    public FactureProformaDetails[] getFilles() {
        return filles;
    }

    public void setFilles(FactureProformaDetails[] filles) {
        this.filles = filles;
    }
}
