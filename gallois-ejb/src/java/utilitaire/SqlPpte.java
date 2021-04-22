// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   SqlPpte.java

package utilitaire;

import java.io.Serializable;

public class SqlPpte
    implements Serializable
{

    public SqlPpte(int longCle, String entete, String proc)
    {
        longueurCle = 5;
        enteteCle = "SA";
        procSeq = "GetSeqSante";
        longueurCle = longCle;
        enteteCle = entete;
        procSeq = proc;
    }

    public String getEnteteCle()
    {
        return enteteCle;
    }

    public void setEnteteCle(String en)
    {
        enteteCle = en;
    }

    public int getLongueurCle()
    {
        return longueurCle;
    }

    public void setLongueurCle(int en)
    {
        longueurCle = en;
    }

    public String getProcSeq()
    {
        return procSeq;
    }

    public void setProcSeq(String en)
    {
        procSeq = en;
    }

    int longueurCle;
    String enteteCle;
    String procSeq;
}
