


<%@page import="mg.spat.relationhumaine.Parcours_professionnel_Lib_Complet"%>
<%@page import="mg.spat.relationhumaine.Parcours_professionnel"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try {
        String autreparsley = "data-parsley-range='[8, 40]' required";
        Parcours_professionnel pj = new Parcours_professionnel();
        PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
        pi.getFormu().getChamp("poste_occupe").setLibelle("Poste occupé");
        pi.getFormu().getChamp("annee_parcours_pro").setLibelle("Année de parcours professionnel");
        if (request.getParameter("idpersonnel") != null) {
            pi.getFormu().getChamp("idPersonnel").setDefaut(request.getParameter("idpersonnel"));
        }
        pi.getFormu().getChamp("idpersonnel").setLibelle("Personnel");
        pi.getFormu().getChamp("duree").setLibelle("Duree par mois");
        pi.getFormu().getChamp("idPersonnel").setAutre("readonly");
        pi.getFormu().getChamp("idPersonnel").setPageAppel("choix/listeIdentificationChoix.jsp");
        pi.setLien((String) session.getValue("lien"));
        pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie parcours professionnel</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>

        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="carriere/parcours-professionnel-fiche.jsp">
        <input name="classe" type="hidden" id="classe" value="mg.spat.relationhumaine.Parcours_professionnel">
    </form>

    <%if (request.getParameter("idpersonnel") != null) {
            Parcours_professionnel_Lib_Complet info = new Parcours_professionnel_Lib_Complet();
            info.setNomTable("PARCOURS_PRO_LIBCOMPLET");
            String listeCrt[] = {"id", "idPersonnel", "poste_occupe", "societe"};
            String listeInt[] = {"annee_parcours_pro"};
            String libEntete[] = {"id", "idPersonnel", "poste_occupe", "societe", "annee_parcours_pro", "duree"};
            PageRecherche pr = new PageRecherche(info, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
            pr.setUtilisateur((user.UserEJB) session.getValue("u"));
            pr.setLien((String) session.getValue("lien"));
            pr.setApres("carriere/parcours-professionnel-liste.jsp");
            pr.setAWhere(" and IDPERSONNEL='"+request.getParameter("idpersonnel")+"'");
            String[] colSomme = null;
            pr.creerObjetPage(libEntete, colSomme);
    %>

    <section class="content-header">
        <h1>Liste parcours professionnel</h1>
    </section>
    <section class="content">
        <%
             String lienTableau[] = {pr.getLien() + "?but=carriere"
                    + "/parcours-professionnel-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            String libEnteteAffiche[] = {"Id", "Personnel", "Poste occupe", "Societe", "Annee parcours pro", "Duree"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

%>