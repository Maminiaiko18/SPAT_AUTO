<%-- 
    Document   : listeClientDBspatChoix
    Created on : 31 oct. 2022, 08:19:46
    Author     : NAEPHA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="mg.spat.Client"%>
<%@ page import="user.*" %>
<%@page import="mg.spat.Navire"%>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    String champReturn = request.getParameter("champReturn");
    Client clt = new Client();
    clt.setNomTable("client");

    String listeCrt[] = {"cdclt", "nomclt", "adrclt", "nmsttclt", "telclt", "faxclt", "nmcin","nif","rc"};
    String listeInt[] = {};
    String libEntete[] = {"cdclt", "nomclt", "adrclt", "nmsttclt", "telclt", "faxclt", "nmcin", "nif", "rc"};
    String libelleAffiche[] = {"cdclt", "nomclt", "adrclt", "nmsttclt", "telclt", "faxclt", "nmcin", "nif", "rc"};
    
    PageRechercheChoix pr = new PageRechercheChoix(clt, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("listeClientDBspatChoix.jsp");
    
    pr.getFormu().getChamp("cdclt").setLibelle("ID");
    pr.getFormu().getChamp("nomclt").setLibelle("Nom");
    pr.getFormu().getChamp("adrclt").setLibelle("Adresse");
    pr.getFormu().getChamp("nmsttclt").setLibelle("STAT");
    pr.getFormu().getChamp("telclt").setLibelle("Telphone");
    pr.getFormu().getChamp("faxclt").setLibelle("FAX");
    pr.getFormu().getChamp("nmcin").setLibelle("CIN");
    pr.getFormu().getChamp("nif").setLibelle("NIF");
    pr.getFormu().getChamp("rc").setLibelle("RC");

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
                <h1>Choix Client</h1>
            </section>
            <section class="content">
                <form action="<%=pr.getApres()%>?champReturn=<%=pr.getChampReturn()%>" method="post" name="personneliste" id="personneliste">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <%
                    pr.getTableau().setLibelleAffiche(libelleAffiche);
                    out.println(pr.getTableauRecap().getHtml());
                %>
                <form action="../<%=pr.getLien()%>?but=choix/apresChoix.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                    <% out.println(pr.getTableau().getHtmlWithRadioButton()); %>O
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>

