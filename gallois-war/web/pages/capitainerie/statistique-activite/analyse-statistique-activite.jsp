<%-- 
    Document   : analyse-journal-de-caisse
    Created on : 2 d�c. 2019, 08:22:05
    Author     : Antsa
--%>

<%@page import="mg.spat.StatistiqueActivite"%>
<%@ page import="user.*" %>
<%@page import="affichage.Liste"%>
<%@ page import="bean.*" %>
<%@page import="bean.TypeObjet"%>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try {
        String mois = utilitaire.Utilitaire.getMoisEnCoursReel() + "";
        String an = utilitaire.Utilitaire.getAnneeEnCours();
        String[] fin = utilitaire.Utilitaire.getBorneDatyMoisAnnee(mois, an);

        StatistiqueActivite stat = new StatistiqueActivite();
        stat.setNomTable("STAT_ACTIVITE_LIB_analyse");
        String listeCrt[] = {"id", "idclient", "rubrique", "daty"};
        String listeInt[] = {"daty"};
        String[] pourcentage = {""};
        String colDefaut[] = {"id", "idclient", "rubrique", "daty"};
        String somDefaut[] = {"cumul"};

        PageRechercheGroupe pr = new PageRechercheGroupe(stat, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, 4, 2);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.getFormu().getChamp("daty1").setDefaut(fin[0]);
        pr.getFormu().getChamp("daty2").setDefaut(fin[1]);

        pr.getFormu().getChamp("daty1").setLibelle("Date debut");
        pr.getFormu().getChamp("daty2").setLibelle("Date fin");
        pr.getFormu().getChamp("idclient").setLibelle("Client");
        pr.setApres("statistique-activite/analyse-statistique-activite.jsp");
        pr.creerObjetPage();
%>
<script>
    function changerDesignation() {
        document.analyse.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse statistique activit&eacute;</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>" method="get" name="analyse" id="analyse">
            <input type="hidden" name="but" value="capitainerie/statistique-activite/analyse-statistique-activite.jsp" />
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id", "Client", "Rubrique", "Date", "Cumul"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            String lienTableau[] = {pr.getLien() + "?but=capitainerie/statistique-activite/details-analyse-statistique-activiteCumul.jsp"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(somDefaut);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
            out.println(pr.getInsertLienModal());
        %>
    </section>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>