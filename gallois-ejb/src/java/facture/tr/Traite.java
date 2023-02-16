/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture.tr;

import bean.AdminGen;
import bean.CGenUtil;
import bean.ClassEtat;
import facture.FactureClient;
import mg.spat.JournalCaisse;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

import java.sql.Connection;
import java.sql.Date;
import mg.spat.MvttIntraCaisse;
import utilitaire.Constante;

/**
 *
 * @author Rado
 */
public class Traite extends ClassEtat {

    String id, tiers, banque, reference,cdclt;
    Date daty, dateEcheance;
    double montant,escompte,total,montantreste;
    String idtypepiece;
    String idfinaledestination;
    String idbanque, typepiece;


    public String getIdbanque() {
        return idbanque;
    }

    public void setIdbanque(String idbanque) {
        this.idbanque = idbanque;
    }

    public String getIdfinaledestination() {
        return idfinaledestination;
    }

    public void setIdfinaledestination(String idfinaledestination) {
        this.idfinaledestination = idfinaledestination;
    }

    public String getIdtypepiece() {
        return idtypepiece;
    }

    public void setIdtypepiece(String idtypepiece) {
        this.idtypepiece = idtypepiece;
    }
    

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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

    public void setBanque(String banque)throws Exception {
        if(this.getMode().equals("modif") && Utilitaire.champNull(banque).isEmpty()){
            throw new Exception("Banque obligatoire");
        }
        this.banque = banque;
    }

    public String getReference() {
        return reference;
    }

    public void setReference(String reference) {
        this.reference = reference;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public Date getDateEcheance() {
        return dateEcheance;
    }

    public void setDateEcheance(Date dateEcheance) {
        this.dateEcheance = dateEcheance;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public double getEscompte() {
        return escompte;
    }

    public void setEscompte(double escompte) {
        this.escompte = escompte;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public double getMontantreste() {
        return montantreste;
    }

    public void setMontantreste(double montantreste) {
        this.montantreste = montantreste;
    }

    public String getCdclt() {
        return cdclt;
    }

    public void setCdclt(String cdclt) {
        this.cdclt = cdclt;
    }
    
    
    
    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public Traite() {
        this.setNomTable("traite");
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("TR", "getseqtraite");
        this.setId(makePK(c));
    }

    /*
      Fonction pour voir le montant de traite disponibles
    */
    public double getMontantDispo(Connection c) throws Exception{
        double toReturn = 0;
       if(this.getId()!=null){
           FCTraite fcTraiteCritere = new FCTraite();
           fcTraiteCritere.setIdTraite(this.getId());
           FCTraite[] fcTraites = (FCTraite[]) CGenUtil.rechercher(fcTraiteCritere,null,null,c,"");
           for(FCTraite fcTraite: fcTraites){
               toReturn += fcTraite.getMontant();
           }
       }
       return this.getMontant() - toReturn;
    }
    
    public Escompte[] getEscompte(Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            Escompte escompte = new Escompte();
            escompte.setIdTraite(this.getId());
            return (Escompte[]) CGenUtil.rechercher(escompte, null, null, c, " AND ETAT=" + ConstanteEtat.getEtatValider());
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    public JournalCaisse[] getRetour(Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            JournalCaisse jc = new JournalCaisse();
            jc.setIdordre(this.getId());
            return (JournalCaisse[]) CGenUtil.rechercher(jc, null, null, c, " AND DEBIT!=0");
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    public FactureClient[] getFactureLiees(Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            FactureClient fact = new FactureClient();
            fact.setNomTable("factureclient_traite");
            fact.setIdtraite(this.getId());
            return (FactureClient[]) CGenUtil.rechercher(fact, null, null, c, "");
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    public double getSolde(Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            FactureClient[] facture = getFactureLiees(c);
            double montantF = AdminGen.calculSommeDouble(facture, "montant");
            return this.getMontant() - montantF;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    public void lierJournalCaisse(String[] ids) throws Exception{
        Connection c = null;
        try{
            c=new UtilDB().GetConn();
            c.setAutoCommit(false);
            lierJournalCaisse(ids,c);
            c.commit();
        }
        catch(Exception ex){
            if(c!=null)c.rollback();
            ex.printStackTrace();
            throw ex;
        }
        finally{
            if(c!=null)c.close();
        }
    }
    public void lierJournalCaisse(String[] ids, Connection c) throws Exception{
        JournalCaisse critere = new JournalCaisse();
        critere.setNomTable("journalcaisse");
        JournalCaisse[] journaux =  (JournalCaisse[])CGenUtil.rechercher(critere,null,null,c," and id in ("+Utilitaire.tabToString(ids, "'", ",")+")");
        double sommeCredit = AdminGen.calculSommeDouble(journaux, "credit");
        if(sommeCredit > this.montantreste){
            throw new Exception("Montant traite insuffisant");
        }
        for(int i=0;i<journaux.length;i++){
            if(journaux[i].getIdtraite()!=null)
                throw new Exception("Traite deja existant");
            if(journaux[i].getIdmode().compareToIgnoreCase(Constante.getTraite()) != 0)
                throw new Exception("Mode de paiement doit etre de type traite");
            journaux[i].setIdtraite(this.id);
            journaux[i].updateToTable(c);
        }
    }
    public String getValColLibelle(){
        return id+";"+montant;
    }
    
    /*@Override
    public Object validerObject(String u, Connection c) throws Exception {
        Traite traite = new Traite();
        traite = (Traite) traite.getById(this.getId(), "TRAITEMTTRESTE", c);
        if(traite.getMontantreste()>0)
            throw new Exception("Le montant disponible ne doit pas etre superieur a zero.");
        String caisseDep = Constante.getCaisseTraite();
        if(this.getIdtypepiece()!=null && this.getIdtypepiece().equals(Constante.getTypePieceCheque()))caisseDep = Constante.caisseDepense;
        MvttIntraCaisse mvt = new MvttIntraCaisse(caisseDep,Constante.EFFETSARECEVOIRREMISALENCAISSEMENT,null,null,
                                    null,this.getTuppleID(),this.getDaty(),this.getMontant());
        mvt.setIdfinaledestination(this.getIdfinaledestination());
        mvt.createObject(u, c);
        mvt.validerObject(u, c);
        return super.validerObject(u, c);
    }*/
    
    public void verser(String u, Connection c) throws Exception {
        
        Traite traite = new Traite();
        traite = (Traite) traite.getById(this.getId(), "TRAITEMTTRESTE", c);
        if(traite.getMontantreste()>0)
            throw new Exception("Le montant disponible ne doit pas etre superieur a zero.");
        String caisseDep = Constante.getCaisseTraite();
        if(this.getIdtypepiece()!=null && this.getIdtypepiece().equals(Constante.getTypePieceCheque()))caisseDep = Constante.caisseDepense;
        MvttIntraCaisse mvt = new MvttIntraCaisse(caisseDep,Constante.EFFETSARECEVOIRREMISALENCAISSEMENT,Constante.getTraite(),null,
                                    null,this.getTuppleID(),this.getDaty(),this.getMontant());
        mvt.setIdfinaledestination(this.getIdfinaledestination());
        mvt.createObject(u, c);
        mvt.validerObject(u, c);
        c.commit();
        
    }
    
    @Override
    public void controler(Connection c) throws Exception{
        if(this.getMontant() <= 0){
            throw new Exception("Le montant ne doit pas etre 0 ou negatif");
        }
    }
    
    public void avantVerser(String[] tId, String u, String finaldestination, Connection c) throws Exception {
        try{
            if(c == null){
                c=new UtilDB().GetConn();
                c.setAutoCommit(false);
            }
            MvttIntraCaisse mvt = new MvttIntraCaisse();
            mvt.setNomTable("mvtintracaissetraiteVcaisse");
            MvttIntraCaisse[] mvts = (MvttIntraCaisse[])CGenUtil.rechercher(mvt, null, null, c, " and idtraite='"+this.getId()+"'");
            if(mvts.length > 0){
                if(mvts[0].getEtatversement() == ConstanteEtat.getEtatValider())
                    throw new Exception("Traite déjà versée.");
                if(mvts[0].getEtatversement() == ConstanteEtat.getEtatEncaissee())
                    throw new Exception("Traite déjà encaissée.");
            }
            Traite traite=new Traite();
            String aWhere = " AND id in ("+Utilitaire.tabToString(tId, "'", ",")+")";
            Traite[] listeTraite = (Traite[])CGenUtil.rechercher(traite, null, null, c, aWhere);
            for(int i=0;i<listeTraite.length;i++){
                listeTraite[i].setIdfinaledestination(finaldestination);
                listeTraite[i].verser(u, c);
            }
        }
        catch(Exception ex){
            if(c!=null)c.rollback();
            ex.printStackTrace();
            throw ex;
        }
        finally{
            if(c!=null)c.close();
        }
    }

    public String getTypepiece() {
        return typepiece;
    }

    public void setTypepiece(String typepiece) {
        this.typepiece = typepiece;
    }
}
