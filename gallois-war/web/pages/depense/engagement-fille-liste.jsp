<%@page import="mg.spat.EngagementFille"%>
<%@page import="affichage.PageRecherche"%>
<%
    try {

        EngagementFille eng = new EngagementFille();
        eng.setNomTable("engagement_fillelib");

        String listeCrt[] = {"id", "idmere","designation"};
        String listeInt[] = {};
        String libEntete[] = {"id", "designation", "montant", "estPaye"};
        PageRecherche pr = new PageRecherche(eng, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
       
        pr.setApres("depense/engagement-fille-liste.jsp");
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
        
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des Engagements filles</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=depense/engagement-fille-liste.jsp" method="post" name="engagement" id="engagement">
            <% out.println(pr.getFormu().getHtmlEnsemble());%>

        </form>
        <%  
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <form action="<%=pr.getLien()%>?but=apresPayerEngagement.jsp" method="post">
        <%
            String libEnteteAffiche[] = {"Id", "Designation", "Montant", "Est pay&eacute;"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            pr.getTableau().setNameBoutton("Payer");
            out.println(pr.getTableau().getHtmlWithCheckbox());
            out.println(pr.getBasPage());
        %>
        </form>
    </section>
</div>
<%  } catch (Exception e) {
        e.printStackTrace();
    }
%>