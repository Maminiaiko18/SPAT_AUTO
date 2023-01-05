/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;

import java.sql.Connection;
import java.sql.Statement;
import user.UserEJBBean;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;

/**
 *
 * @author GILEADA
 */
public abstract class ClassEtat extends ClassUser{

    int etat = 1;

    public int getEtat() {
        return etat;
    }
    
    public void setEtat(int etat) {
        this.etat = etat;
    }
    
    public String getEtatText(int value){
        return chaineEtat(value);
    }
    public String chaineEtat(int value){
        if(value == ConstanteEtat.getEtatCreer()) return "<b style='color:lightskyblue'>CR&Eacute;&Eacute;(E)</b>";
       if(value == ConstanteEtat.getEtatPrivilegerRetourRelance()) return "<b style='color:green'>AVEC�PRIVILEGE </b>";
        if(value == ConstanteEtat.getEtatValider()) return "<b style='color:green'>VIS&Eacute;(E)</b>";
        if(value == ConstanteEtat.getEtatAnnuler()) return "<b style='color:orange'>ANNUL&Eacute;(E)</b>";
        if(value==ConstanteEtat.getEtatCloture()) return "<b style='color:orange'>CLOTUR&Eacute;(E)</b>";
        if(value==ConstanteEtat.getEtatRejeter()) return "<b style='color:red'>REJET&Eacute;(E)</b>";
        if(value==ConstanteEtat.etatExpedition) return "<b style='color:green'>EXP&Eacute;DI&Eacute;E</b>";
        if(value==ConstanteEtat.getEtatSTCCreer()) return "<b style='color:green'>STC CR&Eacute;&Eacute;</b>";
        if(value==ConstanteEtat.getEtatSTCPayer()) return "<b style='color:green'>STC PAY&Eacute;</b>";
        if (value == ConstanteEtat.getEtatRappelGenerer()) return "<b style='color:blue'>RAPPEL GENER&Eacute;</b>";
        if (value == ConstanteEtat.getEtatEditionCloturee()) return "<b style='color:blue'>CL&Ocirc;TUR&Eacute;E</b>";
        if (value == ConstanteEtat.getEtatEditionRecalculee()) return "<b style='color:grey'>RECALCUL&Eacute;E</b>";
        if (value == ConstanteEtat.getEtatDebauche()) return "<b style='color:grey'>DEBAUCH&Eacute;(E)</b>";
        if (value == ConstanteEtat.getEtatRegulariser()) return "<b style='color:blue'>REGULARIS&Eacute;(E)</b>";
        if (value == ConstanteEtat.getEtatEchu()) return "<b style='color:red'>ECHU</b>";
        return null;
    }
    /*public int updateEtat(int valeurEtat, String id, Connection c) throws Exception {
        Statement cmd = null;
        try {
            String req = "update " + getNomTable() + " set etat=" + valeurEtat + " where " + getAttributIDName() + " = '" + id + "'";
            cmd = c.createStatement();
            return cmd.executeUpdate(req);

        } catch (Exception ex) {
            if( c != null ){c.rollback();}
            throw ex;
        } finally {
            cmd.close();
        }
    }*/
    /*
    **Sur definissiavana ity raha misy controle hafa avant annuler ka tiana atao personnalisé
    */
    public void controleAnnuler(Connection c) throws Exception
    {
        if(getEtat()>=ConstanteEtat.getEtatValider()) throw new Exception("Impossible à annuler, deja valide");
    }
    public void controleAnnulerVisa(Connection c) throws Exception
    {
        if(getEtat()>ConstanteEtat.getEtatValider()) throw new Exception("Impossible d annuler le Visa, superieur valide");
    }
    public int annuler(Connection c)throws Exception
    {
        controleAnnuler(c);
        setMode("modif");
        this.setEtat(ConstanteEtat.getEtatAnnuler());
        return this.updateToTable(c);
    }
    public int annuler(String user,Connection c)throws Exception
    {
        controleAnnuler(c);
        setMode("modif");
        this.setEtat(ConstanteEtat.getEtatAnnuler());
        return this.updateToTableWithHisto(user, c);
    }
    public int annulerVisa(String user,Connection c) throws Exception
    {
        controleAnnulerVisa(c);
        setMode("modif");
        this.setEtat(ConstanteEtat.getEtatCreer());
        return this.updateToTableWithHisto(user,c);
    }
    public Object validerObject(String u, Connection c) throws Exception
    {
        setMode("modif");
        controler(c);
        this.setEtat(ConstanteEtat.getEtatValider());
        this.updateToTableWithHisto(u, c);
        return this;
    }
    public void viser(UserEJBBean user,Connection c) throws Exception
    {
        validerObject(user.getUser().getTuppleID() ,c);
    }
    public Object annulerValidation(String u, Connection c) throws Exception
    {
        annulerVisa(u, c);
        return this;
    }
    public Object cloturer(UserEJBBean user,Connection c,int etat) throws Exception
    {
        boolean estOuvert=false;
        try{
            if(c==null)
            {
                c=new UtilDB().GetConn();
                estOuvert=true;
            }
            int etatClot=9;
            if(etat>=0)etatClot=etat;
            if(this.getEtat()>etat) throw new Exception("Objet non cloturable, deja visé");
            this.setEtat(etat);
            this.updateToTableWithHisto(user.getUser().getTuppleID(), c);
            if(estOuvert==true)c.commit();
            return this;
        }
        catch(Exception e)
        {
            c.rollback();
            e.printStackTrace();
        }
        finally
        {
            if(estOuvert==true&&c!=null)c.close();
        }
        return this;
    }
}
