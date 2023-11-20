/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ordremission;

import bean.CGenUtil;
import bean.ClassEtat;
import bean.ClassMAPTable;
import facture.FactureFournisseur;
import facture.FactureFournisseurDetails;
import java.sql.Connection;
import java.sql.Date;
import user.UserEJB;
import utilitaire.Constante;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author Valiah Karen
 */
public class RetourOM extends ClassEtat{
    private String id, idom, heurearrivee, autres, idfactfournisseur, omlib;
    private Date datearrivee;
    private int nombres;
    private double prixunitaire , dureereelle ;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdom() {
        return idom;
    }

    public void setIdom(String idom) {
        this.idom = idom;
    }

    public String getHeurearrivee() {
        return heurearrivee;
    }

    public void setHeurearrivee(String heurearrivee) throws Exception {
        if (getMode().compareToIgnoreCase("modif") == 0) {
            Utilitaire.testHeureValide(heurearrivee);
        }
        this.heurearrivee = heurearrivee;
    }

    public String getAutres() {
        return autres;
    }

    public void setAutres(String autres) {
        this.autres = autres;
    }

    public Date getDatearrivee() {
        return datearrivee;
    }

    public void setDatearrivee(Date datearrivee) {
        this.datearrivee = datearrivee;
    }

    public int getNombres() {
        return nombres;
    }

    public void setNombres(int nombres) {
        this.nombres = nombres;
    }

    public double getPrixunitaire() {
        return prixunitaire;
    }

    public void setPrixunitaire(double prixunitaire) {
        this.prixunitaire = prixunitaire;
    }

    public double getDureereelle() {
        return dureereelle;
    }

    public void setDureereelle(double dureereelle) {
        this.dureereelle = dureereelle;
    }

    public String getIdfactfournisseur() {
        return idfactfournisseur;
    }

    public void setIdfactfournisseur(String idfactfournisseur) {
        this.idfactfournisseur = idfactfournisseur;
    }

    public String getOmlib() {
        return omlib;
    }

    public void setOmlib(String omlib) {
        this.omlib = omlib;
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
        this.preparePk("ROM", "getseqretour_om");
        this.setId(makePK(c));
    }

    public RetourOM() {
        super.setNomTable("RETOUR_OM");
    }
    
    public Object validerObjectOM(UserEJB u, Connection c) throws Exception {
        try{
            if(c == null){
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
            }
            OrdreMission om = new OrdreMission();
            OrdreMission ordremission = (OrdreMission)om.getById(this.getIdom(), "ordre_mission", c);
            double dureereelle = Utilitaire.getDiffJour(ordremission.getDatedepart(), this.getDatearrivee());
            int heure = Integer.parseInt(this.getHeurearrivee().substring(0, 2));
            if(heure < 12)
                dureereelle -= 0.5;
            this.setDureereelle(dureereelle);
            
            this.genererFactureDefinitive(u, c);
            
            RetourOM retour = (RetourOM)super.validerObject(u.getUser().getTuppleID(), c);
            if (c != null) c.commit();
            
            return retour;
        }
        catch(Exception e){
            if (c != null) c.rollback();
            throw e;
        }
        finally {
            if (c != null) {
                c.close();
            }
        }
    }
    
    @Override
    public void controler(Connection c) throws Exception {
        try{
            FactureFournisseur[] factures = (FactureFournisseur[]) CGenUtil.rechercher(new FactureFournisseur(), null, null, c, " and idom = '" + this.getIdom() + "' and idcategorie = '" + Constante.idBonProvisoire + "'");
            if(factures.length == 0)
                throw new Exception("Aucun bon provisoire existant pour cet OM.");
            else{
                if(factures[0].getEtat() != ConstanteEtat.getEtatValider())
                    throw new Exception("Bon provisoire non vis\\351. Impossible de g\\351n\\351rer facture d\\351finitive");
                if(!factures[0].checkPaiement(c)) {
                    throw new Exception("Bon provisoire non pay\\351. Impossible de g\\351n\\351rer facture d\\351finitive");
                }
            }
            String condition = " and idom = '" + this.getIdom() + "'";
            if(this.getId() != null && this.getId().compareToIgnoreCase("") != 0 && this.getId().compareToIgnoreCase("0") != 0)
                condition += " and id != '" + this.getId() + "'";
            RetourOM[] retour = (RetourOM[]) CGenUtil.rechercher(new RetourOM(), null, null, c, condition);
                if(retour.length > 0)
                    throw new Exception("Retour d\\351j\\340 existant pour cet OM.");
        }
        catch(Exception e){
            throw e;
        }
    }
    
    public void genererFactureDefinitive(UserEJB u, Connection c) throws Exception {
        try{
            FactureFournisseur[] factures = (FactureFournisseur[]) CGenUtil.rechercher(new FactureFournisseur(), null, null, c, " and idom = '" + this.getIdom() + "'");
            if(factures.length > 0){
                FactureFournisseurDetails[] ffdetails = (FactureFournisseurDetails[])factures[0].getFille("facture_fournisseur_fille", c, "");
                FactureFournisseurDetails[] ffnvdets = ffdetails;
                int t = ffdetails.length;
                if(this.getNombres() > 0){
                    ffnvdets = new FactureFournisseurDetails[t+1];
                    FactureFournisseurDetails ffnv = new FactureFournisseurDetails();
                    ffnv.setIdmere(factures[0].getId());
                    ffnv.setDesignation(this.getAutres());
                    ffnv.setQuantite(this.getNombres());
                    ffnv.setPu(this.getPrixunitaire());
                    ffnv.setDevise(ffdetails[0].getDevise());
                    ffnv.setMois(ffdetails[0].getMois());
                    ffnv.setAnnee(ffdetails[0].getAnnee());
                    ffnv.setCompte(ffdetails[0].getCompte());
                    ffnv.setTaux(ffdetails[0].getTaux());
                    ffnvdets[t] = ffnv;
                }
                for(int i = 0; i < ffdetails.length; i++){
                    ffdetails[i].setQuantite(this.getDureereelle());
                    ffnvdets[i] = ffdetails[i];
                }
                factures[0].setFille(ffnvdets);
                FactureFournisseur ff = factures[0].genererDefinitive(u, 1, c);
                this.setIdfactfournisseur(ff.getId());
            }
            else{
                throw new Exception("Aucun bon provisoire existant pour cet OM.");
            }
        }
        catch(Exception e){
            throw e;
        }
    }
}
