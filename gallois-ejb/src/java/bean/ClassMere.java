/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;

import java.sql.Connection;
import user.CreateObject;
import user.UserEJB;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;

/**
 *
 * @author pro
 */
public abstract class ClassMere extends ClassEtat{
    
    private ClassFille[] fille;
    private String liaisonFille;
    static String nomClasseFille;
    
    public static String getNomClasseFille() {
        return nomClasseFille;
    }

    public void setNomClasseFille(String nomClasseFill) throws Exception {
        nomClasseFille = nomClasseFill;
    }

    
    public ClassFille[] getFille() {
        return fille;
    }

    public void setFille(ClassFille[] fille) {
        this.fille = fille;
    }

    public String getLiaisonFille() {
        return liaisonFille;
    }

    public void setLiaisonFille(String liaisonFille) {
        this.liaisonFille = liaisonFille;
    }


    public ClassMAPTable createObject(String u,Connection c)throws Exception
    {
        ClassMAPTable ret= super.createObject(u, c);
        if(fille==null) return ret;
        createObjectFille(u,c);
        return ret;
    }
    public void createObjectFille(String u,Connection c) throws Exception
    {
        for(ClassFille f:getFille())
        {
            String idMereF=f.getValInsert(liaisonFille);
            if(idMereF==null||this.getTuppleID().compareToIgnoreCase(idMereF)!=0)f.setValChamp(liaisonFille, this.getTuppleID());
            f.createObject(u, c);
        }
    }
    public ClassFille[] getFille(String nomTable,Connection c,String apresWhere) throws Exception
    {
        boolean estOuvert=false;
        try
        {
            if(c==null)
            {
                c=new UtilDB().GetConn();
                estOuvert=true;
            }
            ClassFille crt=(ClassFille)Class.forName(getNomClasseFille()).newInstance();
            crt.setValChamp(getLiaisonFille(), this.getTuppleID());
            if(nomTable!=null&&nomTable.compareToIgnoreCase("")!=0) crt.setNomTable(nomTable);
            return (ClassFille[])CGenUtil.rechercher(crt, null, null, c, apresWhere);
        }
        catch(Exception e)
        {
            throw e;
        }
        finally
        {
            if(estOuvert==true&&c!=null)c.close();
        }        
    }
    public ClassMAPTable dupliquer(String user,Connection c) throws Exception
    { 
        boolean estOuvert=false;
        try
        {
            if(c==null)
            {
                c=new UtilDB().GetConn();
                estOuvert=true;
                c.setAutoCommit(false);
            }
            ClassMere cm=(ClassMere) super.dupliquer(user,c);
            cm.setEtat(ConstanteEtat.getEtatCreer());
            cm.insertToTableWithHisto(user, c);
            if(this.getFille()==null) this.setFille(getFille(null,c,""));
            cm.setFille(dupliquerFille(user,cm.getTuppleID(), c));
            if(estOuvert==true)c.commit();
            return cm;
        }
        catch(Exception e)
        {
            c.rollback();
            throw e;
        }
        finally
        {
            if(estOuvert==true&&c!=null)c.close();
        }
    }
    public ClassFille[] dupliquerFille(String user,String idMere,Connection c) throws Exception
    {
        ClassFille[] retour=new ClassFille[getFille().length];
        int i=0;
        for(ClassFille f:getFille())
        {
            ClassFille dupl=(ClassFille)f.dupliquer(user, c);
            dupl.setValChamp(liaisonFille, idMere);
            dupl.insertToTableWithHisto(user, c);
            retour[i]=dupl;
            i++;
        }
        return retour;
    }
    
    
}
