<%-- 
    Document   : activite-liste
    Created on : 28 juil. 2016, 16:15:17
    Author     : Ignafah
--%>
<%@page import="affichage.PageRecherche"%>
<%@page import="mg.cnaps.sig.SigActivites"%>
<%
    SigActivites sg = new SigActivites();
    sg.setNomTable("sig_activite_lib");
    String listeCrt[] = {"id", "regime_code", "ventil_code", "code", "regime_taux_empl","regime_taux_trav"};
    String listeInt[] = null;
    String libEntete[] = {"id", "regime_code", "activite_libelle", "ventil_code", "code", "regime_taux_empl", "regime_taux_trav"};
    
    PageRecherche pr = new PageRecherche(sg, request, listeCrt, listeInt, 3, libEntete, 7);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("configuration/activite-fiche.jsp");
    pr.getFormu().getChamp("regime_code").setLibelle("regime code");
    pr.getFormu().getChamp("ventil_code").setLibelle("ventil code");
    pr.getFormu().getChamp("regime_taux_empl").setLibelle("regime taux employeur");
    pr.getFormu().getChamp("regime_taux_trav").setLibelle("regime taux travailleur");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste activités</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=configuration/activite-liste.jsp" method="post" name="analyse" id="analyse">
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
        </form>
        <%
            String lienTableau[] = {pr.getLien() + "?but=configuration/activite-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());
        %>
        <br>
        <%
            String libEnteteAffiche[] = {"id", "regime code", "activite", "ventil code", "code", "régime taux employeur", "régime taux travailleur"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
