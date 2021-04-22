/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilitaire;

import bean.ClassMAPTable;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import oracle.sql.BLOB;

/**
 *
 * @author anthonyandrianaivoravelona
 */
public class Signature{
    private String id;
    private String idcnapsuser;
    private BLOB signature;

    public Signature() {
    }

    public Signature(String id, String idcnapsuser, BLOB signature) {
        this.id = id;
        this.idcnapsuser = idcnapsuser;
        this.signature = signature;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdcnapsuser() {
        return idcnapsuser;
    }

    public void setIdcnapsuser(String idcnapsuser) {
        this.idcnapsuser = idcnapsuser;
    }

    public BLOB getSignature() {
        return signature;
    }

    public void setSignature(BLOB signature) {
        this.signature = signature;
    }
    public byte[] getSignature(String id) throws SQLException {
        Connection con = null;
        try {
            con = new UtilDB().GetConn();
            byte[] res = null;

            String query = "SELECT SIGNATURE FROM CNAPSUSER_SIGNATURE WHERE CNAPSUSER_SIGNATURE.IDCNAPSUSER = '" + id + "'";

            Statement s = con.createStatement();
            ResultSet rs = s.executeQuery(query);
            if (rs.next()) {
                Blob signatureBlob = rs.getBlob("SIGNATURE");
                res = signatureBlob.getBytes(1, (int) signatureBlob.length());
            }
            s.close();
            return res;
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (con != null) {
                con.close();
            }
        }
        return null;
    }
}
