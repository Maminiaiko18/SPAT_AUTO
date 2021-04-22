/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modules;

import bean.CGenUtil;
import config.Table;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;
import javax.servlet.http.HttpServletRequest;
import utilisateur.Restriction;
import utilitaire.UtilDB;

/**
 *
 * @author Jetta
 */
public class GestionRole {

    public int  testRestriction(String idrole, String permission, String table,String direc,Connection c) throws Exception {

        try {
            Restriction r = new Restriction();
            //TypeObjet to=new TypeObjet();
           // r.setIdrole(idrole);

            
           // r.setIdaction(act);
            r.setTablename(table);
            String aw=" AND idaction='"+permission+"' and IDDIRECTION='"+direc+"'";
            // System.out.print("awhere="+aw);
            Restriction[] res = (Restriction[]) CGenUtil.rechercher(r, null, null, c, aw);
           
            if (res!=null&&res.length != 0) {
                return 1;
            }
            return 0;
        } catch (Exception ex) {
            throw ex;
        }
    }

    public String[] getAllTAble(Connection con) throws Exception {
        try {
            String req = "SELECT table_name FROM matable";
            Statement s = con.createStatement();
            ResultSet res = s.executeQuery(req);
            Vector v = new Vector();
            while (res.next()) {
                String st = res.getString(1);
                v.add(st);
            }
            String[] valin = new String[v.size()];
            v.copyInto(valin);
            return valin;
        } catch (Exception e) {
            throw e;
        }
    }

    public void ajoutrestriction(String[] valtab, String idrole, String act, Connection c) throws Exception {
        try {

            for (int i = 0; i < valtab.length; i++) {
                Restriction r = new Restriction(idrole, act, valtab[i]);
                //System.out.println(idrole + " " + act + " " + valtab[i]);
                r.construirePK(c);
                r.insertToTableWithHisto("1060", c);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
        }

    }
    public void ajoutrestriction(String[] valtab, String idrole, String act,String depart,Connection c) throws Exception {
        try {

            for (int i = 0; i < valtab.length; i++) {
                Restriction r = new Restriction(idrole, act, valtab[i], null, null, depart);
                r.construirePK(c);
                r.insertToTableWithHisto("1060", c);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw ex;
        }

    }

    public void modifRestriction(String[] valtab, String idrole, String ajout, String modif, String suppr, String read, HttpServletRequest req, Connection c) throws Exception {

    }

    public void updateRestriction(String tab, String rest, String role, String act, HttpServletRequest req, Connection c) throws Exception {
        try {
            Restriction r = new Restriction();
            r.setId(rest);
            r.deleteToTable();
            if (act != null) {
                r = new Restriction(role, act, tab);
                r.insertToTableWithHisto("UPDATE RESTRICTION");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    public config.Table[] getListeTable(String role,String adr) throws Exception {
       Connection con = null;
        try {
            con=new UtilDB().GetConn();
            String req = "SELECT * FROM matable where 1<2 and  table_name not in(select r.tablename from restriction r where r.idrole='" + role + "' and r.iddirection='"+adr+"')";
            //System.out.print(req);
            Statement s = con.createStatement();
            ResultSet res = s.executeQuery(req);
            Vector v = new Vector();
            while (res.next()) {
                Table st = new Table();
                st.setTable_name(res.getString(1));
                v.add(st);
            }
            Table[] valin = new Table[v.size()];
            v.copyInto(valin);
            return valin;
        } catch (SQLException e) {
            throw e;
        }
        finally{
            if(con!=null)con.close();
        }
    }

}
