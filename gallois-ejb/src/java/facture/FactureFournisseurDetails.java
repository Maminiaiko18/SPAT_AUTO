/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.CGenUtil;
import bean.ClassMAPTable;
import bean.ClassMere;
import fin.Coursdevise;

import java.sql.Connection;
import java.sql.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import lignecredit.LigneCredit;
import mg.spat.EngagementFille;
import mg.spat.stock.BonDeCommande;
import mg.spat.stock.BonDeLivraison;
import mg.spat.stock.BonDeLivraisonFilleReste;
import utilitaire.Constante;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author rijan
 */
public class FactureFournisseurDetails extends FactureClientDetails{
    private double montanttaxe;
    private String comptestr;

    public String getComptestr() {
        return comptestr;
    }

    public void setComptestr(String comptestr) {
        this.comptestr = comptestr;
    }

    public double getMontanttaxe() {
        return montanttaxe;
    }

    public void setMontanttaxe(double montanttaxe) {
        this.montanttaxe = montanttaxe;
    }
    
   
    
    public FactureFournisseurDetails() throws Exception{ 
        this.setNomTable("facture_fournisseur_fille");
        this.setNomClasseMere("facture.FactureFournisseur");
        this.setLiaisonMere("idmere");
    }

    public FactureFournisseurDetails(String id, String idmere, String designation, String compte, String idproduit, String devise, String idactivite, String rubrique, String heureDebut, String heureFin, double quantite, double pu, double taux, double tva, double reduction, double majoration, double test, Date datefact, int mois, int annee) throws Exception{
        this.setNomTable("facture_fournisseur_fille");
        this.setId(id);
        this.setIdmere(idmere);
        this.setDesignation(designation);
        this.setCompte(compte);
        this.setIdproduit(idproduit);
        this.setDevise(devise);
        this.setIdactivite(idactivite);
        this.setRubrique(rubrique);
        this.setHeureDebut(heureDebut);
        this.setHeureFin(heureFin);
        this.setQuantite(quantite);
        this.setPu(pu);
        this.setTaux(taux);
        this.setTva(tva);
        this.setReduction(reduction);
        this.setMajoration(majoration);
        
        this.setDatefact(datefact);
        this.setMois(mois);
        this.setAnnee(annee);
    }
    
    
    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("FFD", "get_seq_factFournFille");
        this.setId(makePK(c));
    }

    public FactureFournisseur findMere(Connection c) throws Exception {
        if(this.getMere() == null) {
            FactureFournisseur fc = new FactureFournisseur();
            fc.setNomTable("facture_Fournisseur_Mere");
            fc.setId(this.getIdmere());
            fc.setEstDDPMICTSL(null);
            FactureFournisseur[] tmp = (FactureFournisseur[]) CGenUtil.rechercher(fc, null, null, c, "");
            
            if(tmp != null && tmp.length > 0) { 
                this.setMere(tmp[0]);
                return tmp[0];
            }
        }
        
        return this.getMere();
    }
    @Override
    public FactureFournisseur getMere() {
        return (FactureFournisseur) super.getMere();
    }

    public void controlerUpdate(Connection c) throws Exception {
        FactureClient m=findMere(c);
        if(m.getEtat()>=ConstanteEtat.getEtatValider()) throw new Exception("Objet mere deja valide");
    }
    
     @Override
    public String getValColLibelle() {
        return getLibDesignation()+";"+getLibDesignation()+";"+getDevise();
    }
    String idBLF;

    public String getIdBLF() {
        return idBLF;
    }

    public void setIdBLF(String idBLF) {
        this.idBLF = idBLF;
    }

    public FactureFournisseurDetails(String idmere, double quantite, double pu, String compte, String designation, double duree) throws Exception {
        setNomTable("facture_fournisseur_fille");
        this.setNomClasseMere("facture.FactureFournisseur");
        this.setLiaisonMere("idmere");
        this.setIdmere(idmere);
        this.setQuantite(quantite);
        this.setPu(pu);
        this.setCompte(compte);
        this.setDesignation(designation);
        this.setDuree(duree);
    }

    public FactureFournisseurDetails(String idmere, double quantite, double pu, String compte, String designation, double duree,int annee, int mois, double tva) throws Exception {
        setNomTable("facture_fournisseur_fille");
        this.setNomClasseMere("facture.FactureFournisseur");
        this.setLiaisonMere("idmere");
        this.setIdmere(idmere);
        this.setQuantite(quantite);
        this.setPu(pu);
        this.setCompte(compte);
        this.setDesignation(designation);
        this.setDuree(duree);
        this.setAnnee(annee);
        this.setMois(mois);
        this.setTva(tva);
    }
    public void setCompte(String compte) throws Exception {
        if (this.getMode().compareTo("modif")==0)
        {
            if(Utilitaire.champNull("compte").compareTo("")==0)
            {  
                    throw new Exception("Compte obligatoire");
            }
        }
        super.setCompte( compte);
    }
    
    public void checkCompte(String nomtable,Connection c) throws Exception{       
        try{   
            FactureFournisseur ff = this.findMere(c);
            if(ff != null && ff.getCode_etablissement()!=null && ff.getProjet()!=null){
                LigneCredit[] lc = ff.findLigneCredit(nomtable, c,this.getCompte());
                int t = lc.length;
                for(int i = 0; i < t; i++){
                    if(lc[i].getCompte().contains(this.getCompte())){
                        return;
                    }
                }
                throw new Exception("Budget non trouvé.");
            }
        }
        catch(Exception e){
            throw e;
        }
    }
    
    
    @Override
    public ClassMAPTable createObject(String user, Connection c) throws Exception {
        try{
            FactureFournisseur fact = (FactureFournisseur) new FactureFournisseur().getById(this.getIdmere(), "FACTURE_FOURNISSEUR_MERE", c);
            if(fact.getDeviseMere().compareToIgnoreCase(this.getDevise())!=0) throw new Exception("Devise different dans la facture details et la facture mere.");

            //si FF via BC, prendre taux BC
            if(fact.getIdBL()!=null) {
                if(fact.getDeviseMere().compareToIgnoreCase(Constante.deviseAr)!=0){
                    BonDeLivraison bl = (BonDeLivraison) new BonDeLivraison().getById(fact.getIdBL(), "AS_BONDELIVRAISON_BC", c);
                    BonDeCommande bc = (BonDeCommande) new BonDeCommande().getById(bl.getId_bc(), "AS_BONDECOMMANDE", c);
                    Coursdevise temp = new Coursdevise();
                    temp.setIddevise(this.getDevise()); 
                    temp.setEstMICTSL("0");
                    String daty = Utilitaire.formatterDatySql(bc.getDaty());
                    temp = ((Coursdevise[]) CGenUtil.rechercher(temp, null, null, c, " AND DATY = TO_DATE('"+daty+"', 'dd/MM/yyyy')"))[0];
                    this.setTaux(temp.getMontant());
                    this.setTauxDonne(true);
                }
            }
            if(this.getDesignation()==null || this.getDesignation().compareToIgnoreCase("")==0) throw new Exception("Désignation details facture obligatoire.");
            String nomtable="situationLCDepenseGRP"; //budget groupé par direction et projet
            if(this.getCompte()!=null && this.getCompte().compareTo("")!=0) {
                if(this.getCompte().length()==11) nomtable="SITUATIONLCDEPENSEVSD"; //budgetindividuel
                if(!this.getCompte().equalsIgnoreCase(Constante.cptNonBudgetise)) this.checkCompte(nomtable,c);
            }
        }
        catch(Exception e){
            throw e;
        }
        return super.createObject(user, c);
    }

    public EngagementFille createEngagementFille(String idEngagement)throws Exception{
        return new EngagementFille(idEngagement,this.getDesignation(),this.getPu() * this.getQuantite() - this.getPu() * this.getQuantite() * this.getReduction() / 100);
    }
    
    @Override
    public int deleteToTableWithHisto(String refUser, Connection con) throws Exception {
        FactureFournisseur mere = getMere(con);

        if (mere != null && mere.getEtat() >= ConstanteEtat.getEtatValider()) {
            throw new Exception("Ne peut \\352tre supprim\\351 car facture fournisseur d\\351j\\340 vis\\351e");
        }

        return super.deleteToTableWithHisto(refUser, con);
    }

    public FactureFournisseur getMere(Connection c) throws Exception {
        int verif = 0;
        FactureFournisseur res = null;

        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }

            FactureFournisseur ff = new FactureFournisseur();
            FactureFournisseur[] tmp = (FactureFournisseur[]) CGenUtil.rechercher(ff, null, null, c, " and id = '" + this.getIdmere()+ "'");

            if (tmp != null && tmp.length > 0) {
                res = tmp[0];
            }
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }

        return res;
    }
}