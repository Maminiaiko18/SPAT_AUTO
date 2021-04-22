<%-- 
    Document   : syndicat-liste
    Created on : 4 déc. 2019, 13:57:50
    Author     : john
--%>

<%@page import="mg.spat.Syndicat"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    Syndicat s = new Syndicat();
    String nomTable = "syndicat";
    if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("") != 0) {
        nomTable = request.getParameter("table");
    }
    
    s.setNomTable(nomTable);
    String listeCrt[] = {"id","nom","description"};
    String listeInt[] = {"etat"};
    String libEntete[] = {"id","nom","description"};
    PageRecherche pr = new PageRecherche(s, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("syndicat/syndicat-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.syndicat.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste syndicat</h1>
    </section>    
    <section class="content">
        <form action="<%=pr.getLien()%>" method="get" name="syndicat" id="syndicat">
            <input type="hidden" name="but" value="syndicat/syndicat-liste.jsp" />
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
            <div class="row col-md-12">
                <div class="col-md-4"></div>
                    <div class="col-md-4">
                    table : 
                    <select name="table" class="champ" id="table" onchange="changerDesignation()" >
                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("syndicat") == 0) {%>    
                        <option value="syndicat" selected>Tous</option>
                        <% } else { %>
                        <option value="syndicat" >Tous</option>
                        <% } %>
                        
                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("syndicatcree") == 0) {%>    
                        <option value="syndicatcree" selected>Creer</option>
                        <% } else { %>
                        <option value="syndicatcree" >Creer</option>
                        <% } %>

                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("syndicatvalide") == 0) {%>    
                        <option value="syndicatvalide" selected>Valider</option>
                        <% } else { %>
                        <option value="syndicatvalide" >Valider</option>
                        <% } %>
                    </select>
                </div>
            </div>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=syndicat"
                    + "/syndicat-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id","Nom","Description"};
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





