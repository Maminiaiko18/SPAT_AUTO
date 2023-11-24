<%-- 
    Document   : listeChantierChoix
    Created on : 29 janv. 2020, 12:10:35
    Author     : rajao
--%>
<%@page import="mg.spat.Chantier"%>
<%@page import="mg.spat.Client"%>
<%@ page import="user.*" %>
<%@page import="mg.spat.Contrat"%>
<%@page import="mg.spat.*"%>

<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try {
        String champReturn = request.getParameter("champReturn");
        Contrat navire = new Contrat();
        navire.setNomTable("CONTRATLIBELLE");
        String listeCrt[] = {"id","idtiers","date_signature","objet","debut_contrat","fin_contrat","duree","unite"};
        String listeInt[] = {};
        String libEntete[] = {"id","idtiers","date_signature","objet","debut_contrat","fin_contrat","duree","unite"};
      
        PageRechercheChoix pr = new PageRechercheChoix(navire, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("listeChantierChoix.jsp");
        pr.setChampReturn(champReturn);
        String[] colSomme = null;
//        pr.getFormu().getChamp("idtravaux").setLibelle("Travaux");
//        pr.getFormu().getChamp("idtiers").setLibelle("Tiers");
//        pr.getFormu().getChamp("avancement").setVisible(false);
//        pr.getFormu().getChamp("datydebut1").setLibelle("Date debut minimale");
//        pr.getFormu().getChamp("datydebut2").setLibelle("Date debut maximale");
//        pr.getFormu().getChamp("datyfin1").setLibelle("Date fin minimale");
//        pr.getFormu().getChamp("datyfin2").setLibelle("Date fin maxinale");

        pr.creerObjetPage(libEntete, colSomme);
%>
<html>
    <head>
        <meta charset="UTF-8">
        <title>SPAT</title>
        <!-- Tell the browser to be responsive to screen width -->
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <jsp:include page='../elements/css.jsp'/>
    </head>
    <body class="skin-blue sidebar-mini">
        <div class="wrapper">
            <section class="content-header">
                <h1>Choix chantier</h1>
            </section>
            <section class="content">
                <form action="<%=pr.getApres()%>?champReturn=<%=pr.getChampReturn()%>" method="post" name="personneliste" id="personneliste">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <%
                    out.println(pr.getTableauRecap().getHtml());
                %>
                <form action="../<%=pr.getLien()%>?but=choix/apresChoix.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">

                    <%
                        String libEnteteAffiche[] = {"id","idtiers","date_signature","objet","debut_contrat","fin_contrat","duree","unite"};
                    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                        out.println(pr.getTableau().getHtmlWithRadioButton());
                    %>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>
<% } catch (Exception e) {
        e.printStackTrace();
    }%>
