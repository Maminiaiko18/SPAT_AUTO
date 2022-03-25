<%-- 
    Document   : listeProjetChoix
    Created on : 29 déc. 2020, 09:20:16
    Author     : ACER
--%>

<%@page import="mg.spat.DemandeAchatMere"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    String champReturn = request.getParameter("champReturn");
    DemandeAchatMere demandeMere = new DemandeAchatMere();
    demandeMere.setNomTable("dem_achat_merelib");

    String listeCrt[] = {"id","num", "designation","codeetablissementlib","projetlib","idengagementlib","daty"};
    String listeInt[] = {"daty"};
    String libEntete[] = {"id","num","designation","codeetablissementlib","projetlib","idengagementlib","daty"};
    
    PageRechercheChoix pr = new PageRechercheChoix(demandeMere, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("listeDAchoix.jsp");
    pr.getFormu().getChamp("daty1").setLibelle("Date Min");
    pr.getFormu().getChamp("daty2").setLibelle("Date Max");
    pr.getFormu().getChamp("projetlib").setLibelle("Projet");
    pr.getFormu().getChamp("codeetablissementlib").setLibelle("Code etablissemment");
    pr.getFormu().getChamp("designation").setLibelle("Designation");
    pr.getFormu().getChamp("idengagementlib").setLibelle("Engagement");
    pr.getFormu().getChamp("num").setLibelle("No.");
    
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
                <h1>Choix d'une demande d'achat</h1>
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
                        String libEnteteAffiche[] ={"Id", "No.", "Désignation", "Code établissement","Projet","Engagement","Date"};
                        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                        out.println(pr.getTableau().getHtmlWithRadioButton()); %>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>
