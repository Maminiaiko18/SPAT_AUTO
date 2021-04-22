<%-- 
    Document   : statistique-liste
    Created on : 19 nov. 2019, 10:43:55
    Author     : john
--%>

<%@page import="mg.spat.Statistique"%>
<%@page import="mg.spat.PosteDestinataireLibComplet"%>
<%@page import="affichage.PageRecherche"%>
<% 
    Statistique posteDestinataire = new Statistique();
    posteDestinataire.setNomTable("statistiquelib");
    String listeCrt[] = {"id", "titre", "navire", "daty"};
    String listeInt[] = {"daty"};
    String libEntete[] = {"id", "titre", "navire", "daty","nombre","volume"};
    PageRecherche pr = new PageRecherche(posteDestinataire, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("statistique/statistique-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.listestatistique.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste </h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=statistique/statistique-liste.jsp" method="post" name="listestatistique" id="listestatistique">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=statist"
                    + "ique/statistique-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id", "Titre", "Navire", "Date","Nombre","Volume"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>


