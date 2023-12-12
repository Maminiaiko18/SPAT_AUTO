/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package data;

import bean.AdminGen;
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
import utilitaire.Utilitaire;

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
    
    public BonDeCommandeData(String idEngagement, String idda, String[] idsachat) throws Exception{
        
        Connection c=null;
        try
        {
            c=new UtilDB().GetConn();
            if(idEngagement !=null && !idEngagement.equals("")){
                engagement=(Engagement)engagement.getById(idEngagement, "ENGAGEMENTLIB", null);
            }
            initDa(idda, idsachat, c);
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
    public void initDa(String idDa, String[] idsachat, Connection c) throws Exception{
        boolean estOuvert = false;
        try
        {
            if(c == null)
            {
                c = new UtilDB().GetConn();
                estOuvert = true;
            }
            DemandeAchatFille fille = new DemandeAchatFille();
            fille.setNomTable("dem_achat_fillelib");
            
            if(idsachat != null){
                String ids = Utilitaire.tabToString(idsachat, "'", ",");
                DemandeAchatMere[] meres = (DemandeAchatMere[]) CGenUtil.rechercher(new DemandeAchatMere("dem_achat_merelib"), null, null, c, " and id in (" + ids + ")");
                String[] projet = AdminGen.getDistinct(meres, "projet");
                if(projet.length > 1)
                    throw new Exception("Projets differents pour les demandes achat selectionees");
                String[] coddeet = AdminGen.getDistinct(meres, "codeetablissement");
                if(coddeet.length > 1)
                    throw new Exception("Code etablissement differents pour les demandes achat selectionees");
                demandeAchatMere.setId(Utilitaire.tabToString(idsachat, "", ";"));
                demandeAchatMere.setProjet(meres[0].getProjet());
                demandeAchatMere.setProjetlib(meres[0].getProjetlib());
                demandeAchatMere.setCodeetablissement(meres[0].getCodeetablissement());
                demandeAchatMere.setCodeetablissementlib(meres[0].getCodeetablissementlib());
                demandeAchatfilles = (DemandeAchatFille[]) CGenUtil.rechercher(fille, null, null, c, "and idmere in (" + ids + ")");
            }
            else{
                if(idDa == null) return;  
                demandeAchatMere = (DemandeAchatMere) (new DemandeAchatMere()).getById(idDa, "dem_achat_merelib", c);
                demandeAchatfilles = (DemandeAchatFille[]) CGenUtil.rechercher(fille, null, null, c, "and idmere ='"+idDa+"'");
            }
            
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
