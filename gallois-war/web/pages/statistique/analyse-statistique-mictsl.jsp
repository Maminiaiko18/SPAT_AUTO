<%-- 
    Document   : analyse-statistique-mictsl
    Created on : 5 mai 2021, 15:40:35
    Author     : nyamp
--%>


<%@page import="mg.spat.StatistiqueActivite"%>
<%@page import="affichage.PageRechercheGroupe"%>
<%
    try {

        StatistiqueActivite lv = new StatistiqueActivite();
        lv.setNomTable("STATISTIQUEACTIVITE_MICTSL_GR");
        String listeCrt[] = {"idtypeactionconteneurlib","moislib","annee"};
        String listeInt[] = {"annee"};

        String[] pourcentage = {};
        String somDefaut[] ={"somme_plein20_vide20_plein40"};
        String colDefaut[] =  {"moislib"};
        String[] colGrCol = {"idtypeactionconteneurlib"};
        PageRechercheGroupe pr = new PageRechercheGroupe(lv, request, listeCrt, listeInt, 3, colGrCol, somDefaut, pourcentage, colDefaut.length, 0);
        
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.getFormu().getChamp("annee1").setLibelle("Annee Min");
        pr.getFormu().getChamp("annee2").setLibelle("Annee Max");
        pr.getFormu().getChamp("moislib").setLibelle("Mois");
        pr.getFormu().getChamp("idtypeactionconteneurlib").setLibelle("Type action");
        
        pr.setApres("statistique/analyse-statistique-mictsl.jsp");
        pr.creerObjetPageCroise(colDefaut, pr.getLien()+"?but=statistique/analyse-statistique-mictsl.jsp");

%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse statistique MICTSL</h1>
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