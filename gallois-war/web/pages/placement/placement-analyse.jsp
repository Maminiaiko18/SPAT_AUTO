<%-- 
    Document   : placement-analyse
    Created on : 3 mai 2022, 15:42:25
    Author     : macos
--%>

<%@page import="mg.spat.placement.Placement"%>
<%@ page import="user.*" %>
<%@page import="affichage.Liste"%>
<%@ page import="bean.*" %>
<%@page import="bean.TypeObjet"%>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try {

        Placement journal = new Placement();
        journal.setNomTable("placement_analyse");

        String listeCrt[] = {"entite", "banque", "moisPlacement", "anneePlacement"};
        String listeInt[] = {"moisPlacement", "anneeplacement"};

        String[] pourcentage = {};
        String somDefaut[] = {"montant", "montant_terme", "interet_recevoir"};
        String colDefaut[] = {"entite", "banque", "moisPlacement", "anneePlacement"};

        PageRechercheGroupe pr = new PageRechercheGroupe(journal, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, colDefaut.length, 3);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.getFormu().getChamp("entite").setLibelle("Entite");
        pr.getFormu().getChamp("banque").setLibelle("Banque");
        pr.getFormu().getChamp("moisPlacement1").setLibelle("Mois de Placement min");
        pr.getFormu().getChamp("moisPlacement2").setLibelle("Mois de Placement max");

        pr.getFormu().getChamp("anneePlacement1").setLibelle("Annee de Placement min");
        pr.getFormu().getChamp("anneePlacement2").setLibelle("Annee de Placement max");


        pr.setApres("placement/placement-analyse.jsp");
        pr.creerObjetPagePourc();

%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse placement</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=placement/placement-analyse.jsp" method="post" name="analyse" id="analyse">
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
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