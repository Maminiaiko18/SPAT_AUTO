<%-- 
    Document   : absence-liste
    Created on : 14 Mars 2016, 10:26:05
    Author     : Do
--%>
<%@page import="lignecredit.LigneCredit"%>
<%@page import="affichage.PageRecherche"%>
<%
    try {

        LigneCredit fa = new LigneCredit();

        String nomTable = "situationLCDepense";
        if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("") != 0) {
            nomTable = request.getParameter("table");
        }
        fa.setNomTable(nomTable);

        String listeCrt[] = {"id", "designation", "compte"};
        String listeInt[] = {""};
        String libEntete[] = {"id", "designation", "compte", "annee", "montant", "facture", "paye"};
        PageRecherche pr = new PageRecherche(fa, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.setApres("ligneCredit/situation-ligneCreditDepense.jsp");
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);%>
<script>
    function changerDesignation() {
        document.absence.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des Credits Depenses </h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=ligneCredit/situation-ligneCreditDepense.jsp" method="post" name="absence" id="absence">
            <% out.println(pr.getFormu().getHtmlEnsemble());%>
            <div class="row col-md-12">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    Etat : 
                    <select name="table" class="champ" id="table" onchange="changerDesignation()" >
                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("situationLCDepense") == 0) {%>    
                        <option value="situationLCDepense" selected>Tous</option>
                        <% } else { %>
                        <option value="situationLCDepense" >Tous</option>
                        <% } %>
                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("situationLCDepenseC") == 0) {%>
                        <option value="situationLCDepenseC" selected> D&eacute;part </option>
                        <% } else { %>
                        <option value="situationLCDepenseC"> Cr&eacute;&eacute; </option>
                        <% } %>

                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("situationLCDepenseV") == 0) {%>
                        <option value="situationLCDepenseV" selected> Arriv&eacute;e  </option>
                        <% } else { %>
                        <option value="situationLCDepenseV"> Vis&eacute;  </option>
                        <% } %>



                    </select>
                </div>
            </div>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=ligneCredit/fiche-ligneCreditDepense.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());
        %>
        <br>
        <%
            String libEnteteAffiche[] = {"id", "designation", "compte", "annee", "montant", "facture", "paye"};
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