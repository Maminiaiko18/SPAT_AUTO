<%-- 
    Document   : listeProjetChoix
    Created on : 29 déc. 2020, 09:20:16
    Author     : ACER
--%>

<%@ page import="user.*" %>
<%@page import="projet.*"%>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    String champReturn = request.getParameter("champReturn");
    Projet projet = new Projet();
    String listeCrt[] = {"id", "projet","designation"};
    String listeInt[] = {};
    String libEntete[] = {"id","projet", "designation"};
    PageRechercheChoix pr = new PageRechercheChoix(projet, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("listeProjetChoix.jsp");
    pr.getFormu().getChamp("designation").setLibelle("Code");
    pr.getFormu().getChamp("projet").setLibelle("Désignation");
    
    pr.setChampReturn(champReturn);
    String[] colSomme = null;
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
                <h1>Choix Projet</h1>
            </section>
            <section class="content">
                 <form action="<%=pr.getApres()%>?champReturn=<%=pr.getChampReturn()%>" method="post" name="personneliste" id="personneliste">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <a  class="btn btn-success" style="margin: 0 47.5%;" href="<%="/spat/pages/globalnegoce.jsp?but=budget/projet-saisie.jsp"%>"> Nouveau </a>
                <br><br>
                <%
                    out.println(pr.getTableauRecap().getHtml());
                %>
                <form action="../<%=pr.getLien()%>?but=choix/apresChoix.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                    
                    <% 
                        String libEnteteAffiche[] = {"id", "Désignation", "Code"};
                        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                        out.println(pr.getTableau().getHtmlWithRadioButton()); %>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>
