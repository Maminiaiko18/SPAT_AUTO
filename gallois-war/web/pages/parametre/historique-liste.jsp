<%-- 
    Document   : historique-liste
    Created on : 30 nov. 2019, 10:12:45
    Author     : john
--%>

<%@page import="historique.MapHistorique"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    MapHistorique historique = new MapHistorique();
    historique.setNomTable("historique_libelle");
    String listeCrt[] = {"idhistorique", "datehistorique", "heure", "objet", "action", "idutilisateur", "refobjet"};
    String listeInt[] = {"datehistorique"};
    String libEntete[] = {"idhistorique", "datehistorique", "heure", "objet", "action", "idutilisateur", "refobjet"};
    PageRecherche pr = new PageRecherche(historique, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.getFormu().getChamp("datehistorique1").setLibelle("date historique min");
    pr.getFormu().getChamp("datehistorique2").setLibelle("date historique max");
    pr.getFormu().getChamp("refobjet").setLibelle("reference");
    pr.getFormu().getChamp("idutilisateur").setLibelle("utilisateur");
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("parametre/historique-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.listehistorique.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste historique</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=parametre/historique-liste.jsp" method="post" name="listehistorique" id="listehistorique">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
           /* String lienTableau[] = {pr.getLien() + "?but=parametre"
                    + "/historique-fiche.jsp"};
            String colonneLien[] = {"idhistorique"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);*/
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id", "Date historique", "Heure", "Objet", "Action", "Utilisateur", "Reference"};
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




