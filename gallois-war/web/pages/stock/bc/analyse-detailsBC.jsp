<%-- 
    Document   : analyse-journal-de-caisse
    Created on : 2 déc. 2019, 08:22:05
    Author     : Antsa
--%>

<%@page import="mg.spat.stock.BonDeCommandeFille"%>
<%@ page import="user.*" %>
<%@page import="affichage.Liste"%>
<%@ page import="bean.*" %>
<%@page import="bean.TypeObjet"%>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try {
        BonDeCommandeFille journal = new BonDeCommandeFille();
        journal.setNomTable("AS_BC_ANALYSEFILLE_LIB");

        String listeCrt[] = {"idbc", "daty", "codelib", "projetlib", "produit", "fournisseurlib"};
        String listeInt[] = {"daty"};
        String[] pourcentage = {};
        String colDefaut[] = {"idbc" , "daty", "codelib", "projetlib", "produit", "quantite", "unite", "pu", "montantht", "fournisseurlib"};
        String somDefaut[] = {};
        String lien[] = {"id"};
        PageRechercheGroupe pr = new PageRechercheGroupe(journal, request, listeCrt, listeInt, 3, colDefaut, somDefaut, pourcentage, colDefaut.length, somDefaut.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.getFormu().getChamp("idbc").setLibelle("IDBC");
        pr.getFormu().getChamp("daty1").setLibelle("Date min");
        pr.getFormu().getChamp("daty2").setLibelle("Date max");
		pr.getFormu().getChamp("codelib").setLibelle("Code");
		pr.getFormu().getChamp("projetlib").setLibelle("Projet");
		pr.getFormu().getChamp("fournisseurlib").setLibelle("Fournisseur");
        pr.setApres("stock/bc/analyse-detailsBC.jsp");
        pr.creerObjetPage();
%>
<script>
    function changerDesignation() {
        document.analyse.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse details BC</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>" method="get" name="analyse" id="analyse">
            <input type="hidden" name="but" value="stock/bc/analyse-detailsBC.jsp" />
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"IDBC" , "date", "code", "projet", "produit", "quantite", "unite", "pu", "montant HT", "fournisseur"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            String lienTableau[] = {
            pr.getLien() + "&but=stock/bc/asBonDeCommande-fiche.jsp"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(lien);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
            out.println(pr.getInsertLienModal());
        %>
    </section>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>