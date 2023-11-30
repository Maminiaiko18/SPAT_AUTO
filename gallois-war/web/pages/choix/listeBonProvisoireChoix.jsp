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
    String listeCrt[] = {"id", "daty", "code_etablissementlib", "projetlib", "modepaiementlib", "code", "num","designation"};
    String listeInt[] = {"daty"};
    String libEntete[] = {"id","daty","tierslib","code_etablissementlib","projetlib","modepaiementlib", "code", "num","designation","categorielib","tva","date_echeance","montant", "montantTVA", "montantTTC"};
    PageRechercheChoix pr = new PageRechercheChoix(e, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("listeBonProvisoireChoix.jsp");
    pr.setAWhere(" and etat = 11");
    pr.setChampReturn(champReturn);
    pr.getFormu().getChamp("id").setLibelleAffiche("ID");
    pr.getFormu().getChamp("Code_etablissementlib").setLibelleAffiche("code etablissement");
    pr.getFormu().getChamp("Projetlib").setLibelleAffiche("Projet");
    pr.getFormu().getChamp("Modepaiementlib").setLibelleAffiche("Mode de paiement");
    pr.getFormu().getChamp("code").setLibelleAffiche("Numero compta");
    pr.getFormu().getChamp("num").setLibelleAffiche("Numero BP");


//    pr.getFormu().getChamp("nom").setLibelleAffiche("Nom");
//    pr.getFormu().getChamp("specialisation").setLibelleAffiche("Sp�cialisation");
        pr.getFormu().getChamp("daty1").setLibelleAffiche("Date Min");
        pr.getFormu().getChamp("daty2").setLibelleAffiche("Date Max");
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
        <div class="content-wrapper">
            <section class="content-header">
                <h1>Bon Provisoire a regulariser</h1>
            </section>
            <section class="content">
                <form action="<%=pr.getApres()%>?champReturn=<%=pr.getChampReturn()%>" method="post" name="etab" id="etab">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <%
//                    String lienTableau[] = {pr.getLien() + "?but=employeur/employeur-fiche.jsp"};
//                    String colonneLien[] = {"id"};
                    String libelles[] = {"id","daty","tiers","code etablissement","projet","mode de paiement", "numero compta", "Numero BP","designation","categorie","tva","date_echeance","montant", "montantTVA", "montantTTC"};
//		    pr.getTableau().setLien(lienTableau);
//                    pr.getTableau().setColonneLien(colonneLien);
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
        }catch(Exception e){
        e.printStackTrace();
}
%>