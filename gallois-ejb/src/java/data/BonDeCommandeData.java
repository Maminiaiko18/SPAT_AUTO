/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package data;

import bean.CGenUtil;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.SQLException;
import mg.spat.DemandeAchatFille;
import mg.spat.DemandeAchatMere;
import mg.spat.Engagement;
import mg.spat.stock.BonDeCommande;
import mg.spat.stock.BonDeCommandeFille;
import utilitaire.UtilDB;

/**
 *
 * @author nyamp
 */
public class BonDeCommandeData {
    String idEngagement ;
    Engagement engagement=new Engagement();
    DemandeAchatMere demandeAchatMere=new DemandeAchatMere();
    DemandeAchatFille[] demandeAchatfilles={};
    
    public BonDeCommandeData(String idEngagement) throws Exception{
        if(idEngagement !=null && !idEngagement.equals("")){
            engagement=(Engagement)engagement.getById(idEngagement, "ENGAGEMENTLIB", null);
        }
    }
    
    public BonDeCommandeData(String idEngagement,String idda) throws Exception{
        
        Connection c=null;
        try
        {
            c=new UtilDB().GetConn();
            if(idEngagement !=null && !idEngagement.equals("")){
                engagement=(Engagement)engagement.getById(idEngagement, "ENGAGEMENTLIB", null);
            }
            initDa(idda, c);
        }
        catch(Exception e)
        {
            e.printStackTrace();
            if(c!=null)c.rollback();
            throw e;
        }
        finally
        {
            if(c!=null)c.close();
        }
    }
    
    public BonDeCommandeData() throws Exception{
       
    }
    public void initDa(String idDa, Connection c) throws Exception{
        if(idDa==null) return;  
        boolean estOuvert=false;
        try
        {
            if(c==null)
            {
                c=new UtilDB().GetConn();
                estOuvert=true;
            }
            demandeAchatMere=(DemandeAchatMere) (new DemandeAchatMere()).getById(idDa, "dem_achat_merelib", c);
            DemandeAchatFille fille=new DemandeAchatFille();
            fille.setNomTable("dem_achat_fillelib");
            demandeAchatfilles= (DemandeAchatFille[]) CGenUtil.rechercher(fille, null, null, c, "and idmere ='"+idDa+"'");
            
        }
        catch(Exception e)
        {
            e.printStackTrace();
            if(c!=null&&estOuvert==true)c.rollback();
            throw e;
        }
        finally
        {
            if(c!=null&&estOuvert==true)c.close();
        }
    }   

    public String getIdEngagement() {
        return idEngagement;
    }

    public void setIdEngagement(String idEngagement) {
        this.idEngagement = idEngagement;
    }

    public Engagement getEngagement() {
        return engagement;
    }

    public void setEngagement(Engagement engagement) {
        this.engagement = engagement;
    }

    public DemandeAchatMere getDemandeAchatMere() {
        return demandeAchatMere;
    }

    public void setDemandeAchatMere(DemandeAchatMere demandeAchatMere) {
        this.demandeAchatMere = demandeAchatMere;
    }

    public DemandeAchatFille[] getDemandeAchatfilles() {
        return demandeAchatfilles;
    }

    public void setDemandeAchatfilles(DemandeAchatFille[] demandeAchatfilles) {
        this.demandeAchatfilles = demandeAchatfilles;
    }
    
    
}
