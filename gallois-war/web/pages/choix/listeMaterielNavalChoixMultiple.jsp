<%@page import="mg.spat.MaterielNaval"%>
<%@page import="affichage.PageRechercheChoix"%>
<%
    String champReturn = request.getParameter("champReturn");
    MaterielNaval mvt = new MaterielNaval();
    mvt.setNomTable("materiel_naval");
    String listeCrt[] = {"id", "denomination", "date_aquisition"};
    String listeInt[] = {"date_aquisition"};
    String libEntete[] = {"id", "denomination", "date_aquisition", "puissance", "detenteur", "maintenance", "immatriculation"};
    PageRechercheChoix pr = new PageRechercheChoix(mvt, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setOrdre(" order by date_aquisition desc");
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("listeMaterielNavalChoixMultiple.jsp");
    pr.setChampReturn(champReturn);

    pr.getFormu().getChamp("date_aquisition1").setLibelle("date aquisition min");
    pr.getFormu().getChamp("date_aquisition2").setLibelle("date aquisition max");
    pr.getFormu().getChamp("date_aquisition2").setLibelle("date aquisition max");

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
        <div class="content-wrapper">
            <section class="content-header">
                <h1>Choix matériels navals</h1>
            </section>
            <section class="content">
                 <form action="<%=pr.getApres()%>?champReturn=<%=pr.getChampReturn()%>" method="post" name="cc" id="cc">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <%
                    out.println(pr.getTableauRecap().getHtml());
                %>
                <form action="../<%=pr.getLien()%>?but=choixMultiple/apresChoixMultiple.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                    <%
                        String libEnteteAff[] = {"id", "denomination", "date aquisition", "puissance", "detenteur", "maintenance", "immatriculation"};
                        pr.getTableau().setLibeEntete(libEnteteAff);
                        out.println(pr.getTableau().getHtmlWithMultipleCheckbox()); %>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>