/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bordereau;

import bean.CGenUtil;
import bean.ClassMAPTable;
import bean.ClassEtat;
import java.sql.Connection;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;

/**
 *
 * @author rasol
 */
public class BordereauFille extends ClassMAPTable {

    private String id, idbordereau, idop;
    private String nomTableMere;
//    private String nomTableDetails;

    public BordereauFille() {
        this.setNomTable("liaisonbordereau");
        this.setNomTableMere("BORDEREAU");
//        this.setNomTableDetails("ordonnerPayement");
    }

    @Override
    public void controler(Connection c) throws Exception {
        super.controler(c);

        String nomTableDetails = this.getIdop().startsWith("ORP") ? "ordonnerPayement" : "facturefournisseur";  
        
        ClassEtat obj = (ClassEtat) new ded.OrdonnerPayement();
//        obj.setNomTable(this.getNomTableDetails());
        obj.setNomTable(nomTableDetails);

        ClassEtat[] tmp = (ClassEtat[]) CGenUtil.rechercher(obj, null, null, c, " and id = '" + this.getIdop() + "'");

        if (tmp == null || tmp.length == 0) {
            throw new Exception("Details non trouvé");
        }
        
        if (tmp[0].getEtat() < ConstanteEtat.getEtatValider()) {
            throw new Exception("Facture/OP non visé(e)");
        }
    }

    @Override
    public int deleteToTableWithHisto(String refUser, Connection con) throws Exception {
        Bordereau mere = getMere(con);

        if (mere != null && mere.getEtat() >= ConstanteEtat.getEtatValider()) {
            throw new Exception("Ne peut être supprimé car bordereau déjà visé");
        }

        return super.deleteToTableWithHisto(refUser, con);
    }

    public Bordereau getMere(Connection c) throws Exception {
        int verif = 0;
        Bordereau res = null;

        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }

            Bordereau op = new Bordereau();
            op.setNomTable(this.getNomTableMere());
            Bordereau[] tmp = (Bordereau[]) CGenUtil.rechercher(op, null, null, c, " and id = '" + this.getIdbordereau() + "'");

            if (tmp != null && tmp.length > 0) {
                res = tmp[0];
            }
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }

        return res;
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

    public String getNomTableMere() {
        return nomTableMere;
    }

    public void setNomTableMere(String nomTableMere) {
        this.nomTableMere = nomTableMere;
    }

//    public String getNomTableDetails() {
//        return nomTableDetails;
//    }
//
//    public void setNomTableDetails(String nomTableDetails) {
//        this.nomTableDetails = nomTableDetails;
//    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("BRDF", "get_seq_liaisonbordereau");
        this.setId(makePK(c));
    }
}
