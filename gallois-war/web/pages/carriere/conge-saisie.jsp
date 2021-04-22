

<%@page import="mg.spat.relationhumaine.Conge_libcomplet"%>
<%@page import="mg.spat.relationhumaine.Conge"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%

    try {
        String autreparsley = "data-parsley-range='[8, 40]' required";
        Conge pj = new Conge();
        PageInsert pi = new PageInsert(pj, request, (user.UserEJB) session.getValue("u"));
        pi.getFormu().getChamp("date_debut_conge").setLibelle("Date de début de congé");
        pi.getFormu().getChamp("date_debut_conge").setDefaut(Utilitaire.dateDuJour());
        pi.getFormu().getChamp("date_fin_conge").setLibelle("Date de fin de congé");
        pi.getFormu().getChamp("idPersonnel").setLibelle("Personnel");
        if (request.getParameter("idpersonnel") != null) {
            pi.getFormu().getChamp("idPersonnel").setDefaut(request.getParameter("idpersonnel"));
        }
        pi.getFormu().getChamp("idPersonnel").setAutre("readonly");
        pi.getFormu().getChamp("etat").setVisible(false);
        pi.getFormu().getChamp("nombre").setVisible(false);
        pi.getFormu().getChamp("idPersonnel").setPageAppel("choix/listeIdentificationChoix.jsp");
        pi.setLien((String) session.getValue("lien"));
        pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1>Saisie de congé</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="sig_commune" id="sig_commune" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>

        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="carriere/conge-fiche.jsp">
        <input name="classe" type="hidden" id="classe" value="mg.spat.relationhumaine.Conge">
    </form>

    <%if (request.getParameter("idpersonnel") != null) {
            Conge_libcomplet info = new Conge_libcomplet();
            info.setNomTable("conge_libcomplet");
            String listeCrt[] = {"id", "idPersonnel", "disponibilite", "date_debut_conge", "date_fin_conge", "nombre"};
            String listeInt[] = {"date_debut_conge", "date_fin_conge", "nombre"};
            String libEntete[] = {"id", "idPersonnel", "disponibilite", "date_debut_conge", "date_fin_conge", "nombre"};
            PageRecherche pr = new PageRecherche(info, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
            
            pr.setAWhere("and idpersonnel='"+request.getParameter("idpersonnel")+"'");
            
            pr.setUtilisateur((user.UserEJB) session.getValue("u"));
            pr.setLien((String) session.getValue("lien"));
            pr.setApres("carriere/conge-liste.jsp");
            String[] colSomme = null;
            pr.creerObjetPage(libEntete, colSomme);
    %>

    <section class="content-header">
        <h1>Liste conge </h1>
    </section>
    <section class="content">
        <%
            String libEnteteAffiche[] = {"Id", "Personnel", "Disponibilite", "Date debut conge", "Date fin conge", "Nombre de jours"};
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