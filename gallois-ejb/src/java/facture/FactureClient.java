/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.CGenUtil;
import bean.ClassEtat;
import bean.ClassMAPTable;
import bean.ClassMere;
import bean.TypeObjet;
import java.sql.Connection;
import java.sql.Date;
import java.util.ArrayList;
import user.UserEJB;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;
import mg.spat.JournalCaisse;
import user.UserEJBBean;
import utilitaire.Constante;
import mg.spat.stock.BonDeLivraisonClient;
import avoir.AvoirFC;
import mg.spat.exploitant.Activite;

/**
 *
 * @author
 */
public class FactureClient extends ClassMere {

    private String id;
    private Date daty, date_echeance;
    private String tiers, designation, type, remarque, iduser,idprevision,escale;
    private double tva, montant, montanttva, montantttc,montantpaye,montantreste;
    private String tierslib;
    private double montantavoir;
    private ArrayList<FactureClientDetails> arrayDetails;
    private String contact, adresse, etatLib;
    
    
    public FactureClient facturer(String u, Activite a, Connection c) throws Exception {
        boolean in = false;
        try {
            if(c == null){
                c = new UtilDB().GetConn();
                in = true;
                c.setAutoCommit(false);
            }
            FactureClient fc = new FactureClient();
            fc.setDaty(Utilitaire.dateDuJourSql());
            fc.setTiers(a.getClient());
            fc.setDesignation("Facturation via activité " + a.getDesignation());
            fc.setIdprevision(a.getBateau());
            fc.setEtat(ConstanteEtat.getEtatCreer());
            ArrayList<FactureClientDetails> lst = a.creerDetailsFacture(c);
            fc.setFille(lst.toArray(new FactureClientDetails[lst.size()]));
            fc.createObject(u, c);
            if(in) c.commit();
            return fc;
        } catch (Exception e) {
            if(in && c!=null) c.rollback();
            throw e;
        }finally{
            if(in && c!=null) c.close();
        }
    }
    
    public FactureClient(Date daty, String tiers, String designation, double tva) throws Exception {
        setNomTable("Factureclient");
        setLiaisonFille("idmere");
        this.setNomClasseFille("facture.FactureClientDetails");
        setDaty(daty);
        setTiers(tiers);
        setDesignation(designation);
        setTva(tva);
        setArrayDetails(new ArrayList<FactureClientDetails>());
    
    }

    @Override
    public Object annulerValidation(String u, Connection c) throws Exception {
        this.controlerAnnulation(c);
        return super.annulerValidation(u, c);
    }
    
    public void payer(String caisse, String mode, String numcheque, String typeCheque, String iddevise, UserEJBBean user,Connection c) throws Exception{
        System.out.println("-----------------FactureClienteeeeeeeeeeeeeeeeeeee.paye");
        JournalCaisse journal=new JournalCaisse();
       
        journal.setIdplacement(this.getId());
        journal.setTiers(this.getTiers());
        journal.setCredit(this.getMontantreste());
        journal.setDateEffet(Utilitaire.dateDuJourSql());
        journal.setCaisse(caisse);
        journal.setIdmode(mode);
        journal.setNumcheque(numcheque);
        journal.setIdTypeCheque(typeCheque);
        journal.setIddevise(iddevise);
        journal.setLibelle("Paiement multiple Auto "+this.getId());
        journal.createObject(user.getUser().getTuppleID(),c);
        
        journal.viser(user, c);
    }

    public String getEtatLib() {
        return etatLib;
    }

    public void setEtatLib(String etatLib) {
        this.etatLib = etatLib;
    }

    public String getEscale() {
        return escale;
    }

    public void setEscale(String escale) {
        this.escale = escale;
    }

    public String getIdprevision() {
        return idprevision;
    }

    public void setIdprevision(String idprevision) {
        this.idprevision = idprevision;
    }
    
    @Override
    public String getValColLibelle() {
        return designation;
    }

    public double getMontantavoir() {
        return montantavoir;
    }

    public void setMontantavoir(double montantavoir) {
        this.montantavoir = montantavoir;
    }
    
    
    public String getTierslib() {
        return tierslib;
    }

    public void setTierslib(String tierslib) {
        this.tierslib = tierslib;
    }
    
    public void controlerAnnulation(Connection c) throws Exception {
        if(getAvoir(c).length > 0) throw new Exception("Impossible à annuler: avoir existant");
        if(getBonDeLivraison(c).length > 0) throw new Exception("Impossible à annuler: bon de livraison existant");
        if(getPaiement(c).length > 0) throw new Exception("Impossible à annuler: paiement existant");
    }

    @Override
    public ClassMAPTable createObject(String iduser, Connection cnctn) throws Exception {
        this.setIduser(iduser);
        return super.createObject(iduser, cnctn);
    }

    public FactureClient() throws Exception {
        setNomTable("Factureclient");
        this.setLiaisonFille("idmere");
        this.setNomClasseFille("facture.FactureClientDetails");
    }

    @Override
    public String getLiaisonFille() {
        return "idmere";
    }
    

    public void recurrent(UserEJB u, Connection c, String typefrequence, int nb) throws Exception {
        boolean ouvert = false;

        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                ouvert = true;
            }

            FactureClient fc = (FactureClient) this.getById(this.getId(), this.getNomTable(), c);

            TypeObjet typeFreq = new TypeObjet();
            typeFreq.setNomTable("TYPEFREQUENCE");
            TypeObjet[] tmp = (TypeObjet[]) CGenUtil.rechercher(typeFreq, null, null, c, " and id = '" + typefrequence + "'");

            if (tmp != null && tmp.length > 0) {
                int nbJ = Utilitaire.stringToInt(tmp[0].getVal());
                Date dateRef = fc.getDaty(), dateEch = fc.getDate_echeance();
                fc.setEtat(ConstanteEtat.getEtatCreer());

                for (int i = 0; i < nb; i++) {
                    String idF = (String) u.dupliquerObject(fc, "facture.FactureClientDetails", "idmere", c);

                    dateRef = Utilitaire.ajoutJourDate(dateRef, nbJ);
                    dateEch = Utilitaire.ajoutJourDate(dateEch, nbJ);

                    fc.setId(idF);
                    fc.setDaty(dateRef);
                    fc.setDate_echeance(dateEch);

//                    System.out.println("fc " + fc.getId());
                    u.updateObject(fc, c);
                }

                if (ouvert) {
                    c.commit();
                }
            }
        } catch (Exception ex) {
            if (c != null && ouvert) {
                c.rollback();
            }
            throw ex;
        } finally {
            if (c != null && ouvert) {
                c.close();
            }
        }
    }
    
    public JournalCaisse[] getPaiement(Connection c) throws Exception{
        boolean isOpen = false;
        try{
            if(c == null){
                c = new UtilDB().GetConn();
                isOpen = true;
            }
            JournalCaisse j = new JournalCaisse();
            j.setNomTable("journalcaisselib_vise");
            JournalCaisse[] journals = (JournalCaisse[]) CGenUtil.rechercher(j, null, null, c, " and idplacement ='"+this.getId()+"'");
            return journals;
        }
        catch(Exception e){
            throw e;
        }
        finally{
            if(c != null && isOpen){
                c.close();
            }
        }
    }
    
    public BonDeLivraisonClient[] getBonDeLivraison(Connection c) throws Exception{
	
	boolean isOpen = false;
	try{
            if(c == null){
                c = new UtilDB().GetConn();
                isOpen = true;
            }
            BonDeLivraisonClient blc = new BonDeLivraisonClient();
			blc.setNomTable("as_bondelivraison_cl");
			BonDeLivraisonClient[] bondelivraisonclient = (BonDeLivraisonClient[]) CGenUtil.rechercher(blc, null, null, c, " and idbc ='"+this.getId()+"' and etat >= " + ConstanteEtat.getEtatValider());
			return bondelivraisonclient;
        }
		catch(Exception e){
            throw e;
        }
		finally{
            if(c != null && isOpen){
                c.close();
            }
        }
    }
    
    public AvoirFC[] getAvoir(Connection c) throws Exception {
        boolean ouvert = false;

        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                
                ouvert = true;
            }
            AvoirFC avoirFC = new AvoirFC();
            avoirFC.setNomTable("avoirfc_vise");
            AvoirFC[] avoir = (AvoirFC[]) CGenUtil.rechercher(avoirFC, null, null, c, " and idfacture = '" + this.getId() + "'");
            return avoir;
        } catch (Exception ex) {
            
            throw ex;
        } finally {
            if (c != null && ouvert) {
                c.close();
            }
        }
        
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk(Constante.fcPrefix, "get_seq_Factureclient");
        setId(makePK(c));
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

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public Date getDate_echeance() {
        return date_echeance;
    }

    public void setDate_echeance(Date date_echeance) {
        this.date_echeance = date_echeance;
    }

    public String getTiers() {
        return tiers;
    }

    public void setTiers(String tiers) {
        this.tiers = tiers;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public String getIduser() {
        return iduser;
    }

    public void setIduser(String iduser) {
        this.iduser = iduser;
    }

    public double getTva() {
        return tva;
    }

    public void setTva(double tva) {
        this.tva = tva;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public double getMontanttva() {
        return montanttva;
    }

    public void setMontanttva(double montanttva) {
        this.montanttva = montanttva;
    }

    public double getMontantttc() {
        return montantttc;
    }

    public void setMontantttc(double montantttc) {
        this.montantttc = montantttc;
    }
    public ArrayList<FactureClientDetails> getArrayDetails() {
        return arrayDetails;
    }

    public void setArrayDetails(ArrayList<FactureClientDetails> arrayDetails) {
        this.arrayDetails = arrayDetails;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }
    
    public double getMontantpaye() {
        return montantpaye;
    }

    public void setMontantpaye(double montantpaye) {
        this.montantpaye = montantpaye;
    }

    public double getMontantreste() {
        return montantreste;
    }

    public void setMontantreste(double montantreste) {
        this.montantreste = montantreste;
    }

}
