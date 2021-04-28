<%-- 
    Document   : listeBordereauFFchoix
    Created on : 28 avr. 2021, 14:32:08
    Author     : Andriamiary
--%>

<%@ page import="user.*" %>
<%@ page import="mg.spat.PosteDestinataireLibComplet"%>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="bordereau.*" %>

<%
    String champReturn = request.getParameter("champReturn");
    Bordereau posteDestinataire = new Bordereau();
    posteDestinataire.setNomTable("BORDEREAU");
    String listeCrt[] = {"id", "numero", "designation", "tiers"};
    String listeInt[] = {};
    String libEntete[] = {"id", "numero", "designation", "tiers","daty"};
    PageRechercheChoix pr = new PageRechercheChoix(posteDestinataire, request, listeCrt, listeInt, 3, libEntete,libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("listeBordereauFFchoix.jsp");
    pr.getFormu().getChamp("numero").setLibelle("Numero");
    pr.getFormu().getChamp("designation").setLibelle("Designation");
    pr.getFormu().getChamp("tiers").setLibelle("Tiers");
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
                <h1>Bordereau</h1>
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
                        String libEnteteAffiche[] =  {"ID", "Numero", "Designation", "Tiers","Date"};
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
