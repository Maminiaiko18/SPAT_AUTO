/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat.placement;

import bean.CGenUtil;
import bean.ClassEtat;
import bean.TypeObjet;
import mg.spat.JournalCaisse;

import java.sql.Connection;
import java.sql.Date;
import user.UserEJBBean;
import utilitaire.Constante;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author Antsa
 */
public class Placement extends ClassEtat {
    
    private String id;
    private String entite;
    private String numero;
    private String iddevise;
    private Date date_placement;
    private Date date_echeance;
    private double duree;
    private double montant;
    private double taux;
    private double montantdevise;
    private String banque;
    private int moisPlacement;
    private int moisRembousement;
    private int anneePlacement,anneeRembousement;
    private double montant_terme;
    private double interet_recevoir;
    private double interetNet;
    private String ancienPlacement,designation;

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }
    private String moisPlacementlib,moisRembousementlib,type;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
    
    public int getAnneeRembousement() {
        return anneeRembousement;
    }

    public void setAnneeRembousement(int anneeRembousement) {
        this.anneeRembousement = anneeRembousement;
    }

    public String getMoisPlacementlib() {
        return moisPlacementlib;
    }

    public void setMoisPlacementlib(String moisPlacementlib) {
        this.moisPlacementlib = moisPlacementlib;
    }

    public String getMoisRembousementlib() {
        return moisRembousementlib;
    }

    public void setMoisRembousementlib(String moisRembousementlib) {
        this.moisRembousementlib = moisRembousementlib;
    }
    

    public Placement() {
         super.setNomTable("placement");
    }

    public String getIddevise() {
        return iddevise;
    }

    public void setIddevise(String iddevise) {
        this.iddevise = iddevise;
    }

    public double getMontantdevise() {
        return montantdevise;
    }

    public void setMontantdevise(double montantdevise) {
        this.montantdevise = montantdevise;
    }

    
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getEntite() {
        return entite;
    }

    public void setEntite(String entite) {
        this.entite = entite;
    }

    public Date getDate_placement() {
        return date_placement;
    }

    public void setDate_placement(Date date_placement) {
        this.date_placement = date_placement;
    }

    public Date getDate_echeance() {
        return date_echeance;
    }

    public void setDate_echeance(Date date_echeance) throws Exception{
        if(this.getMode().compareTo("modif")==0){
            if(date_echeance == null) throw new Exception("Date échéance obligatoire");
            if(this.getDate_placement()!=null && Utilitaire.compareDaty(date_echeance, this.getDate_placement())!=1)
                throw new Exception("La date d échéance doit être supérieure à la date de placement");
        }
        this.date_echeance = date_echeance;  
    }

    public double getDuree() {
        return duree;
    }

    public void setDuree(double duree) {
        this.duree = duree;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) throws Exception {
        if(montant < 0){
            throw new Exception("montant negatif");
        }
        this.montant = montant;
        
    }

    public double getTaux() {
        return taux;
    }

    public void setTaux(double taux)  throws Exception {
         if(taux < 0 || taux >100){
            throw new Exception("montant negatif");
        }
        this.taux = taux;
    }
    @Override
     public void controlerUpdate(Connection c) throws Exception {
         try{
            this.setDuree(Utilitaire.diffMoisDaty(this.getDate_echeance(), this.getDate_placement()));
         }
         catch(Exception ex){
             throw ex;
         }
    } 
     
    @Override
    public void controler(Connection c) throws Exception{
        this.setDuree(Utilitaire.diffMoisDaty(this.getDate_echeance(), this.getDate_placement()));
    }

    @Override
    public String getTuppleID() {
      return this.id;
    }
 @Override
    public String getAttributIDName() {
        return "id";
    }
    
    public void construirePK(Connection c) throws Exception {
         this.preparePk("PLC", "getseqplacement");
        this.setId(makePK(c));
        
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public String getBanque() {
        return banque;
    }

    public void setBanque(String banque) {
        this.banque = banque;
    }

    public int getMoisPlacement() {
        return moisPlacement;
    }

    public void setMoisPlacement(int moisPlacement) {
        this.moisPlacement = moisPlacement;
    }

    public int getMoisRembousement() {
        return moisRembousement;
    }

    public void setMoisRembousement(int moisRemboursement) {
        this.moisRembousement = moisRemboursement;
    }

    public int getAnneePlacement() {
        return anneePlacement;
    }

    public void setAnneePlacement(int anneePlacement) {
        this.anneePlacement = anneePlacement;
    }

    public double getMontant_terme() {
        return montant_terme;
    }

    public void setMontant_terme(double montant_terme) {
        this.montant_terme = montant_terme;
    }

    public double getInteret_recevoir() {
        return interet_recevoir;
    }

    public void setInteret_recevoir(double interet_recevoir) {
        this.interet_recevoir = interet_recevoir;
    }

    public double getInteretNet() {
        return interetNet;
    }

    public void setInteretNet(double interetNet) {
        this.interetNet = interetNet;
    }

    
    public String getAncienPlacement() {
        return ancienPlacement;
    }

    public void setAncienPlacement(String ancienPlacement) {
        this.ancienPlacement = ancienPlacement;
    }

    
    public void controlerEntite(Connection c) throws Exception{
        int verif = 0;
        try{
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
                c.setAutoCommit(false);
            }
            Liaisonplacement lpla = new Liaisonplacement();
            lpla.setIdentite(this.getEntite());
            if(!this.getBanque().equals("BANQ000000")){
                lpla.setIdbanque(this.getBanque());
                Liaisonplacement[] liste=(Liaisonplacement[]) CGenUtil.rechercher(lpla, null, null, c, " ");
                if(liste.length == 0)
                     throw new Exception("Cette entite n est pas liee a une banque.");
            }
            if(verif == 1) c.commit();
        }catch(Exception e){
            if(verif == 1 && c != null) c.rollback();
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    public DetailsPlacements getDetailsPlacement(Connection c) throws Exception{
        DetailsPlacements dp = new DetailsPlacements();
        DetailsPlacements temp = new DetailsPlacements(); temp.setIdmere(this.getId());
        DetailsPlacements[] dps = (DetailsPlacements[]) CGenUtil.rechercher(temp, null, null, c, "");
        if(dps != null && dps.length >0){
            dp = dps[0];
        }
        return dp;
    }
    public Placement getPlacement(Connection c) throws Exception{
        Placement dp = new Placement();
        Placement temp = new Placement(); temp.setId(this.getId());
        Placement[] dps = (Placement[]) CGenUtil.rechercher(temp, null, null, c, "");
        if(dps != null && dps.length >0){
            dp = dps[0];
        }
        return dp;
    }
    public static void viserEtRendreEffectif(Connection c, UserEJBBean u, String id) throws Exception {
        boolean check = false;
        try {
            if(c == null){
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                check = true;
            }
            Placement p = new Placement();
            p.setId(id);
            Object[] ps = CGenUtil.rechercher(p, null, null, c, "");
            if(ps == null || ps.length == 0) throw new Exception("Aucun placement trouvé");
            p = (Placement) ps[0];
            p.validerObject(String.valueOf(u.getUser().getRefuser()), c);

            TypeObjet pb = new TypeObjet();
            pb.setNomTable("placement_banque_caisse");
            pb.setVal(p.getBanque());
            Object[] pbs = CGenUtil.rechercher(pb, null, null, c, "");
            if(pbs == null || pbs.length == 0) throw new Exception("Aucun placement banque trouvé");
            pb = (TypeObjet) pbs[0];

            PlacementLibComplet pc = new PlacementLibComplet();
            pc.setId(id);
            Object[] pcs = CGenUtil.rechercher(pc, null, null, c, "");
            if(pcs == null || pcs.length == 0) throw new Exception("Aucun placement lib trouvé");
            pc = (PlacementLibComplet) pcs[0];
            
            JournalCaisse jc = new JournalCaisse();
            jc.setCaisse(pb.getDesce());
            jc.setLibelle(String.format("Débit placement %s - %s du %s", pc.getValentite(), pc.getValbanque(), p.getDate_placement()));
            jc.setDateEffet(Utilitaire.dateDuJourSql());
            jc.setDebit(p.getMontant());
            jc.setIdTypeCheque(Constante.typeChequeAuComptant);
            jc.setIddevise(Constante.deviseAr);
            jc.setIdmode(Constante.idmodeVirement);
            jc.setIdplacement(p.getId());
            jc.setIdplacementvrai(p.getId());
            
            jc.createObject(String.valueOf(u.getUser().getRefuser()), c);
            jc.viser(u, c);
            c.commit();
        }
        catch(Exception ex){
            c.rollback();
            throw ex;
        }
        finally {
            if(check) c.close();
        }
    }
    
    public static Placement[] findPlacementsPrecedants(Connection c,String idDernier ) throws Exception{
         boolean check = false;
         Placement[] result = null;
        try {
            if(c == null){
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                check = true;
            }
            result = (Placement[]) CGenUtil.rechercher(new Placement(), "select * from placement WHERE etat>=11 CONNECT BY PRIOR ANCIENPLACEMENT = id START WITH id ='"+idDernier+"'");
        }catch(Exception e){
            c.rollback();
            throw e;
        }finally {
            if(check) c.close();
        }
        return result;
    }

    public JournalCaisse[] getSortie(Connection c)throws Exception{
        JournalCaisse[] retour = null;
        int verif=0;
        try{
            if(c==null){
                c=new UtilDB().GetConn();
                verif=1;
            }
            JournalCaisse jc = new JournalCaisse();
            jc.setIdplacement(this.getTuppleID());
            String aWhere = " AND debit!=0";
            retour = (JournalCaisse[])CGenUtil.rechercher(jc,null,null,c,aWhere);
        }catch(Exception e){
            e.printStackTrace();
            throw e;
        }finally{
            if(c!=null && verif==1)c.close();
        }
        return retour;
    }

    public JournalCaisse[] getEntree(Connection c)throws Exception{
        JournalCaisse[] retour = null;
        int verif=0;
        try{
            if(c==null){
                c=new UtilDB().GetConn();
                verif=1;
            }
            JournalCaisse jc = new JournalCaisse();
            jc.setIdplacement(this.getTuppleID());
            String aWhere = " AND credit!=0";
            retour = (JournalCaisse[])CGenUtil.rechercher(jc,null,null,c,aWhere);
        }catch(Exception e){
            e.printStackTrace();
            throw e;
        }finally{
            if(c!=null && verif==1)c.close();
        }
        return retour;
    }
}
