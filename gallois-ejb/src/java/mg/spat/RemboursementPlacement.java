/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.CGenUtil;
import bean.ClassEtat;
import facture.FactureClient;
import facture.FactureClientDetails;

import java.sql.Connection;
import java.sql.Date;
import mg.spat.placement.Placement;
import mg.spat.placement.PlacementLibComplet;
import user.UserEJBBean;
import utilitaire.Constante;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author Nouta
 */
public class RemboursementPlacement extends ClassEtat{
    private String id,idplacement,caisse,entite,banque,caisselib;
    private double montantplace,interet,interetBrut,IRCM;
    private Date daty;
    
    
    public void checkDoublonRemboursement(Connection c) throws Exception{
        RemboursementPlacement rembourcement =new RemboursementPlacement();
        rembourcement.setNomTable("remboursementplacementV");
        RemboursementPlacement[] liste = (RemboursementPlacement[]) CGenUtil.rechercher(rembourcement, null, null,c, " and idplacement='" + this.getIdplacement() + "'");
        if(liste.length>0){
            throw new Exception("Remboursement Placement deja enregistre");
        }
    }
    public RemboursementPlacement() {
        super.setNomTable("remboursementPlacement");
    }

    public double getInteretBrut() {
        return interetBrut;
    }

    public void setInteretBrut(double interetBrut) {
        this.interetBrut = interetBrut;
    }

    public double getIRCM() {
        return IRCM;
    }

    public void setIRCM(double IRCM) {
        this.IRCM = IRCM;
    }

    public String getEntite() {
        return entite;
    }

    public void setEntite(String entite) {
        this.entite = entite;
    }

    public String getBanque() {
        return banque;
    }

    public void setBanque(String banque) {
        this.banque = banque;
    }

    public String getCaisselib() {
        return caisselib;
    }

    public void setCaisselib(String caisselib) {
        this.caisselib = caisselib;
    }
    

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdplacement() {
        return idplacement;
    }

    public void setIdplacement(String idplacement) {
        this.idplacement = idplacement;
    }

    public String getCaisse() {
        return caisse;
    }

    public void setCaisse(String caisse) {
        this.caisse = caisse;
    }

    public double getMontantplace() {
        return montantplace;
    }

    public void setMontantplace(double montantplace) {
        this.montantplace = montantplace;
    }

    public double getInteret() {
        return interet;
    }

    public void setInteret(double interet) {
        this.interet = interet;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
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
        preparePk("CR","GETSEQREMBOURSEMENTPLACEMENT");
        setId(makePK(c));
    }
    public Placement findPlacement(Connection c) throws Exception{
        try{
        Placement p = new Placement();
        Placement[] liste = (Placement[]) CGenUtil.rechercher(p, null, null,c, " and id='" + this.getIdplacement() + "'");
        if(liste.length!=0){
            return liste[0];
        }
        return null;
        }catch(Exception e){
            e.printStackTrace();
        }
        return null;
    }

    /*@Override
    public Object validerObject(String u, Connection c) throws Exception {
        checkDoublonRemboursement(c);
        echu(c, u);
        return super.validerObject(u, c); 
    }*/

    @Override
    public void viser(UserEJBBean user, Connection c) throws Exception {
        checkDoublonRemboursement(c);
        echu(c, user);
        super.viser(user, c);
    }
    
    

    public void echu(Connection c, UserEJBBean user) throws Exception {
        boolean ouvert = false;
        
        try {
            if(c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                ouvert = true;
            }
            
            String refuser = ""+user.getUser().getRefuser();
            PlacementLibComplet placementLibComplet = (PlacementLibComplet) (new PlacementLibComplet()).getById(this.getIdplacement(), "placementlibcomplet", c);
            
            Placement placement = findPlacement(c);
            
        //  Entrée Montant placé
            String designation = String.format("Echeance placement %s/%s: montant place", placementLibComplet.getValentite(), placementLibComplet.getValbanque());
            Date dateDuJour = Utilitaire.dateDuJourSql();
            JournalCaisse j1 = new JournalCaisse(null, this.getCaisse(), null, designation, null, dateDuJour, dateDuJour, 0, placementLibComplet.getMontant());
            j1.setIddevise(placement.getIddevise());
            j1.setIdplacement(this.getIdplacement());
            j1.setMode(Constante.idmodeVirement);
            j1.setIdTypeCheque(Constante.typeChequeAuComptant);
            j1.createObject(refuser, c);
            j1.viser(user, c); 
            
            ConfigPlacement confP = placementLibComplet.getConfigPlacement(c);
            String compte = confP != null ? confP.getCompte() : null;
            
            if(this.getInteretBrut()>0){
                //Création FC pour Produit financier : HT=interet net et tva = IRCM calculé en %
                designation = String.format("Echeance placement %s/%s: montant interet brut", placementLibComplet.getValentite(), placementLibComplet.getValbanque());  
                
                FactureClient fc = new FactureClient(dateDuJour, null, designation, Constante.typeFCAuComptant, Constante.idCategorieFCDefinitive, 1);

                FactureClientDetails fcDetails = new FactureClientDetails(fc.getId(), 1, this.getInteretBrut(), compte, designation, 1, Integer.parseInt(Utilitaire.getAnneeEnCours()), Utilitaire.getMoisEnCours(), "Ar",0); 

                FactureClientDetails[] fille = {fcDetails};
                fc.setFille(fille);

                fc.createObject(refuser, c);
                fc.viser(user,c);

                //Entrée intérêt brut
                designation = String.format("Echeance placement %s/%s: montant interet brut", placementLibComplet.getValentite(), placementLibComplet.getValbanque()); 

                JournalCaisse brut = new JournalCaisse(null, this.getCaisse(), null, designation, null, dateDuJour, dateDuJour, 0, this.getInteretBrut(), placement.getIddevise(), Constante.idmodeVirement, Constante.typeChequeAuComptant,fc.getId());
                
                brut.createObject(refuser, c);
                brut.viser(user, c);
                

                //Sortie IRCM
                designation = String.format("Echeance placement %s/%s: montant IRCM", placementLibComplet.getValentite(), placementLibComplet.getValbanque());     
                
                JournalCaisse ircm = new JournalCaisse(null, this.getCaisse(), null, designation, null, dateDuJour, dateDuJour, this.getIRCM(), 0, placement.getIddevise(), Constante.idmodeVirement, Constante.typeChequeAuComptant,fc.getId());

                ircm.createObject(refuser, c);
                ircm.viser(user, c);
                
                
                

            }else{
            //  Entrée Intérêts
                designation = String.format("Echeance placement %s/%s: montant interets", placementLibComplet.getValentite(), placementLibComplet.getValbanque());                

                JournalCaisse j2 = new JournalCaisse(null, this.getCaisse(), null, designation, null, dateDuJour, dateDuJour, 0, placementLibComplet.getInteret_net());
                j2.setIddevise(placement.getIddevise());
                j2.setMode(Constante.idmodeVirement);
                j2.setIdTypeCheque(Constante.typeChequeAuComptant);
                j2.createObject(refuser, c);
                j2.genererFacture( c, refuser, compte, Utilitaire.getAneeEnCours(), Utilitaire.getMoisEnCours(), 0 );
                j2.viser(user, c);
            }
            
        //  Etat échu 
            Placement[] lp = Placement.findPlacementsPrecedants(c,this.getIdplacement());
            for(int i=0;i<lp.length;i++){
                lp[i].setEtat(ConstanteEtat.getEtatEchu());
                lp[i].updateToTableWithHisto(refuser, c);
            }
            
            if(ouvert) c.commit();
        } catch (Exception e) {
            if(c != null && ouvert) c.rollback();
            throw e;
        }
        finally {
            if(c != null && ouvert) c.close();
        }
    }
    
}
