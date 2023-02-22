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

import java.math.RoundingMode;
import java.sql.Connection;
import java.sql.Date;
import java.time.LocalDate;
import java.time.Year;
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
import bean.ValidationException;
import fin.Coursdevise;
import java.util.List;
import mg.spat.ClientCategorie;
import mg.spat.Engagement;
import mg.spat.Navire;
import mg.spat.Prevision;
import mg.spat.exploitant.Activite;
import mg.spat.exploitant.AdminActivite;
import mg.spat.exploitant.Rubrique;

/**
 *
 * @author
 */
public class FactureClient extends ClassMere {

    private String id;
    private Date daty, date_echeance;
    private String tiers, designation, type, remarque, iduser, idprevision, escale, deviseMere,armateurlib,factureRemplacement;
    private double tva, montant, montanttva, montantttc, montantpaye, montantreste;
    private String tierslib;
    private double montantavoir;
    private ArrayList<FactureClientDetails> arrayDetails;
    private String contact, adresse, etatLib, typelib;
    private FactureClientDetails[] listeDetails;
    private double deviseEuro, deviseDollar, coeff, montantHTEuro, montantTVAEuro, montantHTVADollar, montantTVADollar, montantTTCDollar, montantttcvrai;
    private String idcategorie, idProvision, categorielib, idProvisionlib, iddefinitive;
    private String estDDPMICTSL;
    private String codePrestation, codePrestationlib, codeProvision;
    private String code, numpiece;
    private String estMictsl;
    private double reduction;
    private double ecart;
    private int exercice;
    private String idavoir,provenancelib,destinationlib,bateaulib,pavillon,pavillonlib;
    private double volume,volume100;
    private String nomclt ,adrclt ,nmsttclt ,telclt ,nif ,rc ,tp ,quit , cdclt,idtraite,idfc,factureclientlib, idfact;
    private double nbJours;

    public void setNbJours(double nbJours){
        this.nbJours=nbJours;
    }
    public double getNbJours(){
        return this.nbJours;
    }

    public String getCdclt() {
        return cdclt;
    }
    public int estMICTSLData()throws Exception
    {
        if (this.getTiers()==null)return 0;
        if(this.getTiers().compareToIgnoreCase("0120037")==0||this.getTiers().compareToIgnoreCase("clt1")==0)return 1;
        return 0;
    }

    public void setCdclt(String cdclt) {
        this.cdclt = cdclt;
    }
    private Date dttp ,dtquit;
	
    
	public String getNumpiece(){
		return numpiece;
	}
	
	public  void setNumpiece(String numpiece){
		this.numpiece = numpiece;
	}

    public String getNomclt() {
        return nomclt;
    }

    public void setNomclt(String nomclt) {
        this.nomclt = nomclt;
    }

    public String getAdrclt() {
        return adrclt;
    }

    public void setAdrclt(String adrclt) {
        this.adrclt = adrclt;
    }

    public String getNmsttclt() {
        return nmsttclt;
    }

    public void setNmsttclt(String nmsttclt) {
        this.nmsttclt = nmsttclt;
    }

    public String getTelclt() {
        return telclt;
    }

    public void setTelclt(String telclt) {
        this.telclt = telclt;
    }

    public String getNif() {
        return nif;
    }

    public void setNif(String nif) {
        this.nif = nif;
    }

    public String getRc() {
        return rc;
    }

    public void setRc(String rc) {
        this.rc = rc;
    }

    public String getTp() {
        return tp;
    }

    public void setTp(String tp) {
        this.tp = tp;
    }

    public String getQuit() {
        return quit;
    }

    public void setQuit(String quit) {
        this.quit = quit;
    }

    public Date getDttp() {
        return dttp;
    }

    public void setDttp(Date dttp) {
        this.dttp = dttp;
    }

    public Date getDtquit() {
        return dtquit;
    }

    public void setDtquit(Date dtquit) {
        this.dtquit = dtquit;
    }

    public double getVolume() {
        return volume;
    }

    public void setVolume(double volume) {
        this.volume = volume;
    }

    public double getVolume100() {
        return volume100;
    }

    public void setVolume100(double volume100) {
        this.volume100 = volume100;
    }
    

    public String getPavillon() {
        return pavillon;
    }

    public void setPavillon(String pavillon) {
        this.pavillon = pavillon;
    }

    public String getPavillonlib() {
        return pavillonlib;
    }

    public void setPavillonlib(String pavillonlib) {
        this.pavillonlib = pavillonlib;
    }
    

    public String getProvenancelib() {
        return provenancelib;
    }

    public void setProvenancelib(String provenancelib) {
        this.provenancelib = provenancelib;
    }

    public String getDestinationlib() {
        return destinationlib;
    }

    public void setDestinationlib(String destinationlib) {
        this.destinationlib = destinationlib;
    }

    public String getBateaulib() {
        return bateaulib;
    }

    public void setBateaulib(String bateaulib) {
        this.bateaulib = bateaulib;
    }
    private String typeclientlib,factureLiee;//,idEngagement ; 
    private int estAuto,estAncienne;
    private String typeEngagement,pourCompte,pourCompteLib,heureDepart,heureArrivee,bateau;
    private Date dateDepart,datearrivee;
    private String provenance,destination,armateur,codeFiltre,paiement,paiementlib;

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }
    private String val,desce;
    private double lht,lm,te,jnt;

    public double getLht() {
        return lht;
    }

    public void setLht(double lht) {
        this.lht = lht;
    }

    public double getLm() {
        return lm;
    }

    public void setLm(double lm) {
        this.lm = lm;
    }

    public double getTe() {
        return te;
    }

    public void setTe(double te) {
        this.te = te;
    }

    public String getProvenance() {
        return provenance;
    }

    public void setProvenance(String provenance) {
        this.provenance = provenance;
    }

    public double getJnt() {
        return jnt;
    }

    public void setJnt(double jnt) {
        this.jnt = jnt;
    }
    
    public String getVal() {
        return val;
    }

    public void setVal(String val) {
        this.val = val;
    }

    public String getDesce() {
        return desce;
    }

    public void setDesce(String desce) {
        this.desce = desce;
    }
    

    public String getPaiement() {
        return paiement;
    }

    public void setPaiement(String paiement) {
        this.paiement = paiement;
    }

    public String getPaiementlib() {
        return paiementlib;
    }

    public void setPaiementlib(String paiementlib) {
        this.paiementlib = paiementlib;
    }
    
    
    @Override
    public void controlerUpdate(Connection c) throws Exception {
        FactureClient factureClient =(FactureClient)(new FactureClient()).getById(this.getId(), "Factureclient", c);
        
        if(this.getType().equals(factureClient.getType())==false && this.getEstAncienne()!=1){
            this.setCode(this.calculerCode(c));
        }
        if(this.getEstAncienne()!=1)this.checkCode(c);
    }
    
    public String getCodeFiltre() {
        return codeFiltre;
    }

    public void setCodeFiltre(String codeFiltre) {
        this.codeFiltre = codeFiltre;
    }
    
    public String getArmateur() {
        return armateur;
    }

    public void setArmateur(String armateur) {
        this.armateur = armateur;
    }
    

    public String getHeureDepart() {
        return heureDepart;
    }

    public void setHeureDepart(String heureDepart) {
        this.heureDepart = heureDepart;
    }

    public String getHeureArrivee() {
        return heureArrivee;
    }

    public void setHeureArrivee(String heureArrivee) {
        this.heureArrivee = heureArrivee;
    }

    public String getBateau() {
        return bateau;
    }

    public void setBateau(String bateau) {
        this.bateau = bateau;
    }

    public Date getDateDepart() {
        return dateDepart;
    }

    public void setDateDepart(Date dateDepart) {
        this.dateDepart = dateDepart;
    }

    public Date getDatearrivee() {
        return datearrivee;
    }

    public void setDatearrivee(Date datearrivee) {
        this.datearrivee = datearrivee;
    }
    

    public int getEstAncienne() {
        return estAncienne;
    }

    public void setEstAncienne(int estAncienne) {
        this.estAncienne = estAncienne;
    }

    public String getPourCompte() {
        return pourCompte;
    }

    public void setPourCompte(String pourCompte) {
        this.pourCompte = pourCompte;
    }

    public String getPourCompteLib() {
        return pourCompteLib;
    }

    public void setPourCompteLib(String pourCompteLib) {
        this.pourCompteLib = pourCompteLib;
    }
    
    public String getTypeEngagement() {
        return typeEngagement;
    }

    public void setTypeEngagement(String typeEngagement) {
        this.typeEngagement = typeEngagement;
    }

    public String getFactureLiee() {
        return factureLiee;
    }

    public void setFactureLiee(String factureLiee) {
        this.factureLiee = factureLiee;
    }

    public String getFactureRemplacement() {
        return factureRemplacement;
    }

    public void setFactureRemplacement(String factureRemplacement) {
        this.factureRemplacement = factureRemplacement;
    }

    

    public void setIdavoir(String idavoir) {
        this.idavoir = idavoir;
    }
    

    public int getExercice() {
        return exercice;
    }

    public void setExercice(int exercice) {
        this.exercice = exercice;
    }

    public String getArmateurlib() {
        return armateurlib;
    }

    public void setArmateurlib(String armateurlib) {
        this.armateurlib = armateurlib;
    }
    
    public double getMontantttcvrai() {
        return montantttcvrai;
    }

    public void setMontantttcvrai(double montantttcvrai) {
        this.montantttcvrai = montantttcvrai;
    }

    /*public String getIdEngagement() {
        return idEngagement;
    }

    public void setIdEngagement(String idEngagement) {
        this.idEngagement = idEngagement;
    }*/

    
    public double getEcart() {
        return ecart;
    }

    public void setEcart(double ecart) {
        this.ecart = ecart;
    }

    public String getCodeProvision() {
        return codeProvision;
    }
    public String getTypeclientlib() {
        return typeclientlib;
    }

    public void setTypeclientlib(String typeclientlib) {
        this.typeclientlib = typeclientlib;
    }
    public String getIdavoir() {
        return idavoir;
    }

    public String getIdtraite() {
        return idtraite;
    }

    public void setIdtraite(String idtraite) {
        this.idtraite = idtraite;
    }

    public String getIdfc() {
        return idfc;
    }

    public void setIdfc(String idfc) {
        this.idfc = idfc;
    }

    public String getFactureclientlib() {
        return factureclientlib;
    }

    public void setFactureclientlib(String factureclientlib) {
        this.factureclientlib = factureclientlib;
    }

    
    
    public String validerFacture(UserEJB user, Connection c) throws Exception {
        String provisionString = "";
        int verif = 0;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            if (this.getEtat() < ConstanteEtat.getEtatValider()) {
                ClientCategorie cl = this.getClient(c);
                if (cl != null) {
                    FactureClient[] provision = cl.getResteProvision(c);
                    if (provision.length > 0 && this.idProvision == null) {
                        provisionString = provision[0].getId();
                        this.setIdProvision(provisionString);
                        ValidationException validationException = new ValidationException("Voulez-vous rattacher cette facture \\u00e0 une provision restante?");
                        List<ClassMAPTable> liste_object = new ArrayList<ClassMAPTable>();
                        this.setNomTable("factureclient");
                        liste_object.add(this);
                        user.setValidation(validationException);
                        user.getValidation().setListe_object(liste_object);
                        throw validationException;
                    }
                }
                user.validerObject(this);
            } else {
                throw new Exception("Objet deja visé");
            }
            if (verif == 1) {
                c.commit();
            }
        } catch (Exception exception) {
            throw exception;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
        return provisionString;
    }

    public FactureClient[] getDefinitive(Connection c)throws Exception{
        FactureClient[] fc = null;
        int verif = 0;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            FactureClient pr = new FactureClient();
            pr.setIdProvision(this.getId());
            fc = (FactureClient[])CGenUtil.rechercher(pr, null, null, c, "");
        } catch (Exception exception) {
            throw exception;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
        return fc;
    }

    PaiementFacture[] getPaiementFacture(Connection c, String[] idFact)throws Exception{
        PaiementFacture[] paiement = null;
        int verif = 0;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            PaiementFacture pf = new PaiementFacture();
            paiement = (PaiementFacture[])CGenUtil.rechercher(pf, null, null, c, "id fact in ("+Utilitaire.tabToString(idFact, "'", ",")+")");
        } catch (Exception exception) {
            throw exception;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
        return paiement;
    }

    public void verifResteProv(Connection c)throws Exception{
        int verif = 0;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            FactureClient[] fd = this.getDefinitive(c);
            int fdl = fd.length;
            String[] idFact = new String[fdl];
            for(int i=0; i<fdl; i++){
                idFact[i] = fd[i].getId();
            }
            if(fdl!=0){
                PaiementFacture[] pf = getPaiementFacture(c, idFact);
                double montantD = AdminGen.calculSommeDouble(pf, "montant");
                double reste = this.getMontantttc() - montantD;
                if(reste == 0) throw new Exception ("Reste sur provisoire = 0");
            }
        } catch (Exception exception) {
            throw exception;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    public void verifClient(Connection c) throws Exception{
        int verif = 0;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            FactureClient fc = new FactureClient();
            FactureClient fd = (FactureClient)fc.getById(this.getId(), this.getNomTable(), c);
            if(fd==null)System.out.println("Fact def ====== null");
            System.out.println("ID Fact ==== " + fd.getId());
            FactureClient pr = (FactureClient)fc.getById(fd.getIdProvision(), this.getNomTable(), c);
            System.out.println("PR ====== " + pr.getTiers() + " FD ======== " + fd.getTiers());
            if(pr.getTiers().compareToIgnoreCase(fd.getTiers())!=0) throw new Exception ("Tiers different pour la facture provisoire et definitive");
        } catch (Exception exception) {
            throw exception;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    public void setCodeProvision(String codeProvision) {
        this.codeProvision = codeProvision;
    }

    public FactureClient modifierEntete(String refUser, Connection c) throws Exception {
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

    public void controlerProvision(Connection c) throws Exception {
        if (this.getEtat() < ConstanteEtat.getEtatValider()) {
            throw new Exception("Facture non visée !");
        }

        if (this.getIdcategorie() == null || !this.getIdcategorie().equals(Constante.idCategorieFCDefinitive)) {
            throw new Exception("Seule une facture de type definitive peut generer une facture de provision !");
        }
        FactureClient fc = new FactureClient();
        fc.setNomTable("PROVISIONFACTUREDEFINITIVE");
        FactureClient[] fcs = (FactureClient[]) CGenUtil.rechercher(fc, null, null, c, " and IDDEFINITIVE = '" + this.getId() + "'");
        if (fcs != null && fcs.length > 0) {
            throw new Exception("Cette facture est deja liee a une provision !");
        }
    }

    public String genererLettreMictsl(Connection c) throws Exception {
        ClassFille[] filles = this.getFille();
        if (filles == null) {
            filles = this.getFille(null, c, "");
        }
        if (filles != null && filles.length > 0) {
            TypeObjet obj = new TypeObjet();
            obj.setNomTable("code_rubrique_mictsl");
            TypeObjet[] lst = (TypeObjet[]) CGenUtil.rechercher(obj, null, null, c, " and val = '" + ((FactureClientDetails) filles[0]).getRubrique() + "'");
            if (lst != null && lst.length > 0) {
                return lst[0].getDesce();
            }
        }
        return "A";
    }

    public String getIddefinitive() {
        return iddefinitive;
    }

    public void setIddefinitive(String iddefinitive) {
        this.iddefinitive = iddefinitive;
    }

    public String genererPremierCaractere(Connection c) throws Exception {
        TypeObjet obj = new TypeObjet();
        obj.setNomTable("codeFCPremierCaractere");
        String awhere = " and val = '%s'";

        String val = getIdcategorie().compareTo(Constante.idCategorieFCDefinitive) != 0 ? getIdcategorie() : getType();
        awhere = String.format(awhere, val);

        TypeObjet[] lst = (TypeObjet[]) CGenUtil.rechercher(obj, null, null, c, awhere);
        if (lst != null && lst.length > 0) {
            return lst[0].getDesce();
        }
        return null;
    }

    @Override
    public void controleAnnuler(Connection c) throws Exception {
        PaiementFacture[] paiementFact = getPaiementFacture(c);
        if (paiementFact.length > 0) {
            throw new Exception("Paiement existant");
        }

        FactureClient provision = getProvision(null, c);
        if (provision != null) {
            throw new Exception("Est liee a une provision");
        }

        FactureClient[] definitives = getFactureLiees(null, c);
        if (definitives.length > 0) {
            throw new Exception("Est deja liee a une facture definitive");
        }

        //super.controleAnnuler(c);
    }

    public String genererCodePrestation(Connection c) throws Exception {
        ClassFille[] filles = (ClassFille[]) this.getFille();
        if (filles == null) {
            filles = (ClassFille[]) this.getFille(null, c, "");
        }
        if (filles != null && filles.length > 0) {
            TypeObjet obj = new TypeObjet();
            obj.setNomTable("code_prestation");

            Rubrique rubrique = ((FactureClientDetails) filles[0]).getRubrique(c);

            // Factures automatiques
            if (rubrique == null) {
                return "10";
            }

            TypeObjet[] lst = (TypeObjet[]) CGenUtil.rechercher(obj, null, null, c, " and val = '" + rubrique.getCategorie() + "' ");
            if (lst != null && lst.length > 0) {
                return lst[0].getDesce();
            }
        }
        return null;
    }

    public double getReduction() {
        return reduction;
    }

    public void setReduction(double reduction) {
        this.reduction = reduction;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getCodePrestation() {
        return codePrestation;
    }

    public void setCodePrestation(String codePrestation) {
        this.codePrestation = codePrestation;
    }

    public String getCodePrestationlib() {
        return codePrestationlib;
    }

    public void setCodePrestationlib(String codePrestationlib) {
        this.codePrestationlib = codePrestationlib;
    }

    public String getEstDDPMICTSL() {
        return estDDPMICTSL;
    }

    public void setEstDDPMICTSL(String estDDPMICTSL) {
        this.estDDPMICTSL = estDDPMICTSL;
    }

    public String getDeviseMere() {
        return deviseMere;
    }

    public void setDeviseMere(String deviseMere) {
        this.deviseMere = deviseMere;
    }

    public void controlerDoublonRubrique(Connection c, int mois, int annee, String rubMICTSL) throws Exception {
        FactureClientDetails fcd = new FactureClientDetails();
        fcd.setNomTable("FACTURE_CLIENT_FILLE_VM");

        String awhere = " and tiers in ('%s', '%s') and rubrique = '%s' and mois = %s and annee = %s";
        awhere = String.format(awhere, Constante.idMICTSL, Constante.idMICTSL2, rubMICTSL, mois, annee);
        FactureClientDetails[] tab = (FactureClientDetails[]) CGenUtil.rechercher(fcd, null, null, c, awhere);

        if (tab != null && tab.length > 0) {
            throw new Exception("Rubrique deja facturee pour ce mois");
        }
    }

    public void updateDeviseMere(Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }

            this.setDeviseMere(Constante.deviseAr);
            if (this.getIdprevision() != null && this.getIdprevision().compareTo("") != 0) {
                Prevision prevision = this.findPrevision(null, c);
                if (prevision != null && prevision.estNavireEtranger(c)) {
                    this.setDeviseMere(Constante.deviseDollars);
                }
            }
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
    }

    public String getCategorielib() {
        return categorielib;
    }

    public void setCategorielib(String categorielib) {
        this.categorielib = categorielib;
    }

    public String getIdProvisionlib() {
        return idProvisionlib;
    }

    public void setIdProvisionlib(String idProvisionlib) {
        this.idProvisionlib = idProvisionlib;
    }

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
        if (this.getEtat() < ConstanteEtat.getEtatValider()) {
            throw new Exception("Provision non visee");
        }
        if (!this.getIdcategorie().equals(Constante.idCategorieFCProvision)) {
            throw new Exception("Cette facture n est pas une facture de provision!");
        }
//        JournalCaisse[]journalCaisses= this.getPaiement(c);
//        if(journalCaisses.length==0){
//            throw new Exception("Provision non payée");
//        }
        PaiementFacture [] factures = this.getPaiementFacture(c);
        if(factures.length==0){
            throw new Exception("Provision non payée");
        }
    }

    public void updatePaiement(String u, Connection c) throws Exception {
        JournalCaisse[] lst = getListePaiement(this.getIdProvision(), c);
        for (int i = 0; lst != null && i < lst.length; i++) {
            lst[i].setIdplacement(this.getId());
            lst[i].updateToTableWithHisto(u, c);
        }
    }

    public PaiementFacture[] findPaiementProvision(String idProvision, Connection c) throws Exception {
        boolean ouvert = false;
        PaiementFacture[] retour = null;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                ouvert = true;
            }
            retour = (PaiementFacture[]) CGenUtil.rechercher(new PaiementFacture(), null, null, c, " and idFact='" + idProvision + "'");
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && ouvert) {
                c.close();
            }
        }
        return retour;
    }

    public double genererMontantPaiement(Connection c) throws Exception {
        boolean verif = false;
        double montant = 0;

        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = true;
            }

            montant = getMontantResteProvision(c);

            if (montant >= this.getMontantttc()) {
                montant = this.getMontantttc();
            }

        } catch (Exception ex) {
            throw ex;
        } finally {
            if (c != null && verif) {
                c.close();
            }
        }

        return montant;
    }

    public double getMontantResteProvision(Connection c) throws Exception {
        double result = 0.;
        int verify = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verify = 1;
            }
            EtatProvision ep = new EtatProvision();
            ep.setNomTable("etatprovisionvrai");
            ep.setId(this.getIdProvision());
            EtatProvision[] etatProv = (EtatProvision[]) CGenUtil.rechercher(ep, null, null, c, "");
            if (etatProv.length > 0) {
                result = etatProv[0].getMontantreste();
            }
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && verify == 1) {
                c.close();
            }
        }
        return result;
    }

    public void genererPaiementDefinitive(String u, String idProvision, Connection c) throws Exception {
        boolean ouvert = false;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                ouvert = true;
            }

            FactureClient fc = new FactureClient();
            fc = (FactureClient) fc.getById(this.getId(), "facture_client_union", c);
            double montant = fc.genererMontantPaiement(c);

            PaiementFacture[] listeProvision = this.findPaiementProvision(idProvision, c);
            if (listeProvision != null && listeProvision.length > 0) {
                for (int i = 0; i < listeProvision.length; i++) {
                    listeProvision[i].setIdFact(this.getId());
                    listeProvision[i].setMontant(montant);
                    listeProvision[i].setId(null);
                    listeProvision[i].createObject(u, c);
                }
            }
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && ouvert) {
                c.close();
            }
        }
    }

    @Override
    public Object validerObject(String u, Connection c) throws Exception {
        Prevision prev = findPrevision(null, c);
        if(prev!=null){
            Navire nav = prev.findNavire(c);
            if(nav!=null){
                setLht(nav.getLht());
                setLm(nav.getLm());
                setTe(nav.getTe());
                setJnt(nav.getJnt());
            }
           
        }
        if (this.getIdcategorie() != null && this.getIdcategorie().equals(utilitaire.Constante.idCategorieFCDefinitive) && this.getIdProvision() != null) {
            //vérification reste sur provision
            //this.verifResteProv(c);
            //vérification si même client
            this.verifClient(c);
            //transfert paiement
            this.genererPaiementDefinitive(u, this.getIdProvision(), c);
        }
        
        ClientCategorie cl = this.findClient(null, c);
        if(cl!=null){
            this.setNomclt(cl.getNomclt());
            this.setAdrclt(cl.getAdrclt());
            this.setNmsttclt(cl.getNmsttclt());
            this.setTelclt(cl.getTelclt());
            this.setNif(cl.getNif());
            this.setRc(cl.getRc());
            this.setDttp(cl.getDttp());
            this.setTp(cl.getTp());
            this.setDtquit(cl.getDtquit());
            this.setQuit(cl.getQuit());
        }
        if(this.getEstAncienne()!=1&&this.getCode()==null)this.setCode(calculerCode(c));
        super.validerObject(u, c);
        return this;
    }

    public FactureClientDetails[] genererRedevanceFixe(int mois, int annee, String u, Connection c) throws Exception {
        boolean ouvert = false;

        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                ouvert = true;
            }

            String moisEnLettre = Utilitaire.nbToMois(mois);
            String designation = "Redevance Fixe MICTSL " + moisEnLettre + " " + annee;

            //Generer Details
            FactureClientDetails fcd = new FactureClientDetails();
            fcd.setDesignation(designation);
            fcd.setQuantite(0.5);

            Rubrique rubRedevance = new Rubrique();
            rubRedevance = (Rubrique) rubRedevance.getById(Constante.idRedevanceFixe, rubRedevance.getNomTable(), c);

            fcd.setTva(rubRedevance.getTva());
            fcd.setRubrique(rubRedevance.getId());
            fcd.setPu(Utilitaire.stringToDouble(rubRedevance.getPu()));
            fcd.setDevise(rubRedevance.getDevise());

            double taux = fcd.getTauxFinDuMois(c, mois, annee, fcd.getDevise());

//            System.out.println("taux " + taux);
            fcd.setTaux(taux);
            fcd.setMois(mois);
            fcd.setAnnee(annee);
            fcd.setTauxDonne(true);
            fcd.setDuree(1);
            fcd.setCompte(rubRedevance.getCompte());
            fcd.setDatefact(FactureClientDetails.getFinMois(mois, annee));
            //Generer Facture
            /*FactureClient fc = new FactureClient(Utilitaire.dateDuJourSql(), Constante.idMICTSL, designation, 0);
            fc.setIdcategorie(Constante.idCategorieFCDefinitive);
            
            fc.setIduser(u);
            
//            fc.setFille(new FactureClientDetails[] {fcd}); Modifie à nouveau la valeur du taux
            
            fc.createObject(u, c);*/
 /*fcd.setIdmere(getId());
            fcd.controler(c);
            fcd.construirePK(c);
            fcd.insertToTableWithHisto(u, c);*/
            if (ouvert) {
                c.commit();
            }
            FactureClientDetails[] ret = new FactureClientDetails[1];
            ret[0] = fcd;
            return ret;
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

    public FactureClientDetails[] genererRedevanceVariable(int mois, int annee, String u, Connection c) throws Exception {
        Activite crt = new Activite();
        crt.setNomTable("ActiviteLibComContGPMA");
        Activite[] listeAct = (Activite[]) CGenUtil.rechercher(crt, null, null, c, " and mois =" + mois + " and annee=" + annee);
        double qte = AdminActivite.getQteEVP(listeAct);

        FactureClientDetails[] ret = new FactureClientDetails[1];
        double tauxFinDuMois = getTauxFinDuMois(c, mois, annee, listeAct[0].getDevise());
        Rubrique rubRedevance = new Rubrique();
        rubRedevance = (Rubrique) rubRedevance.getById(Constante.idRedevanceVariable, rubRedevance.getNomTable(), c);

        String moisEnLettre = Utilitaire.nbToMois(mois);
        String designation = "Redevance variable MICTSL " + moisEnLettre + " " + annee;

        //Generer Details
        FactureClientDetails fcd = new FactureClientDetails();
        fcd.setDesignation(designation);
        fcd.setQuantite(qte);
        fcd.setTva(rubRedevance.getTva());

        fcd.setRubrique(rubRedevance.getId());
        fcd.setPu(Utilitaire.stringToDouble(rubRedevance.getPu()));
        fcd.setDevise(rubRedevance.getDevise());
        fcd.setDuree(1);
        fcd.setCompte(rubRedevance.getCompte());
        double taux = getTauxFinDuMois(c, mois, annee, fcd.getDevise());

        fcd.setTaux(taux);
        fcd.setMois(mois);
        fcd.setAnnee(annee);
        fcd.setTauxDonne(true);

        fcd.setDatefact(FactureClientDetails.getFinMois(mois, annee));
        ret[0] = fcd;
        return ret;
    }

    public double getTauxFinDuMois(Connection c, int mois, int annee, String iddevise) throws Exception {
        Date finDuMois = FactureClientDetails.getFinMois(mois, annee);

        String awhere = " and daty = (SELECT max(daty) FROM COURSDEVISE WHERE  daty <= '" + Utilitaire.datetostring(finDuMois) + "' and iddevise = '" + iddevise + "') "
                + " and iddevise = '" + iddevise + "'";
        Coursdevise[] cd = (Coursdevise[]) CGenUtil.rechercher(new Coursdevise(), null, null, c, awhere);

        return cd != null && cd.length > 0 ? cd[0].getMontant() : 0;
    }

    public FactureClientDetails[] genererDroitDePort(int mois, int annee, String u, Connection c, FactureClient mere) throws Exception {
        Activite crt = new Activite();
        crt.setNomTable("ActiviteLibComContGPMA");
        Activite[] listeAct = (Activite[]) CGenUtil.rechercher(crt, null, null, c, " and mois =" + mois + " and annee=" + annee);
        if (listeAct == null || listeAct.length == 0) {
            throw new Exception("Pas d activite pour cette periode " + mois + "/" + annee);
        }
        FactureClientDetails[] ret = new FactureClientDetails[listeAct.length];
        double tauxFinDuMois = getTauxFinDuMois(c, mois, annee, listeAct[0].getDevise());
        for (int i = 0; i < listeAct.length; i++) {
            ret[i] = new FactureClientDetails();
            ret[i].setDesignation("Droit de port " + listeAct[i].getRubriquelib());
            ret[i].setMois(mois);
            ret[i].setAnnee(annee);
            ret[i].setQuantite(listeAct[i].getQte());
            ret[i].setPu(Utilitaire.stringToDouble(listeAct[i].getPu()));
            ret[i].setDevise(listeAct[i].getDevise());
            ret[i].setRubrique(listeAct[i].getRubrique());
            ret[i].setTva(listeAct[i].getTva());
            ret[i].setTaux(tauxFinDuMois);
            ret[i].setTauxDonne(true);
            ret[i].setDuree(1);

        }
        //mere.setEstDDPMICTSL("1");
        return ret;
    }

    public FactureClient creerMICTSL(Date d, String type, String noteExplicative, int mois, int annee, String u, Connection c) throws Exception {
        boolean ouvert = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                ouvert = true;
            }
            LocalDate lastDayOfMonth = LocalDate.of(annee, mois, LocalDate.of(annee, mois, 1).getMonth().length(Year.of(annee).isLeap()));
            this.setDaty(d);
            this.setDate_echeance(Utilitaire.ajoutJourDate(d, 30));
            this.setRemarque(noteExplicative);
            this.setTiers(Constante.idMICTSL);
            this.setIdcategorie(Constante.idCategorieFCDefinitive);
            this.setIduser(u);
            this.setDeviseMere(Constante.deviseDollars);
            this.setType(Constante.getTypeFCAcredit()); //Crédit
            this.setEstMictsl(Constante.estMictsl);

            FactureClient controle = new FactureClient();
            controle.setTiers(this.getTiers());

            FactureClientDetails[] zanany = null;
            if (type.equals("1")) {
                controlerDoublonRubrique(c, mois, annee, Constante.idRedevanceFixe);
                zanany = genererRedevanceFixe(mois, annee, u, c);
            } else if (type.equals("2")) {
                controlerDoublonRubrique(c, mois, annee, Constante.idRedevanceVariable);
                zanany = genererRedevanceVariable(mois, annee, u, c);
            } else if (type.equals("3")) {
                controlerDoublonRubrique(c, mois, annee, Constante.idDroitDePortCalcule);
                zanany = genererDroitDePort(mois, annee, u, c, this);
            }
            this.setFille(zanany);
            this.createObject(u, c);
            if (ouvert) {
                c.commit();
            }
            return this;
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

    public int getEstAuto() {
        return estAuto;
    }

    public void setEstAuto(int estAuto) {
        this.estAuto = estAuto;
    }
    
    public FactureClient(Date daty, String tiers, String designation, String type, String idcategorie, int estAuto) throws Exception {
        setNomTable("Factureclient");
        setLiaisonFille("idmere");
        this.setNomClasseFille("facture.FactureClientDetails");
        this.setDaty(daty);
        this.setTiers(tiers);
        this.setDesignation(designation);
        this.setType(type);
        this.setIdcategorie(idcategorie);
        this.setEstAuto(estAuto);
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

    public FactureClient(Date daty, String tiers, String designation, double tva, String type, String idcategorie,Date date_echeance) throws Exception {
        setNomTable("Factureclient");
        setLiaisonFille("idmere");
        this.setNomClasseFille("facture.FactureClientDetails");
        setDaty(daty);
        setTiers(tiers);
        setDesignation(designation);
        setTva(tva);
        this.setIdcategorie(idcategorie);
        setArrayDetails(new ArrayList<FactureClientDetails>());
        this.setType(type);
        this.setDate_echeance(date_echeance);

    }
    public FactureClient(Date daty, String tiers, String designation, double tva, String type, String idcategorie) throws Exception {
        setNomTable("Factureclient");
        setLiaisonFille("idmere");
        this.setNomClasseFille("facture.FactureClientDetails");
        setDaty(daty);
        setTiers(tiers);
        setDesignation(designation);
        setTva(tva);
        this.setIdcategorie(idcategorie);
        setArrayDetails(new ArrayList<FactureClientDetails>());
        this.setType(type);

    }

    public FactureClient(Date daty, String tiers, String designation, double tva, String type) throws Exception {
        setNomTable("Factureclient");
        setLiaisonFille("idmere");
        this.setNomClasseFille("facture.FactureClientDetails");
        setDaty(daty);
        setTiers(tiers);
        setDesignation(designation);
        setTva(tva);
        setArrayDetails(new ArrayList<FactureClientDetails>());
        this.setType(type);

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
        if (listeDetails == null) {
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
        return Utilitaire.formaterAr(montantreste);
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
        this.setNomClasseFille("facture.FactureClientDetails");
        this.setIduser(iduser);
        this.setId(null);
        if(this.getEstAncienne()!=1)this.setCode(calculerCode(cnctn));
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

    public String getEstMictsl() {
        return estMictsl;
    }

    public void setEstMictsl(String estMictsl) {
        this.estMictsl = estMictsl;
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
        if (listeDetails == null) {
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
        return Utilitaire.arrondirDecimalWithMode(montantreste,"#.##", RoundingMode.HALF_UP);
    }

    public void setMontantreste(double montantreste) {
        this.montantreste = montantreste;
    }

    /*
        Argument type:
            1 genere une facture définitive
            2 genere une facture de provision
     */
    public FactureClient setIdProvision(FactureClient fact2, int type, UserEJB u, Connection c) throws Exception {
        if (type == 1) {
            fact2.setIdProvision(this.getId());
        } else {
            if (this.getIdProvision() != null && !this.getIdProvision().isEmpty()) {
                throw new Exception("Impossible generer, facture deja liee a une provision ");
            }
            this.setIdProvision(fact2.getId());
            this.updateToTableWithHisto(u.getUser().getTuppleID(), c);
        }
        return fact2;
    }

    public FactureClient genererDefinitive(UserEJB u, int type, Connection c) throws Exception {
        int verif = 0;
        FactureClient fact2 = null;

        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }

            FactureClient fc = this;
            if (fc.getDaty() == null) {
                fc = (FactureClient) this.getById(this.getId(), this.getNomTable(), c);
            }

            String categorie = fc.getIdcategorie();

            if (type == 1) {
                fc.controlerDefinitive(c);
                categorie = Constante.idCategorieFCDefinitive;
            } else {
                JournalCaisse[] jc = this.getPaiement(c);
                if (jc.length == 0) {
                    throw new Exception("Pas de paiement pour cette provision");
                }
                fc.controlerProvision(c);
                categorie = Constante.idCategorieFCProvision;
            }

            fact2 = (FactureClient) fc.dupliquer(u.getUser().getTuppleID(), c);
            //System.out.println("length fact fille " + fact2.getFille().length);
            ClassFille[] clFille = fact2.getFille();
            int length = clFille.length;
            FactureClientDetails[] filles = new FactureClientDetails[length];
            for(int i =0; i<length; i++){
                filles[i] = (FactureClientDetails)clFille[i];
                filles[i].setTaux(0);
            }
            fact2 = fc.setIdProvision(fact2, type, u, c);
            fact2.setIdcategorie(categorie);
            fact2.setDaty(Utilitaire.dateDuJourSql());
            fact2.setCode(fact2.calculerCode(c));
            u.updateObjectMultiple(fact2, "idmere", filles, c);
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

        return fact2;
    }

    public JournalCaisse[] getListePaiement(String id, Connection c) throws Exception {
        String awhere = " and etat >= " + ConstanteEtat.getEtatValider() + " and idplacement = '" + id + "'";
        return (JournalCaisse[]) CGenUtil.rechercher(new JournalCaisse(), null, null, c, awhere);
    }

    public double getTauxRecent(Connection c, String iddevise) throws Exception {
        if (this.getDaty() == null) {
            FactureClient fc = new FactureClient();
            //fc.setEstDDPMICTSL(null);
            this.setDaty(((FactureClient) fc.getById(this.getId(), this.getNomTable(), c)).getDaty());
        }
        String awhere = " and daty = (SELECT max(daty) FROM COURSDEVISE WHERE  daty <= '" + Utilitaire.datetostring(this.getDaty()) + "' and iddevise = '" + iddevise + "') "
                + " and iddevise = '" + iddevise + "'";
        Coursdevise[] cd = (Coursdevise[]) CGenUtil.rechercher(new Coursdevise(), null, null, c, awhere);

        if (cd != null && cd.length > 0) {
            return cd[0].getMontant();
        }

        return 0;
    }

    public FactureClientDetails getFirstFille() throws Exception {
        FactureClientDetails fd = null;
        if (listeDetails != null && listeDetails.length > 0) {
            fd = new FactureClientDetails(listeDetails[0].getId(), listeDetails[0].getIdmere(), listeDetails[0].getQuantite(), listeDetails[0].getPu(), listeDetails[0].getTaux(), listeDetails[0].getCompte(), listeDetails[0].getIdproduit(), listeDetails[0].getProduit_lib(), listeDetails[0].getDevise(), listeDetails[0].getDesignation(), listeDetails[0].getIdProduitLib(), listeDetails[0].getIdactivite(), listeDetails[0].getCategorieFacturelib(), listeDetails[0].getCategorieClientlib(), listeDetails[0].getActivitelib(), listeDetails[0].getRubrique(), listeDetails[0].getMere(), listeDetails[0].getMontant(), listeDetails[0].getMontanttaux(), listeDetails[0].getMontantavoirsanstaux(), listeDetails[0].getMontantavoiravectaux(), listeDetails[0].getQtelivree(), listeDetails[0].getRestealivrer(), listeDetails[0].getDatefact(), listeDetails[0].getRubriquelib(), listeDetails[0].getIdprestation(), listeDetails[0].getClientlib(), listeDetails[0].getMois(), listeDetails[0].getAnnee(), listeDetails[0].getHeureDebut(), listeDetails[0].getHeureFin(), listeDetails[0].getMoislib(), listeDetails[0].getAnneelib(), listeDetails[0].getMontantHTEuro(), listeDetails[0].getMontantTVAEuro(), listeDetails[0].getMontanttaxe(), listeDetails[0].getMajoration(), listeDetails[0].getReduction(), listeDetails[0].getTva());
            fd.setRubrique(listeDetails[0].getRubrique());
        }
        fd.setMere(this);
        return fd;
    }
    public FactureClientDetails getFirstFille(String devise) throws Exception {
        if (listeDetails != null && listeDetails.length > 0) {
            for(int i=0;i<listeDetails.length;i++)
            {
                if(listeDetails[i].getDevise().compareToIgnoreCase(devise)==0)
                    return listeDetails[i];
            }
        }
        return null;
     }

    public void setDeviseEuro(Connection c) throws Exception {
        FactureClientDetails fd = getFirstFille(Constante.deviseEuro);
        if(fd==null)
        {
             fd=getFirstFille();
             fd.setDevise(Constante.deviseEuro);
            setDeviseEuro(fd.getTauxRecent(c));
            return;
        }
        if(fd.getTaux()>0)setDeviseEuro(fd.getTaux());
        else setDeviseEuro(fd.getTauxRecent(c));
    }

    public void setDeviseDollar(Connection c) throws Exception {
        //FactureClientDetails fd = getFirstFille();
        //fd.setDevise(Constante.deviseDollars);
        //setDeviseDollar(fd.getTauxRecent(c));
        FactureClientDetails fd = getFirstFille(Constante.deviseDollars);
        if(fd==null) 
        {
            fd=getFirstFille();
            fd.setDevise(Constante.deviseDollars);
            setDeviseDollar(fd.getTauxRecent(c));
            return;
        }
        if(fd.getTaux()>0)setDeviseDollar(fd.getTaux());
        else setDeviseDollar(fd.getTauxRecent(c));
    }
    public Date getDateChange()throws Exception
    {
        FactureClientDetails fdeur = getFirstFille(Constante.deviseEuro);
        FactureClientDetails fddol = getFirstFille(Constante.deviseDollars);
        if(fdeur!=null&&fdeur.getDatefact()!=null) return fdeur.getDatefact();
        if(fddol!=null&&fddol.getDatefact()!=null) return fdeur.getDatefact();
        return this.getDaty();
    }

    public void setDevises(Connection c) throws Exception {
        this.setDeviseEuro(c);
        this.setDeviseDollar(c);
        if(this.getDateChange()!=this.getDaty())
        {
           Coursdevise []cd=Coursdevise.getCours(c, Utilitaire.formatterDaty(this.getDateChange()) , ""+this.estMICTSLData());
           affecterDevise(cd);
        }
    }
    public void affecterDevise(Coursdevise[] liste) throws Exception
    {
        for(Coursdevise cd:liste)
        {
            if(cd.getIddevise().compareToIgnoreCase(Constante.deviseDollars)==0)this.setDeviseDollar(cd.getMontant());
            if(cd.getIddevise().compareToIgnoreCase(Constante.deviseEuro)==0)this.setDeviseEuro(cd.getMontant());           
        }
    }

    public void initDetails(Connection c) throws Exception {
        int verif = 0;

        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                verif = 1;
            }

            if (listeDetails == null) {
                FactureClientDetails fcd = new FactureClientDetails();
                fcd.setNomTable("facture_client_montanttc");
                listeDetails = (FactureClientDetails[]) CGenUtil.rechercher(fcd, null, null, c, " and idmere = '" + this.getId() + "' order by rang asc, datyactivite asc");
                if (listeDetails == null) {
                    throw new Exception("Aucun details pour la facture " + this.getId());
                }
            }

            this.setDevises(c);

            for (int i = 0; i < listeDetails.length; i++) {
                double montantHT = listeDetails[i].getMontant(), montantTVA = listeDetails[i].getMontanttaxe();
                String devise = listeDetails[i].getDevise();
                
                if (devise != null && devise.equalsIgnoreCase(Constante.deviseAr)) {
                    montantHT = montantHT / this.getDeviseEuro();
                    montantTVA = montantTVA / this.getDeviseEuro();
                }

                listeDetails[i].setMontantHTEuro(listeDetails[i].getMontantAvecMajRed(montantHT));
                listeDetails[i].setMontantTVAEuro(listeDetails[i].getMontantAvecMajRed(montantTVA));
            }

            coeff = deviseEuro / deviseDollar;

        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    public Prevision findPrevision(String nomtable, Connection c) throws Exception {
        String awhere = " and id = '%s'";
        awhere = String.format(awhere, this.getIdprevision());
        Prevision pr = new Prevision();
        if (nomtable != null && nomtable.compareTo("") != 0) {
            pr.setNomTable(nomtable);
        }
        Prevision[] result = (Prevision[]) CGenUtil.rechercher(pr, null, null, c, awhere);
//        if (result.length == 0) {
//            throw new Exception("Pas de prevision pour la facture " + this.getId());
//        }
        return result.length > 0 ? result[0] : null;
    }

    public String calculerCodeMictsl(Connection c) throws Exception {
        String daty = Utilitaire.datetostring(this.getDaty());
        String awhere = " and annee = %s";
        String annee = Utilitaire.getAnnee(daty);
        awhere = String.format(awhere, annee);
        return genererPremierCaractere(c)
                + Utilitaire.genererAnnee(daty)
                + Utilitaire.genererMois(daty)
                + genererLettreMictsl(c)
//                + genererSequence(c, "NUMEROFACTUREMCTSL", 6);
                + new UtilitaireFacture().genererSequence(c, "NUMEROFACTUREMCTSL_PARDATE", 6, daty,awhere);
    }
/*
    public String genererSequence(Connection c, String nomtable, int longueur) throws Exception {
        String daty = Utilitaire.datetostring(this.getDaty());
        
        String sequence = "1";
                
        NumeroFacture num = new NumeroFacture();
        num.setNomTable(nomtable);
        
        String awhere = " and mois = %s and annee = %s";
        String mois = Utilitaire.genererMois(daty), annee = Utilitaire.getAnnee(daty);
        awhere = String.format(awhere, mois, annee);
        
        NumeroFacture[] nums = (NumeroFacture[]) CGenUtil.rechercher(num, null, null, c, awhere);
        
        if(nums != null && nums.length > 0) sequence = ""+nums[0].getNumerosuivant();
        
        return Utilitaire.completerInt(longueur, sequence);
    }
*/
    public String calculerCodeSimple(Connection c) throws Exception {
        String daty = Utilitaire.datetostring(this.getDaty());
        String code = "", codePrestation = genererCodePrestation(c);
        String typecateg = genererPremierCaractere(c);
        code += Utilitaire.champNull(typecateg);
        code += Utilitaire.genererAnnee(daty);
        code += Utilitaire.genererMois(daty);
        code += Utilitaire.champNull(codePrestation);
        code += "A";
//        code += genererSequence(c, "numerofacturesimple", 3);
        code += new UtilitaireFacture().genererSequence(c, "NUMEROFACTURESIMPLE_PARDATE", 3,daty, codePrestation, typecateg);
        return code;
    }

    public String calculerCode(Connection c) throws Exception {
        if (estMictsl != null && estMictsl.compareTo("1") == 0) {
            return calculerCodeMictsl(c);
        }

        return calculerCodeSimple(c);
    }

    public FactureClient[] getFactureLiees(String nomtable, Connection c) throws Exception { //iza daholo ny factures liées amin’io provision io
        int verif = 0;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            FactureClient fc = new FactureClient();
            if (nomtable == null) {
                nomtable = this.getNomTable();
            }
            fc.setNomTable(nomtable);
            String awhere = String.format(" and idProvision = '%s' ", this.getId());
            FactureClient[] result = (FactureClient[]) CGenUtil.rechercher(fc, null, null, c, awhere);
            return result;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    public PaiementFacture[] getPaiementFacture(Connection c) throws Exception {
        boolean ouvert = false;

        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();

                ouvert = true;
            }
            PaiementFacture pF = new PaiementFacture();
            pF.setNomTable("paiementFacture");
            PaiementFacture[] paiement = (PaiementFacture[]) CGenUtil.rechercher(pF, null, null, c, String.format(" and idFact='%s' order by id desc", this.getId()));
            return paiement;
        } catch (Exception ex) {

            throw ex;
        } finally {
            if (c != null && ouvert) {
                c.close();
            }
        }
    }

    public FactureClient getProvision(String nomtable, Connection c) throws Exception { //iza ny provision liée amin’io facture io
        int verif = 0;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                verif = 1;
            }
            if (this.getIdProvision() != null) {
                if (nomtable == null) {
                    nomtable = this.getNomTable();
                }
                FactureClient fc = new FactureClient();
                fc.setNomTable(nomtable);
                String awhere = String.format(" and id = '%s' ", this.getIdProvision());
                FactureClient[] result = (FactureClient[]) CGenUtil.rechercher(fc, null, null, c, awhere);
                if (result != null && result.length > 0) {
                    return result[0];
                }

            }
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }

        return null;
    }

    public ClientCategorie getClient(Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            ClientCategorie cc = new ClientCategorie();
            cc.setNomTable("V_CLIENT_CATEGORIE");
            String awhere = String.format(" and cdclt = '%s' ", this.getTiers());
            ClientCategorie[] result = (ClientCategorie[]) CGenUtil.rechercher(cc, null, null, c, awhere);
            if (result != null && result.length > 0) {
                return result[0];
            }
            return null;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    public double affResteProvision(double resteProvision) {
        return Math.abs(resteProvision);
    }

    public String affLibelle(double reste) throws Exception {
        String retour = "Manque";
       
        if (reste > 0) {
            retour = "Trop per&ccedil;u";
        }
        return retour;
    }

    public String affLibelle(Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            EtatProvision etatProvision = new EtatProvision();
            etatProvision.setId(this.getId());
            double reste = etatProvision.getResteProvision(c);
            
            return affLibelle(reste);
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    
    public FactureClientDetails[] getFilles(String [] idfille, Connection c)throws Exception{
        int verif = 0;
        try{
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            utilitaire.Utilitaire.tabToString(idfille, code, iduser);
            FactureClientDetails fcd = new FactureClientDetails();
            fcd.setNomTable("facture_client_fille");
            String awhere = String.format(" and id in (%s)", utilitaire.Utilitaire.tabToString(idfille, "'", ","));
            FactureClientDetails[] result = (FactureClientDetails[]) CGenUtil.rechercher(fcd, null, null, c, awhere);            
            return result;
        }catch(Exception ex){
            throw ex;
        }finally{
            if (c != null && verif == 1) {
                c.close();
            }            
        }
    }
    public FactureClient scinder(String mere, String[] idfille,Connection c) throws Exception{
        int verif = 0;
        FactureClient fact2 = null;
        try {
                if (c == null) {
                    c = (new UtilDB()).GetConn();
                    c.setAutoCommit(false);
                    verif = 1;
                }
            FactureClient fc= (FactureClient) new FactureClient().getById(mere, "Factureclient", c);
            if(fc.getEtat() >= 11) throw new Exception("Une facture visee ne peut etre scindee");
            fact2=fc.scinder(idfille, c);
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
        return fact2;
    }
    public FactureClient scinder(String[] idfille,Connection c) throws Exception{
    int verif = 0;
        try {
                if (c == null) {
                    c = (new UtilDB()).GetConn();
                    c.setAutoCommit(false);
                    verif = 1;
                }
                FactureClient fc = new FactureClient( daty, date_echeance,  tiers,  designation,  type,  remarque,  iduser,  idprevision,  escale,  deviseMere,  tva,  montant, montanttva,  montantttc,  montantpaye,  montantreste,  tierslib,  montantavoir, contact,  adresse,  etatLib,  typelib,  deviseEuro, deviseDollar, coeff, montantHTEuro, montantTVAEuro, montantHTVADollar, montantTVADollar, montantTTCDollar, montantttcvrai, idcategorie, idProvision, categorielib, idProvisionlib, iddefinitive,  estDDPMICTSL, codePrestation, codePrestationlib, codeProvision, code,  estMictsl,  reduction, ecart);
                fc.setNomTable("factureclient");
                fc.construirePK(c);
                fc.setCode(calculerCode(c));
                fc.insertToTableWithHisto(iduser,c);
                FactureClientDetails[] filles =   getFilles(idfille,  c); 
                for(int i=0; i<filles.length; i++ )
                {
                     filles[i].setIdmere(fc.getId());
                     filles[i].updateToTableWithHisto(iduser, c);
                
                }
                        
                return fc;      
        }catch(Exception e){
            if (c != null && verif == 1) {
                c.rollback();
            }
            throw e;
        }finally{
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }
    
    public static FactureClient[] getFactures(String ids, Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            FactureClient cc = new FactureClient();
            cc.setNomTable("factureclientgroupvide");
            String requete = "select tiers,tierslib,cast(sum(montantreste) as NUMBER(30,2)) as montant  "
                    + " from FACTURECLIENTMSUM_LIBV "
                    + " where id in('"+ids.replace(";", "','")+"') group by tiers,tierslib";
            FactureClient[] result = (FactureClient[]) CGenUtil.rechercher(cc, requete, c);
            if (result != null && result.length > 0) {
                return result;
            }
            return null;
        } finally {
            if (c != null && verif == 1) {
                c.close();
            }
        }
    }

    public static FactureClient grouperFacture(String ids, Connection c) throws Exception{
        FactureClient[] factures = getFactures(ids,c);
        if(factures == null || factures.length == 0) throw new Exception("Factures introuvables ou non visees");
        if(factures.length > 1) throw new Exception("Client differents!");
        else if(factures.length == 1) { 
            return factures[0];
        }
        return null;
    }
    
    public void checkCode(Connection c) throws Exception{
        TypeObjet code = new TypeObjet();
        code.setNomTable("CODEFCPREMIERCARACTERE");
        TypeObjet[] ls =null;
        if(this.getIdcategorie()==null || this.getIdcategorie().compareTo("")==0) throw new Exception("Categorie invalide");
        if(this.getIdcategorie().compareTo(Constante.idCategorieFCDefinitive)==0){
            // test debut type
            if(this.getType()==null || this.getType().compareTo("")==0) throw new Exception("Type invalide");
            ls= (TypeObjet[]) CGenUtil.rechercher(code, null, null, c, " and val ='"+this.getType()+"'");
            if(ls.length>0){
                if(this.getCode().startsWith(ls[0].getDesce()) == false) throw new Exception("Début du code invalide");
            }
        }else{
            // test debut categorie
            ls = (TypeObjet[]) CGenUtil.rechercher(code, null, null, c, " and val ='"+this.getIdcategorie()+"'");
            if(ls.length>0){
                if(this.getCode().startsWith(ls[0].getDesce()) == false) throw new Exception("Début du code invalide");
            }
        }
    }
    
    public ClientCategorie findClient(String nomtable,Connection c) throws Exception{
        if (nomtable == null || nomtable.compareToIgnoreCase("") == 0) nomtable = "client_union";
        ClientCategorie cl = new ClientCategorie();
        cl.setNomTable(nomtable);
        ClientCategorie[] clients = (ClientCategorie[]) CGenUtil.rechercher(cl, null, null, c, " and cdclt = '"+this.getTiers()+"'");
        if(clients.length > 0) return clients[0];
        return null;
    }
    
    public FactureClient(Date daty, Date date_echeance, String tiers, String designation, String type, String remarque, String iduser, String idprevision, String escale, String deviseMere, double tva, double montant, double montanttva, double montantttc, double montantpaye, double montantreste, String tierslib, double montantavoir, String contact, String adresse, String etatLib, String typelib, double deviseEuro, double deviseDollar, double coeff, double montantHTEuro, double montantTVAEuro, double montantHTVADollar, double montantTVADollar, double montantTTCDollar, double montantttcvrai, String idcategorie, String idProvision, String categorielib, String idProvisionlib, String iddefinitive, String estDDPMICTSL, String codePrestation, String codePrestationlib, String codeProvision, String code, String estMictsl, double reduction, double ecart) throws Exception {
        setNomTable("Factureclient");
        setLiaisonFille("idmere");
        this.setNomClasseFille("facture.FactureClientDetails");
        this.daty = daty;
        this.date_echeance = date_echeance;
        this.tiers = tiers;
        this.designation = designation;
        this.type = type;
        this.remarque = remarque;
        this.iduser = iduser;
        this.idprevision = idprevision;
        this.escale = escale;
        this.deviseMere = deviseMere;
        this.tva = tva;
        this.montant = montant;
        this.montanttva = montanttva;
        this.montantttc = montantttc;
        this.montantpaye = montantpaye;
        this.montantreste = montantreste;
        this.tierslib = tierslib;
        this.montantavoir = montantavoir;
        this.contact = contact;
        this.adresse = adresse;
        this.etatLib = etatLib;
        this.typelib = typelib;
        this.deviseEuro = deviseEuro;
        this.deviseDollar = deviseDollar;
        this.coeff = coeff;
        this.montantHTEuro = montantHTEuro;
        this.montantTVAEuro = montantTVAEuro;
        this.montantHTVADollar = montantHTVADollar;
        this.montantTVADollar = montantTVADollar;
        this.montantTTCDollar = montantTTCDollar;
        this.montantttcvrai = montantttcvrai;
        this.idcategorie = idcategorie;
        this.idProvision = idProvision;
        this.categorielib = categorielib;
        this.idProvisionlib = idProvisionlib;
        this.iddefinitive = iddefinitive;
        this.estDDPMICTSL = estDDPMICTSL;
        this.codePrestation = codePrestation;
        this.codePrestationlib = codePrestationlib;
        this.codeProvision = codeProvision;
        this.code = code;
        this.estMictsl = estMictsl;
        this.reduction = reduction;
        this.ecart = ecart;
    }
    public String getIdfact() {
        return idfact;
    }
    public void setIdfact(String idfact) {
        this.idfact = idfact;
    }

}
