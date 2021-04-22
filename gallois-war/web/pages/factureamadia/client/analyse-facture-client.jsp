<%@page import="factureclient.PayementFacture"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<%
    try {
    PayementFacture factureClient = new PayementFacture();
    factureClient.setNomTable("PAIEMENTFACTURECLIENT");
    
    String listeCrt[] = {"id", "daty", "tiers", "designation", "typee", "remarque"};
    String listeInt[] = {"daty"};
    String[] pourcentage = {"nombrepargroupe"};
    String colDefaut[] = {"id", "daty", "tiers", "designation", "remarque"};
    String somDefaut[] = {"montant", "montanttotal", "montantpayer", "resteapayer"};
    PageRechercheGroupe pr = new PageRechercheGroupe(factureClient, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, 6, 0);
    pr.getFormu().getChamp("daty1").setLibelle("Date Min");
    pr.getFormu().getChamp("daty2").setLibelle("Date Max");
    
   
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("factureamadia/client/analyse-facture-client.jsp");
    pr.creerObjetPagePourc();
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse facture client</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=factureamadia/client/analyse-facture-client.jsp" method="post" name="analyse" id="analyse">
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
        </form>
        <%out.println(pr.getTableauRecap().getHtml()); %><br>
        <%
            String libEnteteAffiche[] = {"Id", "Date facture", "Client", "Designation","Reference facture","HT", "TOTAL","Payer","RAP", "Nb par groupe"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
<%} catch(Exception e){
    e.printStackTrace();
    throw e;
}%>