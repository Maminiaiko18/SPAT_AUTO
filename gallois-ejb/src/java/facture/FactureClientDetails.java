/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.CGenUtil;
import bean.ClassFille;
import bean.ClassMAPTable;
import bean.TypeObjet;
import fin.Coursdevise;
import java.sql.Connection;
import java.sql.Date;
import mg.spat.exploitant.Activite;
import utilitaire.Constante;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;
/**
 *
 * @author
 */
public class FactureClientDetails extends ClassFille {

    
    private String id,idmere;
    private double quantite,pu,taux;
    private String compte,idproduit,devise,designation, idProduitLib,idactivite,categorieFacturelib,categorieClientlib,activitelib,rubrique;
    private FactureClient mere;
    private double montant;
    private double montanttaux;
    private double montantavoirsanstaux;
    private double montantavoiravectaux;
    private double qtelivree, restealivrer; 
    private Date datefact;

    
    public Date getDatefact() {
        return datefact;
    }

    public void setDatefact(Date datefact) {
        this.datefact = datefact;
    }
    
    double tva;
    //double montantTva;
    public String getActivitelib() {
        return activitelib;
    }

    public void setActivitelib(String activitelib) {
        this.activitelib = activitelib;
    }
    
    public double getTva() {
        return tva;
    }

    public void setTva(double tva) {
        this.tva = tva;
    }
    public double getMontantTva() throws Exception
    {
        return this.getMontanttaux() *this.getTva()/100;
    }
    
    
    @Override
    public String getValColLibelle() {
        return getLibDesignation()+";"+Utilitaire.formaterAr(montanttaux)+";"+Utilitaire.formaterAr(montanttaux)+";"+devise;
    }
    
    public String getLibDesignation(){
        return designation==null || designation.equals("") ? id : designation;
    }
    
    public String getIdProduitLib() {
        return idProduitLib;
    }

    public void setIdProduitLib(String idProduitLib) {
        this.idProduitLib = idProduitLib;
    }

    public double getQtelivree() {
        return qtelivree;
    }

    public void setQtelivree(double qtelivree) {
        this.qtelivree = qtelivree;
    }

    public double getRestealivrer() {
        return restealivrer;
    }

    public void setRestealivrer(double restealivrer) {
        this.restealivrer = restealivrer;
    }

    public double getMontantavoirsanstaux() {
        return montantavoirsanstaux;
    }

    public void setMontantavoirsanstaux(double montantavoirsanstaux) {
        this.montantavoirsanstaux = montantavoirsanstaux;
    }

    public double getMontantavoiravectaux() {
        return montantavoiravectaux;
    }

    public void setMontantavoiravectaux(double montantavoiravectaux) {
        this.montantavoiravectaux = montantavoiravectaux;
    }
   

    public double getMontanttaux() {
        return montanttaux;
    }

    public void setMontanttaux(double montanttaux) {
        this.montanttaux = montanttaux;
    }
    
    
    public FactureClientDetails() throws Exception{
        setNomTable("facture_client_fille");
        this.setNomClasseMere("facture.FactureClient");
        this.setLiaisonMere("idmere");
    }
    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("FCF", "get_seq_facture_client_fille");
        setId(makePK(c));
    }

    @Override
    public String getLiaisonMere() {
        return "idmere";
    }

    @Override
    public ClassMAPTable createObject(String user, Connection c) throws Exception {
        setTaux(getTauxRecent(c));
        return super.createObject(user, c);
    }

    public void verifActivite(Connection c) throws Exception{
        Activite act = getActivite(c);
        if(act.getEtat() < ConstanteEtat.getEtatValider()){
            throw new Exception("Activite non visee !");
        }
    }
    
    @Override
    public void controlerUpdate(Connection c) throws Exception {
        verifActivite(c);
        setTaux(getTauxRecent(c));
        super.controlerUpdate(c);
    }
    public Activite getActivite(Connection c) throws Exception{
        Activite retour=null;
        Boolean estOuvert=false;
        try{
            if(c==null){
                c=new UtilDB().GetConn();
                c.setAutoCommit(false);
                estOuvert=true;
            }
            Activite ac=new Activite();
            ac.setNomTable("ACTIVITELIBCOMPLET");
            Activite[] liste=(Activite[])CGenUtil.rechercher(ac, null, null, c, " and id='"+this.getIdactivite()+"'");
            if(liste.length==0) throw new Exception("Activite introuvable");
            retour=liste[0];
        }catch(Exception e){
            throw e;
        }finally{
            if(c!=null && estOuvert) c.close();
        }
        return retour;
    }
    public double getTauxRecent(Connection c) throws Exception {
        Date date = ((FactureClient)this.findMere("",c)).getDaty();
        
        if(this.getIdactivite()!=null && this.getDatefact() != null){
            date=Utilitaire.ajoutJourDate(this.getDatefact(), -1);
        }
        
        String awhere = " and daty = (SELECT max(daty) FROM COURSDEVISE WHERE  daty <= '" + Utilitaire.datetostring(date) + "' and iddevise = '" + this.getDevise() + "') "
                + " and iddevise = '" + this.getDevise() + "'";
        Coursdevise[] cd = (Coursdevise[]) CGenUtil.rechercher(new Coursdevise(), null, null, c, awhere);
        
        if(cd != null && cd.length > 0) return cd[0].getMontant();
        
        return 0;
    }
    

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    public String getIdmere() {
        return idmere;
    }

    public void setIdmere(String idmere) {
        this.idmere = idmere;
    }

    public double getQuantite() {
        return quantite;
    }

    public void setQuantite(double quantite) {
        this.quantite = quantite;
    }

    public double getPu() {
        return pu;
    }

    public void setPu(double pu) {
        this.pu = pu;
    }

    public double getTaux() {
        return taux;
    }

    public void setTaux(double taux) {
        this.taux = taux;
    }

    public String getCompte() {
        return compte;
    }

    public void setCompte(String compte) {
        this.compte = compte;
    }

    public String getIdproduit() {
        return idproduit;
    }

    public void setIdproduit(String idproduit) {
        this.idproduit = idproduit;
    }

    public String getDevise() {
        return devise;
    }

    public void setDevise(String devise) {
        this.devise = devise;
    }
    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public FactureClient getMere() {
        return mere;
    }

    /*public void setMere(FactureClient mere) {
        this.mere = mere;
    }*/

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }
    public String getIdactivite() {
        return idactivite;
    }

    public void setIdactivite(String idactivite) {
        this.idactivite = idactivite;
    }
    
    public String getCategorieFacturelib() {
        return categorieFacturelib;
    }

    public void setCategorieFacturelib(String categorieFacturelib) {
        this.categorieFacturelib = categorieFacturelib;
    }
    
    public String getCategorieClientlib() {
        return categorieClientlib;
    }

    public void setCategorieClientlib(String categorieClientlib) {
        this.categorieClientlib = categorieClientlib;
    }
    
    public String getRubrique() {
        return rubrique;
    }

    public void setRubrique(String rubrique) {
        this.rubrique = rubrique;
    }
    
    public void checkActivite(Connection c) throws Exception{
        if(this.getIdactivite()!=null && this.getIdactivite().compareTo("")!=0){
            Activite act=new Activite();
            act.setNomTable("ACTIVITESNONFACTUREES");
            Activite[] activites = (Activite[]) CGenUtil.rechercher(act, null, null, c, " and id ='" +this.getIdactivite()+ "'");
        
            if(activites.length == 0) {
                throw new Exception("Cette activite a deja ete facturee ou n est pas encore visee");
            }
        }
    }
    public void controler(Connection c) throws Exception {
        verifActivite(c);
        this.checkActivite(c);
    }

}
