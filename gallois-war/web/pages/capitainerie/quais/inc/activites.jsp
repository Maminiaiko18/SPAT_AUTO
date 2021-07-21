<%@page import="mg.spat.exploitant.Activite"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>
<%
    try {
        Activite activite = new Activite();
        activite.setNomTable("ACTIVITELIBCOMPLET");

        String bateau = request.getParameter("id");

        String listeCrt[] = {};
        String listeInt[] = {};
        String libEntete[] = {"id", "daty", "designation", "clientlib", "rubriquelib", "bateaulib", "qte", "moisLib", "annee", "pu", "datedebut", "heuredebut", "datefin", "heurefin", "nbHeure", "nbJour", "etatlib"};

        PageRecherche pr = new PageRecherche(activite, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("capitainerie/quais/inc/activites.jsp");

        pr.setAWhere(" and bateau = '" + bateau + "'");
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
%>
<section class="content">
    <%
        String lienTableau[] = {pr.getLien() + "?but=exploitants/activites-fiche.jsp"};
        String colonneLien[] = {"id"};
        pr.getTableau().setLien(lienTableau);
        pr.getTableau().setColonneLien(colonneLien);
    %>
    <br>
    <%
        String libEnteteAffiche[] = {"id", "daty", "designation", "client", "Rubrique", "bateau", "Quantite", "mois", "annee", "pu", "date debut", "heure debut", "date fin", "heure fin", "Durée en heures", "Durée en jours", "etat"};
        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
        //pr.getTableau().construire_libelle(champ, libelle_comp);

        String html = pr.getTableau().getHtml();
        if (html != null) {
            out.println(html);
        }    else {
    %>
    <center><h4>Aucun details </h4></center>
        <% } %>
</section>
<%
    }catch (Exception e) {
        e.printStackTrace();
    }
%>