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
import mg.spat.OccupationMaterielNaval;
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
    private String compte,idproduit, produit_lib,devise,designation, idProduitLib,idactivite,categorieFacturelib,categorieClientlib,activitelib,rubrique;
    private FactureClient mere;
    private double montant;
    private double montanttaux;
    private double montantavoirsanstaux;
    private double montantavoiravectaux;
    private double qtelivree, restealivrer; 
    private Date datefact;
    private String rubriquelib, idprestation,clientlib;
    private int mois, annee;
    private String heureDebut, heureFin, moislib,anneelib;
    private double montantHTEuro,montantTVAEuro, montanttaxe,majoration,reduction;

    public double getMajoration() {
        return majoration;
    }

    public void setMajoration(double majoration) {
        this.majoration = majoration;
    }

    public double getReduction() {
        return reduction;
    }

    public void setReduction(double reduction) {
        this.reduction = reduction;
    }
    boolean tauxDonne=false;

    public boolean getTauxDonne() {
        return tauxDonne;
    }

    public void setTauxDonne(boolean tauxDonne) {
        this.tauxDonne = tauxDonne;
    }
    
    public static Date getFinMois(int mois, int annee) {
        String moisS = mois < 10 ? "0" + mois : "" + mois; 
        Date date = Utilitaire.stringDate("01/" + moisS + "/" + annee);
        
        return Utilitaire.getLastDayOfDateSQL(date);
    }
    
    public double getTauxFinDuMois(Connection c, int mois, int annee, String iddevise) throws Exception {
        Date finDuMois = getFinMois(mois, annee);
                
        String awhere = " and daty = (SELECT max(daty) FROM COURSDEVISE WHERE  daty <= '" + Utilitaire.datetostring(finDuMois) + "' and iddevise = '" + iddevise + "') "
                + " and iddevise = '" + iddevise + "'";
        //System.out.println("apres where "+awhere );
        Coursdevise[] cd = (Coursdevise[]) CGenUtil.rechercher(new Coursdevise(), null, null, c, awhere);
        
        return cd != null && cd.length > 0 ? cd[0].getMontant() : 0;
    }
    public void setTauxFinDuMois(Connection c,int mois,int annee,String iddevise) throws Exception
    {
        double tauxFm=getTauxFinDuMois(c,mois,annee,iddevise);
        this.setTaux(tauxFm);
    }
    
    public double getMontanttaxe() {
        return montanttaxe;
    }

    public void setMontanttaxe(double montanttaxe) {
        this.montanttaxe = montanttaxe;
    }

    public String getProduit_lib() {
        return produit_lib;
    }

    public void setProduit_lib(String produit_lib) {
        this.produit_lib = produit_lib;
    }

    public String getClientlib() {
        return clientlib;
    }

    public void setClientlib(String clientlib) {
        this.clientlib = clientlib;
    }

    public double getMontantHTEuro() {
        return montantHTEuro;
    }

    public void setMontantHTEuro(double montantHTEuro) {
        this.montantHTEuro = montantHTEuro;
    }

    public double getMontantTVAEuro() {
        return montantTVAEuro;
    }

    public void setMontantTVAEuro(double montantTVAEuro) {
        this.montantTVAEuro = montantTVAEuro;
    }
    
    
    public OccupationMaterielNaval getPrestation(Connection c) throws Exception {
        OccupationMaterielNaval prestation=new OccupationMaterielNaval();
        prestation.setNomTable("occupationmaterielnavalfacture");
        prestation.setIdfacturelfille(this.getId());
        OccupationMaterielNaval[] prestations =(OccupationMaterielNaval[]) CGenUtil.rechercher(prestation, null, null, c, "");
        if(prestations.length>0){
            prestation = prestations[0];
        }
        else{
           prestation=null; 
        }
        return prestation;
    }

    public String getMoislib() {
        return moislib;
    }

    public void setMoislib(String moislib) {
        this.moislib = moislib;
    }

    public String getAnneelib() {
        return anneelib;
    }

    public void setAnneelib(String anneelib) {
        this.anneelib = anneelib;
    }
    
    
    public String getRubriquelib() {
        return rubriquelib;
    }

    public void setRubriquelib(String rubriquelib) {
        this.rubriquelib = rubriquelib;
    }

    public String getIdprestation() {
        return idprestation;
    }

    public void setIdprestation(String idprestation) {
        this.idprestation = idprestation;
    }

    public int getMois() {
        return mois;
    }

    public void setMois(int mois) {
        this.mois = mois;
    }

    public int getAnnee() {
        return annee;
    }

    public void setAnnee(int annee) {
        this.annee = annee;
    }

    public String getHeureDebut() {
        return heureDebut;
    }

    public void setHeureDebut(String heureDebut) {
        this.heureDebut = heureDebut;
    }

    public String getHeureFin() {
        return heureFin;
    }

    public void setHeureFin(String heureFin) {
        this.heureFin = heureFin;
    }
    
    

    
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
        if(getTauxDonne()==false)setTaux(getTauxRecent(c));
        return super.createObject(user, c);
    }

    public void verifActivite(Connection c) throws Exception{
        Activite act = getActivite(c);
        if(act!=null && act.getEtat() < ConstanteEtat.getEtatValider()){
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
            if(liste.length>0) retour=liste[0];
        }catch(Exception e){
            throw e;
        }finally{
            if(c!=null && estOuvert) c.close();
        }
        return retour;
    }
    
    private double getValeurTaux(Connection c, String nomTable, Date date) throws Exception {
        String awhere = " and daty = (SELECT max(daty) FROM " + nomTable + " WHERE  daty <= '" + Utilitaire.datetostring(date) + "' and iddevise = '" + this.getDevise() + "') "
                + " and iddevise = '" + this.getDevise() + "'";
        Coursdevise cours = new Coursdevise();
        cours.setNomTable(nomTable);
        Coursdevise[] cd = (Coursdevise[]) CGenUtil.rechercher(cours, null, null, c, awhere);

        return cd != null && cd.length > 0 ? cd[0].getMontant() : 0;
    }

    public double getTauxRecent(Connection c) throws Exception {
        this.findMere(c);
        
        if(this.getMere() == null) throw new Exception("Facture mere introuvable");
        String estDDPMICTSL = this.getMere().getEstDDPMICTSL();
        if(estDDPMICTSL != null && estDDPMICTSL.equalsIgnoreCase("1")) return getTauxRecentMICTSL(c);
        
        return getTauxRecentNormal(c);
    }
    
    private FactureClient findMere(Connection c) throws Exception {
        if(this.getMere() == null) {
            FactureClient fc = new FactureClient();
            fc.setId(this.getIdmere());
            fc.setEstDDPMICTSL(null);
            FactureClient[] tmp = (FactureClient[]) CGenUtil.rechercher(fc, null, null, c, "");
            
            if(tmp != null && tmp.length > 0) { 
                this.mere = tmp[0];
                return tmp[0];
            }
        }
        
        return null;
    }
    
    public double getTauxRecentNormal(Connection c) throws Exception {
        this.findMere(c);
        Date date = this.getMere().getDaty();

        if (this.getIdactivite() != null && this.getDatefact() != null) {
            date = Utilitaire.ajoutJourDate(this.getDatefact(), -1);
        }

        return getValeurTaux(c, "coursdeviseNonMICTSL", date);
    }
    
    public double getTauxRecentMICTSL (Connection c) throws Exception {
        this.findMere(c);
        Date date = this.getMere().getDaty();
        return getValeurTaux(c, "coursdeviseMICTSL", date);
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
