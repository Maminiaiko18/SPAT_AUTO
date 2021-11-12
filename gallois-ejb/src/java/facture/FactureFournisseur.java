/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.CGenUtil;
import bean.ClassMAPTable;
import bean.TypeObjet;
import java.sql.Connection;
import java.sql.Date;
import mg.spat.JournalCaisse;
import mg.spat.stock.BonDeLivraisonFilleReste;
import user.UserEJB;
import utilitaire.Constante;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author rijan
 */
public class FactureFournisseur extends FactureClient {
   private String numeroop,projet,code_etablissement,projetlib,code_etablissementlib;
    public String getNumeroop() {
        return numeroop;
    }

    public void setNumeroop(String numeroop) {
        this.numeroop = numeroop;
    }

    public String getProjet() {
        return projet;
    }

    public void setProjet(String projet) {
        this.projet = projet;
    }

    public String getCode_etablissement() {
        return code_etablissement;
    }

    public void setCode_etablissement(String code_etablissement) {
        this.code_etablissement = code_etablissement;
    }

    public String getProjetlib() {
        return projetlib;
    }

    public void setProjetlib(String projetlib) {
        this.projetlib = projetlib;
    }

    public String getCode_etablissementlib() {
        return code_etablissementlib;
    }

    public void setCode_etablissementlib(String code_etablissementlib) {
        this.code_etablissementlib = code_etablissementlib;
    }
   


    public FactureFournisseur() throws Exception {
        this.setNomTable("facture_Fournisseur_Mere");
        this.setLiaisonFille("idmere");
        this.setNomClasseFille("facture.FactureFournisseurDetails");
    }

    @Override
    public String getValColLibelle() {
        return getDesignation()+";"+getId();
    }
    
    

    public FactureFournisseur(String id, String tiers, String designation, String type, String remarque, String iduser, String idprevision, String idcategorie, double tva, Date daty, Date dateEcheance, int etat) throws Exception {
        this.setNomTable("facture_Fournisseur_Mere");
        this.setId(id);
        this.setTiers(tiers);
        this.setDesignation(designation);
        this.setType(type);
        this.setRemarque(remarque);
        this.setIduser(iduser);
        this.setIdprevision(idprevision);
        this.setIdcategorie(idcategorie);
        this.setTva(tva);
        this.setDaty(daty);
        this.setDate_echeance(dateEcheance);
        this.setEtat(etat);
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("FAF", "get_seq_factFournMere");
        this.setId(makePK(c));
    }
    
    public static FactureFournisseur[] getFactures(String ids, Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }
            FactureFournisseur cc = new FactureFournisseur();
            cc.setNomTable("factureclientgroupvide");
            String requete = "select tiers,tierslib,cast(sum(montantreste) as NUMBER(30,3)) as montant  "
                    + " from FACTUREFOURNVALIDE_V "
                    + " where id in('"+ids.replace(";", "','")+"') group by tiers,tierslib";
            FactureFournisseur[] result = (FactureFournisseur[]) CGenUtil.rechercher(cc, requete, c);
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

    @Override
    public ClassMAPTable createObject(String iduser, Connection cnctn) throws Exception {
        this.setNomClasseFille("facture.FactureFournisseurDetails");
        this.setIduser(iduser);
        this.setId(null);
        return super.createObject(iduser, cnctn);
    }

    public FactureFournisseurDetails genererFFDetails() throws Exception {
        FactureFournisseurDetails fcd = new FactureFournisseurDetails();
        fcd.setNomTable("FACTURE_FOURNISSEUR_FILLE");
        fcd.setIdmere(this.getId());
        fcd.setDesignation("bon provisoire no " + this.getCode());
        fcd.setQuantite(1);
        fcd.setPu(this.getMontant());
        fcd.setDevise(Constante.deviseAr);
        fcd.setTaux(1);
        fcd.setTva(0);
        return fcd;
    }

    public FactureFournisseur genererBP(String iduser, Connection c) throws Exception {
        boolean ouvert = false;

        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                ouvert = true;
            }
            System.out.println("Niditra tao amin'ny genererBP dans FF");
            this.setType(Constante.getTypeFCAcredit());
            this.setIdcategorie(Constante.getCategorieFFBP());
            this.setDeviseMere(Constante.deviseAr);
            super.createObject(iduser, c);

            FactureClientDetails ffd = genererFFDetails();
            ffd.createObject(iduser, c);

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

        return this;
    }

    String idBL;

    public String getIdBL() {
        return idBL;
    }

    public void setIdBL(String idBL) {
        this.idBL = idBL;
    }

    public BonDeLivraisonFilleReste[] getBP(Connection c) throws Exception {
        boolean ouvert = false;
        BonDeLivraisonFilleReste[] livraisons = new BonDeLivraisonFilleReste[0];
        if(this.getIdBL() == null || this.getIdBL().trim().equals("")) return livraisons;
        
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                ouvert = true;
            }
            
            BonDeLivraisonFilleReste bl = new BonDeLivraisonFilleReste();
            bl.setNomTable("AS_BONDELIVRAISON_FILLEQTE_RES");
            bl.setNumbl(this.getIdBL());
            livraisons = (BonDeLivraisonFilleReste[]) CGenUtil.rechercher(bl, null, null, c, "");

        } catch (Exception ex) {
            throw ex;
        } finally {
            if (c != null && ouvert) {
                c.close();
            }
        }

        return livraisons;
    }
    public FactureFournisseur setIdProvision(FactureFournisseur fact2, int type, UserEJB u, Connection c) throws Exception {
        if (type == 1) {
            fact2.setIdProvision(this.getId());
        } else {
            if (this.getIdProvision() != null && !this.getIdProvision().isEmpty()) {
                throw new Exception("Impossible a generer, facture deja liee a un bon provisoire ");
            }
            this.setIdProvision(fact2.getId());
            this.updateToTableWithHisto(u.getUser().getTuppleID(), c);
        }
        return fact2;
    }
    public void controlerDefinitive(Connection c) throws Exception {
        if (this.getEtat() < ConstanteEtat.getEtatValider()) {
            throw new Exception("Bon provisoire non visee");
        }
        if (!this.getIdcategorie().equals(Constante.getCategorieFFBP())) {
            throw new Exception("Cette facture n est pas une facture de provision!");
        }
    }
    public FactureFournisseur genererDefinitive(UserEJB u, int type, Connection c) throws Exception {
        int verif = 0;
        FactureFournisseur fact2 = null;

        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                verif = 1;
            }

            FactureFournisseur fc = this;
            if (fc.getDaty() == null) {
                fc = (FactureFournisseur) this.getById(this.getId(), this.getNomTable(), c);
            }

            String categorie = fc.getIdcategorie();

            if (type == 1) {
                fc.controlerDefinitive(c);
                categorie = Constante.categorieFFdefault;
            } else {
                JournalCaisse[] jc = this.getPaiement(c);
                if (jc.length == 0) {
                    throw new Exception("Pas de paiement pour ce bon provisoire");
                }
                fc.controlerProvision(c);
                categorie = Constante.getCategorieFFBP();
            }

            fact2 = (FactureFournisseur) fc.dupliquer(u.getUser().getTuppleID(), c);
            fact2 = (FactureFournisseur) fc.setIdProvision(fact2, type, u, c);
            fact2.setIdcategorie(categorie);
            fact2.setDaty(Utilitaire.dateDuJourSql());
            fact2.calculerCode(c);
            u.updateObjectMultiple(fact2, "idmere", fact2.getFille(), c);
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
    public double getMontantResteProvision(Connection c) throws Exception {
        double result = 0.;
        int verify = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verify = 1;
            }
            EtatProvision ep = new EtatProvision();
            ep.setNomTable("etatbpvrai");
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
    public PaiementFacture[] findPaiementProvision(String idProvision, Connection c) throws Exception {
        boolean ouvert = false;
        PaiementFacture[] retour = null;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                ouvert = true;
            }
            PaiementFacture pf=new PaiementFacture();
            pf.setNomTable("paiementfacturef");
            retour = (PaiementFacture[]) CGenUtil.rechercher(pf, null, null, c, " and idFact='" + idProvision + "'");
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && ouvert) {
                c.close();
            }
        }
        return retour;
    }
    public void genererPaiementDefinitive(String u, String idProvision, Connection c) throws Exception {
        boolean ouvert = false;
        PaiementFacture[] retour = null;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                ouvert = true;
            }

            FactureFournisseur fc = new FactureFournisseur();
            fc = (FactureFournisseur) fc.getById(this.getId(), "FACTFOURN_MSUM_LIB", c);

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
        if (this.getIdcategorie() != null && this.getIdcategorie().equals(utilitaire.Constante.categorieFFdefault) && this.getIdProvision() != null) {
            this.genererPaiementDefinitive(u, this.getIdProvision(), c);
        }
        super.validerObject(u, c);
        return this;
    }
    
			public static FactureFournisseur grouperFacture(String ids, Connection c) throws Exception{
				FactureFournisseur[] factures = FactureFournisseur.getFactures(ids,c);
				if(factures == null || factures.length == 0) throw new Exception("Factures introuvables ou non visees");
				if(factures.length > 1) throw new Exception("Fournisseur differents!");
				else if(factures.length == 1) { 
					return factures[0];
				}
				return null;
			}        

    @Override
    public String calculerCodeSimple(Connection c) throws Exception {
        String daty = Utilitaire.datetostring(this.getDaty());
        String code = "";
        code += Utilitaire.genererAnnee(daty);
        code += Utilitaire.genererMois(daty);
        code += Utilitaire.getJour(daty);
        code += UtilitaireFacture.genererSequence( c, "NUMEROCOMPTA", 4, daty);
        return code;
    }
                        
    
}
