/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.allosakafo.produits;

import bean.CGenUtil;
import bean.ClassMAPTable;
import factureclient.PaiementFactureRemise;
import facturefournisseur.EtatFactureMontantDaty;
import java.sql.Connection;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;

/**
 *
 * @author rasol
 */
public class LiaisonIntraTable extends ClassMAPTable {

    private String id, id1, id2;
    private double montant;

    public LiaisonIntraTable() {
        this.setNomTable("liaisonintratable");
    }

    public LiaisonIntraTable(String id1, String id2, double montant) {
        this.setNomTable("liaisonintratable");
        setId1(id1);
        setId2(id2);
        setMontant(montant);
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("LTAB", "GET_SEQ_LIAISONINTRATABLE");
        this.setId(makePK(c));
    }

    @Override
    public void controler(Connection c) throws Exception {
        if(!checkfacturevisee(c)) {
            throw new Exception("Veuillez viser la facture avant");
        }
    }

    public boolean checkfacturevisee(Connection c) throws Exception {
        int verif = 0;
        EtatFactureMontantDaty[] tmp = null;
        boolean verifier=false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            if(this.getId1().startsWith("FC")){
                PaiementFactureRemise ff = new PaiementFactureRemise();
                PaiementFactureRemise[] tab=(PaiementFactureRemise[]) CGenUtil.rechercher(ff, null, null, c, " and id = '" + this.getId1() + "' and etat= "+ ConstanteEtat.getEtatValider());
                verifier= tab != null && tab.length > 0;

            }
            else{
                EtatFactureMontantDaty ff = new EtatFactureMontantDaty();
                ff.setNomTable("ETATFACTUREMONTANTDATYVISE");
                tmp = (EtatFactureMontantDaty[]) CGenUtil.rechercher(ff, null, null, c, " and id = '" + this.getId1() + "'");
                verifier= tmp != null && tmp.length > 0;
            }
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
        
        return verifier;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getId1() {
        return id1;
    }

    public void setId1(String id1) {
        this.id1 = id1;
    }

    public String getId2() {
        return id2;
    }

    public void setId2(String id2) {
        this.id2 = id2;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }
}
