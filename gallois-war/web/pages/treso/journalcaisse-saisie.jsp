<%@page import="facture.FactureClient"%>
<%@page import="facture.tr.Traite"%>
<%@page import="mg.spat.JournalCaisseData"%>
<%@page import="avoir.AvoirFF"%>
<%@page import="avoir.AvoirFC"%>
<%@page import="ded.OrdonnerPayement"%>
<%@page import="mg.spat.MvtcaisseOrdonnerpayementFacture"%>
<%@page import="mg.spat.JournalCaisse"%>
<%@page import="mg.spat.placement.Placement"%>
<%@page import="mg.spat.placement.DetailsPlacements"%>
<%@ page import="user.UserEJB" %>
<%@ page import="bean.TypeObjet" %>
<%@ page import="bean.CGenUtil" %>
<%@ page import="utilitaire.Utilitaire" %>
<%@ page import="utilitaire.Constante" %>
<%@ page import="affichage.PageInsert" %>
<%@ page import="affichage.Liste" %>
<%@page import="mg.spat.FactureAnalyse"%>
<%
    try {
        String autreparsley = "data-parsley-range='[8, 40]' required";
        JournalCaisse pj = new JournalCaisse();

        PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));

        FactureAnalyse facture = new FactureAnalyse();
        String idfact = request.getParameter("idFacture");
        String idFactures = request.getParameter("idFactures");
        String idFacturesF = request.getParameter("idFacturesF");
        String idOP = request.getParameter("id");
        String idplacement = request.getParameter("idplacement");
        String idmvtcaisse = request.getParameter("idmvtcaisse");
        String idOPs = request.getParameter("idOPs");

        if(request.getParameter("credit")!=null)pi.getFormu().getChamp("credit").setDefaut(request.getParameter("credit"));

        JournalCaisseData datas = new JournalCaisseData(request);
        datas.init(null);
        
        affichage.Liste[] liste = new affichage.Liste[5];
        TypeObjet esc = new TypeObjet();
        liste[0] = new Liste("caisse", esc, "VAL", "id");
        liste[0].setDefaultSelected(Constante.caisseDepense);

        if (idfact != null) {
            facture = datas.getFactureAnalyse();
            double reste = facture.getReste();
            String client = facture.getClient();

            pi.getFormu().getChamp("libelle").setDefaut(facture.getDesignation());
            pi.getFormu().getChamp("credit").setDefaut(Utilitaire.formaterAr("" + reste));
            liste[0].setDefaultSelected(Constante.caisseCentraleEspece);
            pi.getFormu().getChamp("idplacement").setDefaut("" + facture.getNmfact());
            pi.getFormu().getChamp("tiers").setDefaut(client);
            pi.getFormu().getChamp("idplacement").setDefaut(idfact);
        }

        if (idFactures != null) {
            FactureClient fc = datas.getFacture();
            pi.getFormu().getChamp("idplacement").setDefaut(idFactures);
            pi.getFormu().getChamp("credit").setDefaut(Utilitaire.formaterAr(fc.getMontant()));
            pi.getFormu().getChamp("tiers").setDefaut(Utilitaire.champNull(fc.getTiers()));
            pi.getFormu().getChamp("tiers").setValeurLibelle(Utilitaire.champNull(fc.getTierslib()));
            liste[0].setDefaultSelected(Constante.caisseCentraleEspece);

        } else if (idFacturesF != null) {
            FactureClient fc = datas.getFacture();
            pi.getFormu().getChamp("idplacement").setDefaut(idFacturesF);
            pi.getFormu().getChamp("debit").setDefaut(Utilitaire.formaterAr(fc.getMontant()));
            pi.getFormu().getChamp("tiers").setDefaut(Utilitaire.champNull(fc.getTiers()));
            pi.getFormu().getChamp("tiers").setValeurLibelle(Utilitaire.champNull(fc.getTierslib()));
            pi.getFormu().getChamp("Idplacementvrai").setVisible(false);
        }

        boolean estCasisseDep = false;
        if (request.getParameter("caisse") != null) {
            if(request.getParameter("caisse").compareToIgnoreCase("CAISSEDEPENSE")==0){
                estCasisseDep = true;
            }
            esc.setNomTable(request.getParameter("caisse"));
        } else {
            esc.setNomTable("CAISSE");
        }
        
        TypeObjet cheque = new TypeObjet();
        cheque.setNomTable("TYPECHEQUE");
        liste[1] = new Liste("idTypeCheque", cheque, "VAL", "id");

        TypeObjet op = new TypeObjet();
        op.setNomTable("DEVISE");
        liste[2] = new Liste("iddevise", op, "desce", "id");

        liste[2].setDefaultSelected("Ar");

        TypeObjet mode = new TypeObjet();
        mode.setNomTable("MODEPAIEMENT");
        if(request.getParameter("idmode")!=null){
            mode.setNomTable(request.getParameter("idmode"));
        }
        liste[3] = new Liste("idmode", mode, "desce", "id");
        if(estCasisseDep)  liste[3].setDefaultSelected(Constante.modeRecetteCaisseDepense);

        TypeObjet banq = new TypeObjet();
        banq.setNomTable("BANQUE");
        liste[4] = new Liste("idbanque", banq, "VAL", "id");

        pi.getFormu().changerEnChamp(liste);

        pi.getFormu().changerEnChamp(liste);
        //pi.getFormu().getChamp("dateSaisie").setVisible(false);
        pi.getFormu().getChamp("typemvt").setVisible(false);
        pi.getFormu().getChamp("dateSaisie").setDefaut(Utilitaire.dateDuJour());
        pi.getFormu().getChamp("idbanque").setLibelle("Banque");
        pi.getFormu().getChamp("banque").setVisible(false);
        pi.getFormu().getChamp("idmode").setLibelle("Mode");
        pi.getFormu().getChamp("dateEffet").setLibelle("Date Effet");
        pi.getFormu().getChamp("numPiece").setLibelle("Num&eacute;ro pi&egrave;ce");
        pi.getFormu().getChamp("libelle").setLibelle("Libell&eacute;");

        pi.getFormu().getChamp("debit").setLibelle("Sortie");
        pi.getFormu().getChamp("credit").setLibelle("Entr&eacute;e");
        pi.getFormu().getChamp("idtypecheque").setLibelle("Type");
        pi.getFormu().getChamp("iddevise").setLibelle("Devise");
        pi.getFormu().getChamp("numcheque").setLibelle("Numero ch&egrave;que");
        pi.getFormu().getChamp("idordre").setLibelle("Ordre");
        pi.getFormu().getChamp("etat").setVisible(false);
        pi.getFormu().getChamp("designation").setVisible(false);
        pi.getFormu().getChamp("dateEffet").setDefaut(Utilitaire.dateDuJour());
        pi.getFormu().getChamp("idTypeCheque").setDefaut(Constante.typeCheque);

        pi.getFormu().getChamp("tiers").setPageAppel("choix/listeTiersBEDChoix.jsp");
        pi.getFormu().getChamp("tiers").setAutre("readonly");
        pi.getFormu().getChamp("idordre").setPageAppel("choix/listeOrdonnerPayementChoix.jsp");
        pi.getFormu().getChamp("idordre").setAutre("readonly");

        pi.getFormu().getChamp("idplacement").setAutre("readonly");

        pi.getFormu().getChamp("idplacement").setLibelle("Placement");

        if (idOP != null) {

            if (idOP != null && idOP.compareTo("") != 0) {
                MvtcaisseOrdonnerpayementFacture preremplie = datas.getJcInfo();
                pi.getFormu().getChamp("idordre").setDefaut(idOP);

                if (preremplie != null) {
                    pi.getFormu().getChamp("idordre").setValeurLibelle(preremplie.getRemarque());
                    pi.getFormu().getChamp("tiers").setValeurLibelle(preremplie.getNomfournisseur());
                    pi.getFormu().getChamp("tiers").setDefaut(preremplie.getIdfournisseur());
                    pi.getFormu().getChamp("idmode").setDefaut(preremplie.getModepaiement());
                    pi.getFormu().getChamp("debit").setDefaut("" + Utilitaire.formaterAr("" + preremplie.getReste()));
                }
            }

            OrdonnerPayement ordP = datas.getOp();

            if (ordP != null) {
                pi.getFormu().getChamp("designation").setDefaut(ordP.getRemarque());
                pi.getFormu().getChamp("libelle").setDefaut(ordP.getRemarque());

                pi.getFormu().getChamp("idordre").setDefaut(ordP.getId());
                pi.getFormu().getChamp("idordre").setValeurLibelle(ordP.getRemarque());
                pi.getFormu().getChamp("tiers").setDefaut(ordP.getTiers());
                pi.getFormu().getChamp("tiers").setValeurLibelle(ordP.getTierslib());
                pi.getFormu().getChamp("idmode").setDefaut(ordP.getModepaiement());
                if (request.getParameter("entree") != null) {
                    pi.getFormu().getChamp("credit").setDefaut(Utilitaire.formaterAr("" + ordP.getMontant()));

                } else {
                    pi.getFormu().getChamp("debit").setDefaut(Utilitaire.formaterAr("" + ordP.getMontant()));
                }

                if (ordP.getDed_Id() != null && ordP.getDed_Id().startsWith("AVRFC")) {
                    AvoirFC av = datas.getAvoirFC();
                    pi.getFormu().getChamp("idplacement").setDefaut(av.getIdfacture());
                }
            }
        }
        if (idplacement != null) {
            pi.getFormu().getChamp("idplacement").setDefaut(idplacement);
            pi.getFormu().getChamp("idplacement").setValeurLibelle(idplacement);

            if (request.getParameter("param") != null && request.getParameter("param").equalsIgnoreCase("sortie")) {
                Placement pl = datas.getPlacement();
                pi.getFormu().getChamp("debit").setDefaut(Utilitaire.formaterAr("" + pl.getMontant()));
            } else {
                DetailsPlacements dp = datas.getDetailsPlacement();
                pi.getFormu().getChamp("credit").setDefaut(Utilitaire.formaterAr("" + dp.getMontant_terme()));
            }
            if (request.getParameter("auto") != null && !request.getParameter("auto").equals("") && request.getParameter("auto").equals("1")) {
                pi.getFormu().getChamp("caisse").setDefaut(datas.getPbc().getDesce());
            }
        }

        pi.getFormu().getChamp("idplacement").setLibelle("Source");

        String idAvoir = request.getParameter("idAvoir");
        if (idAvoir != null && !idAvoir.isEmpty()) {
            AvoirFC avoir = datas.getAvoirFC();
            pi.getFormu().getChamp("libelle").setDefaut("Paiement avoir via facture client - " + idAvoir);
            pi.getFormu().getChamp("idplacement").setDefaut(idAvoir);
            pi.getFormu().getChamp("idplacement").setAutre("readonly");
            pi.getFormu().getChamp("debit").setDefaut(Utilitaire.formaterAr(avoir.getMontantreste()));
            pi.getFormu().getChamp("tiers").setDefaut(avoir.getTiers());
        }
        String idAvoirFF = request.getParameter("idAvoirFF");
        if (idAvoirFF != null && !idAvoirFF.isEmpty()) {
            AvoirFF avoirFF = datas.getAvoirFF();
            pi.getFormu().getChamp("libelle").setDefaut("Paiement avoir via facture client - " + idAvoir);
            pi.getFormu().getChamp("idplacement").setDefaut(idAvoirFF);
            pi.getFormu().getChamp("idplacement").setAutre("readonly");
            pi.getFormu().getChamp("credit").setDefaut(Utilitaire.formaterAr(avoirFF.getMontantreste()));
            pi.getFormu().getChamp("tiers").setDefaut(avoirFF.getTiers());
        }
        /*if(idfact!=null){
            pi.getFormu().getChamp("idplacement").setDefaut(null);
        }*/
        pi.setLien((String) session.getValue("lien"));
        pi.getFormu().getChamp("idtraite").setVisible(false);
        pi.getFormu().getChamp("etatversement").setVisible(false);
        pi.getFormu().getChamp("idfinaledestination").setVisible(false);
        if(idmvtcaisse!=null){
            pi.getFormu().getChamp("caisse").setDefaut(request.getParameter("idfinaledestination"));
            pi.getFormu().getChamp("idmode").setDefaut(Constante.getTraite());
            pi.getFormu().getChamp("credit").setDefaut(request.getParameter("montant"));

            Traite traite = (Traite)new Traite().getById(request.getParameter("idTraite"),"TRAITE",null);
            if(traite!=null)pi.getFormu().getChamp("tiers").setDefaut(traite.getTiers());
        }
        pi.preparerDataFormu();
%>
%>

<style>
    .checkbox {
        width: 15px;
        height: 15px;
        margin: 12px!important;
    }
</style>
<%
    Liste moisL = new Liste("mois");
    moisL.makeListeMois();

    moisL.setDefaut("" + Utilitaire.getMoisEnCoursReel());
%>
<div class="content-wrapper" style="min-height: 1200px!important">
    <h1>Saisie d'un journal caisse</h1>
    <form action="<%=pi.getLien()%>?but=apresJournalCaisse.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="treso/journalcaisse-fiche.jsp">
        <input name="classe" type="hidden" id="classe" value="mg.allosakafo.fin.MvtCaisse">
        <%if(idmvtcaisse!=null){%>
            <input name="idmvtcaisse" type="hidden" id="idmvtcaisse" value="<%=idmvtcaisse%>">
        <%}%>
        <%if(idOPs!=null){%>
            <input name="idOPs" type="hidden" id="idOPs" value="<%=idOPs%>">
        <%}%>
        <!--<input name="nomtable" type="hidden" id="nomtable" value="journalcaisse">-->
        <div>
            <div class="box">
                <div class="box-body" style="display:flex; flex-direction: column;">
                    <div style="display: flex; align-items: center;">
                        <input type="checkbox" class="checkbox" name="factureAuto" id="factureAuto" />
                        <label for="factureAuto">G&eacute;n&eacute;rer facture</label>
                    </div>
                    <div>
                        <div class="col-md-6">
                            <table class="table table-bordered">
                                <tbody>
                                    <tr>
                                        <th>
                                            <label for="compte">Compte</label>
                                        </th>
                                        <td>
                                            <input name="compte" type="textbox" class="form-control" class="" id="compte" value="" data-parsley-id="4" tabindex="1">
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            <label for="annee">Ann&eacute;e</label>
                                        </th>
                                        <td>
                                            <input name="annee" type="textbox" class="form-control" class="" id="annee" value="<%=Utilitaire.getAneeEnCours()%>" data-parsley-id="4" tabindex="1">
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="col-md-6">
                            <table class="table table-bordered">
                                <tbody>
                                    <tr>
                                        <th>
                                            <label for="tva">TVA</label>
                                        </th>
                                        <td>
                                            <input name="tva" type="textbox" class="form-control" class="" id="tva" value="20" data-parsley-id="4" tabindex="1">
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>
                                            <label for="mois">Mois</label>
                                        </th>
                                        <td>
                                            <%
                                                moisL.makeHtml();
                                                out.print(moisL.getHtml());
                                            %>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> alert('<%=e.getMessage()%>');
    alert("<%=new String(e.getMessage().getBytes(), "UTF-8")%>");
    history.back();
</script>

<% }%>