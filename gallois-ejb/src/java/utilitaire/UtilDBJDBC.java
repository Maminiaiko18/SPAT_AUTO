// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   UtilDBJDBC.java

package utilitaire;

import java.io.PrintStream;
import java.sql.Connection;
import java.sql.DriverManager;

public class UtilDBJDBC
{

    public UtilDBJDBC(String use, String passwor)
    {
        nom_serveur = "cos1";
        nom_instance = "projet1";
        con = null;
        user = "haja";
        password = "haja";
        user = use;
        password = passwor;
        connectJDBC();
    }

    public UtilDBJDBC(String nom_serv, String nom_inst, String use, String passwor)
    {
        nom_serveur = "cos1";
        nom_instance = "projet1";
        con = null;
        user = "haja";
        password = "haja";
        nom_serveur = nom_serv;
        nom_instance = nom_inst;
        user = use;
        password = passwor;
        connectJDBC();
    }

    public UtilDBJDBC()
    {
        nom_serveur = "cos1";
        nom_instance = "projet1";
        con = null;
        user = "haja";
        password = "haja";
        connectJDBC();
    }

    public void set_nom_serveur(String nom_serv)
    {
        nom_serveur = nom_serv;
    }

    public void set_nom_instance(String nom_inst)
    {
        nom_instance = nom_inst;
    }

    public Connection GetConn()
    {
        return con;
    }

    public void close_connection()
    {
        try
        {
            if(con != null)
                con.close();
        }
        catch(Exception e)
        {
            System.out.println(" ** Erreur : ".concat(String.valueOf(String.valueOf(e.getMessage()))));
        }
    }

    public void connectJDBC()
    {
        try
        {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            String url = String.valueOf(String.valueOf((new StringBuffer("jdbc:oracle:thin:@")).append(nom_serveur).append(":1521:").append(nom_instance)));
            con = DriverManager.getConnection(url, user, password);
        }
        catch(ClassNotFoundException e)
        {
            System.out.println("faute de connexion");
        }
        catch(Exception e)
        {
            System.out.println(" ** Erreur : ".concat(String.valueOf(String.valueOf(e.getMessage()))));
        }
    }

    public void commit_on()
    {
        try
        {
            con.setAutoCommit(true);
        }
        catch(Exception e)
        {
            System.out.println(" ** Erreur : ".concat(String.valueOf(String.valueOf(e.getMessage()))));
        }
    }

    public void commit_off()
    {
        try
        {
            con.setAutoCommit(false);
        }
        catch(Exception e)
        {
            System.out.println(" ** Erreur : ".concat(String.valueOf(String.valueOf(e.getMessage()))));
        }
    }

    public void valider()
    {
        try
        {
            con.commit();
        }
        catch(Exception e)
        {
            System.out.println(" ** Erreur : ".concat(String.valueOf(String.valueOf(e.getMessage()))));
        }
    }

    public void annuler()
    {
        try
        {
            con.rollback();
        }
        catch(Exception e)
        {
            System.out.println(" ** Erreur : ".concat(String.valueOf(String.valueOf(e.getMessage()))));
        }
    }

    private String nom_serveur;
    private String nom_instance;
    private Connection con;
    private String user;
    private String password;
}
