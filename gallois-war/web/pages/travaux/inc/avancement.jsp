<%-- 
    Document   : avancement
    Created on : 30 nov. 2020, 17:00:35
    Author     : ASUS
--%>

<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="mg.spat.travaux.PourcentageProjet"%>
<%
    PourcentageProjet projet = new PourcentageProjet();
    projet.setNomTable("pourcentageprojet_lib_etat");
    String listeCrt[] = {"observation", "pourcentage"};
    String listeInt[] = {};
    String libEntete[] = {"id", "daty", "pourcentage", "observation", "etatlib"};
    PageRecherche pr = new PageRecherche(projet, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    String id = "";
    if (request.getParameter("id") != null) {
        id = request.getParameter("id");
        pr.setAWhere(" and idchantier = '" + id + "'");
    }
    pr.setApres("travaux/inc/avancement.jsp");
    String[] colSomme = null;
    
    pr.setOrdre(" order by daty desc");
    pr.creerObjetPage(libEntete, colSomme);

%>
<div class="box-body">
    <%
        String lienTableau[] = {pr.getLien() + "?but=travaux/pourcentage-realisation-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
        String libEnteteAffiche[] = {"id", "Date", "pourcentage", "observation", "etat"};
        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
        out.println(pr.getTableau().getHtml());
    %>
    <a class="btn btn-primary pull-left"  href="<%=(String) session.getValue("lien") + "?but=travaux/pourcentage-realisation-saisie.jsp&id=" + request.getParameter("id")%>" style="margin-right: 10px">Ajouter pourcentage de réalisation</a>
</div>