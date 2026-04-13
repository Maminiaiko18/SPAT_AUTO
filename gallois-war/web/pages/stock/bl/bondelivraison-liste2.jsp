<%--
    Document   : bondelivraison-liste
    Created on : 25 nov. 2020, 17:50:42
    Author     : ASUS
--%>
<%@page import="affichage.PageRecherche"%>
<%@page import="mg.spat.stock.BonDeLivraison"%>
<%@ page import="mg.spat.stock.BonDeLivraisonTiers" %>
<%

    BonDeLivraisonTiers lv = new BonDeLivraisonTiers();
    if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("") != 0) {
        lv.setNomTable(request.getParameter("etat"));
    }
    String libEntete[] = {"id", "daty", "numbc","montant","montanttva","montantttc","montantfactttc","montantpaye","rap","reste_a_facturer","fournisseurLib"};
    String listeCrt[] = {"id", "daty", "numbc", "fournisseurLib"};
    String listeInt[] = {"daty"};
    PageRecherche pr = new PageRecherche(lv, request, listeCrt, listeInt, 5, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.getFormu().getChamp("daty1").setLibelle("Date min");
    pr.getFormu().getChamp("daty2").setLibelle("Date Max");
    pr.getFormu().getChamp("numbc").setLibelle("Num&eacute;ro BC");
    pr.getFormu().getChamp("fournisseurLib").setLibelle("Fournisseur");
    pr.setApres("stock/bl/bondelivraison-liste2.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);%>
<script>
    function changerDesignation() {
        document.incident.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Facturation des bons de livraisons group&eacute;s</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=stock/bl/bondelivraison-liste2.jsp" method="post" name="incident" id="incident">
            <%

                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="row col-md-12">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    Etat :
                    <select name="etat" class="champ" id="etat" onchange="changerDesignation()" >
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("AS_BONDELIVRAISON_MTTCPL_Tiers") == 0) {%>
                        <option value="AS_BONDELIVRAISON_MTTCPL_Tiers" selected>Tous</option>
                        <% } else { %>
                        <option value="AS_BONDELIVRAISON_MTTCPL_Tiers" >Tous</option>
                        <% } %>
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("AS_BONDELIVRAISON_MTTCPL_TierV") == 0) {%>
                        <option value="AS_BONDELIVRAISON_MTTCPL_TierV" selected>Valid&eacute;</option>
                        <% } else { %>
                        <option value="AS_BONDELIVRAISON_MTTCPL_TierV">Valid&eacute;</option>
                        <% } %>

                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("AS_BONDELIVRAISON_MTTCPL_TierC") == 0) {%>
                        <option value="AS_BONDELIVRAISON_MTTCPL_TierC" selected>En cours</option>
                        <% } else { %>
                        <option value="AS_BONDELIVRAISON_MTTCPL_TierC">En cours</option>
                        <% } %>

                    </select>
                </div>
                <div class="col-md-4"></div>
            </div>

        </form>
        <%  String lienTableau[] = {pr.getLien() + "?but=stock/bl/bondelivraison-fiche.jsp", pr.getLien() + "?but=stock/bc/asBonDeCommande-fiche.jsp"};
            String colonneLien[] = {"id","numbc"};
            String[] urlLienMultiple = {"id","id_bc"};
            String[] urlLienAffiche = {"id","id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            pr.getTableau().setUrlLienAffiche(urlLienAffiche);
            pr.getTableau().setUrlLien(urlLienMultiple);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <form action="<%= pr.getLien() + "?but=facture/facture-fournisseur-saisie-vaovao2.jsp"%>" method="post" >
            <%
                String libEnteteAffiche[] = {"Id", "Date","Numero BC","Montant", "Montant TVA", "Montant TTC", "Montant factur&eacute;", "Montant pay&eacute;", "Reste &agrave; payer", "Reste &agrave; facturer","Fournisseur"};
                pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                out.println(pr.getTableau().getHtmlWithCheckbox());
            %>
        </form>
        <%
            out.println(pr.getBasPage());
        %>
    </section>
</div>

<%--<form action="<%=pr.getLien()%>?but=facture/facture-fournisseur-saisie-vaovao2.jsp" method="post" name="budget" id="budget">--%>