/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture.tr;

import bean.CGenUtil;
import bean.ClassEtat;
import facture.PaiementFacture;
import mg.spat.JournalCaisse;
import utilitaire.Constante;
import utilitaire.UtilDB;

import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author Rado
 */
public class FCTraite  extends ClassEtat{
 
    String id, idTraite, idFC, idJc;
    Date daty;
    double montant;
    String tiers;
    String banque;
    String factureClientLib;
    

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdTraite() {
        return idTraite;
    }

    public void setIdTraite(String idTraite) {
        this.idTraite = idTraite;
    }

    public String getIdFC() {
        return idFC;
    }

    public void setIdFC(String idFC) {
        this.idFC = idFC;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public String getTiers() {
        return tiers;
    }

    public void setTiers(String tiers) {
        this.tiers = tiers;
    }

    public String getBanque() {
        return banque;
    }

    public void setBanque(String banque) {
        this.banque = banque;
    }

    public void setFactureClientLib(String factureClientLib) {
        this.factureClientLib = factureClientLib;
    }

    public String getFactureClientLib(){
        return this.factureClientLib;
    }

    public String getIdJc() {
        return idJc;
    }

    public void setIdJc(String idJc) {
        this.idJc = idJc;
    }
    
    @Override
    public String getTuppleID() {
        return id ;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
    public FCTraite() {
        this.setNomTable("fctraite");
    }
    
    @Override
    public void construirePK(Connection c) throws Exception{
        this.preparePk("FC", "GETSEQFCTRAITE");
        this.setId(makePK(c));
    }

    public Traite getTraite(Connection c)throws Exception{
        Traite retour=null;
        int verif=0;
        try{
            if(this.getIdTraite()!=null){
                if(c==null){
                    c=new UtilDB().GetConn();
                    verif=1;
                }
                Traite t=new Traite();
                t.setId(this.getIdTraite());
                Traite[] liste=(Traite[])CGenUtil.rechercher(t, null,null,c,"");
                if(liste.length>0)retour=liste[0];
            }
        }catch(Exception e){
            e.printStackTrace();
            throw e;
        }finally{
            if(c!=null && verif==1)c.close();
        }
        return retour;
    }

    public JournalCaisse getJC(Connection c)throws Exception{
        JournalCaisse retour=null;
        int verif=0;
        try{
            if(c==null){
                c=new UtilDB().GetConn();
                verif=1;
            }

            FCTraite fctraite=(FCTraite)new FCTraite().getById(this.getId(), "FCTRAITE_CPLT", c);
            if(fctraite!=null){
                this.setIdTraite(fctraite.getIdTraite());
                this.setMontant(fctraite.getMontant());
                this.setIdFC(fctraite.getIdFC());
                retour=new JournalCaisse(null, Constante.caisseCentraleBP, null, null, null, fctraite.getTiers(), Constante.typeCheque, fctraite.getDaty(), fctraite.getDaty(), 0.0, fctraite.getMontant());
                retour.setIdbanque(fctraite.getBanque());
            }
            return retour;

        }catch(Exception e){
            e.printStackTrace();
            throw e;
        }finally{
            if(c!=null && verif==1)c.close();
        }
    }

    public void verifSoldeTraite(Connection c)throws Exception{
        Traite traite=this.getTraite(c);
        if(traite!=null && this.getTraite(c).getSolde(c)<this.getMontant()){
            throw new Exception("Solde insuffisant");
        }
    }

    public Object validerObject(String u, Connection c) throws Exception{
        Object retour=this;
        int verif=0;
        try{
            if(c==null){
                c=new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif=1;
            }
            verifSoldeTraite(c);

            JournalCaisse jc=this.getJC(c);
            if(jc!=null){
                jc.createObject(u, c);
                PaiementFacture pf=new PaiementFacture(jc.getTuppleID(), this.getIdFC(), this.getMontant());
                pf.createObject(u, c);
            }

            retour=super.validerObject(u, c);
            
            if(c!=null && verif==1)c.commit();
        }catch(Exception e){
            if(c!=null && verif==1)c.rollback();
            e.printStackTrace();
            throw e;
        }finally{
            if(c!=null && verif==1)c.close();
        }
        return retour;
    }
}
