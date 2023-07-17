

<%@page import="facture.FactureFournisseur"%>
<%@page import="facture.LiaisonEngagement"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
    LiaisonEngagement a = new LiaisonEngagement();
    PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    //Modification des affichages
    if(request.getParameter("id1")!=null){
        pi.getFormu().getChamp("id1").setDefaut(request.getParameter("id1"));
        FactureFournisseur engagement=new FactureFournisseur();
        engagement.setNomTable("FFengagementpopup");
        engagement.setId(request.getParameter("id1"));
        FactureFournisseur factureFournisseur=(FactureFournisseur)engagement.getById(request.getParameter("id1"),"FFengagementpopup",null);
        pi.getFormu().getChamp("id2").setDefaut(factureFournisseur.getIdengaggrp());
    }
    pi.getFormu().getChamp("id1").setLibelle("Facture");
    pi.getFormu().getChamp("id2").setLibelle("Engagements");
    pi.getFormu().getChamp("id1").setPageAppel("choix/listeFFEngagementChoix.jsp","id1;id1libelle");
    pi.getFormu().getChamp("id1").setAutre("readonly");    
    pi.getFormu().getChamp("id2").setAutre("readonly");
    pi.getFormu().getChamp("montant").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);

    //Variables de navigation
    String classe = ".facture.LiaisonEngagement";
    String butApresPost = "recherche/template-recherche-simple";
    String nomTable = "liaisonengagement";
    //Generer les affichages
    pi.preparerDataFormu();
    pi.getFormu().makeHtmlInsertTabIndex();
%>
<div class="content-wrapper">
    <h1 align="center">Liberation engagement facture</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post"  data-parsley-validate>
        <%
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="<%= butApresPost %>">
        <input name="classe" type="hidden" id="classe" value="<%= classe %>">
        <input name="nomtable" type="hidden" id="nomtable" value="<%= nomTable %>">
    </form>
</div>
<%
} catch (Exception e) {
    e.printStackTrace();
} %>

