<%-- 
    Document   : analyse-statistique-mictsl
    Created on : 5 mai 2021, 15:40:35
    Author     : nyamp
--%>


<%@page import="affichage.Liste"%>
<%@page import="mg.spat.StatistiqueActivite"%>
<%@page import="affichage.PageRechercheGroupe"%>
<%
    try {

        StatistiqueActivite lv = new StatistiqueActivite();
        lv.setNomTable("STATISTIQUEACTIVITE_MICTSL_GR");
        String listeCrt[] = {"idtypeactionconteneurlib","mois","annee"};
        String listeInt[] = {"annee","mois"};

        String[] pourcentage = {};
        String somDefaut[] ={"somme_plein20_vide20_plein40"};
        String colDefaut[] =  {"idtypeactionconteneurlib"};
        String[] colGrCol = {"moislib"};
        PageRechercheGroupe pr = new PageRechercheGroupe(lv, request, listeCrt, listeInt, 3, colGrCol, somDefaut, pourcentage, colDefaut.length, 0);
        
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        
        affichage.Champ[] liste = new affichage.Champ[1];
        StatistiqueActivite stat = new StatistiqueActivite();
        stat.setNomTable("STATISTIQUEACTIVITE_MICTSL_GR");
        
        liste[0] = new Liste("idtypeactionconteneurlib", stat, "idtypeactionconteneurlib", "idtypeactionconteneur");
        
        pr.getFormu().changerEnChamp(liste);

        pr.getFormu().getChamp("annee1").setLibelle("Annee Min");
        pr.getFormu().getChamp("annee2").setLibelle("Annee Max");
        pr.getFormu().getChamp("mois1").setLibelle("Mois Min");
        pr.getFormu().getChamp("mois2").setLibelle("Mois Max");
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