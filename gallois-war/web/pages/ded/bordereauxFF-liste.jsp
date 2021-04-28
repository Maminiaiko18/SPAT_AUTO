<%-- 
    Document   : borderaux-liste
    Created on : 21 janv. 2021, 09:51:38
    Author     : ACER
--%>

<%@page import="bordereau.Bordereau"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="utilitaire.Utilitaire"%>

<% 
    Bordereau bordereaux = new Bordereau();
    bordereaux.setNomTable("BORDEREAUFF_LIB_MONTANT");
    String libEntete[] = {"id", "daty","numero","designation","tiers","montant"};
    String listeCrt[] = {"id","designation", "daty","tiers"};
    String listeInt[] = {"daty"};
    PageRecherche pr = new PageRecherche(bordereaux, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("ded/bordereauxFF-liste.jsp");
    pr.getFormu().getChamp("daty1").setLibelle("date de début");
    pr.getFormu().getChamp("daty2").setLibelle("date fin");
    pr.getFormu().getChamp("daty1").setDefaut(Utilitaire.dateDuJour());
    pr.getFormu().getChamp("daty2").setDefaut(Utilitaire.dateDuJour());
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>


<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste bordereaux facture fournisseur</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=ded/bordereauxFF-liste.jsp" method="post" name="travaux" id="travaux">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
            <%
                String lienTableau[] = {pr.getLien() + "?but=ded/bordereauxFF-fiche.jsp"};
                String colonneLien[] = {"id"};
                pr.getTableau().setLien(lienTableau);
                pr.getTableau().setColonneLien(colonneLien);
                out.println(pr.getTableauRecap().getHtml());
            %>
            <br>
            <%
                String libEnteteAffiche[] = {"id", "Date","num&eacute;ro","Désignation","Tiers","Montant"};
                pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                out.println(pr.getTableau().getHtml());
                out.println(pr.getBasPage());
            %>
    </section>
</div>