// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   Table.java
package bean;

import java.io.PrintStream;
import java.sql.*;
import utilitaire.UtilDB;
import java.util.Vector;

// Referenced classes of package bean:
//            Champ
public class Table {

    public Table() {

    }

    public Table(String nom) {
        nomTable = nom;
        //findInfoTable();
    }

    public Table(String nom, Connection c) {
        nomTable = nom;
        //findInfoTable(c);
    }

    public Champ[] getChamp() {
        findInfoTable();
        return champ;
    }

    public String getNomTable() {
        return nomTable;
    }

    public void findInfoTable() {
        UtilDB util = null;
        Connection c = null;
        try {
            util = new UtilDB();
            c = util.GetConn();
            findInfoTable(c);
        } catch (Exception s) {
            System.out.println(String.valueOf(String.valueOf((new StringBuffer("RechercheExecution44444 ")).append(getNomTable()).append(" par Reference ").append(s.getMessage()))));
        } finally {
            try {
                if (c != null) {
                    c.close();
                }
                util.close_connection();
            } catch (SQLException e) {
                System.out.println("Erreur Fermeture SQL RechercheExecution ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }

    public void findInfoTable(Connection c) {
        UtilDB util = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        try {
            String param = "SELECT * FROM USER_TAB_COLUMNS where table_Name = upper(?) order by column_id asc";
            st = c.prepareStatement(param);
            st.setString(1, nomTable);
            rs = st.executeQuery();
            Vector v = new Vector();
            while (rs.next()) {
                v.add(new Champ(rs.getString(2), rs.getString(3), rs.getInt(7), rs.getInt(8)));
            }
            champ = new Champ[v.size()];
            v.copyInto(champ);
        } catch (Exception s) {
            s.printStackTrace();
            System.out.println("findInfoTable " + getNomTable() + " par Reference ");
        } finally {
            try {
                if (st != null) {
                    st.close();
                }
                if (rs != null) {
                    rs.close();
                }
            } catch (SQLException e) {
                System.out.println("Erreur Fermeture SQL RechercheExecution ".concat(String.valueOf(String.valueOf(e.getMessage()))));
            }
        }
    }

    public void setNomTable(String nomTable) {
        this.nomTable = nomTable;
    }

    String nomTable;
    int nombreCol;
    Champ champ[];
}
