

<%@page import="mg.spat.relationhumaine.DiplomePersonnel"%>
<%@page import="mg.spat.relationhumaine.Diplome"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try {
        String autreparsley = "data-parsley-range='[8, 40]' required";
        Diplome pj = new Diplome();
        PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
        pi.getFormu().getChamp("annee_diplome").setLibelle("Année diplome");
        if (request.getParameter("idpersonnel") != null) {
            pi.getFormu().getChamp("idPersonnel").setDefaut(request.getParameter("idpersonnel"));
        }
        pi.getFormu().getChamp("idPersonnel").setAutre("readonly");
        pi.getFormu().getChamp("idPersonnel").setLibelle("Personnel");
        pi.getFormu().getChamp("idPersonnel").setPageAppel("choix/listeIdentificationChoix.jsp");
        pi.setLien((String) session.getValue("lien"));
        pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie diplômes</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="carriere/diplomes-obtenus-fiche.jsp">
        <input name="classe" type="hidden" id="classe" value="mg.spat.relationhumaine.Diplome">
    </form>

    <%
        if (request.getParameter("idpersonnel") != null) {
            Diplome info = new DiplomePersonnel();
            info.setNomTable("diplome_libcomplet");
            String listeCrt[] = {"id", "idPersonnel", "titre", "options", "etablissement", "annee_diplome"};
            String listeInt[] = {"annee_diplome"};
            String libEntete[] = {"id", "nom", "titre", "options", "etablissement", "annee_diplome"};
            PageRecherche pr = new PageRecherche(info, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
            if(request.getParameter("idpersonnel") != null)
                pr.setAWhere(" and idpersonnel='" + request.getParameter("idpersonnel") +"'");
            pr.setUtilisateur((user.UserEJB) session.getValue("u"));
            pr.setLien((String) session.getValue("lien"));
            pr.setApres("carriere/diplomes-obtenus-liste.jsp");
            String[] colSomme = null;
            pr.creerObjetPage(libEntete, colSomme);
    %>
    <section class="content-header">
        <h1>Liste diplome obtenus</h1>
    </section>
    <section class="content">
        <%
            String libEnteteAffiche[] = {"Id", "Personnel", "Titre", "Options", "Etablissement", "Annee diplome"};
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