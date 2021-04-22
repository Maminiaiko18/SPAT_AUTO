<%-- 
    Document   : listePostedestinataireInterneChoix
    Created on : 5 nov. 2019, 16:12:46
    Author     : Tin
--%>

<%@ page import="user.*" %>
<%@page import="mg.spat.PosteDestinataireLibComplet"%>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    String champReturn = request.getParameter("champReturn");
    PosteDestinataireLibComplet posteDestinataire = new PosteDestinataireLibComplet();
    posteDestinataire.setNomTable("POSTEDESTINATAIRELIBCOMPLET");
    String listeCrt[] = {"id", "valquais", "valpays", "valtypequais"};
    String listeInt[] = {};
    String libEntete[] = {"id", "valquais", "valtypequais", "valpays","longueur","profondeur"};
    PageRechercheChoix pr = new PageRechercheChoix(posteDestinataire, request, listeCrt, listeInt, 3, libEntete,libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("listePostedestinataireExterneChoix.jsp");
    pr.getFormu().getChamp("valquais").setLibelle("Quai");
    pr.getFormu().getChamp("valpays").setLibelle("Pays");
    pr.getFormu().getChamp("valtypequais").setLibelle("Type du quai");
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
                <h1>Choix poste externe</h1>
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
                        String libEnteteAffiche[] =  {"ID", "Quai", "Type quai", "Pays","Longueur","Profondeur"};
                        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                        out.println(pr.getTableau().getHtmlWithRadioButton()); 
                    %>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>
