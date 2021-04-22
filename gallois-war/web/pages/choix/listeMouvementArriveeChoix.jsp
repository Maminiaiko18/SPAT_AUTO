<%-- 
    Document   : listeMouvementArriveeChoix
    Created on : 8 déc. 2020, 10:56:10
    Author     : Finaritra
--%>

<%@page import="mg.spat.MouvementLibComplet"%>
<%@page import="affichage.PageRechercheChoix"%>
<%
    String champReturn = request.getParameter("champReturn");
    MouvementLibComplet mvt = new MouvementLibComplet();
    mvt.setNomTable("MOUVEMENT_ARRIVEE");
    String listeCrt[] = {"id","daty","nomnavire","heure"};
    String listeInt[] = {};
    String libEntete[] = {"id","daty","nomnavire","desceconsignataire","heure","valpaysprovenance","valpaysdestination","valquaisdestination"};
    PageRechercheChoix pr = new PageRechercheChoix(mvt, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setOrdre(" order by daty desc");
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("listeMouvementArriveeChoix.jsp");
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
                <h1>Choix Mouvements arrivées</h1>
            </section>
            <section class="content">
                <form action="<%=pr.getApres()%>?champReturn=<%=pr.getChampReturn()%>" method="post" name="arriveeliste" id="arriveeliste">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <%
                    out.println(pr.getTableauRecap().getHtml());
                %>
                <form action="../<%=pr.getLien()%>?but=choix/apresChoix.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                    <% 
                       String libEnteteAff[] = {"id","Date","Navire","Consignataire","Heure","Provenance","Destination","Quai destination"};
                       pr.getTableau().setLibeEntete(libEnteteAff);
                        out.println(pr.getTableau().getHtmlWithRadioButton()); %>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>

