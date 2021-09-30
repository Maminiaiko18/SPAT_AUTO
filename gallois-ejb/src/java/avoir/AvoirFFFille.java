/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package avoir;

import bean.CGenUtil;
import facturefournisseur.DetailsFactureFournisseur;
import facturefournisseur.FactureFournisseur;
import java.sql.Connection;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;

/**
 *
 * @author Sam25v14
 */
public class AvoirFFFille extends AvoirFCFille {
    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("AVRFFF", "get_seqavoirFFfille");
        setId(makePK(c));
    }
    
    public FactureFournisseur getFactureFournisseur(Connection c) throws Exception {
        FactureFournisseur fc = new FactureFournisseur();
        fc.setNomTable("AVOIRFF_FACTURE");
        FactureFournisseur[] tFact = (FactureFournisseur[]) CGenUtil.rechercher(fc, null, null, c, " and idavoir = '" + this.getIdmere() + "'");

        if (tFact != null && tFact.length > 0) {
            return tFact[0];
        }

        return null;
    }
    
    @Override
    public void controler(Connection c) throws Exception {
        FactureFournisseur fc = getFactureFournisseur(c);

        if (fc != null) {
            if (fc.getEtat() < ConstanteEtat.getEtatValider()) {
                throw new Exception("Facture non visée");
            }
        }

        controlQte();

        super.controler(c);
    }
    
    public DetailsFactureFournisseur getFactureFournisseurDetail(Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            DetailsFactureFournisseur fc = new DetailsFactureFournisseur();
            fc.setNomTable("facture_client_filleTTC");
            String awhere = String.format(" and id = '%s' ", this.getIddetailfacture());
            DetailsFactureFournisseur[] result = (DetailsFactureFournisseur[]) CGenUtil.rechercher(fc, null, null, c, awhere);
            if (result != null && result.length > 0) {
                return result[0];
            }
            return null;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    
    public void setMontant(double montant) throws Exception {
//        if (this.getMode().equalsIgnoreCase("modif")) {
//            DetailsFactureFournisseur fc = getFactureFournisseurDetail(null);
//            if (this.getRemise() > 0) {
//                montant = (fc.getMontantTTC() * this.getRemise()) / 100;
//            }
//        }
        super.setMontant(montant);
    }

    public AvoirFFFille() throws Exception {
        super.setNomTable("avoirFFfille");
        this.setNomClasseMere("avoir.AvoirFF");
        this.setLiaisonMere("idmere");
    }
}
