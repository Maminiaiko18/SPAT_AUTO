<%-- 
    Document   : regularisation-fiche
    Created on : 15 janv. 2021, 23:41:49
    Author     : Sanda
--%>

<%@ page import="affichage.PageConsulte" %>
<%@ page import="facturefournisseur.RegulFacture" %>
<%
    String lien = (String) session.getValue("lien"),
           titre = "Regularisation Fiche",
           mapping = "facturefournisseur.RegulFacture",
           apres = "facture/regularisation-fiche.jsp";
    try {
        RegulFacture objet = new RegulFacture();
        PageConsulte pc = new PageConsulte(objet, request, (user.UserEJB) session.getValue("u"));

        pc.getChampByName("idfacture").setLien(lien + "?but=facture/facture-fournisseur-fiche.jsp", "id=");
        pc.getChampByName("idbon").setLien(lien + "?but=treso/bon-provisoire-fiche.jsp", "id=");
        
        pc.getChampByName("idfacture").setLibelle("Facture");
        pc.getChampByName("idbon").setLibelle("Bon provisoire");

        pc.setTitre(titre);
        
        objet = (RegulFacture) pc.getBase();
%>

<style>
    .col-md-center .box-fiche{
        min-width:100%;
    }
</style>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <div class="box" id="fiche">
                <div class="box-title with-border">
                    <h1 class="box-title"><%=pc.getTitre()%></h1>
                </div>
                <div class="box-body">
                    <%out.println(pc.getHtml());%>
                </div>
                
                <div class="box-footer">
                    <a class="btn btn-success"  href="<%=lien + "?but=apresTarif.jsp&acte=valider&classe="+mapping+"&bute="+apres+"&id=" + objet.getId() %>"  style="margin-right: 10px">Viser</a>
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
    history.back();</script>
<% }%>
