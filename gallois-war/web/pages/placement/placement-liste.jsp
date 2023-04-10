<%-- 
    Document   : placement-liste
    Created on : 21 nov. 2019, 14:21:21
    Author     : john
--%>

<%@page import="mg.spat.placement.PlacementLibComplet"%>
<%@page import="mg.spat.Report"%>
<%@page import="affichage.PageRecherche"%>
<% 
    try{
        String nomTable = "placementlib";
        PlacementLibComplet placement = new PlacementLibComplet();
       if(request.getParameter("table")!=null && request.getParameter("table").compareToIgnoreCase("")!=0) nomTable=request.getParameter("table");
        placement.setNomTable(nomTable);
        String listeCrt[] = {"id", "valentite", "date_placement", "date_echeance", "banquelib"};
        String listeInt[] = {"date_placement","date_echeance"};
        String libEntete[] = {"id", "valentite", "banquelib", "date_placement", "date_echeance","duree","montant","taux"};
        PageRecherche pr = new PageRecherche(placement, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.getFormu().getChamp("date_placement1").setLibelle("Date Placement min");
        pr.getFormu().getChamp("date_placement2").setLibelle("Date Placement max");
        pr.getFormu().getChamp("date_echeance1").setLibelle("Date Echeance min");
        pr.getFormu().getChamp("date_echeance2").setLibelle("Date Echeance max");
        pr.getFormu().getChamp("banquelib").setLibelle("Banque");
        pr.getFormu().getChamp("valentite").setLibelle("Entite");
    
        pr.setApres("placement/placement-liste.jsp");
        pr.getFormu().getChamp("date_placement1").setDefaut(utilitaire.Utilitaire.getFirstDayOfMonth());
        pr.getFormu().getChamp("date_placement2").setDefaut(utilitaire.Utilitaire.getLastDayOfMonth());  

        pr.setOrdre(" order by date_placement desc");
        String[] colSomme = {"montant"};
        pr.creerObjetPage(libEntete, colSomme);
        

%>
<script>
    function changerDesignation() {
        document.listeplacement.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des placements</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=placement/placement-liste.jsp" method="post" name="listeplacement" id="listeplacement">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
               <div class="row col-md-12">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    Etat : 
                    <select name="table" class="champ" id="table" onchange="changerDesignation()" >
                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("placementlib") == 0) {%>    
                        <option value="placementlib" selected>Tous</option>
                        <% } else { %>
                        <option value="placementlib" >Tous</option>
                        <% } %>
                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("PLACEMENTLIB_C") == 0) {%>    
                        <option value="PLACEMENTLIB_C" selected>Cr&eacute;e</option>
                        <% } else { %>
                        <option value="PLACEMENTLIB_C" > Cr&eacute;e </option>
                        <% } %>
                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("PLACEMENTLIB_V") == 0) {%>    
                        <option value="PLACEMENTLIB_V" selected> Vis&eacute; </option>
                        <% } else { %>
                        <option value="PLACEMENTLIB_V" > Vis&eacute; </option>
                        <% } %>
                        
                         <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("placementlib_renouvelle") == 0) {%>
                        <option value="placementlib_renouvelle" selected> Renouvel�s </option>
                        <% } else { %>
                        <option value="placementlib_renouvelle"> Renouvel�s </option>
                        <% } %>
                        
                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("PLACEMENTLIB_ECHU") == 0) {%>
                        <option value="PLACEMENTLIB_ECHU" selected> Echu </option>
                        <% } else { %>
                        <option value="PLACEMENTLIB_ECHU"> Echu </option>
                        <% } %>
                        
                    </select>
                </div>
            </div>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=placement/placement-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id", "Entite", "Banque", "Date de placement", "Date d'echeance","Duree(en mois)","Montant","Taux"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
<% }catch(Exception e){
    e.printStackTrace();
}%>

