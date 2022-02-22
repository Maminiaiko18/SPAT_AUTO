<%-- 
    Document   : page-choix
    Created on : 13 avr. 2021, 10:18:32
    Author     : nyamp
--%>

<%@page import="mg.spat.Engagement"%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.PageRechercheChoix"%>
<%
   try { 
      Engagement e = new Engagement();
    e.setNomTable("engagement");
    String champReturn = request.getParameter("champReturn");
    String listeCrt[] = {"designation"};
    String listeInt[] = {};
    String libEntete[] = {"id","designation","montant","dispoAvant","dispoApres"};
    PageRechercheChoix pr = new PageRechercheChoix(e, request, listeCrt, listeInt, 2, libEntete, libEntete.length);
    
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.getFormu().getChamp("designation").setLibelle("Designation");
    pr.setApres("choix/listeEngagementChoix.jsp");
    pr.setChampReturn(champReturn);
    
    
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Projet</title> 
        <!-- Tell the browser to be responsive to screen width -->
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <jsp:include page='../elements/css.jsp'/>
    </head>
    <body class="skin-blue sidebar-mini">
        <div class="wrapper">
            <section class="content-header">
                <h1>Choix Engagement</h1>
            </section>
            <section class="content">
                <form action="<%=pr.getApres()%>?champReturn=<%=pr.getChampReturn()%>" method="post" name="rubrique" id="rubrique">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <%
                    String libelles[] = {"Id","Designation","Projet","code de l'etablissement","Montant","dispo Avant","dispo Apres"};
                    pr.getTableau().setLibelleAffiche(libelles);
                    out.println(pr.getTableauRecap().getHtml());
                %>
                <form action="../<%=pr.getLien()%>?but=choix/apresChoix.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                    <% out.println(pr.getTableau().getHtmlWithRadioButton()); %>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>   
<% } catch (Exception e) {
        e.printStackTrace();
    }%>