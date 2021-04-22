<%-- 
    Document   : utilisateur-liste
    Created on : 30 nov. 2019, 09:25:43
    Author     : john
--%>

<%@page import="historique.MapUtilisateur"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    MapUtilisateur utilisateur = new MapUtilisateur();
    //info.setNomTable("vue_personnel");
    String listeCrt[] = {"loginuser", "idrole", "nomuser","adruser","teluser","refuser"};
    String listeInt[] = {"refuser","rang"};
    String libEntete[] = {"refuser","loginuser", "idrole", "nomuser","adruser","teluser"};
    PageRecherche pr = new PageRecherche(utilisateur, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    /*pr.getFormu().getChamp("loginuser").setLibelle("Login");
    pr.getFormu().getChamp("idrole").setLibelle("Role");
    pr.getFormu().getChamp("nomuser").setLibelle("Nom");
    pr.getFormu().getChamp("adruser").setLibelle("Adresse");
    pr.getFormu().getChamp("teluser").setLibelle("Telephone");
    pr.getFormu().getChamp("refuser").setLibelle("Reference");*/
    pr.setApres("parametre/utilisateur-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.listeutilisateur.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste utilisateur</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=parametre/utilisateur-liste.jsp" method="post" name="listeutilisateur" id="listeutilisateur">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=parametre"
                    + "/utilisateur-fiche.jsp"};
            String colonneLien[] = {"refuser"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Reference","Login", "Role", "Nom","Adresse","Telephone"};
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



