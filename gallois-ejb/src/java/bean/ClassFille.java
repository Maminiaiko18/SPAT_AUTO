/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;

import java.sql.Connection;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;

/**
 *
 * @author pro
 */

public abstract class ClassFille extends ClassMAPTable{
    
    private String liaisonMere;
    private ClassMere mere;
    static String nomClasseMere;
    
    
    
    
    public static String getNomClasseMere() {
        return nomClasseMere;
    }

    public static void setNomClasseMere(String nomClasseMer) throws Exception {
        nomClasseMere = nomClasseMer;
    }

    public String getLiaisonMere() {
        return liaisonMere;
    }

    public void setLiaisonMere(String liaisonMere) {
        this.liaisonMere = liaisonMere;
    }

    public ClassMere getMere() {
        return mere;
    }
    public ClassMere findMere(String nomTable,Connection c)throws Exception
    {
         boolean estOuvert=false;
        try
        {
            if(c==null)
            {
                c=new UtilDB().GetConn();
                estOuvert=true;
            }
            ClassMere crt=(ClassMere)Class.forName(getNomClasseMere()).newInstance();
            if(nomTable!=null&&nomTable.compareToIgnoreCase("")!=0) crt.setNomTable(nomTable);
            crt.setValChamp(this.getAttributIDName(), this.getValInsert(this.getLiaisonMere()));
            ClassMere[] valiny= (ClassMere[]) CGenUtil.rechercher(crt, null, null, c, "");
            if(valiny.length>0)
            {
                this.setMere(valiny[0]);
                return valiny[0];
            }
            return null;
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
    public void controlerDelete(Connection c) throws Exception {
        controlerUpdate(c);
    }
    public void controlerUpdate(Connection c) throws Exception {
        ClassMere m=findMere(null,c);
        if(m.getEtat()>=ConstanteEtat.getEtatValider()) throw new Exception("Objet mere deja valide");
    }
    public void setMere(ClassMere mere) {
        this.mere = mere;
    }
    
}
