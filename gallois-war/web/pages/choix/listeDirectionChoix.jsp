<%-- 
    Document   : listeDirectionChoix.jsp
    Created on : 28 sept. 2023, 09:43:30
    Author     : Mon PC
--%>
<%@page import="lc.Direction"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    String champReturn = request.getParameter("champReturn");
    Direction dir = new Direction();
    
    String listeCrt[] = {"iddir","libelledir","abbrevdir"};
    String listeInt[] = {};
    String libEntete[] = {"iddir","libelledir","abbrevdir"};
    PageRechercheChoix pr = new PageRechercheChoix(dir, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("listeDirectionChoix.jsp");
    pr.getFormu().getChamp("iddir").setLibelle("Id");
    pr.getFormu().getChamp("libelledir").setLibelle("Direction Libellé");
    pr.getFormu().getChamp("abbrevdir").setLibelle("Direction abbreviation");
    
    //pr.getFormu().getChamp("reference").setLibelle("Référence");
    
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
                <h1>Choix Direction</h1>
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
                        String libEnteteAffiche[] = {"Id","Direction Libellé","Direction abbreviation"};
                        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                        out.println(pr.getTableau().getHtmlWithRadioButton()); %>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>
