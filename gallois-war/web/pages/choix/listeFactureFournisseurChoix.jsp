<%-- 
    Document   : listeBonProvisoireChoix
    Created on : 30 déc. 2020, 20:52:34
    Author     : Lenovo
--%>

<%@page import="facturefournisseur.EtatFactureMontantDaty"%>
<%@page import="facture.FactureFournisseur"%>
<%@page import="affichage.PageRechercheChoix"%>

<%
    String champReturn = request.getParameter("champReturn");
    FactureFournisseur ff = new FactureFournisseur();
    ff.setNomTable("FACTFOURN_MSUM_LIB");
    String libEntete[] = {"id","daty","tierslib", "code", "escale","designation","categorielib","tva","date_echeance","exercice","montant", "montantTVA", "montantTTC", "montantAvoir","montantpaye","montantreste"};
    String listeCrt[] = {"id","daty","exercice"};
    String listeInt[] = {"daty"};
    PageRechercheChoix pr = new PageRechercheChoix(ff, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("listeFactureFournisseurChoix.jsp");
    pr.setChampReturn(champReturn);
    pr.getFormu().getChamp("daty1").setLibelleAffiche("Date Min");
    pr.getFormu().getChamp("daty2").setLibelleAffiche("Date Max");
    //pr.getFormu().getChamp("nomfournisseur").setLibelleAffiche("Nom Fournisseur");
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
            <h1>Facture Fournisseur</h1>
        </section>
        <section class="content">
            <form action="<%=pr.getApres()%>?champReturn=<%=pr.getChampReturn()%>" method="post" name="etab" id="etab">
                <% out.println(pr.getFormu().getHtmlEnsemble());%>
            </form>
            <%
                String libelles[] = {"id","daty","Client","Code", "Escale","Note explicative","Catégorie", "tva", "date echeance","exercice","montant HT", "montant TVA", "montant TTC", "montant Avoir","Montant payé","Reste à payer"};
           
                //String libelles[] = {"id", "date", "Fournisseur", "date &eacute;mission", "d&eacute;signation", "numero facture", "date &eacute;ch&eacute;ance", "devise", "Montant TTC", "Montant pay&eacute;", "Reste &agrave; payer", "&Eacute;tat"};
                pr.getTableau().setLibelleAffiche(libelles);
                out.println(pr.getTableauRecap().getHtml());
            %>
            <form action="../<%=pr.getLien()%>?but=choix/apresChoix.jsp" method="post" name="frmchx" id="frmchx">
                <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                <% out.println(pr.getTableau().getHtmlWithRadioButton()); %>
            </form>
            <% out.println(pr.getBasPage());%>
        </section>
        <jsp:include page='../elements/js.jsp'/>
    </body>
</html>