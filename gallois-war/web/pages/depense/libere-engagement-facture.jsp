

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
    if(request.getParameter("id2")!=null){
        pi.getFormu().getChamp("id2").setDefaut(request.getParameter("id2"));
        FactureFournisseur engagement=new FactureFournisseur();
        engagement.setNomTable("FFengagementpopup");
        engagement.setId(request.getParameter("id2"));
        FactureFournisseur factureFournisseur=(FactureFournisseur)engagement.getById(request.getParameter("id2"),"FFengagementpopup",null);
        pi.getFormu().getChamp("id1").setDefaut(factureFournisseur.getIdengaggrp());
    }
    pi.getFormu().getChamp("id2").setLibelle("Facture");
    pi.getFormu().getChamp("id1").setLibelle("Engagements");
    pi.getFormu().getChamp("id2").setPageAppel("choix/listeFFEngagementChoix.jsp","id2;id2libelle;id2;id1");
    pi.getFormu().getChamp("id2").setAutre("readonly");    
    pi.getFormu().getChamp("id1").setAutre("readonly");
    pi.getFormu().getChamp("etat").setVisible(false);

    //Variables de navigation
    String classe = ".facture.LiaisonEngagement";
    String butApresPost = "facture/facture-fournisseur-fiche-vaovao.jsp";
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
        <input name="acte" type="hidden" id="nature" value="libererEngagementFF">
        <input name="bute" type="hidden" id="bute" value="<%= butApresPost %>">
        <input name="classe" type="hidden" id="classe" value="<%= classe %>">
        <input name="nomtable" type="hidden" id="nomtable" value="<%= nomTable %>">
    </form>
</div>
<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript">
    alert('<%=e.getMessage()%>');
    history.back();</script>
<% }%>

