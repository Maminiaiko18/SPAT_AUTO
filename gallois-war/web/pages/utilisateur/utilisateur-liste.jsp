<%@page import="utilisateur.VueCNAPSUser"%>
<%@page import="affichage.PageRecherche"%>
<%

    VueCNAPSUser cnaps = new VueCNAPSUser();
    cnaps.setNomTable("vuecnapsuser");
    String listeCrt[] = {"teluser", "refuser", "loginuser", "username", "adruser", "idrole"};
    String listeInt[] = null;
    String libEntete[] = {"teluser", "refuser", "loginuser", "username", "adruser", "idrole"};
    PageRecherche pr = new PageRecherche(cnaps, request, listeCrt, listeInt, 3, libEntete, 6);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.getFormu().getChamp("teluser").setLibelle("ID Personnel");
    pr.getFormu().getChamp("refuser").setLibelle("Reference");
    pr.getFormu().getChamp("loginuser").setLibelle("Login");
    pr.getFormu().getChamp("username").setLibelle("Nom et prenom");
    pr.getFormu().getChamp("adruser").setLibelle("Direction");
    pr.getFormu().getChamp("idrole").setLibelle("Role");
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("utilisateur/utilisateur-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste utilisateur</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=utilisateur/utilisateur-liste.jsp" method="post" name="listeUtilisateur" id="listeUtilisateur">
            <%

                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=utilisateur/utilisateur-fiche.jsp"};
            String colonneLien[] = {"teluser"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"ID Personnel", "Reference", "login", "Nom", "Direction", "Role"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());

        %>
    </section>
</div>