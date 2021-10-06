<%@page import="facture.FactureFournisseurDetails"%>
<%@page import="facturefournisseur.DetailsFactureFournisseur"%>
<%@page import="affichage.PageRechercheChoix"%>
<%
    String champReturn = request.getParameter("champReturn");
    FactureFournisseurDetails fDet = new FactureFournisseurDetails();
    fDet.setNomTable("facture_fournisseur_fille");
    String listeCrt[] = {"id","idmere" ,"designation","quantite","pu","devise"};
    String listeInt[] = {"quantite"};
    String libEntete[] = {"id","idmere" ,"designation","quantite","pu","devise"};
    PageRechercheChoix pr = new PageRechercheChoix(fDet, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("listeFactureFournisseurDetailsChoix.jsp");
   
    pr.setChampReturn(champReturn);
    
    pr.getFormu().getChamp("idmere").setLibelle("Mère");
    pr.getFormu().getChamp("quantite1").setLibelle("Quantité Min");
    pr.getFormu().getChamp("quantite2").setLibelle("Quantité Max");
   
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
            <section class="content-header">
                <h1>Liste facture fournisseur détails</h1>
            </section>
            <section class="content">
                <form action="<%=pr.getApres()%>?champReturn=<%=pr.getChampReturn()%>" method="post" name="fcdetailsliste" id="fcdetailsliste">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <%
                    out.println(pr.getTableauRecap().getHtml());
                %>
                <form action="../<%=pr.getLien()%>?but=choix/apresChoix.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                    <% 
                       String libEnteteAff[] =  {"Id","Mère","Designation","Quantite","PU","Devise"};
                       pr.getTableau().setLibeEntete(libEnteteAff);
                        out.println(pr.getTableau().getHtmlWithRadioButton()); %>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>

