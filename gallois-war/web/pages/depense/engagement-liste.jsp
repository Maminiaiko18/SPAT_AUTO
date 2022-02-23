<%-- 
    Document   : absence-liste
    Created on : 14 Mars 2016, 10:26:05
    Author     : Do
--%>
<%@page import="mg.spat.Engagement"%>
<%@page import="affichage.PageRecherche"%>
<%
    try {

        Engagement eng = new Engagement();
        eng.setNomTable("engagementlib");

        String listeCrt[] = {"id", "designation","projet", "montant", "disponible","dispoavant","dispoapres","compte","etat","codeetablissementlib","projetlib"};
        String listeInt[] = {};
        String libEntete[] = {"id", "designation", "projet", "montant", "disponible","dispoavant","dispoapres","compte","etat","codeetablissementlib","projetlib"};
        PageRecherche pr = new PageRecherche(eng, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        

        pr.setApres("depense/engagement-liste.jsp");
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des Engagements </h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=depense/engagement-liste.jsp" method="post" name="engagement" id="engagement">
            <% out.println(pr.getFormu().getHtmlEnsemble());%>

        </form>
        <%  String lienTableau[] = {pr.getLien() + "?but=depense/engagement-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] ={"id", "designation","projet", "montant", "disponibilité","disponibilité avant","disponibilité après","compte","etat","codeetablissementlib","projetlib"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());

        %>
    </section>
</div>
<%  } catch (Exception e) {
        e.printStackTrace();
    }
%>