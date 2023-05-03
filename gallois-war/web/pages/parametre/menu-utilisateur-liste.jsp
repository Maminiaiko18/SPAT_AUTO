
<%@page import="utilisateur.UserMenu"%>
<%@page import="historique.MapHistorique"%>
<%@page import="historique.MapUtilisateur"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    UserMenu menu = new UserMenu();
    menu.setNomTable("v_usermenu");
    String listeCrt[] = {"login","nomuser","refuser","id", "idrole", "idmenu", "codeservice", "codedir", "interdit"};
    String listeInt[] = {};
    String libEntete[] = {"refuser","login","nomuser","id", "idrole", "idmenu", "codeservice", "codedir", "interdit"};
    PageRecherche pr = new PageRecherche(menu, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
   /* pr.getFormu().getChamp("refuser").setLibelle("Reference");
    pr.getFormu().getChamp("idrole").setLibelle("Id role");
    pr.getFormu().getChamp("idmenu").setLibelle("Id menu");
    pr.getFormu().getChamp("codeservice").setLibelle("Code service");
    pr.getFormu().getChamp("codedir").setLibelle("Code dir");*/
    pr.setApres("parametre/menu-utilisateur-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.listemenu.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste menu</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=parametre/menu-utilisateur-liste.jsp" method="post" name="listemenu" id="listemenu">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=parametre"
                    + "/menu-utilisateur-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"refuser","login","nomuser","id", "idrole", "idmenu", "codeservice", "codedir", "interdit"};
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




