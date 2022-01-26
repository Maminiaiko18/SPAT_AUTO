<%-- 
    Document   : page-choix
    Created on : 13 avr. 2021, 10:18:32
    Author     : nyamp
--%>

<%@page import="mg.spat.CompteCA"%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.PageRechercheChoix"%>
<%
    try{
    CompteCA e = new CompteCA();
    e.setNomTable("compteCA");
    String champReturn = request.getParameter("champReturn");
    String listeCrt[] = {"val","libelle"};
    String listeInt[] ={};
    String libEntete[] ={"val","libelle"};
    PageRechercheChoix pr = new PageRechercheChoix(e, request, listeCrt, listeInt, 2, libEntete, libEntete.length);
    
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.getFormu().getChamp("val").setLibelle("Désignation");
    pr.getFormu().getChamp("libelle").setLibelle("Libelle");
    pr.setApres("choix/listeCompteCAchoix.jsp");
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
                <h1>Liste Compte CA choix</h1>
            </section>
            <section class="content">
                <form action="<%=pr.getApres()%>?champReturn=<%=pr.getChampReturn()%>" method="post" name="rubrique" id="rubrique">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <%
                    String libelles[] = {"Désignation","Libellé"};
                    pr.getTableau().setLibelleAffiche(libelles);
                    out.println(pr.getTableauRecap().getHtml());
                %>
                <form action="../<%=pr.getLien()%>?but=choix/apresChoix.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                    <% out.println(pr.getTableau().getHtmlWithRadioButton()); %>
                </form>
                <% out.println(pr.getBasPage());%>n
                nnnn
            </section>
        </div>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>      
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
