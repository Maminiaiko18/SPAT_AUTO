<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="mg.cnaps.formation.AnalyseOffreFormation" %>
<%@ page import="affichage.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<%
    try {

        AnalyseOffreFormation offre = new AnalyseOffreFormation();
        String listeCrt[] = {"service", "categorie", "formation_type", "date_debut", "date_fin", "cout_offre"};
        String listeInt[] = {"date_debut", "date_fin", "cout_offre"};
        String[] pourcentage = {"nombrepargroupe"};
        String colDefaut[] = {"service", "categorie", "formation_type", "date_debut", "date_fin"};
        String somDefaut[] = {"cout_offre"};
        PageRechercheGroupe pr = new PageRechercheGroupe(offre, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, 6, 1);

        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.getFormu().getChamp("service").setLibelle("Service");
        pr.getFormu().getChamp("categorie").setLibelle("Cat&eacute;gorie");
        pr.getFormu().getChamp("formation_type").setLibelle("Formation type");
        pr.getFormu().getChamp("date_debut1").setLibelle("Date d&eacute;but min");
        pr.getFormu().getChamp("date_debut2").setLibelle("Date d&eacute;but max");
        pr.getFormu().getChamp("date_fin1").setLibelle("Date fin min");
        pr.getFormu().getChamp("date_fin2").setLibelle("Date fin max");
        pr.getFormu().getChamp("cout_offre1").setLibelle("Cout offre min");
        pr.getFormu().getChamp("cout_offre2").setLibelle("Cout offre max");
        pr.setApres("formation/offre-analyse.jsp");
        pr.creerObjetPagePourc();
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=formation/offre-analyse.jsp" method="post" name="analyse" id="analyse">
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());
        %>
        <br>
        <%
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>

<%
    } catch (Exception e) {
        e.printStackTrace();
    }

%>