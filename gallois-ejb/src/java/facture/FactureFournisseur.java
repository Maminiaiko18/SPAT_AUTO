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

    public FactureFournisseur() throws Exception {
        this.setNomTable("facture_Fournisseur_Mere");
        this.setLiaisonFille("idmere");
        this.setNomClasseFille("facture.FactureFournisseurDetails");
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
        if (this.getIdcategorie() != null && this.getIdcategorie().equals(Constante.getCategorieFFBP())) {
            return genererBP(iduser, cnctn);
        }

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
}
