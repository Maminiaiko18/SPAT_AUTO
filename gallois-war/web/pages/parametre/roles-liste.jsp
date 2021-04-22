

<%@page import="utilisateur.Role"%>
<%@page import="historique.MapHistorique"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    Role role = new Role();
    String listeCrt[] = {"idrole", "descrole", "rang"};
    String listeInt[] = {"rang"};
    String libEntete[] = {"idrole", "descrole", "rang"};
    PageRecherche pr = new PageRecherche(role, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
   /* pr.getFormu().getChamp("idrole").setLibelle("Id role");
    pr.getFormu().getChamp("descrole").setLibelle("Description");
    pr.getFormu().getChamp("rang").setLibelle("Rang");*/
    pr.setApres("parametre/roles-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.listerole.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste role</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=parametre/roles-liste.jsp" method="post" name="listerole" id="listerole">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());   
            %>
        </form>
        <%
            /*String lienTableau[] = {pr.getLien() + "?but=parametre"
                    + "/roles-fiche.jsp"};
            String colonneLien[] = {"idrole"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);*/
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id", "Description", "Rang"};
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




