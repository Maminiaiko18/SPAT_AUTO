<%-- 
    Document   : facture-client-liste
    Created on : 2 févr. 2021, 10:48:45
    Author     : ACER
--%>


<%@page import="rubrique.TarifRubriqueFactureClient"%>
<%@page import="factureclient.PaiementFactureRemise"%>
<%@page import="utilitaire.Utilitaire"%>


<%@page import="affichage.PageRecherche"%>

<%
    try {
        TarifRubriqueFactureClient trfc = new TarifRubriqueFactureClient();
        if (request.getParameter("etat") == null || request.getParameter("etat").compareToIgnoreCase("") == 0) {
            trfc.setNomTable("tarifRubriqueFactureClient_lib");
        } else {
            System.out.println(request.getParameter("etat"));
            trfc.setNomTable(request.getParameter("etat"));
        }

        String listeCrt[] = {"id","iddevise", "idnature"};
        String listeInt[] = {};
        String libEntete[] = {"id","borne_inf", "borne_sup", "prixunitaire", "iddevise","idnature", "unite"};
        PageRecherche pr = new PageRecherche(trfc, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.getFormu().getChamp("idnature").setLibelle("Nature");
        pr.getFormu().getChamp("iddevise").setLibelle("Devise");

        pr.setApres("facture/tarifRubriqueFactureClient-liste.jsp&etat="+request.getParameter("etat")+"");

        String[] colSomme = {};
        pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.personnel.submit();
    }
</script>
<style>
    th {
        color: white !important;
    }
    th a {
        color: white !important;
    }
</style>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste tarif facture client</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=facture/tarifRubriqueFactureClient-liste.jsp" method="post" name="personnel" id="personnel">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="col-md-4"></div>
            <div class="col-md-4">
                <div class="form-group">
                    <label>Etat: </label>
                    <select name="etat" class="champ form-control" id="etat" onchange="changerDesignation()" style="display: inline-block; width: 250px;">
                        <option value="tarifRubriqueFactureClient_lib" <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("tarifRubriqueFactureClient_lib") == 0) {
                                out.print(" selected");
                            }%>>Tous </option>
                        <option value="tarifRubriqueFactureClientcree" <%if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("tarifRubriqueFactureClientcree") == 0) {
                                out.print("selected");
                            }%>>Crée</option>
                        <option value="tarifRubriqueFactureClientvise" <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("tarifRubriqueFactureClientvise") == 0) {
                                out.print(" selected");
                            }%>>Validé </option>
                    </select>
                </div>
            </div>
            <div class="col-md-4"></div>
        </form>
        <%  String lienTableau[] = {pr.getLien() + "?but=facture/tarifRubriqueFactureClient-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String[] motsEntete = {"Id", "Borne inférieure", "Borne supérieure", "Prix unitaire","Devise","Nature","Unité"};
            pr.getTableau().setLibelleAffiche(motsEntete);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
<% } catch (Exception e) {
        e.printStackTrace();
    }
%>
