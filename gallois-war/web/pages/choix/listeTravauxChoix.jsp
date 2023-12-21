<%-- 
    Document   : listeTravauxChoix
    Created on : 4 déc. 2019, 09:51:03
    Author     : rajao
--%>
<%@page import="mg.spat.Travaux"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    String champReturn = request.getParameter("champReturn");
    Travaux travaux = new Travaux();
    travaux.setNomTable("travauxlib");
    String listeCrt[] = {"id","nom","description","datedebut","datefin","avancement"};
    String listeInt[] = {"datedebut","datefin","avancement"};
    String libEntete[] = {"id","nom","description","datedebut","datefin","montant","avancement"};
    PageRechercheChoix pr = new PageRechercheChoix(travaux, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("listeTravauxChoix.jsp");
    pr.getFormu().getChamp("datedebut1").setLibelle("Date Debut min");
    pr.getFormu().getChamp("datedebut2").setLibelle("Date Debut max");
    pr.getFormu().getChamp("datefin1").setLibelle("Date Fin min");
    pr.getFormu().getChamp("datefin2").setLibelle("Date Fin max");
    pr.getFormu().getChamp("avancement1").setLibelle("Avancement min");
    pr.getFormu().getChamp("avancement2").setLibelle("Avancement max");
    
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
                <h1>Choix Travaux</h1>
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
                        String libEnteteAffiche[] = {"id","nom","description","Date de d&eacute;but","Date fin","montant","avancement"};
                        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                        out.println(pr.getTableau().getHtmlWithRadioButton()); %>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>
