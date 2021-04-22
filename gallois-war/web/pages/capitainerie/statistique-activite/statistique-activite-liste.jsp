<%-- 
    Document   : statistique-activite-liste
    Created on : 30 nov. 2019, 10:44:34
    Author     : john
--%>

<%@page import="mg.spat.StatistiqueActiviteV"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    StatistiqueActiviteV menu = new StatistiqueActiviteV();
    menu.setNomTable("v_statistique_activite");
    String listeCrt[] = {"id","rubrique","daty","client","annee"};
    //String listeCrt[] = {"id","idclient","rubrique","daty","client","annee","mois_precedent","mois_en_cours"};
    String listeInt[] = {"daty","annee","mois_precedent","mois_en_cours"};
    String libEntete[] = {"id","client","rubrique","daty","cumul","prevision","annee","mois_precedent","mois_en_cours"};
    PageRecherche pr = new PageRecherche(menu, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.getFormu().getChamp("daty1").setLibelle("Date min");
    pr.getFormu().getChamp("daty2").setLibelle("Date max");
    pr.setApres("capitainerie/statistique-activite/statistique-activite-liste.jsp");
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
        <form action="<%=pr.getLien()%>?but=capitainerie/statistique-activite/statistique-activite-liste.jsp" method="post" name="listestatistiqueactivite" id="listestatistiqueactivite">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=capitainerie/statistique-activite"
                    + "/statistique-activite-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"Id","Client","Rubrique","Date","Cumul","Prevision","Annee","Mois precedent","Mois en cours"};
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

