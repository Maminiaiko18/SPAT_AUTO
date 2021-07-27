// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   UtilDB.java
package utilitaire;

import java.io.PrintStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Hashtable;
import java.util.Properties;
import java.util.TimeZone;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import javax.naming.Context;

// Referenced classes of package utilitaire:
//            Parametre
public class UtilDB {

    public static InitialContext getContext()
            throws NamingException {
        Properties env = new Properties();
        env.put("java.naming.factory.initial", "org.jnp.interfaces.NamingContextFactory");
        env.put("java.naming.provider.url", PROVIDER_URL);
        env.put("java.naming.rmi.security.manager", "yes");
        env.put("java.naming.factory.url.pkgs", "org.jboss.naming");
        //env.put(Context.INITIAL_CONTEXT_FACTORY,"weblogic.jndi.WLInitialContextFactory");
        //env.put(Context.PROVIDER_URL,"t3://localhost:7001");
        return new InitialContext(env);
    }

    public UtilDB(String user, String passWOracle) {
        conn = null;
        try {
            InitialContext jndiContext = getContext();
            DataSource ds = (DataSource) jndiContext.lookup("java:VVFinances");
            conn = ds.getConnection(user, passWOracle);
        } catch (NamingException ne) {
            System.out.println("UtilDB Erreur Naming : ".concat(String.valueOf(String.valueOf(ne.getMessage()))));
        } catch (SQLException se) {
            System.out.println("UtilDB Erreur Connexion : ".concat(String.valueOf(String.valueOf(se.getMessage()))));
        }
    }

    public UtilDB() {
        conn = null;
    }

    // Sans dataSource
    public Connection GetConnSimple() {
        Connection conn = null;
        try {
            TimeZone timeZone = TimeZone.getTimeZone("Asia/Baghdad");
            TimeZone.setDefault(timeZone);
            Class.forName("oracle.jdbc.driver.OracleDriver");
            //conn = DriverManager.getConnection("jdbc:oracle:thin:@10.211.55.5:1521:orcl", "sigi", "sigi16");
            //conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.88.223:1521:orcl", "gallois3", "gallois3");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "gallois", "gallois");
            Connection connection2 = conn;
            return connection2;
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        } catch (SQLException ex) {
            System.out.println("UtilDB Erreur Connexion : ".concat(String.valueOf(String.valueOf(ex.getMessage()))));
        }
        return null;
    }

    //Avec dataSource
    public Connection GetConn() {
        Connection conn = null;
        try {
            TimeZone timeZone = TimeZone.getTimeZone("Asia/Baghdad");
            TimeZone.setDefault(timeZone);
            Class.forName("oracle.jdbc.driver.OracleDriver");
            //conn = DriverManager.getConnection("jdbc:oracle:thin:@10.211.55.5:1521:orcl", "sigi", "sigi16");
            //conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.88.223:1521:orcl", "gallois3", "gallois3");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@127.0.0.1:1521:orcl", "spat_capitainerie", "spat2020");
            Connection connection2 = conn;
            return connection2;
        } catch (Exception ne) {
            System.out.println("UtilDB Erreur Naming : ".concat(String.valueOf(String.valueOf(ne.getMessage()))));
        }
        return conn;
    }
    
    public void commitON() {
        try {
            conn.setAutoCommit(true);
        } catch (Exception e) {
            System.out.println(" ** Erreur commit on: ".concat(String.valueOf(String.valueOf(e.getMessage()))));
        }
    }

    public void commitOFF() {
        try {
            conn.setAutoCommit(false);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void close_connection() {
        try {
            if (conn != null) {
                conn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void valider() {
        try {
            conn.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void annuler() {
        try {
            conn.rollback();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    Connection conn;
    public static final String INITIAL_CONTEXT_FACTORY = "org.jnp.interfaces.NamingContextFactory";
    public static final String PROVIDER_URL = "localhost:1099";

   

}
