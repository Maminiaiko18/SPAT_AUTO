

<%@page import="mg.spat.relationhumaine.Permission"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%

    try {
        String autreparsley = "data-parsley-range='[8, 40]' required";
        mg.spat.relationhumaine.Permission pj = new mg.spat.relationhumaine.Permission();
        PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
        pi.getFormu().getChamp("idpersonnel").setLibelle("Personnel");
        pi.getFormu().getChamp("date_debut_permission").setLibelle("Date de début de permission");
        pi.getFormu().getChamp("date_fin_permission").setLibelle("Date de fin de permission");
        if (request.getParameter("idpersonnel") != null) {
            pi.getFormu().getChamp("idPersonnel").setDefaut(request.getParameter("idpersonnel"));
        }
        pi.getFormu().getChamp("etat").setVisible(false);
        pi.getFormu().getChamp("nombre").setVisible(false);
        pi.getFormu().getChamp("idPersonnel").setAutre("readonly");
        pi.getFormu().getChamp("idPersonnel").setPageAppel("choix/listeIdentificationChoix.jsp");
        pi.setLien((String) session.getValue("lien"));
        pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie de permission</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>

        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="carriere/permission-fiche.jsp">
        <input name="classe" type="hidden" id="classe" value="mg.spat.relationhumaine.Permission">
    </form>
    <% if (request.getParameter("idpersonnel") != null) {
            Permission permission = new Permission();
            permission.setNomTable("PERMISSION_PERSONNEL_LIB");
            String listeCrt[] = {"id", "objet", "date_debut_permission", "date_fin_permission", "nombre"};
            String listeInt[] = {"nombre", "date_debut_permission", "date_fin_permission"};
            String libEntete[] = {"id", "idpersonnel", "objet", "date_debut_permission", "date_fin_permission", "nombre"};
            PageRecherche pr = new PageRecherche(permission, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
            pr.setUtilisateur((user.UserEJB) session.getValue("u"));
            pr.setAWhere(" and personnel='"+request.getParameter("idpersonnel")+"'");
            pr.setLien((String) session.getValue("lien"));
            pr.setApres("carriere/permission-liste.jsp");
            String[] colSomme = null;
            pr.creerObjetPage(libEntete, colSomme);
    %>

    <section class="content-header">
        <h1>Liste Permission</h1>
    </section>
    <section class="content">
        <%
            String libEnteteAffiche[] = {"id", "Personnel", "Objet", "Date debut permission", "Date fin permission", "Nombre de jours"};
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