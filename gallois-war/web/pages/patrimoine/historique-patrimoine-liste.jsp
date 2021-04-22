<%@page import="mg.spat.HistoriquePatrimoineListe"%>

<%@page import="affichage.PageRecherche"%>

<% try{ 
    HistoriquePatrimoineListe s = new HistoriquePatrimoineListe();
    s.setNomTable("historique_patrimoinelib");
    String listeCrt[] = {"id","idUtilisateur","idPatrimoine","etatPatrimoine","daty"};
    String listeInt[] = {"daty"};
    String libEntete[] = {"id","idUtilisateur","idPatrimoine","etatPatrimoine","daty"};
    PageRecherche pr = new PageRecherche(s, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.getFormu().getChamp("idPatrimoine").setLibelle("Patrimoine");
    pr.getFormu().getChamp("etatPatrimoine").setLibelle("etat Patrimoine");
    pr.getFormu().getChamp("daty1").setLibelle("date de début");
    pr.getFormu().getChamp("daty2").setLibelle("date fin");
    pr.getFormu().getChamp("idUtilisateur").setLibelle("utilisateur");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("patrimoine/historique-patrimoine-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<script>
    function changerDesignation() {
        document.listeidentification.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Historique Patrimoine</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=patrimoine/historique-patrimoine-liste.jsp" method="post" name="listeidentification" id="listeidentification">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=patrimoine/historique-patrimoine-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"id","Utilisateur","Objet","Etat","Remarque"};
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





