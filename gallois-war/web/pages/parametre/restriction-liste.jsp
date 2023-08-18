

<%@page import="historique.MapHistorique"%>
<%@page import="historique.MapUtilisateur"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="utilisateur.Restriction"%>

<% try{ 
    Restriction restriction = new Restriction();
    restriction.setNomTable("RESTRICTIONLIB");


    String listeCrt[] = { "ID", "IDROLE", "IDACTION", "TABLENAME", "DESCRIPTION", "REFUSER", "Autorise"};
    String listeInt[] = {};
    String libEntete[] = { "ID", "REFUSER","IDROLE", "IDACTION", "TABLENAME", "DESCRIPTION", "AUTORISE"};
    PageRecherche pr = new PageRecherche(restriction, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
   
    pr.getFormu().getChamp("refuser").setLibelle("Utilisateur");
    pr.getFormu().getChamp("IDACTION").setLibelle("Action");
    pr.getFormu().getChamp("idrole").setLibelle("Role");
    pr.getFormu().getChamp("TABLENAME").setLibelle("Fiche");

    
    
    pr.setApres("parametre/restriction-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.listerestriction.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste restriction</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=parametre/restriction-liste.jsp" method="post" name="listerestriction" id="listerestriction">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=parametre"
                    + "/menu-utilisateur-fiche.jsp"};
            String colonneLien[] = {};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = { "ID", "utilisateur", "Role", "action", "Fiche", "Description", "Autorisation"};
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




