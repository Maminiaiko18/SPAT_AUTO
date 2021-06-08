<%-- 
    Document   : factureclient-liste
    Created on : 14 janv. 2021, 16:30:52
    Author     : Lenovo
--%>

<%@page import="facture.FactureProforma"%>
<%@page import="affichage.PageRecherche"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try {
        FactureProforma ff = new FactureProforma();
        ff.setNomTable("factureprofMSum_lib");
        if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("") != 0) {
            ff.setNomTable(request.getParameter("etat"));
        }

        String listeCrt[] = {"id","daty","tiers","designation","date_echeance"};
        String listeInt[] = {"daty","date_echeance"};
        String libEntete[] = {"id","daty","tiers","designation","tva","date_echeance","montant", "montantTVA", "montantTTC"};

        PageRecherche pr = new PageRecherche(ff, request, listeCrt, listeInt, listeInt.length, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setOrdre(" order by daty desc");
        pr.setApres("facture/facture-proforma-liste.jsp");
        
        pr.getFormu().getChamp("daty1").setLibelle("date debut");
        pr.getFormu().getChamp("daty2").setLibelle("date fin");
        pr.getFormu().getChamp("date_echeance1").setLibelle("date echeance debut");
        pr.getFormu().getChamp("date_echeance2").setLibelle("date echeance fin");
        
        String[] colSomme = {"montant", "montantTVA", "montantTTC"};
        pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.incident.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste facture proforma</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=facture/facture-proforma-liste.jsp" method="post" name="incident" id="incident">
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
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("factureprofMSum_lib") == 0) {%>    
                        <option value="factureprofMSum_lib" selected>Tous</option>
                        <% } else { %>
                        <option value="factureprofMSum_lib" >Tous</option>
                        <% } %>
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("factureprofMSum_libC") == 0) {%>
                        <option value="factureprofMSum_libC" selected>Créée(s)</option>
                        <% } else { %>
                        <option value="factureprofMSum_libC">Créée(s)</option>
                        <% } %>

                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("factureprofMSum_libV") == 0) {%>
                        <option value="factureprofMSum_libV" selected>Visée(s)</option>
                        <% } else { %>
                        <option value="factureprofMSum_libV">Visée(s)</option>
                        <% } %>
                        
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("factureprofMSum_libA") == 0) {%>
                        <option value="factureprofMSum_libA" selected>Visée(s)</option>
                        <% } else { %>
                        <option value="factureprofMSum_libA">Annulée(s)</option>
                        <% } %>

                    </select>
                </div>
                <div class="col-md-4"></div>
            </div>
        </form>
        <%out.println(pr.getTableauRecap().getHtml());%>
        <br/>
        <%
            String lienTableau[] = {pr.getLien() + "?but=facture/facture-proforma-fiche.jsp"};

            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);

            String libEnteteAffiche[] = {"id","daty","tiers","designation", "tva", "date echeance","montant HT", "montant TVA", "montant TTC"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
<% } catch (Exception e) {
        e.printStackTrace();
    }%>
