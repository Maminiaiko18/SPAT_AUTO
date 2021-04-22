<%-- 
    Document   : absence-liste
    Created on : 14 Mars 2016, 10:26:05
    Author     : Do
--%>
<%@page import="mg.cnaps.formation.FormAbsence"%>
<%@page import="affichage.PageRecherche"%>
<%
    try {

        FormAbsence fa = new FormAbsence();
        fa.setNomTable("FORM_ABSENCE_LIBELLE");

        String listeCrt[] = {"id", "id_formation", "log_personnel", "motif", "remarque", "date_absence"};
        String listeInt[] = {"date_absence"};
        String libEntete[] = {"id", "id_formation", "log_personnel", "motif", "remarque", "date_absence"};
        PageRecherche pr = new PageRecherche(fa, request, listeCrt, listeInt, 3, libEntete, 6);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.getFormu().getChamp("log_personnel").setLibelle("Personnel");
        pr.getFormu().getChamp("date_absence1").setLibelle("Date min");
        pr.getFormu().getChamp("date_absence2").setLibelle("Date max");
        pr.getFormu().getChamp("id_formation").setLibelle("Formation");

        pr.setApres("formation/absence-liste.jsp");
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des Absences </h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=formation/absence-liste.jsp" method="post" name="absence" id="absence">
            <% out.println(pr.getFormu().getHtmlEnsemble());%>

        </form>
        <%  String lienTableau[] = {pr.getLien() + "?but=formation/absence-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"id", "Id formation", "Personnel", "Motif", "Remarque", "Date"};
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