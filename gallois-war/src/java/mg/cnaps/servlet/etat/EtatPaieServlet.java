package mg.cnaps.servlet.etat;

import affichage.Liste;
import affichage.PageRecherche;
import affichage.PageRechercheGroupe;
import affichage.TableauRecherche;
import avoir.AvoirFC;
import avoir.AvoirFCFille;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import mg.spat.EtatRedevance;
import mg.spat.EtatJournalCaisse;
import bean.AdminGen;
import bean.CGenUtil;
import bean.ClassMAPTable;
import bean.ResultatEtSomme;
import bean.TypeObjet;
import bean.ValeurEtiquette;
import mg.spat.AnalyseMarchandisePDF;
import bordereau.BordereauFilleLibComplet;
import bordereau.BordereauLibComplet;
import ded.OrdonnerPayementPDF;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import user.*;
import mg.spat.etat.servlet.*;
import reporting.ReportingUtils;
import utilitaire.Utilitaire;
import ded.OrdonnerPayementPDF;
import mg.spat.stock.*;
import utilitaire.ChiffreLettre;
import ded.BonEngagementPDF;
import caisse.SituationComptesData;
import facture.ChiffreAffaire;
import facture.EtatProvision;
import java.util.Collection;
import mg.amadia.stock.EtatdeStockDate;
import mg.amadia.stock.RecapitulatifComptesSubReport;
import mg.amadia.stock.RecapitulatifComptesSubReport;
import mg.spat.JournalCaisse;
import facturefournisseur.*;
import java.sql.Date;
import mg.allosakafo.produits.*;
import mg.spat.FactureAnalyse;
import mg.spat.BonProvisoireComplet;
import utilitaire.UtilDB;
import mg.amadia.facture.*;
import mg.cnaps.formation.CodeEtablissement;
import mg.spat.EtatCaisse;
import service.EtatCaisseService;
import mg.spat.JournalCaisse;
import mg.spat.placement.PlacementLibComplet;
import mg.spat.placement.Placement;
import mg.spat.Caisse;
import mg.spat.JournalCaisseSubReport;
import mg.spat.JournalCaisseMode;
import projet.Projet;
import facture.FactureProforma;
import facture.FactureProformaDetails;
import facture.FactureClient;
import facture.FactureClientDetails;
import facture.FactureClientDetailsGrouper;
import facture.FactureClientDetailsPDF;
import facture.FactureClientDetailsPDFMere;
import facture.FactureFournisseurDetails;
import facture.FactureFournisseurFilleData;
import facture.ProformaFille;
import facture.ProformaMere;
import factureclient.PayementFacture;
import fin.Coursdevise;
import fin.CoursdevisePDF;
import java.io.ByteArrayOutputStream;
import java.io.OutputStream;
import lignecredit.LigneCredit;
import mg.spat.CA;
import mg.spat.CaPDF;
import mg.spat.CargaisonAnalyse;
import mg.spat.Engagement;
import mg.spat.EngagementFille;
import mg.spat.EtatCA;
import mg.spat.JournalCaissePdf;
import mg.spat.OccupationMaterielNaval;
import mg.spat.PrevisionLibComplet;
import mg.spat.Tarif;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import mg.spat.DemandeAchatMere;
import mg.spat.DemandeAchatFille;

import org.apache.poi.ss.usermodel.Sheet;
import utilitaire.Constante;

/**
 *
 * @author Manda
 */
@WebServlet(name = "EtatPaieServlet", urlPatterns = {"/Paie"})
public class EtatPaieServlet extends HttpServlet {

    String nomJasper = "";

    public String getReportPath() throws IOException {
        return getServletContext().getRealPath(File.separator + "report" + File.separator + getNomJasper() + ".jasper");
    }

    public String getNomJasper() {
        return nomJasper;
    }

    public void setNomJasper(String nomJasper) {
        this.nomJasper = nomJasper;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        try {
            String action = request.getParameter("action");
            if (action.equalsIgnoreCase("ordonnerpayement")) {
                ordonnerpayement(request, response);
            } else if (action.equalsIgnoreCase("boncommande")) {
                boncommande(request, response);
            } else if (action.equalsIgnoreCase("imprimerBed")) {
                imprimerBed(request, response);
            } else if (action.equalsIgnoreCase("recapitulatifCompteCourant")) {
                recapitulatifCompteCourant(request, response);
            } else if (action.equalsIgnoreCase("imprimerBed2")) {
                imprimerBed2(request, response);
            } else if (action.equalsIgnoreCase("pieceDeCaiseDepense")) {
                pieceDeCaiseDepense(request, response);
            } else if (action.equalsIgnoreCase("pieceDeCaiseRecette")) {
                pieceDeCaiseRecette(request, response);
            } else if (action.equalsIgnoreCase("imprimerBon")) {
                imprimerBon(request, response);
            } else if (action.equalsIgnoreCase("fiche_facture")) {
                fiche_facture(request, response);
            } else if (action.equalsIgnoreCase("journalCaisseDepense")) {
                journalCaisseDepense(request, response);
            } else if (action.equalsIgnoreCase("imprimerFacture")) {
                imprimerFacture(request, response);
            } else if (action.equalsIgnoreCase("imprimerFactureClient")) {
                imprimerFactureClient(request, response);
            } else if (action.equalsIgnoreCase("fichePrestation")) {
                fichePrestation(request, response);
            } else if (action.equalsIgnoreCase("fact")) {
                fact(request, response);
            } else if (action.equalsIgnoreCase("imprimerAvoir")) {
                imprimerAvoir(request, response);
            } else if (action.equalsIgnoreCase("imprimerEtatProvision")) {
                imprimerEtatProvision(request, response);
            } else if (action.equalsIgnoreCase("imprimerFactureFournisseur")) {
                imprimerFactureFournisseur(request, response);
            } else if (action.equalsIgnoreCase("listeJournalCaisse")) {
                listeJournalCaisse(request, response);
            } else if (action.equalsIgnoreCase("excel")) {
                excel(request, response);
            } else if (action.equalsIgnoreCase("analyseMarchandise")) {
                analyseMarchandise(request, response);
            } else if (action.equalsIgnoreCase("listefactureVaovao")) {
                listefactureClient(request, response);
            } else if (action.equalsIgnoreCase("impressionCA")) {
                impressionCA(request, response);
            } else if (action.equalsIgnoreCase("rubrique_activite")) {
                rubrique_activite_pdf(request, response);
            } else if (action.equalsIgnoreCase("coursdevise")) {
                coursdevise_pdf(request, response);
            } else if (action.equalsIgnoreCase("journalCaisseEtat")) {
                journalCaisseEtat(request, response);
            } else if (action.equalsIgnoreCase("imprimerGestionProvision")) {
                imprimerGestionProvision(request, response);
            } else if (action.equalsIgnoreCase("imprimerRedevanceCommunale")) {
                redevanceCommunale(request, response);
            } else if (action.equalsIgnoreCase("engagement")) {
                engagement(request, response);
            } else if (action.equalsIgnoreCase("dse")) {
                dse(request, response);
            } else if (action.equalsIgnoreCase("lgc")) {
                ligneCreditDepense(request, response);
            } else if (action.equalsIgnoreCase("imprimerDemandeAchat")) {
                demandeAchat(request, response);
            } else if (action.equalsIgnoreCase("proforma")) {
                imprimerProforma(request, response);
            }

        } catch (Exception ex) {
            ex.printStackTrace();
            response.setContentType("text/html");
            //response.setBufferSize(8192);
            PrintWriter out = response.getWriter();
            out.println("<html>");
            out.println("<head>");
            out.print("<script>alert('" + ex.getMessage() + "');history.back();</script>");
            out.println("</head>");
            out.println("</html>");
            out.close();

            throw ex;
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(EtatPaieServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(EtatPaieServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void demandeAchat(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            DemandeAchatMere jc = new DemandeAchatMere();
            jc.setId(request.getParameter("id"));
            jc.setNomTable("dem_achat_merelib");
            DemandeAchatMere[] tabJournal = (DemandeAchatMere[]) CGenUtil.rechercher(jc, null, null, " and id = '" + jc.getId() + "'");
            if (tabJournal.length > 0) {
                jc = tabJournal[0];
            }
            DemandeAchatFille j = new DemandeAchatFille();
            j.setNomTable("dem_achat_fillelib");
            DemandeAchatFille[] tabJournalFille = (DemandeAchatFille[]) CGenUtil.rechercher(j, null, null, " and idmere = '" + jc.getId() + "'");

            Map param = new HashMap();
            param.put("codeEtb", jc.getCodeetablissementlib());
            param.put("numero", jc.getNum());
            param.put("daty", jc.getDaty());
            param.put("codePrj", jc.getProjetlib());
            param.put("designation", jc.getDesignation());

            ArrayList<DemandeAchatFille> arrList = new ArrayList<DemandeAchatFille>();
            for (int i = 0; i < tabJournalFille.length; i++) {
                arrList.add(tabJournalFille[i]);
            }

            param.put("list_table", arrList);
            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            setNomJasper("demande-achat");
            UtilitaireImpression.imprimer(request, response, "demande-achat", param, new ArrayList(), getReportPath(), rt);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void fact(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            System.out.println("test2");
            String id = request.getParameter("id");
            FactureClientDetailsGrouper f = new FactureClientDetailsGrouper();
            f.setNomTable("facture_client_fille_gp");
            FactureClientDetailsGrouper[] liste = (FactureClientDetailsGrouper[]) CGenUtil.rechercher(f, null, null, " and idmere='" + id + "'");
            int i = 0;
            List<FactureClientDetailsGrouper> res = new ArrayList<FactureClientDetailsGrouper>();
            while (i < liste.length) {
                res.add(liste[i]);
                i = i + 1;
            }
            Map param = new HashMap();
            param.put("list_table", res);
            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            setNomJasper("fact");
            UtilitaireImpression.imprimer(request, response, "fiche prestation", param, new ArrayList(), getReportPath(), rt);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    private void fichePrestation(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            PrevisionLibComplet prevision = new PrevisionLibComplet();
            prevision.setNomTable("PREVISIONFICHE_II");
            String id = request.getParameter("id");
            PrevisionLibComplet[] liste = (PrevisionLibComplet[]) CGenUtil.rechercher(prevision, null, null, " and id ='" + id + "'");

            OccupationMaterielNaval oprevision = new OccupationMaterielNaval();
            oprevision.setNomTable("OCCUPMATERIELNAVALLIBCOMPLET");
            OccupationMaterielNaval[] ls = (OccupationMaterielNaval[]) CGenUtil.rechercher(oprevision, null, null, " and idprevision ='" + id + "' and etat =11 ");
            System.out.println("ls =" + ls.length);
            Map param = new HashMap();
            if (liste.length != 0) {

                param.put("num", liste[0].getEscale());
                param.put("escale", liste[0].getEscale());
                param.put("navire", liste[0].getNomnavire());
                param.put("valconsignataire", liste[0].getValconsignataire());
                param.put("caboteur", "");
                param.put("bornage", "");
                param.put("amateur", liste[0].getArmateurlib());
                param.put("pavillon", liste[0].getPavillonnavire());
                param.put("portP", liste[0].getValquaisprovenance());
                param.put("portD", liste[0].getValquaisdestination());
                param.put("jaugeN", liste[0].getJntnavire());
                param.put("Lht", liste[0].getLhtnavire());
                param.put("jaugeB", liste[0].getJbtnavire());

                param.put("lht", liste[0].getLmnavire());
                param.put("jaugeN", liste[0].getJntnavire());
                param.put("tiran", liste[0].getTenavire());

                param.put("type", liste[0].getType());
                param.put("dateA", liste[0].getDate_arrivee());
                param.put("heureA", liste[0].getHeure_arrivee());
                param.put("dateD", liste[0].getDate_depart());
                param.put("heureD", liste[0].getHeure_depart());
                param.put("dateJ", utilitaire.Utilitaire.dateDuJour());

            }
            List<OccupationMaterielNaval> res = new ArrayList<>();
            int i = 0;
            while (i < ls.length) {
                res.add(ls[i]);

                i = i + 1;
            }
            param.put("prestation", res);

            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            setNomJasper("fiche_prestation_compet");
            UtilitaireImpression.imprimer(request, response, "fiche prestation", param, new ArrayList(), getReportPath(), rt);

        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.println("test");
    }

    private void ordonnerpayement(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            String id = request.getParameter("id");
            OrdonnerPayementPDF op = new OrdonnerPayementPDF();
            op.setId(id);
            op.setNomTable("ordonnerpayement_pdf");
            OrdonnerPayementPDF[] tabOp = (OrdonnerPayementPDF[]) CGenUtil.rechercher(op, null, null, "  ");
            Map param = new HashMap();
            if (tabOp.length > 0) {
                op = tabOp[0];
                param.put("NUM_OP", op.getNumeroop());
                param.put("DESTINATION", op.getDestinationlib());
                param.put("PAIEMENT", op.getModepaiement());
                param.put("MONTANT", op.getMontant());
                param.put("MONTANT_LETTRE", op.getMontant_lettre());
                param.put("BENEFICIAIRE", op.getBeneficiaire());
                param.put("ADRESSE", op.getAdresse());
                param.put("MOTIF", op.getRemarque());
                param.put("FACTURE", op.getNumfact());
                param.put("DEVISE", op.getDevise());
            }
            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            setNomJasper("ORDRE_PAYER - Copie");
            UtilitaireImpression.imprimer(request, response, "ORDRE_PAYER", param, new ArrayList(), getReportPath(), rt);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void boncommande(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            String id = request.getParameter("id");
            BonDeCommande bc = new BonDeCommande();
            bc.setId(id);
            bc.setNomTable("AS_BONDECOMMANDE_LIBELLE_TIERS");
            BonDeCommande[] tabBc = (BonDeCommande[]) CGenUtil.rechercher(bc, null, null, " ");
            Map param = new HashMap();
            if (tabBc.length > 0) {
                bc = tabBc[0];
                param.put("DATY", bc.getDaty());
                param.put("NOMFOURNISSEUR", bc.getNomfournisseur());
                param.put("ADRESSE", bc.getAdresse());
                param.put("REMARQUE", bc.getRemarque());
                param.put("CODE_ETAB", bc.getCode_etab());
                param.put("DELAI", bc.getDelaipaiement());
                param.put("TOTAL_HT", bc.getMontant());
                //param.put("REMISE",bc.getRemise());
                param.put("TOTAL_TVA", bc.getMontanttva());
                param.put("TOTAL_TTC", bc.getMontantTTC());

                param.put("MODE_PAIEMENT", bc.getModepaiement());
                param.put("LB", bc.getProjet());
                param.put("REF", bc.getNumbc());
                param.put("TYPE_PAIEMENT", bc.getTypepaiement());

                param.put("DELAILIVRAISON", bc.getDelailivraison());

                String montantString = String.valueOf((int) bc.getMontantTTC());
                long montantLong = Long.valueOf(montantString);
                param.put("TOTAL_TTC_LETTRE", (ChiffreLettre.convertIntToString(montantLong)).toUpperCase() + " ARIARY ");
            }

            BonDeCommandeFille f = new BonDeCommandeFille();
            f.setNomTable("AS_BONDECOMMANDE_FILLE_LIB");
            BonDeCommandeFille[] liste = (BonDeCommandeFille[]) CGenUtil.rechercher(f, null, null, " and IDBC = '" + id + "'");

            List dataSources = new ArrayList();
            int i = 0;
            double totalremise = 0;
            while (i < liste.length) {
                totalremise = totalremise + liste[i].getMontantremise();
                i = i + 1;
            }
            param.put("REMISE", totalremise);
            for (BonDeCommandeFille fille : liste) {
                dataSources.add(fille);
            }

            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            setNomJasper("bon_de_commande");
            UtilitaireImpression.imprimer(request, response, "bon_de_commande", param, dataSources, getReportPath(), rt);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void imprimerBed(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            String id = request.getParameter("id");
            BonEngagementPDF be = new BonEngagementPDF();
            be.setId(id);
            BonEngagementPDF[] tabBe = (BonEngagementPDF[]) CGenUtil.rechercher(be, null, null, " ");
            Map param = new HashMap();
            if (tabBe.length > 0) {
                param.put("id", tabBe[0].getNumeroop());
                param.put("tiers", tabBe[0].getTiers());
            }

            List dataSources = new ArrayList();
            dataSources.addAll(Arrays.asList(tabBe));

            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            setNomJasper("suivi-budgetaire");
            UtilitaireImpression.imprimer(request, response, "suivi-budgetaire", param, dataSources, getReportPath(), rt);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void recapitulatifCompteCourant(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            String daty2 = request.getParameter("daty2");
            String daty1 = request.getParameter("daty1");
            String ingredient = null;
            String colonne = null;
            String ordre = null;

            if (request.getParameter("ingredient").equalsIgnoreCase("null") == false) {
                ingredient = request.getParameter("ingredient");
            }
            if (request.getParameter("colonne").equalsIgnoreCase("null") == false) {
                colonne = request.getParameter("colonne");
            }
            if (request.getParameter("ordre").equalsIgnoreCase("null") == false) {
                ordre = request.getParameter("ordre");
            }

            SituationComptesData datas = new SituationComptesData(daty2, daty1, ingredient, colonne, ordre);
            EtatdeStockDate[] recapitulatifComptes = datas.getRecapitulatifComptes();
            EtatdeStockDate[] recapitulatifPlacement = datas.getRecapitulatifPlacement();
            double totalTresorerie = datas.getTotalTresorerie();
            double totalPlacement = datas.getTotalPlacement();
            double total = totalPlacement + totalTresorerie;

            ClassMAPTable[] caisseAr = datas.getCaisseAr();

            ArrayList tabCaisse = new ArrayList();
            for (ClassMAPTable c : caisseAr) {
                tabCaisse.add((EtatdeStockDate) c);
            }
            ClassMAPTable[] banqueDevise = datas.getBanqueDevise();
            ArrayList tabBanqueDevise = new ArrayList();
            for (ClassMAPTable b : banqueDevise) {
                tabBanqueDevise.add((EtatdeStockDate) b);
            }
            EtatdeStockDate[] placementAr = datas.getPlacementAr();
            EtatdeStockDate[] placementDevise = datas.getPlacementDevise();

            Map param = new HashMap();
            param.put("total", total);

            List dataSources = new ArrayList();
            RecapitulatifComptesSubReport sub = new RecapitulatifComptesSubReport(Arrays.asList(recapitulatifComptes), Arrays.asList(recapitulatifPlacement), tabCaisse, tabBanqueDevise, Arrays.asList(placementAr), Arrays.asList(placementDevise));
            dataSources.add(sub);

            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            setNomJasper("recapitulatifCompteCourant");
            UtilitaireImpression.imprimer(request, response, "recapitulatifCompteCourant", param, dataSources, getReportPath(), rt);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void imprimerBed2(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            String id = request.getParameter("id");
//            BonEngagementPDF be = new BonEngagementPDF();
//            be.setNomTable("BED_PDF_II");
//            be.setId(id);
//            BonEngagementPDF[] tabBe = (BonEngagementPDF[]) CGenUtil.rechercher( be , null, null, " ") ;
//            Map param = new HashMap();
//            if(tabBe.length > 0){
//                param.put("id",tabBe[0].getNumeroop());
//                param.put("tiers",tabBe[0].getPrestataire());
//                param.put("code_etab",tabBe[0].getCode_etablissement());
//                param.put("projet",tabBe[0].getProjet());
//            }
//            
//            List dataSources = new ArrayList();
//            dataSources.addAll(Arrays.asList(tabBe));
//            
//            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
//            setNomJasper("bed");
//            UtilitaireImpression.imprimer(request, response, "bed", param, dataSources, getReportPath(), rt);

            BordereauLibComplet res = new BordereauLibComplet();
            res.setNomTable("bordereauFF_libcomplet");
            BordereauLibComplet[] blc = (BordereauLibComplet[]) CGenUtil.rechercher(res, null, null, String.format(" and id = '%s'", id));
            if (blc.length > 0) {
                res = blc[0];
            }
            //res = (BordereauLibComplet)res.getById(id, null, null); 
            if (res != null) {
                Map param = new HashMap();
                param.put("numero", res.getNumero());
                BordereauFilleLibComplet fille = new BordereauFilleLibComplet();
                fille.setIdbordereau(id);
                fille.setNomTable("liaisonbordereauFF_libcomplet");
                BordereauFilleLibComplet[] liste = (BordereauFilleLibComplet[]) CGenUtil.rechercher(fille, null, null, "");
                EtatFactureMontantDaty[] etatfmd = (EtatFactureMontantDaty[]) CGenUtil.rechercher(new EtatFactureMontantDaty(), "select * from factfourn_msum_lib where id in (select idop from liaisonbordereauFF where idbordereau = '" + id + "')");

                if (etatfmd.length > 0) {
                    facture.FactureFournisseur factf = new facture.FactureFournisseur();
                    //factf.setId(etatfmd[0].getId());
                    //factf = (facture.FactureFournisseur)factf.getById(factf.getId(), null, null);
                    facture.FactureFournisseur[] ff = (facture.FactureFournisseur[]) CGenUtil.rechercher(factf, null, null, String.format(" and id = '%s'", etatfmd[0].getId()));
                    if (ff.length > 0) {
                        factf = ff[0];

                        CodeEtablissement ce = new CodeEtablissement();
                        ce.setNomTable("codeetablissement_libcomplet");
                        //ce.setId(factf.getCode_etablissement());
                        //ce = (CodeEtablissement)ce.getById(ce.getId(), null, null);
                        CodeEtablissement[] cde = (CodeEtablissement[]) CGenUtil.rechercher(ce, null, null, String.format(" and id = '%s'", factf.getCode_etablissement()));
                        if (cde.length > 0) {
                            ce = cde[0];

                            param.put("code_etab", ce.getVal());
                            param.put("direction", ce.getDescelib());
                            param.put("departement", ce.getDepartementlib());
                            param.put("service", ce.getServicelib());

                        }

                        Projet prj = new Projet();
                        prj.setNomTable("projet");
                        //prj.setId(factf.getProjet());
                        //prj = (Projet)prj.getById(prj.getId(), null, null);
                        Projet[] pr = (Projet[]) CGenUtil.rechercher(prj, null, null, String.format(" and id = '%s'", factf.getProjet()));
                        if (pr.length > 0) {
                            prj = pr[0];
                            param.put("projet", prj.getDesignation());
                        }
                    }

                }

                param.put("date", res.getDaty());
                param.put("tiers", res.getTierslib());

                List dataSources = new ArrayList();
                dataSources.addAll(Arrays.asList(etatfmd));

                ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
                setNomJasper("bed");
                UtilitaireImpression.imprimer(request, response, "bed", param, dataSources, getReportPath(), rt);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void pieceDeCaiseDepense(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {

            String idop = request.getParameter("idop");
            OrdonnerPayementPDF op = new OrdonnerPayementPDF();
            op.setNomTable("OrdonnerPayement_LIB");
            op.setId(idop);
            OrdonnerPayementPDF[] tabOp = (OrdonnerPayementPDF[]) CGenUtil.rechercher(op, null, null, "  ");
            Map param = new HashMap();
            JournalCaisse jc = new JournalCaisse();
            jc.setId(request.getParameter("id"));
            jc.setNomTable("JOURNALCAISSELIBCOMPLET");
            JournalCaisse[] tabJournal = (JournalCaisse[]) CGenUtil.rechercher(jc, null, null, " ");
            param.put("facture_lib", tabJournal[0].getLibelle());

            if (tabOp.length > 0) {
                tabOp[0].setDevise(" ARIARY");

                param.put("daty", Utilitaire.dateDuJourSql());
                param.put("montant", tabOp[0].getMontant());
                param.put("montant_lettre", tabOp[0].getMontant_lettre());

                EtatFactureDepService a = new EtatFactureDepService();
                a.setNomTable("ETATFACTUREMONTANTDATY_LIB");
                a.setId(tabOp[0].getDed_Id());
                EtatFactureDepService[] tabFact = (EtatFactureDepService[]) CGenUtil.rechercher(a, null, null, "  ");
                if (tabFact.length > 0) {
                    //param.put("facture_lib",tabFact[0].getDesignation());

                    param.put("direction", tabFact[0].getDirection());
                    param.put("departement", tabFact[0].getDepartement());
                    param.put("service", tabFact[0].getService());
                    param.put("tiers", tabFact[0].getTierslib());
                }
                LiaisonIntraTable liaison = new LiaisonIntraTable();
                liaison.setNomTable("LIAISONINTRATABLE");
                LiaisonIntraTable[] tabLiaison = (LiaisonIntraTable[]) CGenUtil.rechercher(liaison, null, null, " and id2 = '" + idop + "'");
                if (tabLiaison.length > 0) {
                    param.put("facture_montant", tabLiaison[0].getMontant());
                }
            } else {

                if (tabJournal.length > 0) {
                    param.put("daty", tabJournal[0].getDateEffet());
                    param.put("montant", tabJournal[0].getDebit());
                    String montantString = String.valueOf((long) tabJournal[0].getDebit());
                    long montantLong = Long.valueOf(montantString);
                    param.put("montant_lettre", (ChiffreLettre.convertIntToString(montantLong) + " ARIARY ").toUpperCase());

                    param.put("facture_montant", tabJournal[0].getDebit());
                    param.put("tiers", tabJournal[0].getTiersLib());
                }

            }
            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            setNomJasper("piece_de_caisse_depenses");
            UtilitaireImpression.imprimer(request, response, "piece_de_caisse_depenses", param, new ArrayList(), getReportPath(), rt);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void pieceDeCaiseRecette(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            JournalCaisse jc = new JournalCaisse();
            jc.setId(request.getParameter("id"));
            jc.setNomTable("JOURNALCAISSELIBCOMPLET");
            JournalCaisse[] tabJournal = (JournalCaisse[]) CGenUtil.rechercher(jc, null, null, " order by NUMPIECE ASC  ");

            PayementFacture[] tabFact = null;
            String idFacture = request.getParameter("idFacture");
            if (tabJournal.length > 0) {
//                requete = "select * from factureclientmsum_lib where id in ('"+tabJournal[0].getIdplacement().replace(";", "','")+"')";
                tabFact = jc.getPayementFactureTous(null);
            }
            Map param = new HashMap();
            param.put("datyJ", Utilitaire.dateDuJourSql());
            ArrayList<PayementFacture> arrList = new ArrayList<PayementFacture>();
            double montantFacture = 0;
            double arrondi = 0;
            double totalGeneral = 0;
            for (int i = 0; i < tabFact.length; i++) {
                montantFacture = montantFacture + tabFact[i].getMontant();
                arrList.add(tabFact[i]);
            }
            //tabJournal[0].arrondir();
            arrondi = tabJournal[0].getCredit() - montantFacture;
            totalGeneral = tabJournal[0].getCredit();
            param.put("montant", montantFacture);
            param.put("arrondi", arrondi);
            param.put("total", totalGeneral);

            String montantString = String.valueOf((long) totalGeneral);
            long montantLong = Long.valueOf(montantString);

            param.put("montantLettre", ChiffreLettre.convertIntToString(montantLong) + " Ariary ");

            param.put("list_table", arrList);
            /*if(tabFact.length > 0){
                param.put("nmFact",tabFact[0].getCode());
                param.put("montant",tabFact[0].getMontantttcvrai());
                param.put("datyFact",tabFact[0].getDaty());
                
                String montantString = String.valueOf((long)tabFact[0].getMontantttcvrai());
                long montantLong = Long.valueOf(montantString);

                param.put("montantLettre",ChiffreLettre.convertIntToString(montantLong)+" Ariary ");

            }
            else{
                if(tabJournal.length > 0){
                    param.put("montant",tabJournal[0].getDebit());
                    param.put("datyFact",tabJournal[0].getDateEffet());
                    String montantString = String.valueOf((long)tabJournal[0].getDebit());
                    long montantLong = Long.valueOf(montantString);
                    param.put("montantLettre",ChiffreLettre.convertIntToString(montantLong)+" Ariary ");
                }
            }*/
            if (tabJournal.length > 0) {
                param.put("numPiece", tabJournal[0].getNumPiece());
                param.put("client", tabJournal[0].getTiersLib());
                param.put("operation", tabJournal[0].getLibelle());
                param.put("datyPiece", tabJournal[0].getDateEffet());
            }
            String nomJasper = "piece_de_caisse";
            if (tabJournal[0].getIdmode().equalsIgnoreCase("pay1") == false) {

                nomJasper = "piece_de_caisse_banque";
                param.put("banque", tabJournal[0].getIdbanquelib());
                param.put("numCheque", tabJournal[0].getNumcheque());
            }
            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            setNomJasper(nomJasper);
            UtilitaireImpression.imprimer(request, response, "piece_de_caisse", param, new ArrayList(), getReportPath(), rt);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void imprimerBon(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            String id = request.getParameter("id");
            BonProvisoireComplet bon = new BonProvisoireComplet();
            bon.setId(id);

            BonProvisoireComplet[] tab = (BonProvisoireComplet[]) CGenUtil.rechercher(bon, null, null, "  ");
            Map param = new HashMap();
            if (tab.length > 0) {
                param.put("MONTANT", tab[0].getDebit());
                param.put("NUM", tab[0].getNumpiece());
                param.put("DATE", tab[0].getDateeffet());
                param.put("DEMANDEUR", tab[0].getBeneficiairelib());

                String montantString = String.valueOf((long) tab[0].getDebit());
                long montantLong = Long.valueOf(montantString);
                param.put("MONTANT_LETTRE", ChiffreLettre.convertIntToString(montantLong) + " Ariary ");
                param.put("MOTIF", tab[0].getRemarque());
                param.put("DESIGNATION", tab[0].getLibelle());
            }

            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            setNomJasper("bon_provisoire");
            UtilitaireImpression.imprimer(request, response, "bon_provisoire", param, new ArrayList(), getReportPath(), rt);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void fiche_facture(HttpServletRequest request, HttpServletResponse response) throws Exception {
        List dataSource = new ArrayList();
        String id = request.getParameter("id");
        System.out.println(id);
        FactureClientReport pay = null;
        Connection c = null;
        HashMap param = new HashMap();
        this.setNomJasper("facture_client");
        try {
            c = new UtilDB().GetConn();
            pay = FactureService.imprimerFacture(id, c);
            dataSource.add(pay);
            //param.put("MONTANTTOTAL", pay);
            String montantlettre = ChiffreLettre.convertRealToString(pay.getMontantTotal()) + " Ariary ";
            param.put("montantlettre", montantlettre);
            UtilitaireImpression.imprimer(request, response, "Facture_client" + id, param, dataSource, getReportPath(), ReportingUtils.ReportType.PDF);
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    private void journalCaisseDepense(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            String caisse = request.getParameter("caisse");
            String datyString = request.getParameter("daty");
            Date daty = Utilitaire.dateDuJourSql();
            if (datyString != null && datyString.compareTo("") != 0) {
                daty = Utilitaire.stringDate(datyString);
            }
            EtatCaisse ec = new EtatCaisse(caisse, daty);
            EtatCaisseService ecS = new EtatCaisseService();
            ecS.genererEtatCaisseData(ec);
            Caisse[] caisses = ecS.getCaisses();
            JournalCaisse debits = new JournalCaisse();
            debits.setLibelle("Recette de la caisse SPAT Journee du " + datyString);
            debits.setDebit(ecS.getRecette(caisse, daty, null));

            JournalCaisse[] credits = ec.getDebits();
            PlacementLibComplet[] placement = ec.getListePlacement();

            Map param = new HashMap();
            if (ec != null) {
                param.put("FOLIO", ec.getFolio());
                param.put("DATY", ec.getDaty());
                param.put("SoldeAnterieur", ec.getSoldeAnterieur());
                param.put("SoldeActuel", ec.getSoldeActuel());
            }
            JournalCaisseSubReport journalCaisseSub = new JournalCaisseSubReport(debits, credits);
            List dataSources = new ArrayList();
            dataSources.add(journalCaisseSub);
            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            setNomJasper("journal-caisse-depense");
            UtilitaireImpression.imprimer(request, response, "journal-caisse-depense", param, dataSources, getReportPath(), rt);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void imprimerFacture(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            Map param = new HashMap();
            String id = request.getParameter("id");
            FactureProforma e = new FactureProforma();
            e.setNomTable("factureprofMSum_lib");
            FactureProforma[] mere = (FactureProforma[]) CGenUtil.rechercher(e, null, null, null, " and id = '" + id + "'");
            param.put("daty", Utilitaire.formatterDatySql(mere[0].getDaty()));
            param.put("id", mere[0].getId());
            param.put("client", mere[0].getTierslib());
            param.put("adresse", mere[0].getAdresse());
            param.put("phone", mere[0].getContact());
            param.put("montant", mere[0].getMontant());
            param.put("montantTVA", mere[0].getMontanttva());
            param.put("montantTTC", mere[0].getMontantttc());
            param.put("tva", mere[0].getTva());
            String montantlettre = ChiffreLettre.convertRealToString(new Double(mere[0].getMontantttc())) + " Ariary ";
            param.put("montantlettre", montantlettre);

            FactureProformaDetails cht = new FactureProformaDetails();
            cht.setNomTable("FACTURE_CLIENT_PROFMONTANT");
            FactureProformaDetails[] details = (FactureProformaDetails[]) CGenUtil.rechercher(cht, null, null, null, " and idmere = '" + id + "'");
            ArrayList<FactureProformaDetails> arrList = new ArrayList<FactureProformaDetails>();
            for (int i = 0; i < details.length; i++) {
                arrList.add(details[i]);
            }
            //mere[0].setListeDetails(arrList);

            List dataSources = new ArrayList();
            //dataSources.addAll(mere[0].getListeDetails());

            param.put("list_table", dataSources);

            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            setNomJasper("facture_client2");
            UtilitaireImpression.imprimer(request, response, "facture-proforma", param, dataSources, getReportPath(), rt);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void imprimerFactureClient(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Connection c = null;
        try {
            c = (new UtilDB()).GetConn();
            Map param = new HashMap();
            List dataSource = null;
            String id = request.getParameter("id");
            FactureClient facture = new FactureClient();
            facture.setEstDDPMICTSL(null);
            facture.setNomTable("factureClient");
            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            int separer_convention = 1;

            FactureClient[] mere = (FactureClient[]) CGenUtil.rechercher(facture, null, null, c, " and id = '" + id + "' order by daty");
            String code = mere[0].getCode();
            facture.setNomTable("factureClientValide");
            mere = (FactureClient[]) CGenUtil.rechercher(facture, null, null, c, " and id = '" + id + "'");
            param.put("pourcomptelib", mere[0].getPourCompteLib());
            facture = mere[0];
            facture.setId(id);
            facture.initDetails(c);
            double hTEuro = facture.getMontantHTEuro();
            double tvaEuro = facture.getMontantTVAEuro();
            double ttcEuro = hTEuro + tvaEuro;
            double hTDollar = facture.getMontantHTVADollar();
            double tvaDollar = facture.getMontantTVADollar();
            double ttcDollar = facture.getMontantTTCDollar();
            double deviseEuro = facture.getDeviseEuro();
            double deviseDollar = facture.getDeviseDollar();
            String cat = facture.getCategorielib();
            String designation = facture.getDesignation();
            if (mere.length != 0) {
                mg.spat.PrevisionLibComplet p = new mg.spat.PrevisionLibComplet();
                p.setNomTable("PREVISIONLIBCOMPLETPDF");
                mg.spat.PrevisionLibComplet[] pre = (mg.spat.PrevisionLibComplet[]) CGenUtil.rechercher(p, null, null, c, " and id = '" + mere[0].getIdprevision() + "'");
                int convention = 0;
                FactureClientDetails cht = new FactureClientDetails();
                cht.setNomTable("FACT_CLT_FILL_LIB_REST_TAXE");

                FactureClientDetails[] details = (FactureClientDetails[]) CGenUtil.rechercher(cht, null, null, c, " and idmere = '" + id + "'  order by rang, daty asc");
                ArrayList<FactureClientDetails> arrList = new ArrayList<FactureClientDetails>();

                param.put("responsable", "Pr&eacute;par&eacute; Par");
                param.put("chef", "Le Responsable Facturation");
                if (mere[0].getEstMictsl() != null && mere[0].getEstMictsl().compareToIgnoreCase("1") == 0) {

                    param.put("chef", "Le chef de D&eacute;partement");
                    param.put("responsable", "Le contr&ocirc;leur");
                }

                if (pre.length != 0) {

                    param.put("navire", pre[0].getNomnavire());
                    // param.put("escale",pre[0].getEscale());
                    param.put("date_arrivee", pre[0].getDate_arrivee());
                    //param.put("pavillon",pre[0].getPavillon);
                    param.put("date_depart", pre[0].getDate_depart());
                    param.put("destination", pre[0].getValquaisdestination());
                    param.put("lhtnavire", pre[0].getLhtnavire());
                    param.put("jntnavire", pre[0].getJntnavire());
                    param.put("lmnavire", pre[0].getLmnavire());
                    param.put("provenance", pre[0].getValquaisprovenance());
                    param.put("escale", pre[0].getEscale());
                    param.put("pavillonlib", pre[0].getPavillonlib());
                    param.put("heure_depart", pre[0].getHeure_depart());
                    param.put("heure_arrivee", pre[0].getHeure_arrivee());
                    param.put("armateur", pre[0].getArmateurlib());
                    param.put("tenavire", pre[0].getTenavire());

                    setNomJasper("facture_client2 - Copie");//facture_client2 - Copie //facture_convention //facture-client-sans-prevision
                } else if (mere[0].getEstMictsl().compareToIgnoreCase("1") == 0) {
                    setNomJasper("facture-Mictsl");
                } else {
                    setNomJasper("facture-client-sans-prevision");
                    if (mere[0].getCode().contains("09A")) {
                        separer_convention = 0;
                    }
                    /*if (mere[0].getCode().contains("09")) {
                        if (mere[0].getCode().charAt(5) == '0' && mere[0].getCode().charAt(6) == '9') {
                            int i=0;    
                            while(i<details.length){
                                if(details[i].getDesignation().toLowerCase().contains("redevance commun")){
                                    setNomJasper("facture_convention");
                                    break;
                                }
                                i=+1;
                            }
                            
                        };
                    } */
                    //setNomJasper("facture-client-sans-prevision");
                }

                param.put("daty", mere[0].getDaty());
                param.put("id", mere[0].getId());
                param.put("type", mere[0].getTypelib());
                cat = mere[0].getCategorielib();
                param.put("cat", cat);
                designation = mere[0].getDesignation();
                param.put("designation", designation);
                param.put("reduction", mere[0].getReduction());
                param.put("client", mere[0].getTierslib());
                param.put("adresse", mere[0].getAdresse());
                param.put("phone", mere[0].getContact());
                param.put("montant", mere[0].getMontant());
                param.put("montantTVA", mere[0].getMontanttva());
                param.put("montantTTC", mere[0].getMontantttc());
                param.put("montantAvoir", mere[0].getMontantavoir());

                param.put("tva", mere[0].getTva());

                if (mere[0].getTypelib() != null) {
                    if (mere[0].getTypelib().compareToIgnoreCase("au comptant") != 0) {
                        param.put("dateEcheanceLib", "Date limite de paiement :");
                        param.put("dateEcheance", Utilitaire.formatterDatySql(mere[0].getDate_echeance()));
                    }
                }

                param.put("deviseMere", mere[0].getDeviseMere());
                param.put("code", code);

                String montantlettre = ChiffreLettre.convertRealToString(new Double(mere[0].getMontantttc()), " Ariary");

                if (mere[0].getDeviseMere() != null) {
                    if (mere[0].getDeviseMere().compareToIgnoreCase(Constante.deviseDollars) == 0) {
                        montantlettre = ChiffreLettre.convertRealToString(new Double(ttcDollar), " Dollars");
                    }
                    if (mere[0].getDeviseMere().compareToIgnoreCase(Constante.deviseAr) == 0) {
                        montantlettre = ChiffreLettre.convertRealToString(new Double(mere[0].getMontantttc()), " Ariary");
                    }
                    if (mere[0].getDeviseMere().compareToIgnoreCase(Constante.deviseEuro) == 0) {
                        montantlettre = ChiffreLettre.convertRealToString(new Double(ttcEuro), " Euros");
                    }

                }

                param.put("montantlettre", montantlettre);
                param.put("htdollar", hTDollar);
                param.put("dollartva", tvaDollar);
                param.put("dollarttc", ttcDollar);
                param.put("hteuro", hTEuro);
                param.put("tvaeuro", tvaEuro);
                param.put("ttcEuro", ttcEuro);
                param.put("valeuro", deviseEuro);

                param.put("valdollar", deviseDollar);
                param.put("cat", cat);

                if ((designation.length() > 66) && (pre.length != 0)) {
                    param.put("designation", designation.substring(0, 66));
                    param.put("designation+", designation.substring(66, designation.length()));
                } else {
                    param.put("designation", designation);
                }

                /**
                 * *********************************************************************************************
                 */
                /*facture.setId(details[0].getIdmere());
                //facture.setListeDetails(details);
                facture.initDetails(null);*/
                details = facture.getListeDetails();
                double total = 0;
                double reduction = 0;
                for (int i = 0; i < details.length; i++) {
                    //details[i].setMontantHTEuro( details[i].getQuantite()*details[i].getPu());
                    total = total + details[i].getMontantHTEuro();
                    details[i].setMontantTTC(details[i].getMontanttaux() + details[i].getMontantTva());
                    String heuredebut = "";
                    String heurefin = "";
                    if (details[i].getHeureDebut() != null && details[i].getHeureDebut().length() == 8) {// manala anle seconde any amn farany
                        //details[i].getHeureDebut().
                        int len = 0;
                        while (len < 5) {
                            heuredebut += details[i].getHeureDebut().charAt(len);
                            len = len + 1;
                        }
                        details[i].setHeureDebut(heuredebut);

                    }
                    if (details[i].getHeureFin() != null && details[i].getHeureFin().length() == 8) {// manala anle seconde any amn farany
                        //details[i].getHeureDebut().
                        int len = 0;
                        while (len < 5) {
                            heurefin += details[i].getHeureFin().charAt(len);
                            len = len + 1;
                        }
                        details[i].setHeureFin(heurefin);

                    }
                    arrList.add(details[i]);
                    reduction += details[i].getReduction();

                    //total=
                }

                //mere[0].setArrayDetails(arrList);
                //List<FactureClientDetails> res = new ArrayList<FactureClientDetails>();
                /*List dataSources = new ArrayList();
            dataSources.addAll(mere[0].getArrayDetails());*/
                param.put("total", total);
                param.put("montantsns", hTEuro);
                param.put("reduction", reduction);
                param.put("list_table", arrList);

                if (getNomJasper().compareTo("facture-client-sans-prevision") == 0) {
                    List<FactureClientDetailsPDF> detailsPDF = new ArrayList<FactureClientDetailsPDF>();
                    FactureClientDetailsPDF details1 = new FactureClientDetailsPDF();
                    FactureClientDetailsPDF details2 = new FactureClientDetailsPDF();
                    details1.setDetails(new ArrayList<FactureClientDetails>());
                    details2.setDetails(new ArrayList<FactureClientDetails>());
                    int conventionExist = 1;
                    for (int k = 0; k < arrList.size(); k++) {
                        if ((separer_convention == 0) && (arrList.get(k).getRubrique() != null) && (arrList.get(k).getRubrique().compareTo("RB0000000144093258") == 0 || arrList.get(k).getRubrique().compareTo("RB0000000143093146") == 0 || arrList.get(k).getRubrique().compareTo("RB0000000060112257") == 0 || arrList.get(k).getRubrique().compareTo("RB0000000066111845") == 0)) {
                            conventionExist = 0;
                            details2.getDetails().add(arrList.get(k));
                            details2.setTotal(details2.getTotal() + arrList.get(k).getMontantHTEuro());
                            details2.setMontantdevise(details2.getMontantdevise() + arrList.get(k).getMontanttaux());
                            details2.setMontantTVAdevise(details2.getMontantTVAdevise() + arrList.get(k).getTva());
                            details2.setMontantTTCdevise(details2.getMontantdevise() + details2.getMontantTVAdevise());
                        } else {
                            details1.getDetails().add(arrList.get(k));
                            details1.setTotal(details1.getTotal() + arrList.get(k).getMontantHTEuro());
                            details1.setMontantdevise(details1.getMontantdevise() + arrList.get(k).getMontanttaux());
                            details1.setMontantTVAdevise(details1.getMontantTVAdevise() + arrList.get(k).getTva());
                            details1.setMontantTTCdevise(details1.getMontantdevise() + details1.getMontantTVAdevise());
                        }
                    }
                    
                    double montantDevise=mere[0].getMontant(), montantTVADevise=mere[0].getMontanttva(), montantTTCDevise=mere[0].getMontantttc();
                    String codeFacture = mere[0].getCode();
                    
                    if (mere[0].getDeviseMere() != null) {
                        if (mere[0].getDeviseMere().equalsIgnoreCase(Constante.deviseAr)) {
                            if (codeFacture.contains("09A") || codeFacture.contains("01A")) {
                                montantDevise = hTEuro;
                                montantTVADevise = tvaEuro;
                                montantTTCDevise = ttcEuro;
                            }
                        }
                        if (mere[0].getDeviseMere().equalsIgnoreCase(Constante.deviseDollars)) {
                            if (codeFacture.contains("01A") || codeFacture.contains("08A")) {
                                montantDevise = hTDollar;
                                montantTVADevise = tvaDollar;
                                montantTTCDevise = ttcDollar;
                            }
                        }
                        
                        details1.setMontantdevise(montantDevise);
                        details1.setMontantTVAdevise(montantTVADevise);
                        details1.setMontantTTCdevise(montantTTCDevise);
                    }

                    detailsPDF.add(details1);
                    if (conventionExist == 0) {
                        detailsPDF.add(details2);
                    }

                    FactureClientDetailsPDFMere fiche = new FactureClientDetailsPDFMere();
                    fiche.setList_table(detailsPDF);

                    List<FactureClientDetailsPDFMere> ficheMultiple = new ArrayList<FactureClientDetailsPDFMere>();
                    ficheMultiple.add(fiche);
                    dataSource = new ArrayList(ficheMultiple);
                }

            }
            //ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            //setNomJasper("facture_client2 - Copie");
            UtilitaireImpression.imprimer(request, response, "facture-client", param, dataSource, getReportPath(), rt);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    /**
     * *****************************************************************************************************************************************************************************************
     */
    private void imprimerAvoir(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            Map param = new HashMap();
            String id = request.getParameter("id");
            AvoirFC facture = new AvoirFC();
            facture.setNomTable("avoirFC_montant");
            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;

            AvoirFC[] mere = (AvoirFC[]) CGenUtil.rechercher(facture, null, null, null, " and id = '" + id + "'");

            TypeObjet cat = mere[0].getCategorie(null);
            if (cat != null && cat.getVal().compareTo("-") != 0) {
                param.put("categorie", cat.getVal());
            } else {
                param.put("categorie", "");
            }
            param.put("daty", utilitaire.Utilitaire.dateDuJourSql());
            param.put("code", mere[0].getCode());
            param.put("designationAvoir", mere[0].getDesignation());
            param.put("designation", mere[0].getMotiflib());
            param.put("typeavoir", mere[0].getTypelib());

            FactureClient fc = mere[0].getFactureLiee(null, null);
            fc.initDetails(null);
            String daty = "2021-03-05";
            double deviseEuro = fc.getDeviseEuro();
            double deviseDollar = fc.getDeviseDollar();
            param.put("codefact", fc.getCode());

            FactureClient fcavoir = new FactureClient();
            fcavoir.setNomTable("facture_client_union");
            String awhere = String.format(" and idavoir = '%s' ", id);
            FactureClient[] result = (FactureClient[]) CGenUtil.rechercher(fcavoir, null, null, null, awhere);
            if (result.length != 0) {
                param.put("codefact1", result[0].getCode());
            }

            //param.put("pdaty", daty);
            param.put("pdaty", fc.getDaty());
            param.put("client", fc.getTierslib());
            param.put("codeClient", fc.getTiers());
            param.put("adresse", fc.getAdresse());
            param.put("type", fc.getTypelib());
            param.put("deviseMere", fc.getDeviseMere());
            param.put("valeuro", deviseEuro);
            param.put("valdollar", deviseDollar);

            AvoirFCFille[] avoirFille = mere[0].getAvoirFilles(null, null);
            FactureClientDetails[] details = new FactureClientDetails[avoirFille.length];
            for (int i = 0; i < avoirFille.length; i++) {
                details[i] = avoirFille[i].getFactureClientDetail(null);
                details[i].setMontant(avoirFille[i].getMontant());
                details[i].setId(avoirFille[i].getId());
            }
            fc.setListeDetails(details);
            fc.initDetails(null);

            double montanttotal = 0;
            List<FactureClientDetails> arrList = new ArrayList<FactureClientDetails>();
            for (int i = 0; i < details.length; i++) {
                montanttotal = montanttotal + details[i].getMontantHTEuro();
                arrList.add(details[i]);
            }

            param.put("montant", mere[0].getMontant());
            param.put("montantTVA", 0);
            param.put("montantTTC", mere[0].getMontant());
            param.put("total", montanttotal);

            String montantlettre = ChiffreLettre.convertRealToString(new Double(mere[0].getMontant())) + " Ariary ";

            if (fc.getDeviseMere() != null) {
                if (fc.getDeviseMere().compareToIgnoreCase("Dollars") == 0) {
                    double montantDollar = mere[0].getMontant() / deviseDollar;
                    montantlettre = ChiffreLettre.convertRealToString(new Double(montantDollar)) + " Dollars ";
                }
            }

            param.put("montantlettre", montantlettre);
            param.put("list_table", arrList);
            setNomJasper("facture-client-avoir");
            //ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            //setNomJasper("facture_client2 - Copie");
            UtilitaireImpression.imprimer(request, response, "facture-clien-avoirt", param, null, getReportPath(), rt);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void imprimerEtatProvision(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            Map param = new HashMap();
            String id = request.getParameter("id");
            EtatProvision a = new EtatProvision();
            a.setNomTable("etat_provisionlib");
            param.put("daty", utilitaire.Utilitaire.dateDuJourSql());
            EtatProvision[] mere = (EtatProvision[]) CGenUtil.rechercher(a, null, null, null, " and id = '" + id + "'");
            String idfc = "";
            if (mere.length != 0) {
                param.put("numprovision", mere[0].getNumProvision());
                param.put("tierslib", mere[0].getTierslib());
                param.put("idnavirelib", mere[0].getIdnavirelib());
                param.put("idmodelib", mere[0].getIdmodelib());
                param.put("idbanquelib", mere[0].getIdbanquelib());
                param.put("numpiece", mere[0].getNumpiece());
                param.put("operation", mere[0].getOperation());
                idfc = mere[0].getIdFacture();
            }

            FactureClient fc = new FactureClient();
            fc.setNomTable("facture_client_union");
            FactureClient[] fclt = (FactureClient[]) CGenUtil.rechercher(fc, null, null, null, " and id = '" + idfc + "'");
            if (fclt.length != 0) {
                param.put("montantttc", fclt[0].getMontantttc());
                param.put("code", fclt[0].getCode());
            }

            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            setNomJasper("EtatProvision");
            //ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            //setNomJasper("facture_client2 - Copie");
            UtilitaireImpression.imprimer(request, response, "etat-provision", param, null, getReportPath(), rt);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void imprimerFactureFournisseur(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Connection c = null;
        try {
            c = (new UtilDB()).GetConn();
            Map param = new HashMap();
            String id = request.getParameter("id");
            facture.FactureFournisseur facture = new facture.FactureFournisseur();
            facture.setEstDDPMICTSL(null);
            facture.setNomTable("FACTFOURN_MSUM_LIB");
            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;

            facture.FactureFournisseur[] mere = (facture.FactureFournisseur[]) CGenUtil.rechercher(facture, null, null, c, " and id = '" + id + "' order by daty");
            String code = mere[0].getCode();
            facture.setNomTable("FACTFOURN_VALIDE");
            mere = (facture.FactureFournisseur[]) CGenUtil.rechercher(facture, null, null, c, " and id = '" + id + "'");

            if (mere.length != 0) {

                setNomJasper("facture-client-sans-prevision");
                FactureFournisseurDetails cht = new FactureFournisseurDetails();
                cht.setNomTable("FACTFOURN_FILL_LIB_REST_TAXE");

                FactureFournisseurDetails[] details = (FactureFournisseurDetails[]) CGenUtil.rechercher(cht, null, null, c, " and idmere = '" + id + "'");
                ArrayList<FactureFournisseurDetails> arrList = new ArrayList<FactureFournisseurDetails>();

                FactureFournisseurFilleData dataF = new FactureFournisseurFilleData(id, details, null);
                facture.FactureFournisseur fact = dataF.getFacture();
                facture.setId(id);
                facture = mere[0];
                //facture.initDetails(c);
                double hTEuro = fact.getMontantHTEuro();
                double tvaEuro = fact.getMontantTVAEuro();
                double ttcEuro = hTEuro + tvaEuro;
                double hTDollar = fact.getMontantHTVADollar();
                double tvaDollar = fact.getMontantTVADollar();
                double ttcDollar = fact.getMontantTTCDollar();
                double deviseEuro = fact.getDeviseEuro();
                double deviseDollar = fact.getDeviseDollar();
                String cat = fact.getCategorielib();
                String designation = fact.getDesignation();
                facture.setId(details[0].getIdmere());
                facture.setListeDetails(details);
                facture.initDetails(null);
                double total = 0;
                double reduction = 0;
                for (int i = 0; i < details.length; i++) {
                    //details[i].setMontantHTEuro( details[i].getQuantite()*details[i].getPu());
                    total = total + details[i].getMontantHTEuro();
                    arrList.add(details[i]);
                    reduction += details[i].getReduction();

                    //total=
                }
                //mere[0].setArrayDetails(arrList);
                List<FactureFournisseurDetails> res = new ArrayList<FactureFournisseurDetails>();
                /*List dataSources = new ArrayList();
            dataSources.addAll(mere[0].getArrayDetails());*/
                param.put("total", total);
                param.put("montantsns", hTEuro);
                param.put("reduction", reduction);
                param.put("list_table", arrList);

                param.put("daty", mere[0].getDaty());
                param.put("id", mere[0].getId());
                param.put("type", mere[0].getTypelib());
                cat = mere[0].getCategorielib();
                param.put("cat", cat);
                designation = mere[0].getDesignation();
                param.put("designation", designation);
                param.put("reduction", mere[0].getReduction());
                param.put("client", mere[0].getTierslib());
                param.put("adresse", mere[0].getAdresse());
                param.put("phone", mere[0].getContact());
                param.put("montant", mere[0].getMontant());
                param.put("montantTVA", mere[0].getMontanttva());
                param.put("montantTTC", mere[0].getMontantttc());
                param.put("montantAvoir", mere[0].getMontantavoir());
                param.put("tva", mere[0].getTva());

                if (mere[0].getTypelib() != null) {
                    if (mere[0].getTypelib().compareToIgnoreCase("au comptant") != 0) {
                        param.put("dateEcheanceLib", "Date limite de paiement :");
                        param.put("dateEcheance", Utilitaire.formatterDatySql(mere[0].getDate_echeance()));
                    }
                }

                param.put("deviseMere", mere[0].getDeviseMere());
                param.put("code", code);
                String montantlettre = ChiffreLettre.convertRealToString(new Double(mere[0].getMontantttc())) + " Ariary ";

                if (mere[0].getDeviseMere() != null) {
                    if (mere[0].getDeviseMere().compareToIgnoreCase("Dollars") == 0) {
                        montantlettre = ChiffreLettre.convertRealToString(new Double(ttcDollar)) + " Dollars ";
                    }
                }

                param.put("montantlettre", montantlettre);
                param.put("htdollar", hTDollar);
                param.put("dollartva", tvaDollar);
                param.put("dollarttc", ttcDollar);
                param.put("hteuro", hTEuro);
                param.put("tvaeuro", tvaEuro);
                param.put("ttcEuro", ttcEuro);
                param.put("valeuro", deviseEuro);

                param.put("valdollar", deviseDollar);
                param.put("cat", cat);
                param.put("designation", designation);
            }
            /**
             * *********************************************************************************************
             */

            //ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            //setNomJasper("facture_client2 - Copie");
            UtilitaireImpression.imprimer(request, response, "facture-fournisseur", param, null, getReportPath(), rt);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void listefactureClient(HttpServletRequest request, HttpServletResponse response) {
        try {
            String sql = "";
            if (request.getParameter("mois") != null && request.getParameter("mois").compareToIgnoreCase("null") != 0 && request.getParameter("mois").length() != 0) {
                sql = sql + " and mois= " + request.getParameter("mois") + " ";
            }
            if (request.getParameter("annee") != null && request.getParameter("annee").compareToIgnoreCase("null") != 0 && request.getParameter("annee").length() != 0) {
                sql = sql + " and annee= " + request.getParameter("annee") + " ";
            }
            sql += " order by code_prest";
            ChiffreAffaire ff = new ChiffreAffaire();
            ff.setNomTable("rubrique_activite_CA");
            ChiffreAffaire[] details = (ChiffreAffaire[]) CGenUtil.rechercher(ff, null, null, null, sql);
            System.out.println(details.length);
            double total = 0;
            for (int i = 0; i < details.length; i++) {
                if (details[i].getType().compareToIgnoreCase("TFC002") == 0) {
                    details[i].setMontantstring(utilitaire.Utilitaire.formaterAr(details[i].getMontant()));
                } else {
                    details[i].setCreditstring(utilitaire.Utilitaire.formaterAr(details[i].getMontant()));
                }
                total = total + details[i].getMontant();
            }
            List datasource = Arrays.asList(details);
            Map param = new HashMap();
            param.put("total", total);
            param.put("list_table", datasource);
            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            setNomJasper("liste_factureclient_vaovao");
            UtilitaireImpression.imprimer(request, response, "chiffres d affaire", param, null, getReportPath(), rt);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public void listeJournalCaisse(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        Connection c = null;
        try {
            c = (new UtilDB()).GetConn();
            Map param = new HashMap();
            String id = request.getParameter("id");
            String folio = request.getParameter("folio");
            String valcaisse = request.getParameter("valcaisse");
            String libelle = request.getParameter("libelle");
            String remarque = request.getParameter("remarque");
            String dateEffet1 = request.getParameter("dateEffet1");
            String dateEffet2 = request.getParameter("dateEffet2");
            String idtypecheque = request.getParameter("idtypecheque");
            String idplacement = request.getParameter("idplacement");
            String descecaisse = request.getParameter("descecaisse");
            String daty = "";

            String sql = "";
            if (id != null && id.compareToIgnoreCase("null") != 0 && id.length() != 0) {
                sql = sql + " and UPPER(id) like UPPER('%" + id + "%') ";
            }
            if (folio != null && folio.compareToIgnoreCase("null") != 0 && folio.length() != 0) {
                sql = sql + " and UPPER(folio) like UPPER('%" + folio + "%')";
            }
            if (valcaisse != null && valcaisse.compareToIgnoreCase("null") != 0 && valcaisse.length() != 0) {
                sql = sql + " and UPPER(valcaisse) like UPPER('%" + valcaisse + "%') ";
            }
            if (libelle != null && libelle.compareToIgnoreCase("null") != 0 && libelle.length() != 0) {
                sql = sql + " and UPPER(libelle) like UPPER('%" + libelle + "%') ";
            }
            if (remarque != null && remarque.compareToIgnoreCase("null") != 0 && remarque.length() != 0) {
                sql = sql + " and UPPER(remarque) like UPPER('%" + remarque + "%') ";
            }
            if (dateEffet1 != null && dateEffet1.compareToIgnoreCase("null") != 0 && dateEffet1.length() != 0) {
                sql = sql + " and dateEffet >= '+" + dateEffet1 + "'";
                daty += "du " + dateEffet1;
            }
            if (dateEffet2 != null && dateEffet2.compareToIgnoreCase("null") != 0 && dateEffet2.length() != 0) {
                sql = sql + " and dateEffet <= '+" + dateEffet2 + "'";
                daty += " au " + dateEffet2;
            }
            if (idtypecheque != null && idtypecheque.compareToIgnoreCase("null") != 0 && idtypecheque.length() != 0) {
                sql = sql + " and UPPER(idtypecheque) like UPPER('%" + idtypecheque + "%') ";
            }
            if (idplacement != null && idplacement.compareToIgnoreCase("null") != 0 && idplacement.length() != 0) {
                sql = sql + " and UPPER(idplacement) like UPPER('%" + idplacement + "%') ";
            }
            if (descecaisse != null && descecaisse.compareToIgnoreCase("null") != 0 && descecaisse.length() != 0) {
                sql = sql + " and UPPER(descecaisse) like UPPER('%" + descecaisse + "%') ";
            }

            //System.out.println(sql);
            JournalCaisse journalCaisse = new JournalCaisse();
            journalCaisse.setNomTable("JOURNALCAISSELIBCOMPLET");
            JournalCaisse[] details = (JournalCaisse[]) CGenUtil.rechercher(journalCaisse, null, null, c, sql);

            ArrayList<JournalCaissePdf> ls = new ArrayList<JournalCaissePdf>();
            double totalmontant = 0;
            double totalcredit = 0;
            int i = 0;
            while (i < details.length) {
                PayementFacture[] p = details[i].getPayementFactureTous(c);
                JournalCaissePdf temp = new JournalCaissePdf();
                double montant = 0;

                temp.setClient(details[i].getTiersLib());
                temp.setMotif(details[i].getLibelle());
                temp.setNumpiece(details[i].getNumPiece());

                int a = 0;
                //System.out.println("len"+p.length);
                ArrayList<JournalCaisse> j = new ArrayList<JournalCaisse>();

                if (a < p.length) {
                    while (a < p.length) {
                        JournalCaisse caissetemp = new JournalCaisse();
                        if (a == 0) {
                            caissetemp.setCaisse(details[i].getLibelle());
                        }

                        caissetemp.setNumPiece(p[a].getCode());
                        caissetemp.setMontant(p[a].getMontant());
                        caissetemp.setRemarque(utilitaire.Utilitaire.formaterAr(p[a].getMontant()));
                        montant = montant + p[a].getMontant();

                        //System.out.println("codddeeeee="+p[a].getCode());
                        j.add(caissetemp);

                        a = a + 1;
                    }
                } else {
                    JournalCaisse caissetemp = new JournalCaisse();
                    caissetemp.setCaisse(details[i].getLibelle());
                    j.add(caissetemp);
                }
                //temp.setMotif(details[i].getLibelle());
                temp.setMontant(montant);
                temp.setReste(details[i].getCredit() - montant);
                totalmontant = totalmontant + montant;
                totalcredit = totalcredit + (details[i].getCredit() - montant);

                temp.setJcaisse(j);
                //temp.setMontant(montant);
                //temp.setNumfacture(numfact);
                ls.add(temp);
                i = i + 1;
            }
            double totalfinale = totalmontant + totalcredit;

            param.put("daty", daty);
            param.put("datyjour", utilitaire.Utilitaire.dateDuJourSql());
            param.put("list_table", ls);
            param.put("totalmontant", totalmontant);
            param.put("totalcredit", totalcredit);
            param.put("totalfinale", totalfinale);
            param.put("lettre", ChiffreLettre.convertRealToString(totalfinale));
            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            setNomJasper("journalcaisse");

            UtilitaireImpression.imprimer(request, response, "Journal de caisse", param, null, getReportPath(), rt);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }

    public void excel(HttpServletRequest request, HttpServletResponse response) {
        try {
            user.UserEJB user = (user.UserEJB) request.getSession().getValue("u");

            response.setContentType("application/ms-excel");
            response.setHeader("Content-Disposition", "attachment; filename=analyse_marchandise.xls");
            HSSFWorkbook wb = new HSSFWorkbook();
            Sheet sheet = wb.createSheet("new sheet");

            HSSFCellStyle style = wb.createCellStyle();
            /*   style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
            style.setBorderTop(HSSFCellStyle.BORDER_THIN);
            style.setBorderRight(HSSFCellStyle.BORDER_THIN);
            style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
            style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);*/

            HSSFCellStyle nombrestyle = wb.createCellStyle();
            /*nombrestyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
            nombrestyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
            nombrestyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
            nombrestyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
            nombrestyle.setAlignment(CellStyle.ALIGN_RIGHT);
            nombrestyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);*/
            UserEJB u = (user.UserEJB) request.getSession().getValue("u");
            CargaisonAnalyse recap = new CargaisonAnalyse();
            String listeCrt[] = {"mois", "cargaisonlib"};
            String listeInt[] = {"mois"};

            String[] pourcentage = {};
            String somDefaut[] = {"tonnage"}; //sum
            String colGrCol[] = {"moislib"}; //ligne
            String[] colDefaut = {"cargaisonlib"}; // colonnes

            PageRechercheGroupe pr = new PageRechercheGroupe(recap, request, listeCrt, listeInt, 3, colGrCol, somDefaut, pourcentage, 4, 0);
            pr.setUtilisateur(u);

            pr.setLien((String) request.getSession().getValue("lien"));
            pr.creerObjetPageCroise(colDefaut, pr.getLien() + "?but=capitainerie/quais/marchandise-analyse.jsp");
            ValeurEtiquette[][] table = pr.getTableau().getValeurEtiquette();
            System.out.println("ligne=" + table.length);
            System.out.println(table[0][1].getValeur());
            int i = 0;
            while (i < table.length) {
                Row row = sheet.createRow(i);
                int a = 0;
                while (a < table[i].length) {
                    Cell x = row.createCell(a);
                    x.setCellValue(table[i][a].getValeur());

                    a = a + 1;
                }

                i = i + 1;
            }

            i = 0;
            for (int x = 0; x < 14; x++) {
                sheet.autoSizeColumn(x);
            }

            ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
            wb.write(outByteStream);
            byte[] outArray = outByteStream.toByteArray();
            OutputStream outStream = response.getOutputStream();
            outStream.write(outArray);
            outStream.flush();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void analyseMarchandise(HttpServletRequest request, HttpServletResponse response) {
        try {

            UserEJB u = (user.UserEJB) request.getSession().getValue("u");
            CargaisonAnalyse recap = new CargaisonAnalyse();
            String listeCrt[] = {"mois", "cargaisonlib"};
            String listeInt[] = {"mois"};

            String[] pourcentage = {};
            String somDefaut[] = {"tonnage"}; //sum
            String colGrCol[] = {"moislib"}; //ligne
            String[] colDefaut = {"cargaisonlib"}; // colonnes

            PageRechercheGroupe pr = new PageRechercheGroupe(recap, request, listeCrt, listeInt, 3, colGrCol, somDefaut, pourcentage, 4, 0);
            pr.setUtilisateur(u);

            pr.setLien((String) request.getSession().getValue("lien"));
            pr.creerObjetPageCroise(colDefaut, pr.getLien() + "?but=capitainerie/quais/marchandise-analyse.jsp");
            ValeurEtiquette[][] table = pr.getTableau().getValeurEtiquette();
            ArrayList<AnalyseMarchandisePDF> ls = new ArrayList<AnalyseMarchandisePDF>();
            System.out.println("ligne" + table.length);
            //System.out.println("ligne"+table.length);

            int i = 0;

            while (i < table.length) {
                int a = 0;
                AnalyseMarchandisePDF r = new AnalyseMarchandisePDF();
                ArrayList<CargaisonAnalyse> temp = new ArrayList<CargaisonAnalyse>();
                while (a < table[i].length) {
                    CargaisonAnalyse x = new CargaisonAnalyse();
                    x.setMoislib(table[i][a].getValeur());
                    temp.add(x);
                    a = a + 1;
                }
                System.out.println("colonne=" + table[i].length);
                //System.out.println(temp.size());
                r.setParam1(temp);
                ls.add(r);
                i = i + 1;
            }
            System.out.println(ls.size());

            Map param = new HashMap();

            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            setNomJasper("analyseMarchandise");

            UtilitaireImpression.imprimer(request, response, "analyse marchandise", param, ls, getReportPath(), rt);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void impressionCA(HttpServletRequest request, HttpServletResponse response) {
        try {
            String mois = request.getParameter("mois");
            String annee = request.getParameter("annee");

            if (mois == null || mois.trim().isEmpty() || mois.compareToIgnoreCase("null") == 0) {
                mois = "" + Utilitaire.getMoisEnCoursReel();
            }
            if (annee == null || annee.trim().isEmpty() || annee.compareToIgnoreCase("null") == 0) {
                annee = "" + Utilitaire.getAneeEnCours();
            }

            Liste moisL = new Liste("mois");
            moisL.makeListeMois();
            moisL.setDefaut("" + mois);

            String moisEnLettre = (String) moisL.getValeurBrute()[Utilitaire.stringToInt(mois) - 1];
            Map param = new HashMap();

            EtatCA etatCA = new EtatCA(Integer.parseInt(mois), Integer.parseInt(annee), false);
            Map<String, CA[]> listeParRubrique = etatCA.getListeParRubrique();
            Map<String, CA> sommePartiel = etatCA.getSommePartiel();
            CA totalGeneral = etatCA.getTotalGeneral();
            List result = new ArrayList();
            if (listeParRubrique != null) {
                /*Details*/
                for (String rubrique : listeParRubrique.keySet()) {
                    CaPDF temp = new CaPDF();
                    temp.setLibelle("<b>" + Utilitaire.champNull(rubrique.toUpperCase()) + "</b>");
                    result.add(temp);
                    for (CA ca : listeParRubrique.get(rubrique)) {
                        result.add(new CaPDF(ca));
                    }
                    CaPDF temp2 = new CaPDF(sommePartiel.get(rubrique));
                    temp2.setLibelle("<center><b>" + temp2.getLibelle().toUpperCase() + "</b></center>");
                    temp2.setAnciencumul("<b>" + temp2.getAnciencumul() + "</b>");
                    temp2.setRegul("<b>" + temp2.getRegul() + "</b>");
                    temp2.setRegulEETP("<b>" + temp2.getRegulEETP() + "</b>");
                    temp2.setAvoirCumRegul("<b>" + temp2.getAvoirCumRegul() + "</b>");
                    temp2.setAvoirEETP("<b>" + temp2.getAvoirEETP() + "</b>");
                    temp2.setComptant("<b>" + temp2.getComptant() + "</b>");
                    temp2.setCredit("<b>" + temp2.getCredit() + "</b>");
                    temp2.setTotal("<b>" + temp2.getTotal() + "</b>");
                    temp2.setnCumul("<b>" + temp2.getnCumul() + "</b>");
                    temp2.setTaux("<b>" + temp2.getTaux() + "</b>");
                    result.add(temp2);
                }
                /*Details*/

 /*total*/
                param.put("anciencumul", Utilitaire.formaterAr(totalGeneral.getAnciencumul()));
                param.put("regul", Utilitaire.formaterAr(totalGeneral.getRegul()));
                param.put("regulEP", Utilitaire.formaterAr(totalGeneral.getRegulEETP()));
                param.put("cumul", Utilitaire.formaterAr(totalGeneral.getAvoirCumRegul()));
                param.put("avoir", Utilitaire.formaterAr(totalGeneral.getAvoirEETP()));
                param.put("comptant", Utilitaire.formaterAr(totalGeneral.getComptant()));
                param.put("credit", Utilitaire.formaterAr(totalGeneral.getCredit()));
                param.put("total", Utilitaire.formaterAr(totalGeneral.getTotal()));
                param.put("cumule", Utilitaire.formaterAr(totalGeneral.getNCumul()));
                param.put("taux", Utilitaire.formaterAr(totalGeneral.getTaux()));

                /*total*/
 /*taux*/
                param.put("avoirtaux", Utilitaire.formaterAr(etatCA.getPourcAvoir()));
                param.put("comptanttaux", Utilitaire.formaterAr(etatCA.getPourComptant()));
                param.put("credittaux", Utilitaire.formaterAr(etatCA.getPourcCredit()));
                /*taux*/
                param.put("nbr", Utilitaire.formaterAr(Utilitaire.formaterAr(etatCA.getNbFactComptant())));
                param.put("nbr2", Utilitaire.formaterAr(etatCA.getNbFactCredit()));
                param.put("nbr3", Utilitaire.formaterAr(etatCA.getNbFactureTotal()));
                param.put("mois", Constante.getMois()[Utilitaire.stringToInt(mois) - 1]);
                param.put("daty", Utilitaire.dateDuJour());
            }
            /**
             * ****************
             */

            param.put("list_table", result);
            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            setNomJasper("chiffre_affaire");
            UtilitaireImpression.imprimer(request, response, "chiffre d'affaires", param, result, getReportPath(), rt);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void rubrique_activite_pdf(HttpServletRequest request, HttpServletResponse response) {
        try {
            String id = request.getParameter("id");
            String code = request.getParameter("code");
            String compte = request.getParameter("compte");
            String prestation = request.getParameter("prestation");
            String tarif2 = request.getParameter("tarif");
            String unite = request.getParameter("unite");
            String where = "";
            if (id != null && id.compareToIgnoreCase("null") != 0 && id.length() != 0) {
                where += " and upper(id) like upper('%" + id + "%') ";
            }
            if (code != null && code.compareToIgnoreCase("null") != 0 && code.length() != 0) {
                where += " and upper(code) like upper('%" + code + "%') ";
            }
            if (compte != null && compte.compareToIgnoreCase("null") != 0 && compte.length() != 0) {
                where += " and upper(compte) like upper('%" + compte + "%') ";
            }
            if (prestation != null && prestation.compareToIgnoreCase("null") != 0 && prestation.length() != 0) {
                where += " and upper(prestation) like upper('%" + prestation + "%') ";
            }
            if (tarif2 != null && tarif2.compareToIgnoreCase("null") != 0 && tarif2.length() != 0) {
                where += " and upper(tarif) like upper('%" + tarif2 + "%') ";
            }
            if (unite != null && unite.compareToIgnoreCase("null") != 0 && unite.length() != 0) {
                where += " and upper(unite) like upper('%" + unite + "%') ";
            }

            Map param = new HashMap();
            param.put("daty", Utilitaire.datedujourlettre(Utilitaire.dateDuJour()));
            Tarif tarif = new Tarif();
            Tarif[] datatarif = (Tarif[]) CGenUtil.rechercher(tarif, null, null, where);
            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            setNomJasper("rubrique-activite-pdf");
            UtilitaireImpression.imprimer(request, response, "Rubrique d'activite", param, Arrays.asList(datatarif), getReportPath(), rt);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void coursdevise_pdf(HttpServletRequest request, HttpServletResponse response) {
        try {
            String id = request.getParameter("id");
            String iddevise = request.getParameter("iddevise");
            String date1 = request.getParameter("daty1");
            String date2 = request.getParameter("daty2");
            String where = "";
            if (id != null && id.compareToIgnoreCase("null") != 0 && id.length() != 0) {
                where += " and upper(id) like upper('%" + id + "%') ";
            }
            if (iddevise != null && iddevise.compareToIgnoreCase("null") != 0 && iddevise.length() != 0) {
                where += " and upper(iddevise) like upper('%" + iddevise + "%') ";
            }
            if (date1 != null && date1.compareToIgnoreCase("null") != 0 && date1.length() != 0) {
                where += " and  daty >= '" + date1 + "'";
            }
            if (date2 != null && date2.compareToIgnoreCase("null") != 0 && date2.length() != 0) {
                where += " and  daty <= '" + date2 + "'";
            }
            where += " and upper(iddevise) != upper('Ar')";
            Map param = new HashMap();
            param.put("datyjour", Utilitaire.dateDuJour());
            Coursdevise devise = new Coursdevise();
            devise.setNomTable("COURSDEVISENONMICTSL_PDF");
            Coursdevise[] datadevise = (Coursdevise[]) CGenUtil.rechercher(devise, null, null, where);
            List result = new ArrayList();
            for (int i = 0; i < datadevise.length; i++) {
                Coursdevise coursdevise = datadevise[i];
                CoursdevisePDF pdf = new CoursdevisePDF(coursdevise.getDaty(), coursdevise.getIddevise(), coursdevise.getMontant());
                result.add(pdf);
            }
            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            setNomJasper("coursdevise-pdf");
            UtilitaireImpression.imprimer(request, response, "Cours devise", param, result, getReportPath(), rt);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void journalCaisseEtat(HttpServletRequest request, HttpServletResponse response) {
        try {
            String daty = request.getParameter("date");
            Date date = new java.sql.Date(Utilitaire.stringToDate("yyyy-mm-dd", daty).getTime());
            EtatJournalCaisse ejc = new EtatJournalCaisse(date);
            JournalCaisse[] jc = ejc.getListeDepenses();
            Map param = new HashMap();
            param.put("daty", date);
            double credit = 0;
            double debit = 0;
            ArrayList<JournalCaisse> arrList = new ArrayList<JournalCaisse>();
            for (int i = 0; i < jc.length; i++) {
                debit = debit + jc[i].getCredit();
                credit = credit + jc[i].getDebit();
                arrList.add(jc[i]);
            }
            debit = debit + ejc.getTotalRecette();
            double soldeAnterieur = ejc.getSoldeAnterieur();
            double soldeActuel = ejc.getSoldeActuel();
            double totalCreditEtat = ejc.getTotalCreditEtat();
            double totalDebitEtat = ejc.getTotalDebitEtat();

            JournalCaisse jcc = new JournalCaisse();
            jcc.setLibelle("Recette de la caisse SPAT Journée du " + date.toString());
            jcc.setCredit(debit);
            arrList.add(jcc);

            param.put("list_table", arrList);

            param.put("credit", credit);
            param.put("debit", debit);
            param.put("soldeAnterieur", soldeAnterieur);
            param.put("soldeActuel", soldeActuel);
            param.put("totalCreditEtat", totalCreditEtat);
            param.put("totalDebitEtat", totalDebitEtat);

            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            setNomJasper("journal_caisse_etat");
            UtilitaireImpression.imprimer(request, response, "journal-caisse-etat", param, null, getReportPath(), rt);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void imprimerGestionProvision(HttpServletRequest request, HttpServletResponse response) {
        try {
            String id = request.getParameter("id");
            EtatProvision a = new EtatProvision();
            a.setNomTable("etat_provisionlib");
            Map param = new HashMap();
            param.put("daty", utilitaire.Utilitaire.dateDuJourSql());
            EtatProvision[] mere = (EtatProvision[]) CGenUtil.rechercher(a, null, null, null, " and idfacture = '" + id + "'");
            if (mere.length != 0) {
                param.put("numprovision", mere[0].getNumProvision());
                param.put("identififcation", mere[0].getId());
                param.put("date", mere[0].getDaty());
                param.put("client", mere[0].getTierslib());
                param.put("navire", mere[0].getIdnavirelib());
                param.put("mode", mere[0].getIdmodelib());
                param.put("banque", mere[0].getIdbanquelib());
                //param.put("montantProv", mere[0].getMontantprovision());
                param.put("num", mere[0].getNumProvision());
                param.put("datyprof", "");
                param.put("datyedit", Utilitaire.dateDuJour());
                //param.put("montant", mere[0].getMontantprovision());
            }
            FactureClient e = new FactureClient();
            e.setNomTable("Provisionviseenonfacturee");
            FactureClient[] ls = (FactureClient[]) CGenUtil.rechercher(e, null, null, null, " and id = '" + id + "'");
            if (ls.length != 0) {
                param.put("monatntttc", ls[0].getMontantttc());
                param.put("daty", ls[0].getDate_echeance());
                param.put("numfact", ls[0].getId());
                param.put("montantProv", ls[0].getMontant());
                param.put("montant", ls[0].getMontant());
            }

            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            setNomJasper("gestion provision");
            UtilitaireImpression.imprimer(request, response, "gestion de provision", param, null, getReportPath(), rt);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public void redevanceCommunale(HttpServletRequest request, HttpServletResponse response) {
        try {
            String daty1 = request.getParameter("daty1");
            Date date1 = new java.sql.Date(Utilitaire.stringToDate("dd/mm/yyyy", daty1).getTime());
            String daty2 = request.getParameter("daty2");
            Date date2 = new java.sql.Date(Utilitaire.stringToDate("dd/mm/yyyy", daty2).getTime());
            String tierslib = request.getParameter("tierslib");
            String typelib = request.getParameter("typelib");
            String titre = request.getParameter("titre");
            EtatRedevance redevance = new EtatRedevance();
            redevance.setNomTable("redevanceCommunaleFacture");
            String requete = "";
            if (daty1 != null) {
                requete = requete + String.format(" and daty >= '%s'", daty1);

            }
            if (daty2 != null) {
                requete = requete + String.format(" and daty <= '%s'", daty2);

            }
            requete = requete + " and upper(tierslib) like upper('%" + tierslib + "%') and upper(typelib) like upper('%" + typelib + "%') order by daty asc";
            EtatRedevance[] list = (EtatRedevance[]) CGenUtil.rechercher(redevance, null, null, null, requete);
            Map param = new HashMap();
            param.put("daty", utilitaire.Utilitaire.dateDuJourSql());
            double total = 0;
            double totalTVA = 0;
            double totalTTC = 0;
            ArrayList<EtatRedevance> arrList = new ArrayList<EtatRedevance>();
            for (int i = 0; i < list.length; i++) {
                arrList.add(list[i]);
                total = total + list[i].getMontantHT();
                totalTVA = totalTVA + list[i].getTva();
                totalTTC = totalTTC + list[i].getMontantTTC();
            }

            param.put("titre", titre);
            param.put("date_debut", date1);
            param.put("date_fin", date2);
            param.put("total", total);
            param.put("totalTTC", totalTTC);
            param.put("totalTVA", totalTVA);
            param.put("list_table", arrList);

            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            setNomJasper("redevance-communale");
            UtilitaireImpression.imprimer(request, response, "redevance-communale", param, null, getReportPath(), rt);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void engagement(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        Connection c = null;
        try {
            c = (new UtilDB()).GetConn();
            String id = request.getParameter("id");
            Engagement engagement = new Engagement();
            engagement.setId(id);
            engagement.setNomTable("engagementlib");
            Engagement[] mere = (Engagement[]) CGenUtil.rechercher(engagement, null, null, c, "");
            Map param = new HashMap();
            if (mere.length != 0) {
                engagement = mere[0];
                param.put("code_etab", engagement.getCodeEtablissementlib());
                param.put("annee", Utilitaire.getAnnee(engagement.getDaty()) + "");
                param.put("piece", engagement.getDesignation());
                param.put("du", engagement.getDaty());
                param.put("projet", engagement.getProjetlib());
                param.put("numero", engagement.getNum());

                LigneCredit lc = engagement.findLigneCredit(c);
                if (lc != null) {
                    if (engagement.getCodeEtablissementlib() == null) {
                        param.put("code_etab", lc.getCodeEtablissementlib());
                    }
                    if (engagement.getProjetlib() == null) {
                        param.put("projet", lc.getProjetlib());
                    }
                }

                lc = engagement.findSituationCredit(c);
                if (lc != null) {
                    param.put("annuel", Utilitaire.formaterAr(lc.getMontant()));
                }
                param.put("montant", Utilitaire.formaterAr((engagement.getMontant())));
                param.put("avant", Utilitaire.formaterAr(engagement.getDispoAvant()));
                param.put("apres", Utilitaire.formaterAr(engagement.getDispoApres()));
            }

            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            setNomJasper("engagement");
            UtilitaireImpression.imprimer(request, response, "engagement", param, null, getReportPath(), rt);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (c != null) {
                c.close();
            }
        }

    }

    public void dse(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        Connection c = null;
        try {
            c = (new UtilDB()).GetConn();
            String id = request.getParameter("id");
            Engagement engagement = new Engagement();
            engagement.setId(id);
            engagement.setNomTable("engagementlib");
            Engagement[] mere = (Engagement[]) CGenUtil.rechercher(engagement, null, null, c, "");
            Map param = new HashMap();
            List<EngagementFille> datafille = new ArrayList<EngagementFille>();
            double total = 0;
            if (mere.length != 0) {
                engagement = mere[0];
                param.put("codeetablissementlib", engagement.getCodeEtablissementlib());
                param.put("daty", Utilitaire.datetostring(engagement.getDaty()) + "");
                param.put("projetlib", engagement.getProjetlib());
                param.put("designation", engagement.getDesignation());
                param.put("tierslib", engagement.getTierslib());

                EngagementFille fi = new EngagementFille();
                fi.setNomTable("engagement_fillelib");
                fi.setIdmere(engagement.getId());
                EngagementFille[] fille = (EngagementFille[]) CGenUtil.rechercher(fi, null, null, c, "");
                for (int i = 0; i < fille.length; i++) {
                    if (i == 0) {
                        fille[i].setEstPaye(engagement.getTierslib());
                    } else {
                        fille[i].setEstPaye(null);
                    }
                    datafille.add(fille[i]);
                    total += fille[i].getMontant();
                }
                param.put("total", total);
            }
            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            setNomJasper("dse-pdf");
            UtilitaireImpression.imprimer(request, response, "dse-pdf", param, datafille, getReportPath(), rt);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (c != null) {
                c.close();
            }
        }

    }

    public void ligneCreditDepense(HttpServletRequest request, HttpServletResponse response) {
        try {
            user.UserEJB user = (user.UserEJB) request.getSession().getValue("u");
            String daty1 = request.getParameter("daty1");
            String daty2 = request.getParameter("daty2");
            /*
            String compteInv = request.getParameter("compteInv");
            String compteSimple = request.getParameter("compteSimple");
            String direction = request.getParameter("direction");
            String projet = request.getParameter("projet");
            String directionProjet = request.getParameter("directionProjet");
            String annee = request.getParameter("annee");
            String etat = request.getParameter("etat");
             */
            LigneCredit fa = new LigneCredit();
            fa.setNomTable("situationLC_vide");
            String listeCrt[] = {"compteInv", "compteSimple", "direction", "projet", "directionProjet", "daty", "annee"};
            String listeInt[] = {"daty"};
//        String libEntete[] = {"id", "designation", "compte", "annee", "montant", "engageer", "facture", "pourcEngage", "paye", "pourcPaye", "arecouvrir", "restebudget"};
            String libEntete[] = {"direction", "projet", "montant", "engageer", "facture", "pourcEngage", "paye", "pourcPaye", "arecouvrir", "restebudget", "resteApresEngmt"};

            PageRecherche pr = new PageRecherche(fa, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
            pr.setUtilisateur((user.UserEJB) user);
            String reqniv = request.getParameter("niveau");
            String moisMin = daty1 != null && daty1.compareToIgnoreCase("null") != 0 && !daty1.isEmpty() ? "" + Utilitaire.stringToInt(Utilitaire.getMois(daty1)) : "", moisMax = daty2 != null && daty2.compareToIgnoreCase("null") != 0 && !daty2.isEmpty() ? "" + Utilitaire.stringToInt(Utilitaire.getMois(daty2)) : "";

            String[] colSomme = {"montant", "engageer", "facture", "pourcEngage", "paye", "pourcPaye", "arecouvrir", "restebudget", "resteApresEngmt"};
            pr.creerObjetPage(libEntete, colSomme);

            ResultatEtSomme rs = LigneCredit.findSituationCreditDepense((LigneCredit) pr.getCritere(), daty1, daty2, null, colSomme);
            pr.setRs(rs);
            pr.setTableau(new TableauRecherche((bean.ClassMAPTable[]) rs.getResultat(), libEntete));
            pr.makeTableauRecap();
            LigneCredit[] data = (LigneCredit[]) pr.getTableau().getData();
            Map param = new HashMap();
            if (data.length != 0) {
                param.put("annee", data[0].getAnnee() + "");
                System.out.println("annee" + data[0].getAnnee() + "");
                param.put("annuel", Utilitaire.formaterAr(data[0].getMontant()));
                System.out.println("annuel" + Utilitaire.formaterAr(data[0].getMontant()));
                param.put("avant", Utilitaire.formaterAr(data[0].getResteApresEngmt()));
                System.out.println("avant" + Utilitaire.formaterAr(data[0].getResteApresEngmt()));
                param.put("projet", data[0].getProjet());
                System.out.println("projet" + data[0].getProjetlib());
                param.put("code_etab", data[0].getDirection());
                System.out.println("code_etab" + data[0].getCodeEtablissementlib());
            }
            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            setNomJasper("lgc");
            UtilitaireImpression.imprimer(request, response, "ligne Credit depense", param, null, getReportPath(), rt);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void imprimerProforma(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        Connection c = null;
        try {
            c = (new UtilDB()).GetConn();
            Map param = new HashMap();
            String id = request.getParameter("id");
            ProformaMere facture = new ProformaMere();
            facture.setEstDDPMICTSL(null);
//            facture.setNomTable("ESCALEPROFORMAPDF");
            facture.setNomTable("proforma_mere_msum_lib");
            ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;

            ProformaMere[] mere = (ProformaMere[]) CGenUtil.rechercher(facture, null, null, c, " and id = '" + id + "'");
            String code = mere[0].getCode();

            facture = mere[0];
            facture.setId(id);
            facture.initDetails(c);
            double hTEuro = facture.getMontantHTEuro();
            double tvaEuro = facture.getMontantTVAEuro();
            double ttcEuro = hTEuro + tvaEuro;
            double hTDollar = facture.getMontantHTVADollar();
            double tvaDollar = facture.getMontantTVADollar();
            double ttcDollar = facture.getMontantTTCDollar();
            double deviseEuro = facture.getDeviseEuro();
            double deviseDollar = facture.getDeviseDollar();
            String cat = facture.getCategorielib();
            String designation = facture.getDesignation();
            if (mere.length != 0) {
                mg.spat.PrevisionLibComplet p = new mg.spat.PrevisionLibComplet();
                p.setNomTable("ESCALEPROFORMAPDF");
                mg.spat.PrevisionLibComplet[] pre = (mg.spat.PrevisionLibComplet[]) CGenUtil.rechercher(p, null, null, c, " and id = '" + id + "'");
                ProformaFille cht = new ProformaFille();
                cht.setNomTable("proforma_fille_lib");
                //cht.setNomTable("FACT_CLT_FILL_LIB_REST_TAXE");

                ProformaFille[] details = (ProformaFille[]) CGenUtil.rechercher(cht, null, null, c, " and idmere = '" + id + "' ");
                ArrayList<ProformaFille> arrList = new ArrayList<ProformaFille>();
                FactureClientDetails[] __details = facture.getListeDetails();
                for (int i = 0; i < details.length; i++) {
                    for (int j = 0; j < __details.length; j++) {
                        if (__details[j].getId().compareTo(details[i].getId()) == 0) {
                            details[i].setMontantHTEuro(__details[j].getMontantHTEuro());
                            arrList.add(details[i]);
                        }
                    }

                }
                param.put("responsable", "Pr&eacute;par&eacute; Par");
                param.put("chef", "Le Responsable Facturation");

                param.put("chef", "Le chef de D&eacute;partement");
                param.put("responsable", "Le contr&ocirc;leur");

                if (pre.length != 0) {

                    param.put("navire", pre[0].getNomnavire());
                    // param.put("escale",pre[0].getEscale());
                    param.put("date_arrivee", pre[0].getDate_arrivee());
                    //param.put("pavillon",pre[0].getPavillon);
                    param.put("date_depart", pre[0].getDate_depart());
                    param.put("destination", pre[0].getValquaisdestination());
                    param.put("lhtnavire", pre[0].getLhtnavire());
                    param.put("jntnavire", pre[0].getJntnavire());
                    param.put("lmnavire", pre[0].getLmnavire());
                    param.put("provenance", pre[0].getValquaisprovenance());
                    param.put("escale", pre[0].getEscale());
                    param.put("pavillonlib", pre[0].getPavillonlib());
                    param.put("heure_depart", pre[0].getHeure_depart());
                    param.put("heure_arrivee", pre[0].getHeure_arrivee());
                    param.put("armateur", pre[0].getArmateurlib());
                    param.put("tenavire", pre[0].getTenavire());
                    param.put("pourcomptelib", mere[0].getPourCompteLib());
                    setNomJasper("facture_client2 - Copie");//facture_client2 - Copie //facture_convention //facture-client-sans-prevision
                }

                param.put("daty", mere[0].getDaty());
                param.put("id", mere[0].getId());
                param.put("type", mere[0].getTypelib());
                cat = mere[0].getCategorielib();
                param.put("cat", cat);
                designation = mere[0].getDesignation();
                param.put("designation", designation);
                param.put("reduction", mere[0].getReduction());
                param.put("client", mere[0].getTierslib());
                param.put("adresse", mere[0].getAdresse());
                param.put("phone", mere[0].getContact());
                param.put("montant", mere[0].getMontant());
                param.put("montantTVA", mere[0].getMontanttva());
                param.put("montantTTC", mere[0].getMontantttc());
                param.put("montantAvoir", mere[0].getMontantavoir());
                param.put("tva", mere[0].getTva());

                param.put("dateEcheanceLib", "Date limite de paiement :");
                param.put("dateEcheance", Utilitaire.formatterDatySql(mere[0].getDate_echeance()));

                param.put("deviseMere", mere[0].getDeviseMere());
                param.put("code", code);

                String montantlettre = ChiffreLettre.convertRealToString(new Double(mere[0].getMontantttc()), " Ariary");

                if (mere[0].getDeviseMere() != null) {
                    if (mere[0].getDeviseMere().compareToIgnoreCase(Constante.deviseDollars) == 0) {
                        montantlettre = ChiffreLettre.convertRealToString(new Double(ttcDollar), " Dollars");
                    }
                    if (mere[0].getDeviseMere().compareToIgnoreCase(Constante.deviseAr) == 0) {
                        montantlettre = ChiffreLettre.convertRealToString(new Double(mere[0].getMontantttc()), " Ariary");
                    }
                    if (mere[0].getDeviseMere().compareToIgnoreCase(Constante.deviseEuro) == 0) {
                        montantlettre = ChiffreLettre.convertRealToString(new Double(ttcEuro), " Euros");
                    }

                }

                param.put("montantlettre", montantlettre);
                param.put("htdollar", hTDollar);
                param.put("dollartva", tvaDollar);
                param.put("dollarttc", ttcDollar);
                param.put("hteuro", hTEuro);
                param.put("tvaeuro", tvaEuro);
                param.put("ttcEuro", ttcEuro);
                param.put("valeuro", deviseEuro);

                param.put("valdollar", deviseDollar);
                param.put("cat", cat);

                /**
                 * *********************************************************************************************
                 */
                // facture.setId(details[0].getIdmere());
                //facture.setListeDetails(details);
                //facture.initDetails(null);
                //details = facture.getListeDetails();
                double total = 0;
                double reduction = 0;

                param.put("total", total);
                param.put("montantsns", hTEuro);
                param.put("reduction", reduction);
                param.put("list_table", arrList);
            }
            //ReportingUtils.ReportType rt = ReportingUtils.ReportType.PDF;
            setNomJasper("proforma");
            UtilitaireImpression.imprimer(request, response, "facture-client", param, null, getReportPath(), rt);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }
}
