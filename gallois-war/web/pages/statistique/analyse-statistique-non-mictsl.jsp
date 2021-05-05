<%-- 
    Document   : analyse-statistique-non-mictsl
    Created on : 5 mai 2021, 16:19:31
    Author     : nyamp
--%>

<%@page import="mg.spat.StatistiqueActivite"%>
<%@page import="affichage.PageRechercheGroupe"%>
<%
    try {

        StatistiqueActivite lv = new StatistiqueActivite();
        lv.setNomTable("STATISTIQUEACTIVITE_NMICTSL_GR");
        String listeCrt[] = {"idtypemanipulationlib","moislib"};
        String listeInt[] = {};

        String[] pourcentage = {};
        String somDefaut[] ={"nombreunite"};
        String colDefaut[] =  {"moislib"};
        String[] colGrCol = {"idtypemanipulationlib"};
        PageRechercheGroupe pr = new PageRechercheGroupe(lv, request, listeCrt, listeInt, 3, colGrCol, somDefaut, pourcentage, colDefaut.length, 0);
        
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.getFormu().getChamp("idtypemanipulationlib").setLibelle("Type manipulation");
        pr.getFormu().getChamp("moislib").setLibelle("Mois");
        
        pr.setApres("statistique/analyse-statistique-non-mictsl.jsp");
        pr.creerObjetPageCroise(colDefaut, pr.getLien()+"?but=statistique/analyse-statistique-non-mictsl.jsp");

%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse statistique AUTRE</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=<%= pr.getApres()%>" method="post" name="formulaire" id="analyse">
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            out.println(pr.getTableau().getHtml());
        %>
    </section>
</div>

<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
