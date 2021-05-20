/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facture;

import bean.CGenUtil;
import java.sql.Connection;
import java.util.ArrayList;
import user.UserEJB;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
/**
 *
 * @author je sais pas
 */
public class FactureProforma extends FactureClient{
    
    private FactureProformaDetails[] filles;
    private ArrayList<FactureProformaDetails> listeDetails;
    private String adresse, contact;
    private double montanttaux;
    
    public FactureProforma() throws Exception{
        super.setNomTable("facture_prof_mere");
        setLiaisonFille("idmere");
        this.setNomClasseFille("facture.FactureProformaDetails");
    }
    
    @Override
    public void construirePK(Connection c) throws Exception {
        preparePk("FCP", "get_seqfacture_prof_fille");
        setId(makePK(c));
    }
    
    public void initialiserFilles (Connection c, String nomtablefille) throws Exception {
        boolean ouvert = false;
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                ouvert = true;
            }
            FactureProformaDetails factureProformaDetails = new FactureProformaDetails();
            factureProformaDetails.setNomTable(nomtablefille);
            FactureProformaDetails[] fille = (FactureProformaDetails[]) CGenUtil.rechercher(factureProformaDetails, null, null, c, " and idmere = '" + this.getId() + "'");
            
            if (fille != null && fille.length > 0) {
                this.setFilles(fille);
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
    
    public FactureClient proformaToFactureClient(UserEJB u, Connection c) throws Exception {
        boolean ouvert = false;
        
        try {
            if (c == null) {
                c = (new UtilDB()).GetConn();
                c.setAutoCommit(false);
                ouvert = true;
            }

            FactureProforma fact = (FactureProforma) this.getById(this.getId(), this.getNomTable(), c);

            if (fact.getEtat() < ConstanteEtat.getEtatValider()) {
                throw new Exception("Facture proforma non visée");
            }

            fact.setNomTable("factureclient");
            
            fact.setId(null);
            u.createObject(fact, c);

            initialiserFilles(c, "facture_prof_fille");

            if (filles != null) {
                for (int i = 0; i < filles.length; i++) {
                    filles[i].setNomTable("facture_client_fille");
                    filles[i].setIdmere(fact.getId());
                    filles[i].setId(null);
                    
                    u.createObject(filles[i], c);
                }
            }
            
            if (ouvert) {
                c.commit();
            }
            
            return fact;
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
    
    public FactureProformaDetails[] getFilles() {
        return filles;
    }

    public void setFilles(FactureProformaDetails[] filles) {
        this.filles = filles;
    }

    public ArrayList<FactureProformaDetails> getListeDetails() {
        return listeDetails;
    }

    public void setListeDetails(ArrayList<FactureProformaDetails> listeDetails) {
        this.listeDetails = listeDetails;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public double getMontanttaux() {
        return montanttaux;
    }

    public void setMontanttaux(double montanttaux) {
        this.montanttaux = montanttaux;
    }
    
}
