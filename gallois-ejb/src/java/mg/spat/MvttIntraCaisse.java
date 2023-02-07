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
import utilitaire.Constante;
import utilitaire.Utilitaire;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;

/**
 *
 * @author Sanda
 */
public class MvttIntraCaisse extends ClassEtat {
    private String id,caissedepart,caissearrivee,modepaiement,remarque,designation,idTraite;
    private Date daty;
    private double montant;
    private  JournalCaisse[] listeJournal;
    int etatversement;
    String idfinaledestination ;

    public int getEtatversement() {
        return etatversement;
    }

    public void setEtatversement(int etatversement) {
        this.etatversement = etatversement;
    }

    public String getIdfinaledestination() {
        return idfinaledestination;
    }

    public void setIdfinaledestination(String idfinaledestination) {
        this.idfinaledestination = idfinaledestination;
    }
    
    

    public MvttIntraCaisse(String caissedepart,String caissearrivee,String modepaiement,String remarque,String description,String idTraite,Date daty,double montant)throws Exception{
        this.setNomTable("MvtIntracaisse");
        this.setCaissearrivee(caissearrivee);
        this.setCaissedepart(caissedepart);
        this.setModepaiement(modepaiement);
        this.setRemarque(remarque);
        this.setDesignation(designation);
        this.setIdTraite(idTraite);
        this.setDaty(daty);
        this.setMontant(montant);
    }

    public String getIdTraite() {
        return idTraite;
    }

    public void setIdTraite(String idTraite) {
        this.idTraite = idTraite;
    }

    public JournalCaisse[] getListeJournal() {
        return listeJournal;
    }

    public void setListeJournal(JournalCaisse[] listeJournal) {
        this.listeJournal = listeJournal;
    }
    
    public MvttIntraCaisse(){
        super.setNomTable("mvtintracaisse");
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCaissedepart() {
        return caissedepart;
    }

    public void setCaissedepart(String caissedepart) {
        this.caissedepart = caissedepart;
    }

    public String getCaissearrivee() {
        return caissearrivee;
    }

    public void setCaissearrivee(String caissearrivee) {
        this.caissearrivee = caissearrivee;
    }

    public String getModepaiement() {
        return modepaiement;
    }

    public void setModepaiement(String modepaiement) {
        this.modepaiement = modepaiement;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
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
    
    
    
    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
    @Override
    public void construirePK(Connection c) throws Exception {
        super.preparePk("MIC", "get_seq_mvtintracaisse");
        this.setId(makePK(c));
    }

    @Override
    public Object validerObject(String u, Connection c) throws Exception {
        JournalCaisse sortie = new JournalCaisse(null, this.getCaissedepart(), null, this.getDesignation(), null, Utilitaire.dateDuJourSql(), this.getDaty(), this.getMontant(), 0);
        sortie.setIddevise(Constante.deviseAr);
        sortie.setIdmode(this.getModepaiement());

        sortie.createObject(u, c);
        sortie.validerObject(u, c);
        
        JournalCaisse entree = new JournalCaisse(null, this.getCaissearrivee(), null, this.getDesignation(), null, Utilitaire.dateDuJourSql(), this.getDaty(), 0, this.getMontant());
        entree.setIddevise(Constante.deviseAr);
        entree.setIdmode(this.getModepaiement());

        entree.createObject(u, c);
        entree.validerObject(u, c);
        
        this.setEtatversement(ConstanteEtat.getEtatValider());
        
        return super.validerObject(u, c); //To change body of generated methods, choose Tools | Templates.
    }
    
    @Override
    public void controler(Connection c) throws Exception{
        if(this.getCaissedepart() != null && this.getCaissearrivee() != null){
            if(this.getCaissedepart().equalsIgnoreCase(this.getCaissearrivee())){
                throw new Exception("Caisse de départ et d' arrivée identiques");
            }
        }
    }
    
    public double calculerSomme(String idMvts) throws Exception{
        double somme=0;
        String[] tableau = Utilitaire.split(idMvts, ";");
        String idMvtsNew = Utilitaire.tabToString(tableau, "'", ",");
        JournalCaisse[]journalCaisses =(JournalCaisse[]) CGenUtil.rechercher(new JournalCaisse(), null, null, null, " and id in ("+idMvtsNew+")");
        if(this.listeJournal==null){
            this.listeJournal = journalCaisses;
        }
       
        int taille= journalCaisses.length;
        String caisse=null;
        for(int i=0;i<taille;i++){
            if(caisse==null){
                caisse=journalCaisses[i].getCaisse();
            }
            else{
                if(!caisse.equals(journalCaisses[i].getCaisse())){
                    throw new Exception("Caisses différentes");
                }
            }
            if(journalCaisses[i].getEtat()<ConstanteEtat.getEtatValider()){
                throw new Exception("Mouvement non valide");
            }
            somme+=journalCaisses[i].getCredit();
        }
        return somme;
    }
    
    public void verserTraite(String refUser)throws Exception{
        Connection c=null;
        try{
            c=new UtilDB().GetConn();
            c.setAutoCommit(false);
            
            this.setEtatversement(ConstanteEtat.getEtatValider());
            this.validerObject(refUser, c);
            c.commit();
        }catch(Exception e){
            if(c!=null)c.rollback();
            e.printStackTrace();
        }finally{
            if(c!=null)c.close();
        }
    }
    
    public void encaisserTraite(String u)throws Exception{
        Connection c=null;
        try{
            c=new UtilDB().GetConn();
            c.setAutoCommit(false);
            
            MvttIntraCaisse nouvMvt = new MvttIntraCaisse(Constante.EFFETSARECEVOIRREMISALENCAISSEMENT,this.getIdfinaledestination(),this.getModepaiement(),
                        this.getRemarque(),this.getDesignation(),this.getIdTraite(),this.getDaty(),this.getMontant());
            nouvMvt.createObject(u,c);
            nouvMvt.validerObject(u, c);
            
            this.setEtatversement(ConstanteEtat.getEtatEncaissee());
            this.updateToTable(c);
            c.commit();
        }catch(Exception e){
            if(c!=null)c.rollback();
            e.printStackTrace();
            throw e;
        }finally{
            if(c!=null)c.close();
        }
    }
}
