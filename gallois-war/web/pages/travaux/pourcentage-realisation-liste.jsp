<%-- 
    Document   : tiers-liste
    Created on : 4 déc. 2019, 13:27:12
    Author     : john
--%>
<%@page import="mg.spat.travaux.PourcentageProjet"%>
<%@page import="mg.spat.Travaux"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    PourcentageProjet t = new PourcentageProjet();
    t.setNomTable("pourcentageprojetlib");
    String listeCrt[] = {"id","idchantier","daty","idutilisateur","pourcentage"};
    String listeInt[] = {"daty"};
    String libEntete[] = {"id","idchantier","daty","idutilisateur","pourcentage"};
    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("travaux/pourcentage-realisation-liste.jsp");
    pr.getFormu().getChamp("idchantier").setLibelle("Chantier");
    pr.getFormu().getChamp("daty1").setLibelle("Date min");
    pr.getFormu().getChamp("daty2").setLibelle("Date max");
    pr.getFormu().getChamp("idutilisateur").setLibelle("Utilisateur");
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
        <h1>Liste pourcentage de réalisation</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=travaux/pourcentage-realisation-liste.jsp" method="post" name="listeidentification" id="listeidentification">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="row col-md-12">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    Etat : 
                    <select name="table" class="champ" id="table" onchange="changerDesignation()" >
                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("pourcenatgeProjetLibComplet") == 0) {%>    
                        <option value="pourcenatgeProjetLibComplet" selected>Tous</option>
                        <% } else { %>
                        <option value="pourcenatgeProjetLibComplet" >Tous</option>
                        <% } %>
                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("pourcenatgeProjetLibCree") == 0) {%>    
                        <option value="pourcenatgeProjetLibCree" selected>Cr&eacute;&eacute;</option>
                        <% } else { %>
                        <option value="pourcenatgeProjetLibCree" >Cr&eacute;&eacute;</option>
                        <% } %>
                        <% if (request.getParameter("table") != null && request.getParameter("table").compareToIgnoreCase("pourcenatgeProjetLibValide") == 0) {%>    
                        <option value="pourcenatgeProjetLibValide" selected> ValidCr&eacute; </option>
                        <% } else { %>
                        <option value="pourcenatgeProjetLibValide" > ValidCr&eacute; </option>
                        <% } %>
                    </select>
                </div>
            </div>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=travaux"
                    + "/pourcentage-realisation-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"id","chantier","Date","utilisateur","pourcentage"};
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




