package ded;

import avoir.AvoirFC;
import bean.*;
import facture.FactureClient;
import facture.FactureFournisseur;
import facture.PaiementFacture;
import facture.UtilitaireFacture;
import factureclient.PaiementFactureRemise;
import facturefournisseur.EtatFactureMontantDaty;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import mg.allosakafo.produits.LiaisonIntraTable;
import mg.spat.JournalCaisse;
import utilitaire.Constante;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;
//import finance.MvtCaisse;
//import finance.MvtCaisseUtil;
//import facturefournisseur.FactureFournisseurLc;
//import lc.LigneCredit;

/**
 * <p>
 * Title: Gestion des recettes </p>
 * <p>
 * Description: </p>
 * <p>
 * Copyright: Copyright (c) 2005</p>
 * <p>
 * Company: </p>
 *
 * @author unascribed
 * @version 1.0
 */
public class OrdonnerPayement extends ClassEtat {

    private String id;
    private String ded_Id;
    private String idLigne;
    private java.sql.Date daty;
    private double montant;
    private String remarque;
    private String numeroop, destination, modepaiement,etatlib,tiers;
    private String numerobed;
    private String folio, numcheque, numfact;
    private double montantpaye,reste;
    private String modepaiementlib, tierslib;
    private String idfacture,type,idengagement,numeroCompta;
    private String adresse, montant_lettre,devise,beneficiaire, destinationlib;
    private double montantdevise;
    private String deviselib;

    public String getDeviselib() {
        return deviselib;
    }

    public void setDeviselib(String deviselib) {
        this.deviselib = deviselib;
    }

    public double getMontantdevise() {
        return montantdevise;
    }

    public void setMontantdevise(double montantdevise) {
        this.montantdevise = montantdevise;
    }

    public void checkDoublonNumeroOP(Connection c) throws Exception {
			this.setNomTable("ordonnerpayement");
			String query = " and id != '"+this.getId()+"' and numeroop='"+this.getNumeroop()+"'";
			OrdonnerPayement[] op = (OrdonnerPayement[]) CGenUtil.rechercher(new OrdonnerPayement(), null, null, c, query);
			if(op.length > 0) throw new Exception("Numero OP existant");
    }

    public String getNumeroCompta() {
        return numeroCompta;
    }

    public void setNumeroCompta(String numeroCompta) {
        this.numeroCompta = numeroCompta;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public String getMontant_lettre() {
        return montant_lettre;
    }

    public void setMontant_lettre(String montant_lettre) {
        this.montant_lettre = montant_lettre;
    }

    public String getDevise() {
        return devise;
    }

    public void setDevise(String devise) {
        this.devise = devise;
    }

    public String getBeneficiaire() {
        return beneficiaire;
    }

    public void setBeneficiaire(String beneficiaire) {
        this.beneficiaire = beneficiaire;
    }

    public String getDestinationlib() {
        return destinationlib;
    }

    public void setDestinationlib(String destinationlib) {
        this.destinationlib = destinationlib;
    }
    
    public String getTierslib() {
        return tierslib;
    }

    public String getIdengagement() {
        return idengagement;
    }

    public void setIdengagement(String idengagement) throws Exception{
        this.idengagement = idengagement;
    }

    public void setTierslib(String tierslib) {
        this.tierslib = tierslib;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public double getMontantpaye() {
        return montantpaye;
    }

    public void setMontantpaye(double montantpaye) {
        this.montantpaye = montantpaye;
    }

    public double getReste() {
        return reste;
    }

    public void setReste(double reste) {
        this.reste = reste;
    }

    public String getIdfacture() {
        return idfacture;
    }

    public void setIdfacture(String idfacture) {
        this.idfacture = idfacture;
    }
  
    public String getNumfact() {
        return numfact;
    }

    public void setNumfact(String numfact) {
        this.numfact = numfact;
    }
    
    public static OrdonnerPayement getOp(String idfc, Connection c) throws Exception {
        boolean in = false;
        try {
            if(c == null){
                c = new UtilDB().GetConn();
                in = !in;
            }
            OrdonnerPayement[] ordoPaye = (OrdonnerPayement[])CGenUtil.rechercher(new OrdonnerPayement(), null, null, c, " and ded_id = '"+idfc+"' and etat = " + ConstanteEtat.getEtatValider());
            if(ordoPaye.length >= 1){
                return ordoPaye[0];
            }
        }catch(Exception e){
            throw e;
        }finally{
            if(in && c!=null) c.close();
        }
        return null;
    }
    
    
    public String getNumerobed() {
        return numerobed;
    }

    public void setNumerobed(String numerobed) {
        this.numerobed = numerobed;
    }

    public String getTiers() {
        return tiers;
    }

    public void setTiers(String tiers) {
        this.tiers = tiers;
    }

    public String getEtatlib() {
        return etatlib;
    }

    public void setEtatlib(String etatlib) {
        this.etatlib = etatlib;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public String getModepaiement() {
        return modepaiement;
    }

    public void setModepaiement(String modepaiement) {
        this.modepaiement = modepaiement;
    }

    public String getFolio() {
        return folio;
    }

    public void setFolio(String folio) {
        this.folio = folio;
    }

    public String getNumcheque() {
        return numcheque;
    }

    public void setNumcheque(String numcheque) {
        this.numcheque = numcheque;
    }

    public OrdonnerPayement() {
        this.setNomTable("OrdonnerPayement");
    }

    public OrdonnerPayement(String id) {
        this.setNomTable("OrdonnerPayement");
        this.setId(id);
    }

    public OrdonnerPayement (String ded_id,double montant,Date daty,String iduser,String remarque,int etat){
        this.setNomTable("OrdonnerPayement");
        this.setDed_Id(ded_id);
        this.setMontant(montant);
        this.setDaty(daty);
        this.setIduser(iduser);
        this.setRemarque(remarque);
        this.setEtat(etat);
    }
    public OrdonnerPayement (String ded_id,double montant,Date daty,String iduser,String remarque,int etat,String tiers){
        this.setNomTable("OrdonnerPayement");
        this.setDed_Id(ded_id);
        this.setMontant(montant);
        this.setDaty(daty);
        this.setIduser(iduser);
        this.setRemarque(remarque);
        this.setEtat(etat);
        this.setTiers(tiers);
    }
    public OrdonnerPayement(String id, String ded, String ligne, String dt, String mont, String rem, String eta) {
        this.setNomTable("OrdonnerPayement");
        this.setId(id);
        this.setDed_Id(ded);
        this.setIdLigne(ligne);
        this.setDaty((utilitaire.Utilitaire.string_date("dd/MM/yyyy", dt)));
        this.setMontant(utilitaire.Utilitaire.stringToDouble(mont));
        this.setRemarque(rem);
        this.setEtat(utilitaire.Utilitaire.stringToInt(eta));
    }

    public OrdonnerPayement(String id, String ded, java.sql.Date dt, double mont, String rem) {
        this.setNomTable("OrdonnerPayement");
        this.setId(id);
        this.setDed_Id(ded);
        this.setDaty(dt);
        this.setMontant(mont);
        this.setRemarque(rem);
    }

    public OrdonnerPayement(String ded, String ligne, String dt, String mont, String rem, String eta) throws Exception {
        this.setNomTable("OrdonnerPayement");
        this.preparePk("ORP", "get_Seq_Op");
        this.setId(makePK());
        this.setDed_Id(ded);
        this.setIdLigne(ligne);
        this.setDaty(utilitaire.Utilitaire.string_date("dd/MM/yyyy", dt));
        this.setMontant(utilitaire.Utilitaire.stringToDouble(mont));
        this.setRemarque(rem);
        this.setEtat(utilitaire.Utilitaire.stringToInt(eta));
    }

    public String getAttributIDName() {
        return "id";
    }

    public String getNumeroop() {
        return numeroop;
    }

    public void setNumeroop(String numeroop) {
        this.numeroop = numeroop;
    }

    public String getTuppleID() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

    public void setDed_Id(String ded_Id) {
        this.ded_Id = ded_Id;
    }

    public String getDed_Id() {
        return ded_Id;
    }

    public void setIdLigne(String idLigne) {
        this.idLigne = idLigne;
    }

    public String getIdLigne() {
        return idLigne;
    }

    public void setDaty(java.sql.Date daty) {
        this.daty = daty;
    }

    public java.sql.Date getDaty() {
        return daty;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public double getMontant() {
        return montant;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public String getRemarque() {
        return remarque;
    }

    public String getEtatLettre() {
        if (getEtat() == 1) {
            return "vise";
        }
        if (getEtat() == 0) {
            return "non vise";
        }
        return "";
    }

    public String getModepaiementlib() {
        return modepaiementlib;
    }

    public void setModepaiementlib(String modepaiementlib) {
        this.modepaiementlib = modepaiementlib;
    }

    
    public void construirePK(Connection c) throws Exception {
        this.preparePk("ORP", "get_Seq_Op");
        this.setId(makePK(c));
    }

//    public void controlTiers(EtatFactureMontantDaty[] factures) throws Exception {
//        if (factures == null || factures.length < 2) {
//            return;
//        }
//
//        String[] atts = {"idfournisseur"};
//        String[] values = {factures[0].getIdFournisseur()};
//        ClassMAPTable[] memeTiers = AdminGen.find(factures, atts, values);
//
//        if (factures.length != memeTiers.length) {
//            throw new Exception("Les factures n'ont pas le même tiers");
//        }
//    }
    private void createObjectFC(String u, Connection c) throws Exception{
        
            this.setIduser(u);
            String[] idFact = this.getDed_Id().split(";");

            PaiementFactureRemise f = new PaiementFactureRemise();

            PaiementFactureRemise[] factures = f.getByIds(idFact, c);
            if (idFact.length != factures.length) {
                throw new Exception("Certaines factures n'ont pas été trouvées");
            }
            if (this.getDed_Id().contains(";")) {
    //            controlTiers(factures);
                double montantTotal = AdminGen.calculSommeDouble(factures, "resteapayer");
                //if(this.getMontant()==0){
                    this.setMontant(montantTotal);
                //}
            }
            this.controler(c);
            this.construirePK(c);
            this.insertToTableWithHisto(u, c);

            for (int i = 0; i < factures.length; i++) {
                LiaisonIntraTable liaison = new LiaisonIntraTable(factures[i].getId(), this.getTuppleID(), factures[i].getResteapayer());
                liaison.createObject(u, c);
            }
    }

    
    @Override
    public ClassMAPTable createObject(String u, Connection c) throws Exception {

        this.setIduser(u);
//        String[] idFact = this.getDed_Id().split(";");

        /*FactureFournisseur[] factures = this.getFactures(c);
        if(factures.length>0){
            this.setMontant(AdminGen.calculSommeDouble(factures, "montantreste"));
        }*/

        this.construirePK(c);
        this.gererFF( u, c);
        this.setNumeroop(genererNumeroOP(c));
        this.checkDoublonNumeroOP(c);
        return super.createObject(u, c);
    }
    
    public void payer(String u, Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            
            JournalCaisse jc = new JournalCaisse(null, Constante.caisseCentraleBP, null, this.getRemarque(), null, Utilitaire.dateDuJourSql(), Utilitaire.dateDuJourSql(), this.getMontant(), 0);
            jc.setIdordre(this.getId());
            jc.setTiers(this.getTiers());
//            jc.setIddevise(Constante.deviseAr);
    
            FactureFournisseur[] factures = this.getFactures(c);
            if(factures != null && factures.length > 0) {
//                System.out.println("devise " + factures[0].getIdDevise());
                jc.setIddevise(factures[0].getDeviseMere());
            }     
            
            jc.createObject(u, c);
            jc.validerObject(u, c);
            
            if(verif == 1) c.commit();
        } catch (Exception e) {
            if(c != null && verif == 1) c.rollback();
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    public OrdonnerPayement modifierEntete(String refUser, Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }

            this.updateToTableWithHisto(refUser, c);

            if (verif == 1) {
                c.commit();
            }
        } catch (Exception e) {
            if (c != null && verif == 1) {
                c.rollback();
            }
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
        return this;
    }

    public OrdonnerPayement getOP(Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }

            OrdonnerPayement[] tmp = (OrdonnerPayement[]) CGenUtil.rechercher(this, null, null, c, String.format(" and id = '%s'", this.getId()));

            if (tmp != null && tmp.length > 0) {
                return tmp[0];
            }
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }

        return null;
    }

    /*public void viser(UserEJBBean user, Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            
            this.validerObject(user, c);
            user.updateEtat(this, ConstanteEtat.getEtatValider(), this.getId(), c);
            if (verif == 1 && c != null) {
                c.commit();
            }
        } catch (Exception e) {
            if (c != null && verif == 1) {
                c.rollback();
            }
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }*/

    public void controlerMontant(double montantTTc, double reste, Connection c)throws Exception{
        OrdonnerPayement op=new OrdonnerPayement();
        op.setNomTable("ordonnerpayementgroupefact");
        OrdonnerPayement[] listeOP = (OrdonnerPayement[]) CGenUtil.rechercher(op, null, null, c, "and ded_id = '" + this.getDed_Id() + "'");
        if(listeOP.length>0){
            if(listeOP[0].getMontant() >= montantTTc){
                throw new Exception("Déjà payé en total ou en attente de paiement");
            }
            if(reste-this.getMontant()<-0.0001){
                throw new Exception("Montant supérieur au reste à payer");
            }
        }
    }
    public void controlerAvoirFC(AvoirFC[] avoirListe, Connection c)throws Exception{
        OrdonnerPayement op=new OrdonnerPayement();
        op.setNomTable("ordonnerpayementgroupefact");
        OrdonnerPayement[] listeOP = (OrdonnerPayement[]) CGenUtil.rechercher(op, null, null, c, "and ded_id = '" + this.getDed_Id() + "'");
        //double montantTTc=AdminGen.calculSommeDouble(avoirListe, "montant");
        if(listeOP.length>0){
            double montantTTc=avoirListe[0].getMontantttc();
            double reste= avoirListe[0].getMontantreste();
            //double reste=avoirListe[0].getMontantttc() - AdminGen.calculSommeDouble(avoirListe, "montantpaye");
            
            
            
            if(listeOP[0].getMontant() >= avoirListe[0].getMontantttc()){
                throw new Exception("Facture(s) déjà payée(s) ou en attente de paiement");
            }
            if(reste<this.getMontant()){
                throw new Exception("Montant supérieur au reste à payer");
            }
        }
    }
    public void gererFF(String u,Connection c)throws Exception{
        FactureFournisseur[] factures=this.getFactures(c);
        if(factures.length>0){
            //double montantTTc=AdminGen.calculSommeDouble(factures, "montantTTC");
            //double reste=AdminGen.calculSommeDouble(factures, "montantreste");
            //this.controlerMontant(montantTTc,reste, c);
            for (int i = 0; i < factures.length; i++) {
                LiaisonIntraTable liaison = new LiaisonIntraTable(factures[i].getId(), this.getTuppleID(), factures[i].getMontantttc());
                liaison.createObject(u, c);
            }
        }
    }

    public void ajouterFF(String u,String idFacture) throws Exception{
        int verif = 0;
        Connection c = null;
        LiaisonIntraTable[] retour=null;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }

            OrdonnerPayement[]op=(OrdonnerPayement[]) CGenUtil.rechercher(new OrdonnerPayement(), null, null, c, " and id='"+this.getId()+"'");

            String temp = op[0].getDed_Id();
                if(op[0].getEtat()==11) throw new Exception("OP deja vise, impossible d'ajouter une facture.");
                op[0].setDed_Id(idFacture);
                op[0].controlerDoublon(c);
                op[0].setDed_Id(temp+";"+idFacture);

                FactureFournisseur fact= new FactureFournisseur();
                fact.setNomTable("FACTFOURN_MSUM_LIB");
                FactureFournisseur[] ff=(FactureFournisseur[]) CGenUtil.rechercher(fact, null, null, c, " and id='"+idFacture+"'");
                if(ff.length > 0){
                    if(ff[0].getEtat()==1) throw new Exception("Facture fournisseur non vise");
                    LiaisonIntraTable liaison = new LiaisonIntraTable(ff[0].getId(), op[0].getTuppleID(), ff[0].getMontantttc());
                    liaison.createObject(u, c);
                }

                op[0].setMontant(op[0].getMontant()+ff[0].getMontantttc());
                op[0].updateToTable(c);
                    
            } catch (Exception e) {
            if (c != null && verif == 1) {
                c.rollback();
            }
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    public LiaisonIntraTable[] getLiaisonIntratable(Connection c) throws Exception{
        int verif = 0;
        LiaisonIntraTable[] retour=null;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            retour=(LiaisonIntraTable[]) CGenUtil.rechercher(new LiaisonIntraTable(), null, null, c, " and id2='"+this.getId()+"'");
        } catch (Exception e) {
            if (c != null && verif == 1) {
                c.rollback();
            }
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
        return retour;
    }
    public void gererAvoirFC(String u,Connection c)throws Exception{
        AvoirFC[] avoirList=this.getAvoirFC(c);
        if(avoirList.length>0){
            double montantTTc=avoirList[0].getMontantttc();
            double reste= avoirList[0].getMontantreste();
            //double reste=avoirList[0].getMontantttc() - AdminGen.calculSommeDouble(avoirList, "montantpaye");
            
            
            this.controlerMontant(montantTTc,reste, c);
            FactureClient factliee = avoirList[0].getFactureLiee("facture_client_union_ordre",c);
            if(factliee.getMontantreste()>=0)
                throw new Exception("Impossible de régulariser une facture qui ne demande aucun remboursement.");
            for (int i = 0; i < avoirList.length; i++) {
                LiaisonIntraTable liaison = new LiaisonIntraTable(avoirList[i].getId(), this.getTuppleID(), avoirList[i].getMontantreste());
                liaison.createObject(u, c);
            }
        }
    }
    public Object validerObject(String u, Connection c) throws Exception{
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            if (this.getEtat() >= ConstanteEtat.getEtatValider()) {
                throw new Exception("OP Deja valide");
            }

            this.gererVisaFF(c);
            if(getLiaison(c).length == 0) this.gererFF( u, c);
            this.gererAvoirFC( u, c);
            
            super.validerObject(u, c);
            if (c != null && verif == 1) c.commit();
        } catch (Exception e) {
            if (c != null ) c.rollback();
            throw e;
        } finally {
            if (c != null && verif == 1) c.close();
        }
        return this;
    }

    public FactureFournisseur[] getFactures(Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            FactureFournisseur ff=new FactureFournisseur();
            ff.setNomTable("factfourn_msum_lib");
            if(this.getDed_Id()!=null) return (FactureFournisseur[]) CGenUtil.rechercher(ff, null, null, c, " and id in (" + Utilitaire.tabToString(this.getDed_Id().split(";"), "'", ",") + ")");
            return null;
        } catch (Exception e) {
            if (c != null && verif == 1) {
                c.rollback();
            }
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    
    public LiaisonIntraTable[] getLiaison(Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            LiaisonIntraTable av=new LiaisonIntraTable();
            av.setNomTable("LIAISONINTRATABLE");
            return (LiaisonIntraTable[]) CGenUtil.rechercher(av, null, null, c, "and id2='" + this.getId()+"'");
        } catch (Exception e) {
            if (c != null && verif == 1) {
                c.rollback();
            }
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    public AvoirFC[] getAvoirFC(Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            AvoirFC av=new AvoirFC();
            av.setNomTable("AVOIRFC_MONTANT_REGROUP_V");
            if(this.getDed_Id()!=null) return (AvoirFC[]) CGenUtil.rechercher(av, null, null, c, "and id='" + this.getDed_Id()+"'");
            return null;
        } catch (Exception e) {
            if (c != null && verif == 1) {
                c.rollback();
            }
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    @Override
    public String getValColLibelle() {
        return this.getId()+";"+this.getRemarque()+";"+this.getDed_Id()+";"+Utilitaire.formaterAr(this.getMontant())+";"+numeroop;
    }
    public PaiementFacture[] genererPaiementFacture(Connection c, JournalCaisse jc) throws Exception{
        int verif = 0;
        PaiementFacture[] retour=null;
        try{
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            LiaisonIntraTable[] listeLiaison=this.getLiaisonIntratable(c);
            if(listeLiaison.length>0){
                retour=new PaiementFacture[listeLiaison.length];
                double valeurPource=(100*jc.getDebit())/this.getMontant();
                for(int i=0;i<listeLiaison.length;i++){
                    PaiementFacture pf=new PaiementFacture();
                    pf.setNomTable("paiementfactureF");
                    pf.setIdMvt(jc.getId());
                    pf.setIdFact(listeLiaison[i].getId1());
                    //double valeurPource=(100*listeLiaison[i].getMontant())/jc.getDebit();
                    //pf.setMontant((jc.getDebit()*valeurPource)/100);
                    pf.setMontant((listeLiaison[i].getMontant()*valeurPource)/100);
                    retour[i]=pf;
                }
            }
        } catch (Exception e) {
            if (c != null && verif == 1) {
                c.rollback();
            }
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
        return retour;
    }

    @Override
    public void controlerUpdate(Connection c) throws Exception {
        this.controleDoublonNumeroOP(c);
    }

     public String genererNumeroOP(Connection c) throws Exception{
        String numero = ""; 
        try{   
            String awhere = " and annee=%s and mois=%s";
            awhere = String.format(awhere, Utilitaire.getAnnee(this.getDaty()), Utilitaire.getMois(this.getDaty()));
            
//            numero += UtilitaireFacture.genererSequence(c, "NUMEROOP", 4, utilitaire.Utilitaire.datetostring(this.getDaty()));
            numero += UtilitaireFacture.genererSequence(c, "NUMEROOP", 4, Utilitaire.datetostring(this.getDaty()), awhere);
            numero+="/";
            numero+=Utilitaire.genererMois(utilitaire.Utilitaire.datetostring(this.getDaty()));
            numero+="/";
            numero+=Utilitaire.genererAnnee(utilitaire.Utilitaire.datetostring(this.getDaty()));
            
            this.setNumeroop(numero);
         }catch(Exception e){
             e.printStackTrace();
         }
        
        controleDoublonNumeroOP(c);
         return numero;
     }
    
    public static ArrayList<FactureFournisseur> controlerDecaissementMultiple(Connection c,String[] ids) throws Exception{
        ArrayList<FactureFournisseur> result = new ArrayList<>();
        OrdonnerPayement base = new OrdonnerPayement();
        base.setNomTable("OrdonnerPayement");
        String where = String.format(" and id in (%s) ", Utilitaire.tabToString(ids, "'", ","));
        OrdonnerPayement[] tabOp = (OrdonnerPayement[])CGenUtil.rechercher(base, null, null, c, where);
        for(OrdonnerPayement op: tabOp){
            if(op.getEtat() < 11) throw new Exception("OP non visé");
            FactureFournisseur[] tabFactOp = op.getFactures(c);
            for(FactureFournisseur factOp: tabFactOp) 
                result.add(factOp);
        }
        return result;
    }
    
    public static String[] getFacturesOPs(Connection c, String[] idOPs) throws Exception {
        java.util.List<FactureFournisseur> factures = controlerDecaissementMultiple(c, idOPs);
        String[] idFactures = new String[factures.size()];
        
        if(factures.size() > 0) {
            for(int i=0; i < factures.size(); i++) {
                idFactures[i] = factures.get(i).getId();
            }
        }
        
        return idFactures;
    }
    
    public void controleDoublonNumeroOP(Connection c) throws Exception{
        OrdonnerPayement[] op = (OrdonnerPayement[]) CGenUtil.rechercher(new OrdonnerPayement(), null, null, c, " and id != '"+this.getId()+"' and numeroop='"+this.getNumeroop()+"'");
        if(op.length > 0) throw new Exception("Numero OP "+this.getNumeroop()+" existant");
    } 
    
    public JournalCaisse[] getPaiement(Connection c) throws Exception{
        boolean verif = false;
        try{
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = true;
            }
            JournalCaisse jc = new JournalCaisse();
            jc.setIdordre(this.getId());
            JournalCaisse[] listeJc = (JournalCaisse[]) CGenUtil.rechercher(jc, null, null, c, "");
            return listeJc;
        } catch (Exception e) {
            if (c != null && verif == true) {
                c.rollback();
            }
            throw e;
        } finally {
            if (c != null && verif == true) {
                c.close();
            }
        }
    }

    @Override
    public void controleAnnulerVisa(Connection c) throws Exception {
        if(this.getPaiement(null).length!=0)throw new Exception("Annuler visa non permis, les lignes de paiement existant pour cet OP");
    }

    public void controlerMotantFF(Connection c)throws Exception{
        FactureFournisseur[] listeFF=this.getFactures(c);
        double rap = 0;
        if(listeFF!=null&&listeFF.length>0){
            for(int i=0;i<listeFF.length;i++){
                rap += listeFF[i].getMontantreste();
            }
            if((float)rap<(float)this.getMontant())throw new Exception("Montant superieur au reste à payer");
        }
    }
    
    public void controlerDoublon(Connection c) throws Exception{
        String [] idFacture = this.getDed_Id().split(";");
        for(int i = 0 ; i < idFacture.length ; i++){
            OrdonnerPayement[]ordonnerPayment=(OrdonnerPayement[]) CGenUtil.rechercher(new OrdonnerPayement(), null, null, c, " and ded_id like '%"+idFacture[i]+"%'");
            if(ordonnerPayment.length>0){
                throw new Exception("OP deja saisi pour la facture : "+idFacture[i]);
            }
        }
            
    }
    
    @Override
    public void controler(Connection c) throws Exception {
        this.controlerMotantFF(c);
        this.controlerDoublon(c);
    }
    
    public void annulerOP(String refUser, Connection c) throws Exception {
        boolean verif = false;
        try{
            if (c == null) {
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
                verif = true;
            }
            OrdonnerPayement op = (OrdonnerPayement)(new OrdonnerPayement()).getById(this.getId(), "ordonnerpayement", c);
            op.annuler(c);
            LiaisonIntraTable[] lt = (LiaisonIntraTable[]) CGenUtil.rechercher(new LiaisonIntraTable(), null, null, c, " and id2='"+this.getId()+"'");
            for(int i = 0; i<lt.length; i++){
                lt[i].deleteToTableWithHisto(refUser, c);
            }
                
            if(verif) c.commit();
        }
        catch(Exception e){
            if (c != null && verif == true) {
                c.rollback();
            }
            throw e;
        }
        finally {
            if (c != null && verif == true) {
                c.close();
            }
        }
    }
    
    public void gereDevise(Connection c)throws Exception{
        FactureFournisseur[] factures=this.getFactures(c);
        if(factures.length>0){
            FactureFournisseur temp = factures[0];
            //find FF fille, si devise hafa dia ovaina ilay OP
        }
    }

    public void gererVisaFF(Connection c)throws Exception{
        FactureFournisseur[] factures=this.getFactures(c);
        if(factures.length>0){
            for (int i = 0; i < factures.length; i++) {
                if(factures[i].getEtat() < ConstanteEtat.getEtatValider())
                    throw new Exception("Facture Fournisseur non visée. Impossible de viser L'OP.");
            }
        }
    }
}
