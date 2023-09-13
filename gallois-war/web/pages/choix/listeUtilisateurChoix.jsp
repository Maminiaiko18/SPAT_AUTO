<%-- 
    Document   : listeUtilisateurChoix
    Created on : 8 déc. 2020, 10:56:10
    Author     : Finaritra
--%>

<%@page import="utilisateur.Utilisateur"%>
<%@page import="mg.spat.MouvementLibComplet"%>
<%@page import="affichage.PageRechercheChoix"%>
<%
    String champReturn = request.getParameter("champReturn");
    Utilisateur user = new Utilisateur();
    user.setNomTable("utilisateurlib");
    String listeCrt[] = {"refuser", "loginuser", "nomuser"};
    String listeInt[] = {};
    String libEntete[] = {"refuser", "loginuser", "nomuser"};
    PageRechercheChoix pr = new PageRechercheChoix(user, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
  //  pr.setOrdre(" order by daty desc");
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("listeUtilisateurChoix.jsp");
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
                <h1>Choix Utilisateur</h1>
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
                        String libEnteteAff[] = {"refuser", "loginuser", "pwduser", "nomuser"};
                        pr.getTableau().setLibeEntete(libEnteteAff);
                        out.println(pr.getTableau().getHtmlWithRadioButton()); %>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>

