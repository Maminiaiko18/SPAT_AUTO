<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="mg.spat.stock.BonDeCommandeFille"%>
<%@page import="mg.spat.stock.BonDeLivraison"%>
<%@page import="mg.spat.stock.BonDeCommande"%>
<%@page import="service.UploadService"%>
<%@page import="mg.spat.AttacherFichier"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
    BonDeCommande dma;
    double total = 0.0;
%>
<%
    dma = new BonDeCommande();
    dma.setNomTable("AS_BONDECOMMANDE_LIBELLE_lib");
    PageConsulte pc = new PageConsulte(dma, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
    BonDeCommande base = (BonDeCommande)pc.getBase();
    pc.getChampByName("daty").setLibelle("Date");
//    pc.getChampByName("adresse").setVisible(false);
//    pc.getChampByName("remise").setVisible(false);
    pc.getChampByName("tva").setVisible(false);
    pc.getChampByName("etat").setVisible(false);
    pc.getChampByName("montantfacture").setVisible(false);
    //pc.getChampByName("nomfournisseur").setLien((String) session.getValue("lien") + "?but=travaux/tiers-fiche.jsp&id="+base.getFournisseur(), "nom=");
    //pc.getChampByName("nomfournisseur").setLibelle("Fournisseur");
    pc.getChampByName("montantremise").setLibelle("Montant remise");
    pc.getChampByName("etatlib").setLibelle("Etat");
    pc.getChampByName("modepaiement").setLibelle("Mode de paiement");
    pc.getChampByName("montant").setLibelle("montant HT");
    pc.getChampByName("montant_paye_reel").setLibelle("Montant payé réel");
    pc.getChampByName("montant_A_payer").setLibelle("Montant BL TTC");
    pc.getChampByName("restepayergeneral").setLibelle("Reste à livrer");
    pc.getChampByName("resteapayerreel").setLibelle("Reste à payer réel");
    pc.getChampByName("montantTTC").setLibelle("Montant TTC");
    pc.getChampByName("montanttva").setLibelle("Montant TVA");
    pc.getChampByName("numbc").setLibelle("Numero Bon De Commande");
    pc.getChampByName("remarque").setLibelle("Reference");
    pc.getChampByName("code_etab").setLibelle("Code etablissement");
    //pc.getChampByName("delaipaiement").setLibelle("Délai de paiement");
    //pc.getChampByName("delailivraison").setLibelle("Délai de livraison");
    //pc.getChampByName("typepaiement").setLibelle("Type paiement");

    
    pc.setTitre("Fiche Bon de commande");

    BonDeCommande bondecommande = (BonDeCommande) pc.getBase();

    /*Onglets*/
    String tab = null;
    Map<String, String> map = new HashMap<String, String>();
    map.put("details-bc", "");
    map.put("bondelivraison-liste", "");
    String id = request.getParameter("id");
    tab = request.getParameter("tab");
    if (tab == null) {
        tab = "details-bc";
    }
    map.put(tab, "active");
    tab = "inc/" + tab + ".jsp";
    
        AttacherFichier[] fichiers = UploadService.getUploadFile(request.getParameter("id"));
        configuration.CynthiaConf.load();
        String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
        String dossier = "bondecommande";
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-2"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=stock/bc/asBonDeCommande-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <a class="btn btn-info pull-right"  href="<%=(String) session.getValue("lien") + "?but=pageupload.jsp&id=" + request.getParameter("id") + "&dossier=" + dossier + "&nomtable=ATTACHER_FICHIER&procedure=GETSEQ_ATTACHER_FICHIER&bute=stock/bc/asBonDeCommande-fiche.jsp"%>" style="margin-right: 10px">Attacher Fichier</a>              
                            <% if (bondecommande.getEtat() == ConstanteEtat.getEtatCreer()) {%>
                            <a class="btn btn-danger pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&acte=annuler&bute=stock/bc/asBonDeCommande-fiche.jsp&classe=mg.spat.stock.BonDeCommande&id=" + request.getParameter("id")%>" style="margin-right: 10px">Annuler</a>
                            <a class="btn btn-warning pull-right"  href="<%=(String) session.getValue("lien") + "?but=stock/bc/asBonDeCommande-modif-multiple.jsp&id=" + request.getParameter("id")%>" style="margin-right: 10px">Modifier</a>
                            <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&bute=stock/bc/asBonDeCommande-fiche.jsp&classe=mg.spat.stock.BonDeCommande&id=" + request.getParameter("id")%>" style="margin-right: 10px">Viser</a>
                            <a class="btn btn-warning pull-right"  href="<%=(String) session.getValue("lien") + "?but=stock/bc/bonDeCommandeFille-saisie.jsp&idbc=" + request.getParameter("id")%>" style="margin-right: 10px">Ajouter détails BC</a>
                            <% }%>
                            <% if (bondecommande.getEtat() == ConstanteEtat.getEtatValider()) {%>
                            <a class="btn btn-default pull-right"  href="<%=(String) session.getValue("lien") + "?but=stock/bl/asBonDeLivraison-direct.jsp&id_bc=" + request.getParameter("id")%>" style="margin-right: 10px">Reception</a>
                            <% } %>
                            
                            <%
                                if (bondecommande.getEtat() == ConstanteEtat.getEtatLivraison()) {
                                    BonDeLivraison liv = new BonDeLivraison();
                                    String idbl = " AND idbc = '" + request.getParameter("id").trim() + "'";

                                    BonDeLivraison[] filles = (BonDeLivraison[]) CGenUtil.rechercher(liv, null, null, idbl);
                            %>
                            <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=stock/bl/bondelivraison-fiche.jsp&id=" + filles[0].getId()%>" style="margin-right: 10px">Etat de livraison</a>
                            <% } %>
                            <a class="btn btn-info pull-right"  href="${pageContext.request.contextPath}/Paie?action=boncommande&id=<%=bondecommande.getId()%>" style="margin-right: 10px">Imprimer</a>
                            <a class="btn btn-primary pull-right"  href="<%=(String) session.getValue("lien") %>?but=facture/facture-fournisseur-saisie-multiple.jsp&idBC=<%=bondecommande.getId()%>" style="margin-right: 10px">Facturer</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-10 col-md-offset-1">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs">
                    <li class="<%= map.get("details-bc")%>"><a href="globalnegoce.jsp?but=stock/bc/asBonDeCommande-fiche.jsp&id=<%=request.getParameter("id")%>&tab=details-bc&tva=<%=bondecommande.getTva()%>">Details BC</a></li>
                    <li class="<%= map.get("bondelivraison-liste")%>"><a href="globalnegoce.jsp?but=stock/bc/asBonDeCommande-fiche.jsp&id=<%=request.getParameter("id")%>&tab=bondelivraison-liste&id_bc=<%=bondecommande.getId()%>">Bon de livraison</a></li>
                </ul>

                <div class="tab-content">       
                    <jsp:include page="<%=tab%>" />  
                </div>
            </div>
        </div>
    </div>
    <div class="row">            
        <div class="col-md-10 col-md-offset-1">
            <div class="col-md-2"></div>
            <div class="col-md-8">
                <div class="box-title with-border">
                    <h2 class="box-title" style="margin-left: 10px;">Les fichiers attachés</h2>
                </div>
                <div class="box-body">
                    <table class="table table-striped table-bordered table-condensed table-responsive tree">
                        <thead>
                            <tr>
                                <th style="background-color:#bed1dd;"></th>
                                <th style="background-color:#bed1dd;">Libellé</th>
                                <th style="background-color:#bed1dd;">Fichier</th>
                                <th style="background-color:#bed1dd;">Voir</th>
                                <th style="background-color:#bed1dd;">#</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%if (fichiers == null || fichiers.length == 0) {%>
                            <tr>
                                <td colspan="3" style="text-align: center;"><strong>Aucun fichier</strong></td>
                            </tr>
                            <%} else {
                                for (AttacherFichier fichier : fichiers) {%> 
                            <tr class="treegrid-1 treegrid-expanded">
                                <td><span class="treegrid-expander glyphicon glyphicon-minus"></span></td>
                                <td><%=fichier.getChemin()%></td>
                                <td><%=Utilitaire.champNull(fichier.getLibelle())%></td>
                                <td><a href="#" class="btn btn-primary" onclick="javascript:pagePopUp('<%=cdn + dossier + "/" + fichier.getChemin()%>')">Voir</a></td>
                                <td></td>
                            </tr>
                            <%}
                                }%>


                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
</div>
<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript">
    alert('<%=e.getMessage()%>');
    history.back();
</script>
<% }%>