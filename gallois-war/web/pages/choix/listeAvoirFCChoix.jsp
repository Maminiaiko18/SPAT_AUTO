<%-- 
    Document   : listeAvoirFCChoix.jsp
    Created on : 28 déc. 2021, 16:23:16
    Author     : john
--%>
<%@page import="avoir.AvoirFC"%>
<%@page import="affichage.PageRechercheChoix"%>
<%@page import="mg.spat.BonProvisoire"%>

<%

    try {
        String champReturn = request.getParameter("champReturn");
        AvoirFC e = new AvoirFC();
        e.setNomTable("avoirFC_montant");
        String listeCrt[] = {"id", "tierslib", "idfacture", "typelib"};
        String listeInt[] = null;
        String libEntete[] = {"id", "daty", "code", "tierslib", "idfacture", "typelib", "montant", "montantpaye", "montantreste"};

        PageRechercheChoix pr = new PageRechercheChoix(e, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setChampReturn(champReturn);

        pr.getFormu().getChamp("tierslib").setLibelle("tiers");
        pr.getFormu().getChamp("idfacture").setLibelle("facture");
        pr.getFormu().getChamp("typelib").setLibelle("type");

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
        <div class="content-wrapper">
            <section class="content-header">
                <h1>Liste AvoirFC</h1>
            </section>
            <section class="content">
                <form action="<%=pr.getApres()%>?champReturn=<%=pr.getChampReturn()%>" method="post" name="etab" id="etab">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <%

                    String libelles[] = {"id", "date", "Code", "tiers", "facture", "Type", "montant", "montant payé", "Reste à payer"};
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

<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
