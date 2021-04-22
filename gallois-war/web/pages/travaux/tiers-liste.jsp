<%-- 
    Document   : tiers-liste
    Created on : 4 déc. 2019, 13:27:12
    Author     : john
--%>

<%@page import="mg.spat.Tiers"%>
<%@page import="mg.spat.Travaux"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    Tiers t = new Tiers();  
   
    String nomTable = "tiers";    
    if(request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("") != 0){
         nomTable=request.getParameter("table");
    }
    t.setNomTable(nomTable);
    String listeCrt[] = {"id","nom","description","nif","stat","contact","responsable","adresse","type"};
    String listeInt[] = {};
    String libEntete[] = {"id","nom","description","nif","stat","contact","responsable","adresse","type"};
    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("travaux/tiers-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.listeidentification.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste tiers</h1>
    </section>
    <section class="content">

        <form action="<%=pr.getLien()%>?but=travaux/tiers-liste.jsp" method="post" name="listeidentification" id="listeidentification">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="row col-md-12">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    Etat : 
                    <select name="table" class="champ" id="table" onchange="changerDesignation()" >
                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("tiers") == 0) {%>    
                        <option value="tiers" selected>Tous</option>
                        <% } else { %>
                        <option value="tiers" >Tous</option>
                        <% } %>
                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("tiers_cree") == 0) {%>    
                        <option value="tiers_cree" selected>Cré&eacute; </option>
                        <% } else { %>
                        <option value="tiers_cree" > Cré&eacute; </option>
                        <% } %>

                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("tiers_valide") == 0) {%>
                        <option value="tiers_valide" selected> Valid&eacute; </option>
                        <% } else { %>
                        <option value="tiers_valide"> Valid&eacute; </option>
                        <% } %>

                    </select>
                </div>
            </div>
        </form>

        <%
            String lienTableau[] = {pr.getLien() + "?but=travaux"
                    + "/tiers-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id","Nom","Description","Nif","Stat","Contact","Responsable","Adresse","Type"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
<%
}catch(Exception e){
    e.printStackTrace();
}
%>




