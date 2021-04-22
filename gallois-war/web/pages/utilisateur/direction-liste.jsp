<%@page import="affichage.PageRecherche"%>
<%@page import="lc.Direction"%>
<% Direction dr = new Direction();
    String listeCrt[] = {"idDir","libelledir", "descdir", "abbrevdir"};
    String listeInt[] = null;
    String libEntete[] = {"idDir","libelledir", "descdir", "abbrevdir"};
    PageRecherche pr = new PageRecherche(dr, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("utilisateur/direction-liste.jsp");
    pr.getFormu().getChamp("idDir").setLibelle("Id");
    pr.getFormu().getChamp("libelledir").setLibelle("Libelle");
    pr.getFormu().getChamp("descdir").setLibelle("Description");
    pr.getFormu().getChamp("abbrevdir").setLibelle("Abreviation");
    
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste Direction</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=utilisateur/direction-liste.jsp" method="post" name="listedirection" id="listeUtilisateur">
            <%

                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=utilisateur/direction-fiche.jsp"};
            String colonneLien[] = {"idDir"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"id","Direction", "Description", "Libelle", "Abreviation"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());

        %>
    </section>
</div>