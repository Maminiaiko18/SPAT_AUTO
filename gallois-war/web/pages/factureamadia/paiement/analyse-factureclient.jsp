<%@page import="mg.spat.FactureAnalyse2"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<%
    FactureAnalyse2 factureClient = new FactureAnalyse2();
    factureClient.setNomTable("VIEW_FACTURECLIENT_2");
    String listeCrt[] = {"id", "tiers", "typee","daty"};    
    String listeInt[] = {"daty"};
    String[] pourcentage = {"nombrepargroupe"};
    String colDefaut[] = {"id", "tiers", "designation", "typee", "devise", "compte", "remarque", "daty"};
    String somDefaut[] = {"montant", "montanttva", "coursdevise", "tva"};
    PageRechercheGroupe pr = new PageRechercheGroupe(factureClient, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, 6, 0);
    pr.getFormu().getChamp("daty1").setLibelle("Date amende Min");
    pr.getFormu().getChamp("daty2").setLibelle("Date amende Max");
    
    affichage.Champ[] liste = new affichage.Champ[1];
    
    TypeObjet tfc = new TypeObjet();
    tfc.setNomTable("type_facture_client");
    liste[0] = new Liste("typee", tfc, "val", "val");
    
    pr.getFormu().changerEnChamp(liste);
   
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("factureamadia/paiement/analyse-factureclient.jsp");
    pr.creerObjetPagePourc();
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse facture client</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=factureamadia/paiement/analyse-factureclient.jsp" method="post" name="analyse" id="analyse">
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
        </form>
        <%out.println(pr.getTableauRecap().getHtml()); %><br>
        <%
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>