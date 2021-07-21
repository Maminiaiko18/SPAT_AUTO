<%-- 
    Document   : absence-liste
    Created on : 14 Mars 2016, 10:26:05
    Author     : Do
--%>
<%@page import="affichage.TableauRecherche"%>
<%@page import="affichage.TableauRecherche"%>
<%@page import="lignecredit.SituationCredit"%>
<%@page import="affichage.PageRecherche"%>
<%
    try {

        SituationCredit fa = new SituationCredit();

        String nomTable = "situationLC_vide";
        if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("") != 0) {
            nomTable = request.getParameter("table");
        }
        fa.setNomTable(nomTable);

        String listeCrt[] = {"id", "designation", "compte"};
        String listeInt[] = {"daty"};
        String libEntete[] = {"id", "designation", "compte", "annee", "montant", "facture", "paye","daty"};
        PageRecherche pr = new PageRecherche(fa, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        
        pr.setApres("ligneCredit/situation-ligneCreditRecette.jsp");
        String[] colSomme = null;
        SituationCredit[] liste  = SituationCredit.findSituationCreditRecette(request.getParameter("id"),request.getParameter("designation"),request.getParameter("compte"),request.getParameter("daty1"),request.getParameter("daty2"),null);
        pr.creerObjetPage(libEntete, colSomme);
        pr.setTableau(new TableauRecherche(liste, libEntete));

%>
<script>
    function changerDesignation() {
        document.absence.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des Credits Recettes </h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=ligneCredit/situation-ligneCreditRecette.jsp" method="post" name="absence" id="absence">
            <% out.println(pr.getFormu().getHtmlEnsemble());%>
            <div class="row col-md-12">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    Etat : 
                    <select name="table" class="champ" id="table" onchange="changerDesignation()" >
                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("situationLCRecette") == 0) {%>    
                        <option value="situationLCRecette" selected>Tous</option>
                        <% } else { %>
                        <option value="situationLCRecette" >Tous</option>
                        <% } %>
                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("situationLCRecetteC") == 0) {%>
                        <option value="situationLCRecetteC" selected> Cr&eacute;&eacute; </option>
                        <% } else { %>
                        <option value="situationLCRecetteC"> Cr&eacute;&eacute; </option>
                        <% } %>

                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("situationLCRecetteV") == 0) {%>
                        <option value="situationLCRecetteV" selected> Vis&eacute;  </option>
                        <% } else { %>
                        <option value="situationLCRecetteV"> Vis&eacute;  </option>
                        <% } %>
                    </select>
                </div>
            </div>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=ligneCredit/fiche-ligneCreditRecette.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());
        %>
        <br>
        <%
            String libEnteteAffiche[] = {"id", "designation", "compte", "annee", "montant", "facture", "paye","Date"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());

        %>
    </section>
</div>
<%  } catch (Exception e) {
        e.printStackTrace();
    }
%>