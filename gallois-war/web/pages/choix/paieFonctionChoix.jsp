<%@page import="mg.cnaps.paie.PaieFonction"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    PaieFonction e = new PaieFonction();
    e.setNomTable("PAIE_FONCTIONLIBELLE");
    String champReturn = request.getParameter("champReturn");
    String listeCrt[] = {"id", "val", "desce", "idgroupefonction"};
    String listeInt[] = null;
    String libEntete[] = {"id", "val", "desce", "idgroupefonction"};
    PageRechercheChoix pr = new PageRechercheChoix(e, request, listeCrt, listeInt, 3, libEntete, 4);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("paieFonctionChoix.jsp");
    pr.getFormu().getChamp("id").setLibelle("ID");
    pr.getFormu().getChamp("val").setLibelle("Code");
    pr.getFormu().getChamp("desce").setLibelle("Description");
    pr.getFormu().getChamp("idgroupefonction").setLibelle("Groupe");
    pr.setChampReturn(champReturn);
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
                <h1>Liste des fonctions</h1>
            </section>
            <section class="content">
                <form action="<%=pr.getApres()%>?champReturn=<%=pr.getChampReturn()%>" method="post" name="rubrique" id="rubrique">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <%                    
                    String libEnteteAffiche[] = {"ID", "Code", "Description", "Groupe"};
                    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
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