package mg.spat;

import java.sql.Connection;

import bean.CGenUtil;
import bean.ClassMAPTable;
import facture.FactureClient;
import utilitaire.UtilDB;

public class FcDefPr extends ClassMAPTable {
    String id, id1, id2;

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

    @Override
    public String getTuppleID() {
        return this.getId();
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public FcDefPr() {
        this.setNomTable("FCDEFPR");
    }

    public void construirePK(Connection c) throws Exception {
        this.preparePk("FCDP", "GETSEQFCDEFPR");
        this.setId(makePK(c));
    }

    
    public FactureClient getFacture(Connection c, String id) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            FactureClient cc = new FactureClient();
            cc.setNomTable("facture_client_union");
            String awhere = String.format(" and id = '%s' ", id);
            FactureClient[] result = (FactureClient[]) CGenUtil.rechercher(cc, null, null, c, awhere);
            if (result != null && result.length > 0) {
                return result[0];
            }
            return null;
        } catch (Exception ex) {
            throw ex;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

}