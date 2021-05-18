/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package avoir;

import bean.CGenUtil;
import bean.ClassMAPTable;
import facture.FactureClient;
import java.sql.Connection;
import utilitaire.ConstanteEtat;

/**
 *
 * @author
 */
public class AvoirFCFille extends ClassMAPTable {

    private String id;
    private double montant, montantdf;
    private String idmere, compte, iddetailfacture;

    public FactureClient getFacture(Connection c) throws Exception {
        FactureClient fc = new FactureClient();
        fc.setNomTable("AVOIRFC_FACTURE");
        FactureClient[] tFact = (FactureClient[]) CGenUtil.rechercher(fc, null, null, c, " and idavoir = '" + this.getIdmere() + "'");

        if (tFact != null && tFact.length > 0) {
            return tFact[0];
        }

        return null;
    }

    @Override
    public void controler(Connection c) throws Exception {
        FactureClient fc = getFacture(c);

        if (fc != null) {
            if (fc.getEtat() < ConstanteEtat.getEtatValider()) {
                throw new Exception("Facture non visée");
            }
        }
        
        if (this.getMontant() > this.getMontantdf()) {
            throw new Exception("Montant (" + this.getMontant() + ") supérieur à celui du détail! (" + this.getMontantdf() + ") ");
        }

        super.controler(c);
    }

    public AvoirFCFille() {
        setNomTable("avoirFCfille");
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("AVRFCF", "get_seqavoirFCfille");
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

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public String getIdmere() {
        return idmere;
    }

    public void setIdmere(String idmere) {
        this.idmere = idmere;
    }

    public String getCompte() {
        return compte;
    }

    public void setCompte(String compte) {
        this.compte = compte;
    }

    public String getIddetailfacture() {
        return iddetailfacture;
    }

    public void setIddetailfacture(String iddetailfacture) {
        this.iddetailfacture = iddetailfacture;
    }

    public double getMontantdf() {
        return montantdf;
    }

    public void setMontantdf(double montantdf) {
        this.montantdf = montantdf;
    }
}
