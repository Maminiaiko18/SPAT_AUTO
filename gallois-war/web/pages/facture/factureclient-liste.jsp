<%-- 
    Document   : factureclient-liste
    Created on : 14 janv. 2021, 16:30:52
    Author     : Lenovo
--%>

<%@page import="mg.spat.FactureAnalyse"%>
<%@page import="affichage.PageRecherche"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try {
        FactureAnalyse ff = new FactureAnalyse();
        ff.setNomTable("ANALYSEGLOBALEFACTURE_ANALYSE");
        if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("") != 0) {
            ff.setNomTable(request.getParameter("etat"));
        }

        String listeCrt[] = {"nmfact","client", "daty", "categorie_facture", "sous_categorie_facture", "categorie_client", "valCat","numCompte"};
        String listeInt[] = {"daty"};
        String libEntete[] = {"nmfact","client", "daty","designation", "categorie_facture", "sous_categorie_facture","mttc","mtht","mtavoir", "categorie_client", "valCat","paye","reste","numCompte"};

        PageRecherche pr = new PageRecherche(ff, request, listeCrt, listeInt, listeInt.length, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setOrdre(" order by daty desc");
        pr.setApres("facture/factureclient-liste.jsp");
        pr.getFormu().getChamp("nmfact").setLibelle("id");
        pr.getFormu().getChamp("daty1").setLibelle("date debut");
        pr.getFormu().getChamp("daty2").setLibelle("date fin");
        pr.getFormu().getChamp("categorie_facture").setLibelle("categorie facture");
        pr.getFormu().getChamp("sous_categorie_facture").setLibelle("sous_categorie_facture");
        pr.getFormu().getChamp("categorie_client").setLibelle("categorie_client");
        pr.getFormu().getChamp("valCat").setLibelle("categorie");

        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.incident.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste facture client</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=facture/factureclient-liste.jsp" method="post" name="incident" id="incident">
            <%
                String libelleAffiche[] = {};
                pr.getTableau().setLibelleAffiche(libelleAffiche);
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="row col-md-12">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    Etat : 
                    <select name="etat" class="champ" id="etat" onchange="changerDesignation()" >
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("ANALYSEGLOBALEFACTURE_ANALYSE") == 0) {%>    
                        <option value="ANALYSEGLOBALEFACTURE_ANALYSE" selected>Tous</option>
                        <% } else { %>
                        <option value="ANALYSEGLOBALEFACTURE_ANALYSE" >Tous</option>
                        <% } %>
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("ANALYSEGLOBALEFACTURE_PAYE") == 0) {%>
                        <option value="ANALYSEGLOBALEFACTURE_PAYE" selected>Payée(s)</option>
                        <% } else { %>
                        <option value="ANALYSEGLOBALEFACTURE_PAYE">Payée(s)</option>
                        <% } %>

                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("ANALYSEGLOBALEFACTURE_NON_PAYE") == 0) {%>
                        <option value="ANALYSEGLOBALEFACTURE_NON_PAYE" selected>Non payée(s)</option>
                        <% } else { %>
                        <option value="ANALYSEGLOBALEFACTURE_NON_PAYE">Non payée(s)</option>
                        <% } %>

                    </select>
                </div>
                <div class="col-md-4"></div>
            </div>
        </form>
        <%out.println(pr.getTableauRecap().getHtml());%>
        <br/>
        <%
            String lienTableau[] = {pr.getLien() + "?but=facture/factureclient-fiche.jsp"};

            String colonneLien[] = {"nmfact"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);

            String libEnteteAffiche[] = {"id","client", "date","designation", "categorie facture", "sous categorie facture","montant TTC","montant HT","montant avoir", "categorie client", "Categorie","payé","reste a payé","numero de Compte"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
        <% out.println(pr.getBasPage());%>
    </section>
</div>
<% } catch (Exception e) {
        e.printStackTrace();
    }%>
