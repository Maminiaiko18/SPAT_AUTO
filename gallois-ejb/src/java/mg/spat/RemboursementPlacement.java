/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.spat;

import bean.AdminGen;
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

    public void checkMontantRemboursement(Connection c) throws Exception{
        RemboursementPlacement rembourcement =new RemboursementPlacement();
        rembourcement.setNomTable("remboursementplacementV");
        RemboursementPlacement[] liste = (RemboursementPlacement[]) CGenUtil.rechercher(rembourcement, null, null,c, " and idplacement='" + this.getIdplacement() + "'");
        double sommeRembourser = AdminGen.calculSommeDouble(liste, "montantplace");
        Placement p = new Placement();
        p.setId(this.getIdplacement());
        p = p.getPlacement(c);
        if(sommeRembourser + this.getMontantplace() > p.getMontant() ) throw new Exception("Montant remboursé supérieur au montant du placement");
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
        //checkDoublonRemboursement(c);
        checkMontantRemboursement(c);
        echu(c, user);
        
        Placement p = findPlacement(c);
        if(p.getDisponible() < this.getMontantplace()){
            throw new Exception("Montant à rembourser supérieur au montant disponible.");
        }
        double dispoNouv = p.getDisponible() - this.getMontantplace();
        double duree = Utilitaire.diffMoisDaty(this.getDaty(), p.getDate_placement());
        double intRemb = Utilitaire.calculerInteret(this.getMontantplace(), p.getTaux(), duree);
        this.setInteret(intRemb);
        this.setInteretBrut(intRemb*0.8);
        this.updateToTableWithHisto(user.getUser().getTuppleID(), c);
        double intPlacement = Utilitaire.calculerInteret(dispoNouv, p.getTaux(), (p.getDuree() - duree));
        p.setInteret_recevoir(intPlacement*0.8);
        p.setDisponible(dispoNouv);
        p.updateToTableWithHisto(user.getUser().getTuppleID(), c);
        
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

            JournalCaisse[] listeSortie = placement.getSortie(c);
            if(listeSortie==null || listeSortie.length==0)throw new Exception("Remboursement invalide. Décaissement non effectif");
            if(this.getDaty().before(listeSortie[0].getDateEffet()))throw new Exception("Date anterieure à la date de decaissement");
            
        //  Entrée Montant placé
            String designation = String.format("Echeance placement %s/%s: montant place", placementLibComplet.getValentite(), placementLibComplet.getValbanque());
            Date dateDuJour = Utilitaire.dateDuJourSql();
            JournalCaisse j1 = new JournalCaisse(null, this.getCaisse(), null, designation, null, dateDuJour, this.getDaty(), 0, placementLibComplet.getMontant());
            j1.setIddevise(placement.getIddevise());
            j1.setIdplacement(this.getIdplacement());
            j1.setMode(Constante.idmodeVirement);
            j1.setIdTypeCheque(Constante.typeChequeAuComptant);
            j1.setIdplacementvrai(this.getIdplacement());
            j1.createObject(refuser, c);
            j1.viser(user, c); 
            
            ConfigPlacement confP = placementLibComplet.getConfigPlacement(c);
            String compte = confP != null ? confP.getCompte() : null;
            
            if(this.getInteretBrut()>0){
                //Entrée intérêt brut
                designation = String.format("Echeance placement %s/%s: montant interet brut", placementLibComplet.getValentite(), placementLibComplet.getValbanque()); 

                JournalCaisse brut = new JournalCaisse(null, this.getCaisse(), null, designation, null, dateDuJour, this.getDaty(), 0, this.getInteretBrut(), placement.getIddevise(), Constante.idmodeVirement, Constante.typeChequeAuComptant);
                brut.setIdplacementvrai(this.getIdplacement());
                brut.createObject(refuser, c);
                brut.genererFacture(c, refuser, compte, Integer.parseInt(Utilitaire.getAnneeEnCours()), Utilitaire.getMoisEnCours(), (this.getIRCM()/this.getInteret())*100,this.getInteret());
                brut.viser(user, c);
                

                //Sortie IRCM
                designation = String.format("Echeance placement %s/%s: montant IRCM", placementLibComplet.getValentite(), placementLibComplet.getValbanque());     
                
                JournalCaisse ircm = new JournalCaisse(null, this.getCaisse(), null, designation, null, dateDuJour, this.getDaty(), this.getIRCM(), 0, placement.getIddevise(), Constante.idmodeVirement, Constante.typeChequeAuComptant,this.getIdplacement());
                ircm.setIdplacementvrai(this.getIdplacement());
                ircm.createObject(refuser, c);
                ircm.viser(user, c);
            }else{
            //  Entrée Intérêts
                designation = String.format("Echeance placement %s/%s: montant interet net", placementLibComplet.getValentite(), placementLibComplet.getValbanque());                

                JournalCaisse j2 = new JournalCaisse(null, this.getCaisse(), null, designation, null, dateDuJour, this.getDaty(), 0, placementLibComplet.getInteret_net());
                j2.setIddevise(placement.getIddevise());
                j2.setMode(Constante.idmodeVirement);
                j2.setIdTypeCheque(Constante.typeChequeAuComptant);
                j2.setIdplacementvrai(this.getIdplacement());
                j2.createObject(refuser, c);
                j2.genererFacture( c, refuser, compte, Utilitaire.getAneeEnCours(), Utilitaire.getMoisEnCours(), 20 );
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
