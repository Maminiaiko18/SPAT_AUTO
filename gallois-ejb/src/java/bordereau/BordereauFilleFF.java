/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bordereau;
import java.sql.*;
import utilitaire.UtilDB;
/**
 *
 * @author
 */
public class BordereauFilleFF extends BordereauFille{
    public BordereauFilleFF() {
        this.setNomTable("liaisonbordereauFF");
        this.setNomTableMere("BORDEREAUFF");
//        this.setNomTableDetails("facturefournisseur");
    }



    @Override
    public void controlerDelete(Connection c) throws Exception {
        this.checkEngagement(c);
    }

    public void checkEngagement(Connection c) throws Exception{
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }

            Bordereau mere = getMere(c);
            if (mere != null && mere.getIdengagement() != null) {
                throw new Exception("Impossible d'effectuer cette action, bordereau déjà engagé.");
            }
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
}
