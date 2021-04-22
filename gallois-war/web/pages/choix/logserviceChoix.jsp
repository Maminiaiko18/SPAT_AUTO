<%-- 
    Document   : serviceChoix
    Created on : 30 sept. 2015, 17:41:03
    Author     : user
--%>
<%@page import="mg.cnaps.log.LogService"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%

    LogService e = new LogService();
    e.setNomTable("LOG_SERVICE_LIBELLE");//si_dossiers_travailleurs_lib
    String champReturn = request.getParameter("champReturn");
    String listeCrt[] = {"id", "libelle", "code_dr", "dr_rattache"};
    String listeInt[] = {""};
    String libEntete[] = {"id", "libelle", "code_dr", "dr_rattache"};
    PageRechercheChoix pr = new PageRechercheChoix(e, request, listeCrt, listeInt, 2, libEntete, 4);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("logserviceChoix.jsp");
    pr.setChampReturn(champReturn);
    pr.getFormu().getChamp("id").setLibelleAffiche("ID");
    pr.getFormu().getChamp("libelle").setLibelleAffiche("Libelsle");
    pr.getFormu().getChamp("code_dr").setLibelleAffiche("Direction regionale");
    pr.getFormu().getChamp("dr_rattache").setLibelleAffiche("DR rattache");
    String serv=request.getParameter("serv2");
    if(serv!=null && serv.compareToIgnoreCase("")!=0)
    {
        pr.setAWhere(" and id!='"+serv+"'");
    }
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
                <h1>Liste Service</h1>
            </section>
            <section class="content">
                <form action="logserviceChoix.jsp?champReturn=<%=pr.getChampReturn()%>&serv2=<%=serv%>" method="post" name="personneliste" id="personneliste">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <%
//                    String lienTableau[] = {pr.getLien() + "?but=dossier/dossier-travailleur.jsp"};
//                    String colonneLien[] = {"id"};
                    String libelles[] = {"ID", "Libelle", "Direction regionale", "DR rattache"};
//                    pr.getTableau().setLien(lienTableau);
//                    pr.getTableau().setColonneLien(colonneLien);
                    pr.getTableau().setLibelleAffiche(libelles);
                    out.println(pr.getTableauRecap().getHtml());
                %>
                <form action="../<%=pr.getLien()%>?but=choix/apresChoix.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                    <% out.println(pr.getTableau().getHtmlWithRadioButton()); %>
                </form>
                <% pr.setChampReturn(pr.getChampReturn()+"&serv2="+serv);
                    out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>