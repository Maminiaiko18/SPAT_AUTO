<%-- 
    Document   : projet-liste.jsp
    Created on : 29 déc. 2020, 08:56:28
    Author     : Lenovo
--%>

<%@page import="projet.Projet"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    Projet menu = new Projet();
    menu.setNomTable("Projet");
    String listeCrt[] = {"projet","designation"};

    String listeInt[] = {""};
    String libEntete[] = {"projet","designation"};
    PageRecherche pr = new PageRecherche(menu, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.getFormu().getChamp("designation").setLibelle("Code");
    pr.setApres("budget/projet-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.listestatistiqueactivite.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste statistique activite</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=budget/projet-liste.jsp" method="post" name="listestatistiqueactivite" id="listestatistiqueactivite">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=budget/projet-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"projet","Code"};
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