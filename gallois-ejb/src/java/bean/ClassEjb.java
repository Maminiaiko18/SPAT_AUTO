// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   ClassEjb.java

package bean;

import historique.MapHistorique;
import historique.MapUtilisateur;

// Referenced classes of package bean:
//            ErreurDAO, ClassMAPTable

public class ClassEjb
{

    public ClassEjb()
    {
    }

    public int create(ClassMAPTable a, MapUtilisateur b)
        throws Exception
    {
        MapHistorique h = new MapHistorique(a.getClassName(), "insert", b.getTuppleID(), a.getTuppleID());
        return a.insertToTable(h);
    }

    public int update(ClassMAPTable a, MapUtilisateur b)
        throws Exception
    {
        MapHistorique h = new MapHistorique(a.getClassName(), "update", b.getTuppleID(), a.getTuppleID());
        return a.updateToTableWithHisto(h);
    }

    public int delete(ClassMAPTable a, MapUtilisateur b)
        throws Exception
    {
        MapHistorique h = new MapHistorique(a.getClassName(), "delete", b.getTuppleID(), a.getTuppleID());
        return a.deleteToTable(h);
    }
}
