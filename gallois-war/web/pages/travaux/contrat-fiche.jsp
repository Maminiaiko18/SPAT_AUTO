<%-- 
    Document   : contrat-fiche.jsp
    Created on : 17 déc. 2020, 14:24:07
    Author     : nyamp
--%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="mg.spat.compta.ContratChantierLibComplet"%>
<%@page import="mg.spat.AttacherFichier"%>
<%@page import="service.UploadService"%>
<%@page import="mg.spat.compta.Contrat"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try {
        ContratChantierLibComplet contrat = new ContratChantierLibComplet();
        contrat.setNomTable("contrat_chantier_CplSum");
        PageConsulte pc = new PageConsulte(contrat, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
        contrat = (ContratChantierLibComplet) pc.getBase();
        pc.setTitre("Fiche Contrat");

        pc.getChampByName("prestataire").setVisible(false);
        pc.getChampByName("idchantier").setVisible(false);
        pc.getChampByName("code_etab").setVisible(false);
        pc.getChampByName("chantierlib").setLibelle("Chantier");
        pc.getChampByName("prestatairelib").setLibelle("Prestataire");
        pc.getChampByName("nocontrat").setLibelle("Numero contrat");
        pc.getChampByName("tva").setLibelle("TVA");
        pc.getChampByName("projetlib").setLibelle("Projet");
        pc.getChampByName("code_etablib").setLibelle("Code Etablissement");
        pc.getChampByName("montant_paye").setLibelle("Montant payé ");
        pc.getChampByName("resteapaye").setLibelle("Reste à payer");
        pc.getChampByName("chantierlib").setLien((String) session.getValue("lien") + "?but=travaux/chantier-fiche.jsp&id=" + contrat.getIdchantier(), "nom");
        pc.getChampByName("prestatairelib").setLien((String) session.getValue("lien") + "?but=travaux/tiers-fiche.jsp&id=" + contrat.getPrestataire(), "nom");
        pc.getChampByName("code_etablib").setLien((String) session.getValue("lien") + "?but=fin/code-etablissement-fiche.jsp&id=" + contrat.getCode_etab(), "nom");

        AttacherFichier[] fichiers = UploadService.getUploadFile(request.getParameter("id"));
        configuration.CynthiaConf.load();
        String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
        String dossier = "contrat";


        /*Onglets*/
        String tab = null;
        Map<String, String> map = new HashMap<String, String>();
        map.put("facture-fournisseur-liste", "");
        map.put("historique-contrat", "");
        map.put("avancement-contrat", "");

        String id = request.getParameter("id");
        tab = request.getParameter("tab");
        if (tab == null) {
            //tab = "facture-fournisseur-liste&recap=checked";
            tab = "facture-fournisseur-liste";
        }
        map.put(tab, "active");
        tab = "inc/" + tab + ".jsp";
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=compta/contrat/contrat-fiche.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <a class="btn btn-primary pull-left"  href="<%=(String) session.getValue("lien") + "?but=travaux/avenant-saisie.jsp&idcontrat="+contrat.getId()+"&nomcontrat="+contrat.getDesignation()%>" style="margin-right: 10px">Saisir avenant</a>
                            <a class="btn btn-info pull-left"  href="<%=(String) session.getValue("lien") + "?but=pageupload.jsp&id=" + contrat.getId() + "&dossier=" + dossier + "&nomtable=ATTACHER_FICHIER&procedure=GETSEQ_ATTACHER_FICHIER&bute=compta/contrat/contrat-fiche.jsp"%>" style="margin-right: 10px">Attacher Fichier</a> 
                            <a class="btn btn-warning pull-left"  href="<%=(String) session.getValue("lien") + "?but=travaux/contrat-modif.jsp&id=" + contrat.getId()%>" style="margin-right: 10px">Modifier</a> 
                            <a class="btn btn-primary pull-left"  href="<%=(String) session.getValue("lien") + "?but=travaux/avancement-contrat-saisie.jsp&idcontrat="+ contrat.getId() %>" style="margin-right: 10px">Pourcentage de réalisation</a> 
                            <a class="btn btn-success pull-right"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&id=" + contrat.getId()%>&acte=valider&bute=travaux/contrat-fiche.jsp&id=<%=contrat.getId()%>&classe=mg.spat.compta.ContratChantier" style="margin-right: 10px">Viser</a>            
                        </div>
                        <br/>

                    </div>
                </div>
            </div>
        </div>
    </div>       
    <div class="row" style="margin:0;">
        <div class="col-md-12">       

            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs">
                    <li class="<%= map.get("facture-fournisseur-liste")%>"><a href="globalnegoce.jsp?but=travaux/contrat-fiche.jsp&id=<%=request.getParameter("id")%>&tab=facture-fournisseur-liste&recap=checked&remarque=<%=contrat.getId()%>">Facture fournisseur</a></li>
                    <li class="<%= map.get("historique-contrat")%>"><a href="globalnegoce.jsp?but=travaux/contrat-fiche.jsp&id=<%=request.getParameter("id")%>&tab=historique-contrat&id=<%= contrat.getId()%>">Avenants</a></li>
                    <li class="<%= map.get("avancement-contrat")%>"><a href="globalnegoce.jsp?but=travaux/contrat-fiche.jsp&id=<%=request.getParameter("id")%>&tab=avancement-contrat&id=<%= contrat.getId()%>">Avancement</a></li>
                </ul>
                <div class="tab-content">       
                    <jsp:include page="<%=tab%>">
                        <jsp:param name="remarque" value="<%=contrat.getId()%>" />
                    </jsp:include>
                </div>
            </div>           

        </div>  
    </div>
    <div class="row">
        <div class="col-md-12">
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
<script language="JavaScript"> alert('<%=e.getMessage()%>');
    history.back();</script>
    <% }%>
