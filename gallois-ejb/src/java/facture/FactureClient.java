/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.CGenUtil;
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
import bean.AdminGen;
import bean.ClassFille;
import fin.Coursdevise;

/**
 *
 * @author
 */
public class FactureClient extends ClassMere {

    private String id;
    private Date daty, date_echeance;
    private String tiers, designation, type, remarque, iduser, idprevision, escale;
    private double tva, montant, montanttva, montantttc, montantpaye, montantreste;
    private String tierslib;
    private double montantavoir;
    private ArrayList<FactureClientDetails> arrayDetails;
    private String contact, adresse, etatLib, typelib;
    private FactureClientDetails[] listeDetails;
    private double deviseEuro, deviseDollar, coeff, montantHTEuro, montantTVAEuro, montantHTVADollar, montantTVADollar, montantTTCDollar;
    private String idcategorie ,idProvision ;

    public String getIdcategorie() {
        return idcategorie;
    }

    public void setIdcategorie(String idcategorie) {
        this.idcategorie = idcategorie;
    }

    public String getIdProvision() {
        return idProvision;
    }

    public void setIdProvision(String idProvision) {
        this.idProvision = idProvision;
    }
    
    public void controlerDefinitive(Connection c) throws Exception {
        if(!this.getIdcategorie().equals(Constante.idCategorieFCProvision) ){
            throw new Exception("Cette facture n est pas une facture de provision!");
        }
        FactureClient fc = new FactureClient();
        fc.setNomTable("ProvisionFactureDefinitive");
        FactureClient[] lst = (FactureClient[])CGenUtil.rechercher(fc, null, null, c, "id='"+this.id+"'");
        if(lst.length > 0){
            throw new Exception("Cette provision a deja ete facturee !");
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

    public void fusionner(String u, String colonneFusion, Connection c, String idAutre) throws Exception {
        FactureClient autre = (FactureClient) new FactureClient().getById(idAutre, "Factureclient", c);

        if (this.getEtat() >= ConstanteEtat.getEtatValider() || this.getEtat() != autre.getEtat()) {
            throw new Exception("Facture deja visee ou etats differents!");

        }

        if (!this.getTiers().equals(autre.getTiers())) {
            throw new Exception("Les factures doivent avoir le même tiers !");
        }

        ClassFille[] fillesAutre = autre.getFille("facture_client_fille", c, "");
        for (int i = 0; i < fillesAutre.length; i++) {
            FactureClientDetails det = (FactureClientDetails) fillesAutre[i];
            det.setIdmere(this.getId());
            det.updateToTableWithHisto(u, c);
        }
    }

    public void fusionner(String u, String colonneFusion, Connection c, String[] idAutre) throws Exception {
        boolean ouvert = false;

        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                ouvert = true;
            }

            for (String idAutre1 : idAutre) {
                fusionner(u, colonneFusion, c, idAutre1);
            }

            if (ouvert) {
                c.commit();
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

    @Override
    public Object annulerValidation(String u, Connection c) throws Exception {
        this.controlerAnnulation(c);
        return super.annulerValidation(u, c);
    }

    public void payer(String caisse, String mode, String numcheque, String typeCheque, String iddevise, UserEJBBean user, Connection c) throws Exception {
        System.out.println("-----------------FactureClienteeeeeeeeeeeeeeeeeeee.paye");
        JournalCaisse journal = new JournalCaisse();

        journal.setIdplacement(this.getId());
        journal.setTiers(this.getTiers());
        journal.setCredit(this.getMontantreste());
        journal.setDateEffet(Utilitaire.dateDuJourSql());
        journal.setCaisse(caisse);
        journal.setIdmode(mode);
        journal.setNumcheque(numcheque);
        journal.setIdTypeCheque(typeCheque);
        journal.setIddevise(iddevise);
        journal.setLibelle("Paiement multiple Auto " + this.getId());
        journal.createObject(user.getUser().getTuppleID(), c);

        journal.viser(user, c);
    }

    public FactureClientDetails[] getListeDetails() {
        return listeDetails;
    }

    public void setListeDetails(FactureClientDetails[] listeDetails) {
        this.listeDetails = listeDetails;
    }

    public double getDeviseEuro() {
        return deviseEuro;
    }

    public void setDeviseEuro(double deviseEuro) {
        this.deviseEuro = deviseEuro;
    }

    public double getDeviseDollar() {
        return deviseDollar;
    }

    public void setDeviseDollar(double deviseDollar) {
        this.deviseDollar = deviseDollar;
    }

    public double getCoeff() {
        return coeff;
    }

    public void setCoeff(double coeff) {
        this.coeff = coeff;
    }

    public double getMontantHTEuro() {
        if(listeDetails == null){
            return montantHTEuro;
        }
        return AdminGen.calculSommeDouble(listeDetails, "montantHTEuro");
    }

    public void setMontantHTEuro(double montantHTEuro) {
        this.montantHTEuro = montantHTEuro;
    }

    public double getMontantHTVADollar() {
        return getMontantHTEuro() * getCoeff();
//        return montantHTVADollar;
    }

    public void setMontantHTVADollar(double montantHTVADollar) {
        this.montantHTVADollar = montantHTVADollar;
    }

    public double getMontantTVADollar() {
        return getMontantTVAEuro() * getCoeff();
//        return montantTVADollar;
    }

    public void setMontantTVADollar(double montantTVADollar) {
        this.montantTVADollar = montantTVADollar;
    }

    public double getMontantTTCDollar() {
        return getMontantTVADollar() + getMontantHTVADollar();
//        return montantTTCDollar;
    }

    public void setMontantTTCDollar(double montantTTCDollar) {
        this.montantTTCDollar = montantTTCDollar;
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

    public String getTypelib() {
        return typelib;
    }

    public void setTypelib(String typelib) {
        this.typelib = typelib;
    }

    public String getTierslib() {
        return tierslib;
    }

    public void setTierslib(String tierslib) {
        this.tierslib = tierslib;
    }

    public void controlerAnnulation(Connection c) throws Exception {
        if (getAvoir(c).length > 0) {
            throw new Exception("Impossible à annuler: avoir existant");
        }
        if (getBonDeLivraison(c).length > 0) {
            throw new Exception("Impossible à annuler: bon de livraison existant");
        }
        if (getPaiement(c).length > 0) {
            throw new Exception("Impossible à annuler: paiement existant");
        }
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

    public JournalCaisse[] getPaiement(Connection c) throws Exception {
        boolean isOpen = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                isOpen = true;
            }
            JournalCaisse j = new JournalCaisse();
            j.setNomTable("journalcaisselib_vise");
            JournalCaisse[] journals = (JournalCaisse[]) CGenUtil.rechercher(j, null, null, c, " and idplacement ='" + this.getId() + "'");
            return journals;
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && isOpen) {
                c.close();
            }
        }
    }

    public BonDeLivraisonClient[] getBonDeLivraison(Connection c) throws Exception {

        boolean isOpen = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                isOpen = true;
            }
            BonDeLivraisonClient blc = new BonDeLivraisonClient();
            blc.setNomTable("as_bondelivraison_cl");
            BonDeLivraisonClient[] bondelivraisonclient = (BonDeLivraisonClient[]) CGenUtil.rechercher(blc, null, null, c, " and idbc ='" + this.getId() + "' and etat >= " + ConstanteEtat.getEtatValider());
            return bondelivraisonclient;
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && isOpen) {
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

    public double getMontantTVAEuro() {
         if(listeDetails == null){
            return montantTVAEuro;
        }
        return AdminGen.calculSommeDouble(listeDetails, "montantTVAEuro");
    }

    public void setMontantTVAEuro(double montantTVAEuro) {
        this.montantTVAEuro = montantTVAEuro;
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

    public void setDeviseEuro(Connection c) throws Exception {
        setDeviseEuro(getTauxRecent(c, "Eur"));
    }

    public void setDeviseDollar(Connection c) throws Exception {
        setDeviseDollar(getTauxRecent(c, "Dollars"));
    }
    
    public FactureClient genererDefinitive(UserEJB u, Connection c) throws Exception {
        int verif = 0;
        FactureClient fact2 = null;
        
        try {
            if(c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            
            FactureClient fc = this;
            if(fc.getDaty() == null) fc = (FactureClient) this.getById(this.getId(), this.getNomTable(), c);
            
            fact2 = (FactureClient) fc.dupliquer(u.getUser().getTuppleID(), c);
            fact2.setIdProvision(this.getId());
            u.updateObject(fact2, c);
            
            if(verif == 1) c.commit();
        } catch (Exception e) {
            if(c != null && verif == 1) c.rollback();
            throw e;
        }
        finally {
            if(c != null && verif == 1) c.close();
        }
        
        return fact2;
    }
    
    public JournalCaisse[] getListePaiement(String id, Connection c) throws Exception {
        String awhere = " and etat >= " + ConstanteEtat.getEtatValider() + " and idplacement = '" + id + "'";
        return (JournalCaisse[]) CGenUtil.rechercher(new JournalCaisse(), null, null, c, awhere);
    }

    public double getTauxRecent(Connection c, String iddevise) throws Exception {
        if(this.getDaty() == null){
            this.setDaty(((FactureClient)this.getById(this.getId(), this.getNomTable(), c)).getDaty());
        }
        String awhere = " and daty = (SELECT max(daty) FROM COURSDEVISE WHERE  daty <= '" + Utilitaire.datetostring(this.getDaty()) + "' and iddevise = '" + iddevise + "') "
                + " and iddevise = '" + iddevise + "'";
        Coursdevise[] cd = (Coursdevise[]) CGenUtil.rechercher(new Coursdevise(), null, null, c, awhere);

        if (cd != null && cd.length > 0) {
            return cd[0].getMontant();
        }

        return 0;
    }

    public void initDetails(Connection c) throws Exception {
        int verif = 0;

        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                verif = 1;
            }

            FactureClientDetails fcd = new FactureClientDetails();
            fcd.setNomTable("FACTURE_CLIENT_MERE_FILLE");
            listeDetails = (FactureClientDetails[]) CGenUtil.rechercher(fcd, null, null, c, " and idmere = '" + this.getId() + "'");
            if (listeDetails == null) {
                throw new Exception("Aucun details pour la facture " + this.getId());
            }
            
            setDeviseEuro(c);
            setDeviseDollar(c);
            coeff = deviseEuro / deviseDollar;

        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
}
