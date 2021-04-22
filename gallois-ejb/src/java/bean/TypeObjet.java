// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   TypeObjet.java

package bean;


// Referenced classes of package bean:
//            ClassMAPTable

public class TypeObjet extends ClassMAPTable
{

    public TypeObjet(String nomTable, String nomProcedure, String suff, String vale, String desc)
    {
        setNomTable(nomTable);
        setNomProcedureSequence(nomProcedure);
        setIndicePk(suff);
        id = makePK();
        val = vale;
        setDesce(desc);
    }

    public TypeObjet(String nomTable, String ide, String vale, String desc)
    {
        setNomTable(nomTable);
        id = ide;
        val = vale;
        setDesce(desc);
    }

    public TypeObjet(String ide, String vale, String desc)
    {
        id = ide;
        val = vale;
        setDesce(desc);
    }
    public TypeObjet(String nt)
    {
      setNomTable(nt);
    }
    public TypeObjet()
    {

    }

    public String getAttributIDName()
    {
        return "id";
    }

    public String getTuppleID()
    {
        return id;
    }

    public void setVal(String val)
    {
        this.val = val;
    }

    public String getVal()
    {
        return val;
    }

    public void setDesce(String desc)
    {
        if(desc == null)
            desce = "-";
        else
            desce = desc;
    }

    public String getDesce()
    {
        return desce;
    }

    public void setId(String id)
    {
        this.id = id;
    }

    public String getId()
    {
        return id;
    }

    public String val;
    public String desce;
    public String id;
    
    public String getValColLibelle() {
        return val;
    }
    
    public static TypeObjet[] get(String nom_Table){
        try{
            TypeObjet to = new TypeObjet();
            to.setNomTable(nom_Table);
            TypeObjet[] liste = (TypeObjet[])CGenUtil.rechercher(to, null, null, "");
            return liste;
        }catch(Exception ex){
            ex.printStackTrace();
        }
        return null;
    }
}
