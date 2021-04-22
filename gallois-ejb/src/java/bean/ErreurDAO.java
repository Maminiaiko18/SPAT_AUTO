// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   ErreurDAO.java

package bean;

import java.sql.Connection;
import utilitaire.Log;

public class ErreurDAO extends Exception
{

    public ErreurDAO(String msgErreur)
    {
        super(msgErreur);
    }

    public ErreurDAO(Connection c, String msgErreur)
    {
        super(msgErreur);
        try
        {
            c.rollback();
        }
        catch(Exception e)
        {
            Log.log("Erreur annulation dans ErrerDAO.java ".concat(String.valueOf(String.valueOf(e.getMessage()))));
        }
    }
}
