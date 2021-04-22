<%-- 
    Document   : service
    Created on : 28 nov. 2016, 12:43:39
    Author     : Jetta
--%>

<%@page import="affichage.PageRechercheChoix"%>
<%@page import="mg.cnaps.log.LogService"%> 
<%

    LogService e = new LogService();
    e.setNomTable("LOG_SERVICE_LIBELLE");//si_dossiers_travailleurs_lib
    String champReturn = request.getParameter("champReturn");
    String listeCrt[] = {"id", "libelle", "code_dr", "dr_rattache"};
    String listeInt[] = {""};
    String libEntete[] = {"id", "libelle", "code_dr", "dr_rattache"};
    PageRechercheChoix pr = new PageRechercheChoix(e, request, listeCrt, listeInt, 3, libEntete, 4);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("service.jsp");
    pr.setChampReturn(champReturn);
    pr.getFormu().getChamp("id").setLibelleAffiche("ID");
    pr.getFormu().getChamp("code_dr").setLibelleAffiche("Dr");
    pr.getFormu().getChamp("dr_rattache").setLibelleAffiche("Dr Rattache");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Cynthia 2.0 | CNaPS</title>
        <!-- Tell the browser to be responsive to screen width -->
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <jsp:include page='../elements/css.jsp'/>
    </head>
    <body class="skin-blue sidebar-mini">
        <div class="wrapper">
            <section class="content-header">
                <h1>Liste services</h1>
            </section>
            <section class="content">
                <form action="service.jsp?champReturn=<%=pr.getChampReturn()%>" method="post" name="chauffeur" id="chauffeur">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <%

                    String libelles[] = {"ID", "Libelle", "Direction regionale", "DR rattache"};
                    pr.getTableau().setLibelleAffiche(libelles);
                    out.println(pr.getTableauRecap().getHtml());
                %>
                <form action="../<%=pr.getLien()%>?but=choixMultiple/apresChoixMultiple.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                    <% out.println(pr.getTableau().getHtmlWithMultipleCheckbox());%>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>