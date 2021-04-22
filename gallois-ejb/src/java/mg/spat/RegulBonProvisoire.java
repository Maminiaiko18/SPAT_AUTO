/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.CGenUtil;
import bean.ClassEtat;
import java.sql.Connection;
import java.sql.Date;
import user.UserEJB;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author pro
 */

public class RegulBonProvisoire extends ClassEtat{
    
    private String id;
    private String idBonProvisoire;
    private String remarque;
    private double montant;
    private Date daty;

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public RegulBonProvisoire() {
        super.setNomTable("regulBonProvisoire");
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdBonProvisoire() {
        return idBonProvisoire;
    }

    public void setIdBonProvisoire(String idBonProvisoire) {
        this.idBonProvisoire = idBonProvisoire;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
    public void construirePK(Connection c) throws Exception {
        this.preparePk("RGBP", "getseq_regulBonProvisoire");
        this.setId(makePK(c));

    }
    public BonProvisoire getBonProvisoire(Connection c) throws Exception{
        int verif = 0;
        BonProvisoire bp=null;
        try{
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            BonProvisoire[] lbp=(BonProvisoire[]) CGenUtil.rechercher(new BonProvisoire(), null, null, c, " and id='"+this.getIdBonProvisoire()+"'");
            if(lbp.length>0) bp=lbp[0];
            
        }catch(Exception e){
            c.rollback();
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
        return bp;
    }
    public void saveRegul(Connection c,UserEJB u) throws Exception{
        int verif = 0;
        try{
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
                c.setAutoCommit(false);
            }
            BonProvisoire bp=this.getBonProvisoire(c);
            if(bp.getEtat()!=ConstanteEtat.getEtatValider()) throw new Exception("Bon provisoire non valide");
            if((bp.getSommeRegulBonPrpvisoire(c)+this.getMontant())>bp.getDebit()) throw new Exception("Le montant regularise est superieur au reste a payer");
            u.createObject(this, c);
            
            JournalCaisse jc=new JournalCaisse(bp.getId(), bp.getCaisse(), null, this.getRemarque(), this.getRemarque(), Utilitaire.dateDuJourSql(), Utilitaire.dateDuJourSql(), 0, this.getMontant());
            u.createObject(jc, c);
            if(verif == 1) c.commit();
            
        }catch(Exception e){
            c.rollback();
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    public void saveRetour(Connection c,UserEJB u) throws Exception{
        int verif = 0;
        try{
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
                c.setAutoCommit(false);
            }
            BonProvisoire bp=this.getBonProvisoire(c);
            if(bp.getEtat()!=ConstanteEtat.getEtatValider()) throw new Exception("Bon provisoire non valide");
            if((bp.getDebit()-bp.getSommeRegulBonPrpvisoire(c))!=this.getMontant()) throw new Exception("Montant different du reste!!");
            this.setMontant(this.getMontant()*-1);
            u.createObject(this, c);
            
            if(verif == 1) c.commit();
            
        }catch(Exception e){
            c.rollback();
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
}

