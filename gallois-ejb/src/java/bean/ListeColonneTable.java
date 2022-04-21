package bean;

import java.util.Hashtable;
import java.sql.*;
import java.util.Vector;
import java.lang.reflect.Field;
import utilitaire.UtilDB;
import java.util.Enumeration;
import java.util.List;
import java.util.Arrays;

/**
 * <p>
 * Title: Gestion des recettes </p>
 * <p>
 * Description: </p>
 * <p>
 * Copyright: Copyright (c) 2005</p>
 * <p>
 * Company: </p>
 *
 * @author unascribed
 * @version 1.0
 */
public class ListeColonneTable {

    static Hashtable listeColPTable = new Hashtable();

    public static Field[] getFieldListeHeritage(ClassMAPTable e)throws Exception  {
        Field[] prim = e.getClass().getDeclaredFields();
        //System.out.println("Le nombre de champ de base prim "+e.getClass().getName()+" = "+prim.length);
        if (e.getClass().getSuperclass().getName().endsWith("ClassMAPTable") == true) {
            //return prim;
        }
        Vector listeF = new Vector();
        List temp = Arrays.asList(prim);
        listeF.addAll(temp);
        Class p = e.getClass().getSuperclass();
        while (1 < 2) {
            if (p.getName().endsWith("ClassMAPTable") == true){
                //if(e.getNomTable().compareToIgnoreCase("op_complet")==0)System.out.println("MODE DE E====="+e.getMode());
                if(e.getMode().compareToIgnoreCase("groupe")==0)
                {
                    //Field nbPargroupe=p.getDeclaredField("nombrepargroupe");
                    //listeF.add(nbPargroupe);
                }
                break;
            }
            Field second[] = p.getDeclaredFields();
            //System.out.println("Le nombre de champ de base second "+p.getName()+"  = "+second.length);
            listeF.addAll(Arrays.asList(second));
            p = p.getSuperclass();
        }
        
        Field[] retour = new Field[listeF.size()];
        listeF.copyInto(retour);
        return retour;
    }

    public static void ajouterAlaListe(ClassMAPTable e, Connection c) throws Exception {
        boolean estOuvert=false;
        try
        {
            String nomTable = e.getNomTable();
            boolean testDedans = listeColPTable.containsKey(nomTable);
            if (testDedans == false) {
                if(c==null)
                {
                    c=new UtilDB().GetConn();
                    estOuvert=true;
                }
                Vector r = getChampFromTable(nomTable, c);          
                Field fieldlist[] = getFieldListeHeritage(e);
                if (e.getNomTable().compareToIgnoreCase("LOG_DEMANDE_DEPL_INFO")==0)System.out.println("Taille du r "+fieldlist.length+" vector="+r.size());
                Champ[] retour = new Champ[r.size()];
                Vector intersect = new Vector();
                for (int i = 0; i < r.size(); i++) {
                    retour[i] = (Champ) r.get(i);
                    for (int k = 0; k < fieldlist.length; k++) {
                        if (retour[i].getNomColonne().compareToIgnoreCase(fieldlist[k].getName()) == 0) {
                            intersect.add(new Champ(fieldlist[k], retour[i].getPrecision()));
                            break;
                        }
                    }
                }
                Champ[] valiny = new Champ[intersect.size()];
                intersect.copyInto(valiny);
                //Champ[] =Champ.getChampFromTable(nomTable,c);
                //for(int i=0;i<valiny.length;i++) System.out.println("liste champ=="+valiny[i].getNomColonne());
                if (valiny.length > 0) {
                    listeColPTable.put(nomTable, valiny);
                }
            }
        }
        catch(Exception ex)
        {
            if(c!=null)c.rollback();
            throw ex;
        }
        finally
        {
            if(estOuvert==true&&c!=null)c.close();
        }
    }

    public static Field[] getChampBase(ClassMAPTable e, Connection c) throws Exception {
        String nomTable = e.getNomTable();
        boolean testDedans = listeColPTable.containsKey(nomTable);
        Champ[] retour = null;
        if (testDedans == false) {
            Vector r = getChampFromTable(nomTable, c);
            retour = new Champ[r.size()];
            r.copyInto(retour);
        } else {
            retour = (Champ[]) listeColPTable.get(nomTable);
        }
        Field fieldlist[] = getFieldListeHeritage(e);
        Vector intersect = new Vector();
        for (int i = 0; i < retour.length; i++) {
            for (int k = 0; k < fieldlist.length; k++) {
                if (retour[i].getNomColonne().compareToIgnoreCase(fieldlist[k].getName()) == 0) {
                    intersect.add(fieldlist[k]);
                    break;
                }
            }
        }
        Field[] valiny = new Field[intersect.size()];
        intersect.copyInto(valiny);
        return valiny;
    }

    public static Champ[] getFromListe(ClassMAPTable e, Connection c) throws Exception {
        String nomTable = e.getNomTable();
        ajouterAlaListe(e, c);
        return (Champ[]) listeColPTable.get(nomTable);
    }
    public static Champ getChamp(ClassMAPTable e, String col, Connection cnx) throws Exception {
        try {
            Champ[] liste = null;
            //System.out.println("AVANT EEE TABLE "+e.getNomTable() );
            //if (listeColPTable.containsKey(e.getNomTable()) == false) 
            if (listeColPTable.containsKey(e.getNomTable()) == false) 
            {
                //System.out.println("INTERIEUR PAS DE TABLE:"+e.getNomTable());
                //cnx = new UtilDB().GetConn();
                liste = getFromListe(e, cnx);
                //System.out.println("TAILLE DE LA LISTE TABLE "+liste.length);
            } else {
                //System.out.println("INTERIEUR ELSE PAS DE TABLE=="+e.getNomTable());
                liste = (Champ[]) listeColPTable.get(e.getNomTable());
            }
            if(liste==null)return null;
            for (int i = 0; i < liste.length; i++) {
	        //System.out.println("liste["+i+"]======="+liste[i].getNomColonne());
                if (liste[i].getNomColonne().compareToIgnoreCase(col) == 0) {
                    return liste[i];
                }
            }
            return null;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        } 
    }
    public static Champ getChamp(ClassMAPTable e, String col) throws Exception {
        Connection cnx=null;
        try {
            Champ[] liste = null;
            
            System.out.println("AVANT EEE TABLE "+e.getNomTable() );
            if (listeColPTable.containsKey(e.getNomTable()) == false) 
            {
                System.out.println("INTERIEUR PAS DE TABLE:"+e.getNomTable());
                cnx = new UtilDB().GetConn();
                liste = getFromListe(e, cnx);
                System.out.println("TAILLE DE LA LISTE TABLE "+liste.length);
            } else {
                System.out.println("INTERIEUR ELSE PAS DE TABLE=="+e.getNomTable());
                liste = (Champ[]) listeColPTable.get(e.getNomTable());
            }
            for (int i = 0; i < liste.length; i++) {
	        System.out.println("liste["+i+"]======="+liste[i].getNomColonne());
                if (liste[i].getNomColonne().compareToIgnoreCase(col) == 0) {
                    return liste[i];
                }
            }
            return null;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        } 
        finally
        {
            if(cnx!=null)cnx.close();
        }
    }

    /*public static Champ getChamp(ClassMAPTable e, String col) throws Exception {
        Connection cnx = null;
        try {
            Champ[] liste = null;
            if (listeColPTable.containsKey(e.getNomTable()) == false) {
                cnx = new UtilDB().GetConn();
                return getChamp(e,col,cnx);
                
            } 
            else return getChamp(e,col,null);
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        } finally {
            if (cnx != null) {
                cnx.close();
            }
        }
    }*/
    /*
     public static Champ[] getFromListe(String nomTable, Connection c) throws Exception
     {
     ajouterAlaListe(nomTable, c);
     return (Champ[])listeColPTable.get(nomTable);
     }*/

    public static Vector getChampFromTable(String nomT, Connection c) throws Exception {
        Statement st = null;
        ResultSet dr = null;
        try {
            //Console.WriteLine("NIDITRA NAKA CHAMP "+nomT);
            String comande = "SELECT * FROM USER_TAB_COLUMNS where table_Name = upper('" + nomT + "') order by column_id asc";
            //if (nomT.compareToIgnoreCase("sig_deposant_n_affilie")==0) System.out.println("Liste colonne venant de la base = "+comande);      
            st = c.createStatement();
            dr = st.executeQuery(comande);
            Vector retour = new Vector();
            int i = 0;
            while (dr.next()) {
                Champ temp = new Champ(dr.getString(2), dr.getString(3), dr.getInt(7), dr.getInt(8));
                retour.add(temp);
                i++;
            }
            Champ temp = new Champ("nombrepargroupe", "NUMBER", 10, 0);
            retour.add(temp);
            return retour;
        } catch (Exception ex) {
            throw ex;
        } finally {
            if (st != null) {
                st.close();
            }
            if (dr != null);
            dr.close();
        }
    }

}
