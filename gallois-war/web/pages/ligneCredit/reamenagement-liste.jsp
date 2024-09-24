<%-- 
    Document   : reamenagement-liste
    Created on : 24 sept. 2024, 10:35:34
    Author     : Estcepoire
--%>

<%@page import="affichage.Liste"%>
<%@page import="lignecredit.LigneCredit"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="lignecredit.Reamenagement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try {
        Reamenagement reamenagement = new Reamenagement();
        reamenagement.setNomTable("reamenagementlib");
        if (request.getParameter("table") != null) {
            reamenagement.setNomTable(request.getParameter("table"));
        }

        String listeCrt[] = {"id", "idLigneDepart", "idLigneArrive","montant"};
        String listeInt[] = {"montant"};
        String libEntete[] = {"id", "idLigneDepartLib", "idLigneArriveLib", "montant"};

        PageRecherche pr = new PageRecherche(reamenagement, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.getFormu().getChamp("montant1").setLibelle("Montant min");
        pr.getFormu().getChamp("montant2").setLibelle("Montant max");
        pr.getFormu().getChamp("idLigneDepart").setLibelle("Ligne Depart");
        pr.getFormu().getChamp("idLigneArrive").setLibelle("Ligne arrivée");

        LigneCredit ligne = new LigneCredit();
        ligne.setNomTable("ligneCreditRecette");
        Liste[] list = new Liste[2];
        list[0] = new Liste("idLigneDepart", ligne, "designation", "id");
        list[1] = new Liste("idLigneArrive", ligne, "designation", "id");

        pr.getFormu().changerEnChamp(list);
        pr.setApres("ligneCredit/reamenagement-liste.jsp");

        String[] colSomme = {"montant"};
        pr.creerObjetPage(libEntete, colSomme);
%>  

<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des Reamenagemts</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=ligneCredit/reamenagement-liste.jsp" method="post">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="row col-md-12">  
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    Etat : 
                    <select name="table" class="champ" id="table" onchange="changerDesignation()" >

                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("TRANSFERT_COFFRE_TOUS") == 0) {%>    
                        <option value="reamenagementlib" selected>Tous</option>
                        <% } else { %>
                        <option value="reamenagementlib" >Tous</option>
                        <% } %>

                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("TRANSFERT_COFFRE_CREE") == 0) {%>    
                        <option value="reamenagementlibcreer" selected>Cr&eacute;&eacute;</option>
                        <% } else { %>
                        <option value="reamenagementlibcreer" >Cr&eacute;&eacute;</option>
                        <% } %>

                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("TRANSFERT_COFFRE_VISEE") == 0) {%>    
                        <option value="reamenagementlibvise" selected>Valid&eacute;</option>
                        <% } else { %>
                        <option value="reamenagementlibvise" >Valid&eacute;</option>
                        <% } %>
                    </select>
                </div>
            </div>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=ligneCredit/reamenagement-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"id", "Ligne Depart", "Ligne Arrive", "montant"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>

<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<script>
    function changerDesignation() {
        document.listebilletage.submit();
    }
</script>