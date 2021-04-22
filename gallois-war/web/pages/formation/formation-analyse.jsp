
<%@page import="mg.cnaps.formation.AnalyseDemandeFormation"%>
<%@ page import="user.*" %>
<%@page import="affichage.Liste"%>
<%@ page import="bean.*" %>
<%@page import="bean.TypeObjet"%>
<%@ page import="utilitaire.*" %>

<%@ page import="affichage.*" %>
<%@page import="lc.Direction"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<%
    try {
        AnalyseDemandeFormation formation = new AnalyseDemandeFormation();
        formation.setNomTable("analyse_formation");

        String listeCrt[] = {"domaine", "service", "date_debut", "date_fin", "lieu", "cout"};
        String listeInt[] = {"date_debut", "date_fin", "cout"};
        String[] pourcentage = {""};
        String colDefaut[] = {"domaine", "service", "date_debut", "date_fin", "lieu"};
        String somDefaut[] = {"cout"};

        PageRechercheGroupe pr = new PageRechercheGroupe(formation, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, 18, 2);
        pr.getFormu().getChamp("date_debut1").setLibelle("Date d&eacute;but min");
        pr.getFormu().getChamp("date_debut2").setLibelle("Date d&eacute;but max");
        pr.getFormu().getChamp("date_fin1").setLibelle("Date fin min");
        pr.getFormu().getChamp("date_fin2").setLibelle("Date fin max");
        pr.getFormu().getChamp("cout1").setLibelle("Co&ucirc;t min");
        pr.getFormu().getChamp("cout2").setLibelle("Co&ucirc;t max");
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.setApres("formation/formation-analyse.jsp");
        pr.creerObjetPage();
%>
<script>
    function changerDesignation() {
        document.analyse.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse formation</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>" method="get" name="analyse" id="analyse">
            <input type="hidden" name="but" value="formation/formation-analyse.jsp" />
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
            <div class="row col-md-12">  
                <div class="col-md-4"></div>
            </div>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Domaine", "Service", "Date début", "Date fin", "Lieu", "Somme"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
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
