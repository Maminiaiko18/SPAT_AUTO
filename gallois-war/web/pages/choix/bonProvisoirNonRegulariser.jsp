<%-- 
    Document   : listeBonProvisoireChoix
    Created on : 30 d�c. 2020, 20:52:34
    Author     : Lenovo
--%>

<%@page import="affichage.PageRechercheChoix"%>
<%@page import="facture.FactureFournisseur"%>

<%
    
    try{
        

    String champReturn = request.getParameter("champReturn");
    FactureFournisseur e = new FactureFournisseur();
    e.setNomTable("BPNONREGULARISER");
    String listeCrt[] = {"id","daty","tierslib","designation","date_echeance","num","categorielib", "code"};
    String listeInt[] = {"daty"};
    String libEntete[] = {"id","daty","tierslib", "code", "num","designation","categorielib","tva","date_echeance","montant", "montantTVA", "montantTTC", "montantAvoir","montantpaye","montantreste"};
    PageRechercheChoix pr = new PageRechercheChoix(e, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("bonProvisoirNonRegulariser.jsp");
    pr.setAWhere(" and etat = 11");
    pr.setChampReturn(champReturn);
//    pr.getFormu().getChamp("id").setLibelleAffiche("ID");
//    pr.getFormu().getChamp("nom").setLibelleAffiche("Nom");
//    pr.getFormu().getChamp("specialisation").setLibelleAffiche("Sp�cialisation");
//    pr.getFormu().getChamp("daty1").setLibelleAffiche("Date Min");
//    pr.getFormu().getChamp("daty2").setLibelleAffiche("Date Max");
//    pr.getFormu().getChamp("adresse").setLibelleAffiche("Adresse");
//    pr.getFormu().getChamp("pays").setLibelleAffiche("Pays");
//    pr.getFormu().getChamp("contact").setLibelleAffiche("Contact");
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
            <section class="content-header">
                <h1>Bon Provisoire non regulariser</h1>
            </section>
            <section class="content">
                <form action="<%=pr.getApres()%>?champReturn=<%=pr.getChampReturn()%>" method="post" name="etab" id="etab">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <%
                    String libEnteteAffiche[] = {"id","daty","Client","Code", "Numero BP","Note explicative","Cat�gorie", "tva", "date echeance","montant HT", "montant TVA", "montant TTC", "montant Avoir","Montant pay�","Reste � payer"};
                    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
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

<%
        }catch(Exception e){
        e.printStackTrace();
}
%>