/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.CGenUtil;
import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author Nouta
 */
public class ProformaFille extends FactureClientDetails{

    public ProformaFille() throws Exception{
        super.setNomTable("proforma_fille");
        this.setNomClasseMere("facture.ProformaMere");
        this.setLiaisonMere("idmere");
    }

    public ProformaFille(String id, String idmere, double quantite, double pu, double taux, String compte, String idproduit, String produit_lib, String devise, String designation, String idProduitLib, String idactivite, String categorieFacturelib, String categorieClientlib, String activitelib, String rubrique, FactureClient mere, double montant, double montanttaux, double montantavoirsanstaux, double montantavoiravectaux, double qtelivree, double restealivrer, Date datefact, String rubriquelib, String idprestation, String clientlib, int mois, int annee, String heureDebut, String heureFin, String moislib, String anneelib, double montantHTEuro, double montantTVAEuro, double montanttaxe, double majoration, double reduction, double tva) {
        super(id, idmere, quantite, pu, taux, compte, idproduit, produit_lib, devise, designation, idProduitLib, idactivite, categorieFacturelib, categorieClientlib, activitelib, rubrique, mere, montant, montanttaux, montantavoirsanstaux, montantavoiravectaux, qtelivree, restealivrer, datefact, rubriquelib, idprestation, clientlib, mois, annee, heureDebut, heureFin, moislib, anneelib, montantHTEuro, montantTVAEuro, montanttaxe, majoration, reduction, tva);
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

    @Override
    public double getTauxRecentNormal(Connection c) throws Exception {
        ProformaMere mere = (ProformaMere) this.findMere(c);
        
        Date date = mere.getDaty();
        if(mere.getDateDepart() != null) {
            date = mere.getDateDepart();
        }
        
        return getValeurTaux(c, "coursdeviseNonMICTSL", date);
    }
}
