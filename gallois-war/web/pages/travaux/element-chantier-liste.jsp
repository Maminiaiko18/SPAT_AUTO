<%-- 
    Document   : element-chantier-liste
    Created on : 25 nov. 2020, 16:34:04
    Author     : ACER
--%>

<%@page import="elementchantier.ElementChantier"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    ElementChantier ec = new ElementChantier();
    
    String listeCrt[] = {"id","libelle","caracteristique","unite","code"};
    String listeInt[] = {};
    String libEntete[] = {"id","libelle","caracteristique","unite","code"};
    
    PageRecherche pr = new PageRecherche(ec, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("travaux/element-chantier-liste.jsp");
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
        <h1>Liste élements chantier</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=travaux/element-chantier-liste.jsp" method="post" name="listeidentification" id="listeidentification">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=travaux/element-chantier-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id","Designation","Caractéristique","Unité","Code"};
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